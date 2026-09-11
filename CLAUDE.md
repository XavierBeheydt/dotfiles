# CLAUDE.md - AGENTS.md

System configuration for Arch Linux + Hyprland (Wayland) + Quickshell —
between a plain dotfiles repo and a small Linux distribution. `AGENTS.md` is
a symlink to this file (see [agents.md](https://agents.md/)).

## Language

All docs, code, comments and commit messages: English, always. In an
interactive session, reply to the user in whatever language they use — this
rule is about repo content, not conversation.

## Layout

- `home/` — symlinked into `$HOME` by `home/.local/bin/bootstrap`
- `etc/` — copied (never symlinked) into `/etc`, root only, via `bootstrap`
- `pkg.list` — installed packages (`pacman -Qqe`, or `paru -Qqe` for AUR too)
- `permissions.conf` — owner/group/mode restored on deploy
  (`dotfiles add <path>`)
- `docs/` — durable reference docs, not the GitHub wiki, so they stay
  versioned and grep-able from any worktree
- `.claude/` — agent-local working dir (worktrees, notes, local settings),
  gitignored; `.agents` is a tracked symlink to it, same idea as
  `AGENTS.md` → `CLAUDE.md`
- `.tmp/` — the user's own untracked scratch notes/temp files, gitignored

## Branching & worktrees

- `main` — protected, merge only via reviewed PR, never push directly
- `dev` — integration branch to locally merge several in-progress feature
  branches together and try them live; not where day-to-day work happens
- Day-to-day work: one branch + one worktree per feature/fix, under
  `.claude/worktrees/<branch-name>` (or the `.agents/worktrees/<branch-name>`
  alias) — no `worktree-` prefix, the branch name is the directory name
- Branch prefixes: `feat/`, `fix/`, `hotfix/`, `release/`, `chore/`, `docs/`,
  `refactor/`, `test/`, `perf/`, `ci/`/`build/`

## Commits & PRs

- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/):
  `type(scope): description`, `!` or a `BREAKING CHANGE:` footer for
  breaking changes
- Co-author commits only if the user opts in; PRs are authored as the user
  by default unless they ask for agent-authored or co-authored instead
- Parked in-progress code (an experiment that doesn't work yet but is worth
  keeping) lives in a **draft PR**, notes and findings in its description —
  not a separate markdown write-up

## Code conventions

- Comment tags: `TODO` (later task) · `FIXME` (known bug, fragile) · `HACK`
  (deliberate workaround, not the real fix) · `XXX` (doubtful/dangerous
  code, look before touching) · `BUG` (confirmed, documented bug) · `NOTE`
  (context, no action needed)
- Every source/config file starts with a copyright header in that
  language's comment syntax: `Copyright (c) <year> <name> <email>` (from
  `git config user.name`/`user.email`)

## Roadmap & skills

Planned work is tracked on the GitHub
[Project board](https://github.com/users/XavierBeheydt/projects/16), not a
hand-maintained file. Every roadmap item must be backed by a real GitHub
Issue — add one with `/roadmap <description>` (see
`.claude/commands/roadmap.md`), never as a bare checklist line or note.
One-off or occasional procedures live in skills, not here, to keep this
file short.
