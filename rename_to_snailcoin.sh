#!/usr/bin/env bash
set -euo pipefail

# Run this from the root of the repo: ~/coins/scashx
# It mass-replaces visible "Bitcoin" branding with "Snailcoin"
# in GUI and user-facing text.

COIN_NAME="Snailcoin"
COIN_NAME_LOWER="snailcoin"
CORE_NAME="Snailcoin Core"

# Adjust these if you decide a different ticker
TICKER="SNAIL"
TICKER_LOWER="snail"

# Directories where GUI / user-facing strings live
TARGET_DIRS=(
  "src/qt"
  "share"
  "doc"
  "contrib"
  "."
)

# File types to touch (GUI, UI, docs, translation, config templates)
EXTENSIONS=(
  "cpp" "h" "ui" "qrc" "ts"
  "md" "txt" "in" "rc" "xml"
  "desktop" "json" "py" "sh"
)

echo "=== rename_to_snailcoin.sh ==="
echo "Coin name:       $COIN_NAME"
echo "Lowercase name:  $COIN_NAME_LOWER"
echo "Core name:       $CORE_NAME"
echo "Ticker:          $TICKER"
echo "Ticker (lower):  $TICKER_LOWER"
echo

# Helper: run a search/replace only on the chosen dirs + extensions
replace_all() {
  local from="$1"
  local to="$2"

  echo "Replacing: '$from' -> '$to'"

  for d in "${TARGET_DIRS[@]}"; do
    # Skip .git and build dirs defensively
    if [[ "$d" == ".git" || "$d" == "src/leveldb" || "$d" == "src/secp256k1" ]]; then
      continue
    fi

    find "$d" \
      \( -path "./.git" -o -path "./src/leveldb" -o -path "./src/secp256k1" \) -prune -o \
      \( $(printf ' -name "*.%s" -o' "${EXTENSIONS[@]}" | sed 's/ -o$//') \) \
      -type f -print0 | \
    xargs -0 perl -pi -e "s/$from/$to/g"
  done
}

echo ">>> Make sure you have a clean git state first:"
echo "    git status"
echo

read -p "Continue with replacements? (y/N) " ans
if [[ "$ans" != "y" && "$ans" != "Y" ]]; then
  echo "Aborted."
  exit 1
fi

# 1. Core / app name first (more specific)
replace_all "Bitcoin Core" "$CORE_NAME"
replace_all "bitcoin-core" "snailcoin-core"

# 2. GUI executable name references (not the actual filename yet)
replace_all "bitcoin-qt" "snailcoin-qt"

# 3. Generic branding (order matters: capitalized then lowercase)
replace_all "Bitcoin" "$COIN_NAME"
replace_all "bitcoin" "$COIN_NAME_LOWER"

# 4. Ticker symbols (optional; you can comment these out if you want BTC unchanged)
replace_all "BTC" "$TICKER"
replace_all "btc" "$TICKER_LOWER"

echo
echo "Done. Now re-run qmake/compile if needed and check the GUI."
echo "If something looks wrong, use 'git diff' and 'git restore' to undo."
