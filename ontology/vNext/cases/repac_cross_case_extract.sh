#!/usr/bin/env bash
set -euo pipefail

OUT="REPAC-CROSS-CASE-EXTRACTION-PACKET.md"
: > "$OUT"

echo "# REPAC Cross-Case Extraction Packet" >> "$OUT"
echo "" >> "$OUT"
echo "Generated: $(date)" >> "$OUT"
echo "" >> "$OUT"

for n in 01 02 03 04 05 06 07; do
  echo "## REPAC-CASE-${n}" >> "$OUT"
  echo "" >> "$OUT"

  # Root case file
  root="REPAC-CASE-${n}.md"
  if [ -f "$root" ]; then
    echo "### ${root}" >> "$OUT"
    echo "" >> "$OUT"
    echo '```markdown' >> "$OUT"
    cat "$root" >> "$OUT"
    echo "" >> "$OUT"
    echo '```' >> "$OUT"
    echo "" >> "$OUT"
  else
    echo "_Missing: ${root}_" >> "$OUT"
    echo "" >> "$OUT"
  fi

  # Steps 06-10
  for step in 06 07 08 09 10; do
    f="REPAC-CASE-${n}-STEP-${step}-"*.md
    # shellcheck disable=SC2086
    if ls $f >/dev/null 2>&1; then
      # shellcheck disable=SC2086
      for file in $f; do
        echo "### ${file}" >> "$OUT"
        echo "" >> "$OUT"
        echo '```markdown' >> "$OUT"
        cat "$file" >> "$OUT"
        echo "" >> "$OUT"
        echo '```' >> "$OUT"
        echo "" >> "$OUT"
      done
    else
      echo "_Missing: REPAC-CASE-${n}-STEP-${step}-*_" >> "$OUT"
      echo "" >> "$OUT"
    fi
  done

  echo "" >> "$OUT"
done

echo "Wrote: ${OUT}" >&2
