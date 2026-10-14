#!/usr/bin/env bash
# Deploy Angular 20 build to GitHub Pages
# Run from repo root: ./deploy-gh-pages.sh

set -e
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
# Custom domain serves from site root: https://metaldrafting.com/
BASE_HREF="/"
CUSTOM_DOMAIN="metaldrafting.com"
OUT_DIR="dist/metaldrafting-website/browser"

cd "$REPO_ROOT"

if [ ! -f "angular.json" ]; then
  echo "Run this script from the repo root (where angular.json is)."
  exit 1
fi

# Prefer the authenticated origin already configured for this clone
REPO_URL="$(git -C "$REPO_ROOT" remote get-url origin)"

echo "Building Angular app for production (base-href=$BASE_HREF)..."
npx ng build --configuration production --base-href "$BASE_HREF"

if [ ! -f "$OUT_DIR/index.html" ]; then
  echo "Error: Build output not found at $OUT_DIR/index.html"
  exit 1
fi

echo "Adding 404.html for SPA routing..."
cp "$OUT_DIR/index.html" "$OUT_DIR/404.html"

echo "Writing CNAME for custom domain ($CUSTOM_DOMAIN)..."
printf '%s\n' "$CUSTOM_DOMAIN" > "$OUT_DIR/CNAME"

echo "Pushing to gh-pages branch..."
cd "$OUT_DIR"
rm -rf .git
git init
git add -A
git commit -m "Deploy Metal Drafting site to GitHub Pages"
git branch -M main
git remote add origin "$REPO_URL"
git push -f origin main:gh-pages

echo "Done. Pages settings: Branch gh-pages → / (root), custom domain $CUSTOM_DOMAIN"
echo "Live URL: https://$CUSTOM_DOMAIN/"
