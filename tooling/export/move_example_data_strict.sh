#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
REPO_ROOT="$(cd "$REPO_ROOT" && pwd)"

SOURCE_DIR="$REPO_ROOT/viewer/generated/example-data"
TARGET_DIR="$REPO_ROOT/tooling/export/example-data"
DRY_RUN="false"

if [ "${1:-}" = "--dry-run" ]; then
  DRY_RUN="true"
fi

echo "REPAC strict example-data relocation"
echo "Repository root: $REPO_ROOT"
echo "Source:          $SOURCE_DIR"
echo "Target:          $TARGET_DIR"
echo "Dry run:         $DRY_RUN"
echo

if [ ! -d "$SOURCE_DIR" ]; then
  echo "ERROR: Source directory does not exist:"
  echo "  $SOURCE_DIR"
  exit 1
fi

mkdir_cmd() {
  local dir="$1"
  if [ "$DRY_RUN" = "true" ]; then
    echo "[dry-run] mkdir -p \"$dir\""
  else
    mkdir -p "$dir"
  fi
}

move_cmd() {
  local src="$1"
  local dst="$2"
  if [ "$DRY_RUN" = "true" ]; then
    echo "[dry-run] mv \"$src\" \"$dst\""
  else
    mv "$src" "$dst"
  fi
}

remove_dir_if_empty() {
  local dir="$1"
  if [ -d "$dir" ]; then
    if [ "$DRY_RUN" = "true" ]; then
      if [ -z "$(find "$dir" -mindepth 1 -print -quit)" ]; then
        echo "[dry-run] rmdir \"$dir\""
      fi
    else
      rmdir "$dir" 2>/dev/null || true
    fi
  fi
}

mkdir_cmd "$TARGET_DIR"
mkdir_cmd "$TARGET_DIR/supersets"
mkdir_cmd "$TARGET_DIR/documents"
mkdir_cmd "$TARGET_DIR/navigation"
mkdir_cmd "$TARGET_DIR/interrogatives"

echo "Moving top-level example files..."
if [ -f "$SOURCE_DIR/manifest.json" ]; then
  move_cmd "$SOURCE_DIR/manifest.json" "$TARGET_DIR/"
fi

if [ -f "$SOURCE_DIR/ontology-index.json" ]; then
  move_cmd "$SOURCE_DIR/ontology-index.json" "$TARGET_DIR/"
fi

echo
echo "Moving structured example files..."
for subdir in supersets documents navigation interrogatives; do
  if [ -d "$SOURCE_DIR/$subdir" ]; then
    shopt -s nullglob
    for f in "$SOURCE_DIR/$subdir"/*.json; do
      move_cmd "$f" "$TARGET_DIR/$subdir/"
    done
    shopt -u nullglob
  fi
done

echo
echo "Cleaning up empty source directories..."
for subdir in interrogatives navigation documents supersets; do
  remove_dir_if_empty "$SOURCE_DIR/$subdir"
done
remove_dir_if_empty "$SOURCE_DIR"

echo
echo "Done."
echo
echo "Recommended next checks:"
echo "  bash tooling/export/verify_viewer_structure.sh"
echo "  find tooling/export/example-data -type f | sort"