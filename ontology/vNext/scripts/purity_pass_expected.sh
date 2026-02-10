#!/usr/bin/env sh
set -eu

# ============================================================
# REPAC vNext — Tier-1B Purity Pass (Safe + Low Noise)
# Location requirement: run from .../ontology/vNext/scripts
#
# Changes:
#   1) Global:  "should have been" -> "were expected to be"
#   2) Bullets: "should be" -> "was treated as"
#
# Scope:
#   ../cases/*.md only
#
# Usage:
#   chmod +x purity_pass_expected.sh
#   ./purity_pass_expected.sh
# ============================================================

CASES_DIR="${CASES_DIR:-../cases}"

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
  backup_dir="${CASES_DIR}/.backup_purity_expected_${ts}"
  mkdir -p "$backup_dir"
  say "Backups: ${backup_dir}"
}

backup_one() {
  f="$1"
  [ -f "$f" ] || return 0
  cp -p "$f" "${backup_dir}/$(basename "$f")"
}

list_case_files() {
  find "$CASES_DIR" -maxdepth 1 -type f -name "*.md" -print | sort
}

scan_hits() {
  say ""
  say "Scan (report):"
  say "  - should have been"
  say "  - should be (bullets only)"
  say ""

  say "Hits: should have been"
  if grep -RIn --exclude-dir=".backup_*" "should have been" "$CASES_DIR" >/tmp/repac_expected_scan_$$.txt 2>/dev/null; then
    cat /tmp/repac_expected_scan_$$.txt
  else
    say "  (none)"
  fi
  rm -f /tmp/repac_expected_scan_$$.txt

  say ""
  say "Hits: should be (bullets only)"
  # Bullet lines: optional spaces, then -,*,+ then spaces, then contains "should be"
  if grep -RInE --exclude-dir=".backup_*" '^[[:space:]]*[-*+][[:space:]]+.*\bshould be\b' "$CASES_DIR" >/tmp/repac_shouldbe_scan_$$.txt 2>/dev/null; then
    cat /tmp/repac_shouldbe_scan_$$.txt
  else
    say "  (none)"
  fi
  rm -f /tmp/repac_shouldbe_scan_$$.txt
}

rewrite_file() {
  f="$1"
  [ -f "$f" ] || return 0

  before_sig="$(cksum < "$f" | awk '{print $1 ":" $2}')"

  # 1) Global rewrite
  perl -pi -e 's/\bshould have been\b/were expected to be/gi' "$f"

  # 2) Bullet-only rewrite for "should be"
  # Applies only on lines beginning with Markdown bullets (- * +).
  perl -pi -e '
    if (/^[\s]*[-*+][\s]+/i) {
      s/\bshould be\b/was treated as/gi;
    }
  ' "$f"

  after_sig="$(cksum < "$f" | awk '{print $1 ":" $2}')"

  if [ "$before_sig" != "$after_sig" ]; then
    backup_one "$f"
    say "UPDATED: $(basename "$f")"
  fi
}

main() {
  ensure_right_dir
  init_backup_dir

  say "REPAC Tier-1B purity pass:"
  say "  Global:  \"should have been\" -> \"were expected to be\""
  say "  Bullets: \"should be\" -> \"was treated as\""
  say "  Scope:   ${CASES_DIR}/*.md"
  say ""

  say "Before:"
  scan_hits

  say ""
  say "Applying rewrites..."
  changed=0

  for f in $(list_case_files); do
    before="$(cksum < "$f" | awk '{print $1 ":" $2}')"
    rewrite_file "$f"
    after="$(cksum < "$f" | awk '{print $1 ":" $2}')"
    if [ "$before" != "$after" ]; then
      changed=$((changed + 1))
    fi
  done

  say ""
  say "Files changed: $changed"
  say "Backups stored in: $backup_dir"

  say ""
  say "After:"
  scan_hits

  say ""
  say "Next:"
  say "  cd .."
  say "  git status"
  say "  git diff"
  say "If satisfied:"
  say "  git add cases/*.md"
  say "  git commit -m \"Purity pass: replace should-phrases with descriptive equivalents\""
  say "  git push"
}

main "$@"
