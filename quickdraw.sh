#!/usr/bin/env bash
# Quickdraw: close an issue or PR within 5 minutes of opening it.
# Requires: gh CLI authenticated, run inside a repo you own.
set -euo pipefail

REPO="${1:-}"
if [[ -z "$REPO" ]]; then
  echo "Usage: $0 <owner/repo>"
  echo "Example: $0 lisa/my-project"
  exit 1
fi

echo "Opening issue on $REPO..."
ISSUE_URL=$(gh issue create \
  --repo "$REPO" \
  --title "Quickdraw achievement issue" \
  --body "Opened to trigger the Quickdraw achievement. Safe to close/delete." )

echo "Created: $ISSUE_URL"

ISSUE_NUMBER=$(basename "$ISSUE_URL")

echo "Closing immediately..."
gh issue close "$ISSUE_NUMBER" --repo "$REPO"

echo "Done. Closed issue #$ISSUE_NUMBER within seconds of opening it."
echo "Quickdraw should appear on your profile within a few minutes."
