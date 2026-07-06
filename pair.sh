#!/usr/bin/env bash
# Pair Extraordinaire: merge a PR with a commit co-authored by a second
# GitHub account. You need access to a second account/email (e.g. a personal
# + work account, or an alt account you own) — this can't be faked with a
# made-up email, GitHub checks it against a real verified account.
set -euo pipefail

COAUTHOR_NAME="${1:-}"
COAUTHOR_EMAIL="${2:-}"

if [[ -z "$COAUTHOR_NAME" || -z "$COAUTHOR_EMAIL" ]]; then
  echo "Usage: $0 \"Second Account Name\" second-account-email@example.com"
  echo "The email must belong to a verified GitHub account you control."
  exit 1
fi

BRANCH="pair-achievement-$(date +%s)"
DEFAULT_BRANCH=$(gh repo view --json defaultBranchRef -q .defaultBranchRef.name)

git fetch origin "$DEFAULT_BRANCH" -q
git checkout -b "$BRANCH" "origin/$DEFAULT_BRANCH"

echo "pair achievement $(date -u)" >> PAIR.md
git add PAIR.md
git commit -q -m "chore: trigger Pair Extraordinaire achievement

Co-authored-by: ${COAUTHOR_NAME} <${COAUTHOR_EMAIL}>"

git push -q -u origin "$BRANCH"

PR_URL=$(gh pr create \
  --title "Pair Extraordinaire achievement PR" \
  --body "Co-authored commit to trigger the Pair Extraordinaire achievement." \
  --base "$DEFAULT_BRANCH" \
  --head "$BRANCH")

gh pr merge "$PR_URL" --merge --delete-branch

echo "Done. Merged $PR_URL with a Co-authored-by trailer for ${COAUTHOR_EMAIL}."
echo "Both accounts should see Pair Extraordinaire within a few minutes."
