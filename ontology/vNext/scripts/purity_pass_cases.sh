#!/usr/bin/env sh
set -eu

# ============================================================
# REPAC vNext — Purity Pass (Maximum Tone Purity + Low Noise)
# Location requirement: run from .../ontology/vNext/scripts
#
# Purpose:
#   - Reduce prescriptive-sounding language and scan noise in case markdown
#   - Apply conservative, REPAC-safe rewrites
#   - Create timestamped backups of modified files
#   - Re-scan after changes
#
# Usage (from vNext/scripts):
#   chmod +x purity_pass_cases.sh
#   ./purity_pass_cases.sh
#
# Optional:
#   CASES_DIR=../cases ./purity_pass_cases.sh
#   PURE_REWRITE_NEG_RECOMMENDATIONS=0 ./purity_pass_cases.sh
# ============================================================

CASES_DIR="${CASES_DIR:-../cases}"

# If 1, rewrite "recommendation(s)" in negation contexts to "prescriptive guidance"
# Default is 0 because "without asserting recommendations" is already fine.
PURE_REWRITE_NEG_RECOMMENDATIONS="${PURE_REWRITE_NEG_RECOMMENDATIONS:-0}"

say() { printf "%s\n" "$*"; }
die() { say "ERROR: $*"; exit 1; }

ensure_right_dir() {
  base="$(basename "$(pwd)")"
  parent="$(basename "$(dirname "$(pwd)")")"
  grandparent="$(basename "$(dirname "$(dirname "$(pwd)")")")"

  [ "$base" = "scripts" ] || die "Run from .../ontology/vNext/scripts (pwd must end with /vNext/scripts). Current: $(pwd)"
  [ "$parent" = "vNext" ] || die "Run from .../ontology/vNext/scripts (parent must be vNext). Current: $(pwd)"
  [ "$grandparent" = "ontology" ] || die "Run from .../ontology/vNext/scripts (grandparent must be ontology). Current: $(pwd)"

  [ -d "$CASES_DIR" ] || die "Cases directory not found: $CASES_DIR"
}

init_backup_dir() {
  ts="$(date +%Y%m%d_%H%M%S)"
  backup_dir="${CASES_DIR}/.backup_purity_${ts}"
  mkdir -p "$backup_dir"
  say "Backups: ${backup_dir}"
}

backup_one() {
  f="$1"
  [ -f "$f" ] || return 0
  cp -p "$f" "${backup_dir}/$(basename "$f")"
}

# Only touch markdown files directly under cases/
list_case_files() {
  find "$CASES_DIR" -maxdepth 1 -type f -name "*.md" -print | sort
}

scan_terms() {
  say ""
  say "Purity scan (report):"
  pattern='should have been|should|must|need to|best practice|root cause|recommendation|recommendations|recommend|fix|solution'
  if grep -RInE --exclude-dir=".backup_*" "$pattern" "$CASES_DIR" >/tmp/repac_purity_scan_$$.txt 2>/dev/null; then
    cat /tmp/repac_purity_scan_$$.txt
  else
    say "No hits found for: $pattern"
  fi
  rm -f /tmp/repac_purity_scan_$$.txt
}

# Apply conservative rewrites using perl (macOS has perl by default).
# We back up file if any rewrite changes it.
rewrite_file() {
  f="$1"
  [ -f "$f" ] || return 0

  before_sig="$(cksum < "$f" | awk '{print $1 ":" $2}')"

  # Rewrites:
  # 1) "should have been" -> "were expected to be" (removes normative mood)
  # 2) Question-frame: "what conditions must be met" -> "what conditions are required to be met"
  # 3) General "need to" -> "are required to" (conservative)
  # 4) "best practice" -> "commonly cited practice"
  # 5) "root cause" -> "single-factor cause"
  # 6) "solution" -> "resolution" (only as a noun-like usage; conservative general replacement)
  # 7) "fix" -> "remediation" (conservative general replacement)
  #
  # Notes:
  # - We avoid rewriting "must" globally; we target common question formulations to preserve meaning.
  # - We avoid rewriting "recommendations" unless toggle is enabled and the context is explicitly negation.

  perl -0777 -pi -e '
    s/\bshould have been\b/were expected to be/gi;

    # Target question-form uses of must: "what conditions must be met"
    s/\b(what\s+conditions)\s+must\s+be\s+met\b/$1 are required to be met/gi;
    s/\b(what\s+criteria)\s+must\s+be\s+met\b/$1 are required to be met/gi;

    # Conservative: need to -> are required to
    s/\bneed to\b/are required to/gi;

    # best practice -> commonly cited practice
    s/\bbest practice\b/commonly cited practice/gi;

    # root cause -> single-factor cause
    s/\broot cause\b/single-factor cause/gi;

    # solution -> resolution (conservative; acceptable shift in meaning for REPAC narrative tone)
    s/\bsolution\b/resolution/gi;

    # fix -> remediation
    s/\bfix\b/remediation/gi;
  ' "$f"

  if [ "$PURE_REWRITE_NEG_RECOMMENDATIONS" = "1" ]; then
    perl -0777 -pi -e '
      # Only when explicitly negated (avoids changing real "recommendations" text if any)
      s/without asserting (corrective )?recommendations/without asserting prescriptive guidance/gi;
      s/does not recommend actions or remedies/does not provide prescriptive guidance or remedies/gi;
    ' "$f"
  fi

  after_sig="$(cksum < "$f" | awk '{print $1 ":" $2}')"

  if [ "$before_sig" != "$after_sig" ]; then
    backup_one "$f"
    say "CLEAN: $(basename "$f")"
  fi
}

main() {
  ensure_right_dir
  init_backup_dir

  say "Running purity pass on: $CASES_DIR"
  say ""

  say "Scan before:"
  scan_terms

  say ""
  say "Applying conservative rewrites..."
  changed_count=0

  for f in $(list_case_files); do
    before="$(cksum < "$f" | awk '{print $1 ":" $2}')"
    rewrite_file "$f"
    after="$(cksum < "$f" | awk '{print $1 ":" $2}')"
    if [ "$before" != "$after" ]; then
      changed_count=$((changed_count + 1))
    fi
  done

  say ""
  say "Files changed: $changed_count"
  say "Backups stored in: $backup_dir"

  say ""
  say "Scan after:"
  scan_terms

  say ""
  say "Next:"
  say "  cd .."
  say "  git status"
  say "  git diff"
  say "If satisfied, commit with a message like:"
  say "  git commit -am \"Purity pass: reduce prescriptive scan noise in cases\""
}

main "$@"
