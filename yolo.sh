#!/usr/bin/env bash
# YOLO: merge a pull request without requesting/getting a review.
# Requires: gh CLI authenticated, run inside a local clone of a repo you own,
# with a remote named "origin".
set -euo pipefail

BRANCH="yolo-achievement-$(date +%s)"
DEFAULT_BRANCH=$(gh repo view --json defaultBranchRef -q .defaultBranchRef.name)

echo "Creating branch $BRANCH off $DEFAULT_BRANCH..."
git fetch origin "$DEFAULT_BRANCH" -q
git checkout -b "$BRANCH" "origin/$DEFAULT_BRANCH"

echo "yolo achievement $(date -u)" >> YOLO.md
git add YOLO.md
git commit -q -m "chore: trigger YOLO achievement"
git push -q -u origin "$BRANCH"

echo "Opening PR..."
PR_URL=$(gh pr create \
  --title "YOLO achievement PR" \
  --body "Opened to trigger the YOLO achievement. Merging without review." \
  --base "$DEFAULT_BRANCH" \
  --head "$BRANCH")

echo "Merging without review..."
gh pr merge "$PR_URL" --merge --delete-branch

echo "Done. Merged $PR_URL without a review."
echo "YOLO should appear on your profile within a few minutes."
