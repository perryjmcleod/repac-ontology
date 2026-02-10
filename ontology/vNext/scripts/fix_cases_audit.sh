
#!/usr/bin/env sh
set -eu

# ============================================================
# REPAC vNext — Case Audit Fix Script
# - Normalizes case step H1 headings (Cases 01–03, Steps 07–10)
# - Creates backups of modified files
# - Performs tone-scan report for prescriptive drift
# - Validates it is run from the correct directory (ontology/vNext)
#
# Usage:
#   sh scripts/fix_cases_audit.sh
#   ./scripts/fix_cases_audit.sh
#
# Optional:
#   CASES_DIR=cases sh scripts/fix_cases_audit.sh
# ============================================================

CASES_DIR="${CASES_DIR:-cases}"

say() { printf "%s\n" "$*"; }
die() { say "ERROR: $*"; exit 1; }

ensure_right_dir() {
  base="$(basename "$(pwd)")"
  parent="$(basename "$(dirname "$(pwd)")")"

  [ "$base" = "vNext" ] || die "Run this from the vNext directory (expected pwd to end with /ontology/vNext). Current: $(pwd)"
  [ "$parent" = "ontology" ] || die "Run this from /ontology/vNext (parent folder must be 'ontology'). Current: $(pwd)"

  [ -d "$CASES_DIR" ] || die "Cases directory not found: '$CASES_DIR' (pwd: $(pwd))"
}

init_backup_dir() {
  ts="$(date +%Y%m%d_%H%M%S)"
  backup_dir="${CASES_DIR}/.backup_headings_${ts}"
  mkdir -p "$backup_dir"
  say "Backups: ${backup_dir}"
}

backup_file() {
  f="$1"
  [ -f "$f" ] || return 0
  cp -p "$f" "${backup_dir}/$(basename "$f")"
}

replace_h1_exact() {
  file="$1"
  old="$2"
  new="$3"

  [ -f "$file" ] || { say "SKIP (missing): $file"; return 0; }

  first_line="$(awk 'NR==1{print; exit}' "$file")"
  if [ "$first_line" != "$old" ]; then
    say "OK   (no match): $file"
    return 0
  fi

  backup_file "$file"

  tmp="${file}.tmp.$$"
  awk -v new="$new" 'NR==1{print new; next}{print}' "$file" > "$tmp"
  mv "$tmp" "$file"

  say "FIX  (H1): $file"
}

tone_scan() {
  say ""
  say "Tone scan (report only):"
  say "  Searching for common prescriptive drift terms in ${CASES_DIR}/"
  say ""

  pattern='should|must|need to|best practice|root cause|recommend|recommendation|fix|solution'

  if grep -RInE --exclude-dir=".backup_headings_*" "$pattern" "$CASES_DIR" >/tmp/repac_tone_scan_$$.txt 2>/dev/null; then
    cat /tmp/repac_tone_scan_$$.txt
    say ""
    say "Review the hits above. Not all are violations, but each one is worth confirming against REPAC's non-prescriptive stance."
  else
    say "No hits found for: $pattern"
  fi

  rm -f /tmp/repac_tone_scan_$$.txt
}

