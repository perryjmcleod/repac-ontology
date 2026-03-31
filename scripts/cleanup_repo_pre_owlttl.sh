#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

timestamp="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$REPO_ROOT/_cleanup_backup/$timestamp"
ARCHIVE_DIR="$REPO_ROOT/archive/deprecated-pre-semantic-lock/source-legacy"
mkdir -p "$BACKUP_DIR"
mkdir -p "$ARCHIVE_DIR"

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] $*"
  else
    eval "$@"
  fi
}

echo "Repository root: $REPO_ROOT"
echo "Script dir: $SCRIPT_DIR"
echo "Backup dir: $BACKUP_DIR"
echo "Archive dir: $ARCHIVE_DIR"
echo

echo "Step 1: Remove macOS and zip export junk"
while IFS= read -r path; do
  [[ -z "$path" ]] && continue
  run "rm -rf -- \"$path\""
done < <(find . \( -name '.DS_Store' -o -path './__MACOSX' -o -path './__MACOSX/*' \) -print)

echo
echo "Step 2: Remove editor swap artifact if present"
if [[ -f ".git/.COMMIT_EDITMSG.swp" ]]; then
  run "rm -f -- .git/.COMMIT_EDITMSG.swp"
fi

echo
echo "Step 3: Remove known root junk files"
for f in \
  "OLLAtoucN.md" \
  "OLLAtouch" \
  "toucentouch" \
  "touch" \
  "touchboratouch" \
  "touchlabotouch"
do
  if [[ -e "$f" ]]; then
    run "rm -f -- \"$f\""
  fi
done

echo
echo "Step 4: Archive legacy Source subset files that conflict with current semantic lock"
for f in \
  "ontology/vNext/core-extension/source/SOURCE-SUBSET-01-internal" \
  "ontology/vNext/core-extension/source/SOURCE-SUBSET-02-external"
do
  if [[ -e "$f" ]]; then
    base="$(basename "$f")"
    run "cp -p -- \"$f\" \"$ARCHIVE_DIR/$base\""
    run "rm -f -- \"$f\""
  fi
done

echo
echo "Step 5: Reconcile duplicate root vnext directory"
if [[ -d "vnext" ]]; then
  mkdir -p "$BACKUP_DIR/vnext-root-duplicate"
  run "cp -a -- \"vnext\" \"$BACKUP_DIR/vnext-root-duplicate/\""

  echo "Comparing root vnext/ against ontology/vNext/vnext/ ..."
  if [[ -d "ontology/vNext/vnext" ]]; then
    if [[ "$DRY_RUN" -eq 1 ]]; then
      echo "[dry-run] diff -qr vnext ontology/vNext/vnext || true"
    else
      diff -qr vnext ontology/vNext/vnext || true
    fi
  else
    echo "WARNING: ontology/vNext/vnext does not exist; skipping duplicate removal."
  fi

  if [[ -d "ontology/vNext/vnext" ]]; then
    run "rm -rf -- \"vnext\""
  fi
fi

echo
echo "Step 6: Remove empty directories conservatively"
while IFS= read -r d; do
  [[ -z "$d" ]] && continue
  case "$d" in
    ./.git|./.git/*) continue ;;
  esac
  run "rmdir -- \"$d\" 2>/dev/null || true"
done < <(find . -type d -empty -print | sort -r)

echo
echo "Step 7: Final status hints"
echo "Run these next:"
echo "  git status"
echo "  git diff --name-status"
echo "  find ontology/vNext/core-extension -maxdepth 2 -type f | sort"
echo
echo "Cleanup complete."