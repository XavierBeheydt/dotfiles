---
description: Add a roadmap item as a GitHub Issue on this repo's Project board
---

Add "$ARGUMENTS" to this repo's roadmap.

This repo has no hand-maintained ROADMAP.md — the roadmap lives entirely on
GitHub (Project board: https://github.com/users/XavierBeheydt/projects/16,
project number 16, owner XavierBeheydt). **Every roadmap item must be
backed by a real GitHub Issue.** Never add a roadmap idea as just a
checklist line, a comment, or a note somewhere — always go through this
command (or the equivalent manual steps below) so it ends up as an Issue on
the board.

Steps:
1. If "$ARGUMENTS" is empty, ask the user what the roadmap item is before
   doing anything else.
2. Turn it into a concise Issue title and a short body (context, why it
   matters, links to anything already discussed). Follow this repo's usual
   conventions (see CLAUDE.md) for tone/language (English).
3. Create the Issue: `gh issue create --title "..." --body "..."` — add
   `--label enhancement` (or another existing label) if one fits.
4. Add it to the Project board:
   `gh project item-add 16 --owner XavierBeheydt --url <issue-url-from-step-3>`.
5. Report back the issue number and URL.

If project number 16 ever stops resolving (e.g. after a repo reset), check
the current board link in README.md/CLAUDE.md and update this file to
match before continuing.