main() {
  ensure_right_dir
  init_backup_dir

  say "REPAC: normalizing case step headings in: ${CASES_DIR}"
  say ""

  h07_case01="# REPAC Case 01 — Step 07: Governance and Scope"
  h08_case01="# REPAC Case 01 — Step 08: Communication and Collaboration Analysis"
  h09_case01="# REPAC Case 01 — Step 09: Value and Legitimacy Impacts"
  h10_case01="# REPAC Case 01 — Step 10: Case Synthesis (Non-Prescriptive)"

  h07_case02="# REPAC Case 02 — Step 07: Governance and Scope"
  h08_case02="# REPAC Case 02 — Step 08: Communication and Collaboration Analysis"
  h09_case02="# REPAC Case 02 — Step 09: Value and Legitimacy Impacts"
  h10_case02="# REPAC Case 02 — Step 10: Case Synthesis (Non-Prescriptive)"

  h07_case03="# REPAC Case 03 — Step 07: Governance and Scope"
  h08_case03="# REPAC Case 03 — Step 08: Communication and Collaboration Analysis"
  h09_case03="# REPAC Case 03 — Step 09: Value and Legitimacy Impacts"
  h10_case03="# REPAC Case 03 — Step 10: Case Synthesis (Non-Prescriptive)"

  replace_h1_exact "${CASES_DIR}/REPAC-CASE-01-STEP-07-GOVERNANCE-SCOPE.md" \
    "# REPAC Case 01 — Step 7" "$h07_case01"
  replace_h1_exact "${CASES_DIR}/REPAC-CASE-01-STEP-08-COMMUNICATION-COLLABORATION.md" \
    "# REPAC Case 01 — Step 8" "$h08_case01"
  replace_h1_exact "${CASES_DIR}/REPAC-CASE-01-STEP-09-VALUE-LEGITIMACY-IMPACTS.md" \
    "# REPAC Case 01 — Step 9" "$h09_case01"
  replace_h1_exact "${CASES_DIR}/REPAC-CASE-01-STEP-10-CASE-SYNTHESIS-NON-PRESCRIPTIVE.md" \
    "# REPAC Case 01 — Step 10" "$h10_case01"

  replace_h1_exact "${CASES_DIR}/REPAC-CASE-02-STEP-07-GOVERNANCE-SCOPE.md" \
    "# REPAC Case 02 — Step 7" "$h07_case02"
  replace_h1_exact "${CASES_DIR}/REPAC-CASE-02-STEP-08-COMMUNICATION-COLLABORATION.md" \
    "# REPAC Case 02 — Step 8" "$h08_case02"
  replace_h1_exact "${CASES_DIR}/REPAC-CASE-02-STEP-09-VALUE-LEGITIMACY-IMPACTS.md" \
    "# REPAC Case 02 — Step 9" "$h09_case02"
  replace_h1_exact "${CASES_DIR}/REPAC-CASE-02-STEP-10-CASE-SYNTHESIS-NON-PRESCRIPTIVE.md" \
    "# REPAC Case 02 — Step 10" "$h10_case02"

  replace_h1_exact "${CASES_DIR}/REPAC-CASE-03-STEP-07-GOVERNANCE-SCOPE.md" \
    "# REPAC Case 03 — Step 7" "$h07_case03"
  replace_h1_exact "${CASES_DIR}/REPAC-CASE-03-STEP-08-COMMUNICATION-COLLABORATION.md" \
    "# REPAC Case 03 — Step 8" "$h08_case03"
  replace_h1_exact "${CASES_DIR}/REPAC-CASE-03-STEP-09-VALUE-LEGITIMACY-IMPACTS.md" \
    "# REPAC Case 03 — Step 9" "$h09_case03"
  replace_h1_exact "${CASES_DIR}/REPAC-CASE-03-STEP-10-CASE-SYNTHESIS-NON-PRESCRIPTIVE.md" \
    "# REPAC Case 03 — Step 10" "$h10_case03"

  say ""
  say "Heading normalization complete."
  say "Verify headings:"
  say "  grep -R \"^# REPAC Case\" ${CASES_DIR}/"
  say ""

  tone_scan

  say ""
  say "Next:"
  say "  git status"
  say "  git diff"
  say "If satisfied:"
  say "  git add ${CASES_DIR}/REPAC-CASE-0{1,2,3}-STEP-0{7,8,9}-*.md ${CASES_DIR}/REPAC-CASE-0{1,2,3}-STEP-10-*.md"
  say "  git commit -m \"Normalize case step headings (07–10) and run tone scan\""
  say "  git push"
}

main "$@"
SH
