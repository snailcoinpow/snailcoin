#!/usr/bin/env bash
set -euo pipefail

# Run this from the root of the repo: ~/coins/scashx
# It mass-replaces visible "ScashX" branding with "Snailcoin"
# and "scashx" with "snailcoin" in GUI / user-facing text.

OLD_CAMEL="ScashX"
OLD_LOWER="scashx"
OLD_UPPER="SCASHX"

NEW_CAMEL="Snailcoin"
NEW_LOWER="snailcoin"
NEW_UPPER="SNAILCOIN"

# If you want to change tickers too, adjust these; for now they are just examples.
OLD_TICKER="SCASH"
OLD_TICKER_LOWER="scash"
NEW_TICKER="SNAIL"
NEW_TICKER_LOWER="snail"

TARGET_DIRS=(
  "src/qt"
  "share"
  "doc"
  "contrib"
  "."
)

EXTENSIONS=(
  "cpp" "h" "ui" "qrc" "ts"
  "md" "txt" "in" "rc" "xml"
  "desktop" "json" "py" "sh"
)

echo "=== rename_scashx_to_snailcoin.sh ==="
echo "From: $OLD_CAMEL / $OLD_LOWER / $OLD_UPPER"
echo "To:   $NEW_CAMEL / $NEW_LOWER / $NEW_UPPER"
echo "Ticker: $OLD_TICKER -> $NEW_TICKER (can disable inside script)"
echo

echo ">>> Make sure git is clean so you can undo if needed:"
echo "    git status"
echo

read -p "Continue with replacements? (y/N) " ans
if [[ "$ans" != "y" && "$ans" != "Y" ]]; then
  echo "Aborted."
  exit 1
fi

replace_all() {
  local from="$1"
  local to="$2"

  echo "Replacing: '$from' -> '$to'"

  for d in "${TARGET_DIRS[@]}"; do
    find "$d" \
      \( -path "./.git" -o -path "./src/leveldb" -o -path "./src/secp256k1" \) -prune -o \
      \( $(printf ' -name "*.%s" -o' "${EXTENSIONS[@]}" | sed 's/ -o$//') \) \
      -type f -print0 | \
    xargs -0 perl -pi -e "s/$from/$to/g"
  done
}

# 1. Brand name in different casings
replace_all "$OLD_CAMEL" "$NEW_CAMEL"
replace_all "$OLD_LOWER" "$NEW_LOWER"
replace_all "$OLD_UPPER" "$NEW_UPPER"

# 2. Ticker (comment these out if you want to keep SCASH for now)
replace_all "$OLD_TICKER" "$NEW_TICKER"
replace_all "$OLD_TICKER_LOWER" "$NEW_TICKER_LOWER"

echo
echo "Done. Check changes with 'git diff'. If something looks wrong, use 'git restore .' to undo."
