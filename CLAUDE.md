# recipe-tracker

Recipe tracker with quantity scaling. iOS + web, synced via Supabase. Public code, private data. Read `docs/DECISIONS.md` first, then `docs/RAMBLE.md` and `docs/PLAN.md` if they exist.

## Rules

- **No secrets in the repo.** It is public. The Supabase anon key is fine to commit only because every table has row-level security. Service-role keys, passwords and tokens never go in git.
- **Every table gets RLS in the same migration that creates it.** No table ships without it.
- **Schema changes are migrations in `supabase/migrations/`.** Never edit an applied migration; add a new one.
- **Record non-obvious decisions in `docs/DECISIONS.md`**, not in code comments.
- **Plan before writing** for any task touching more than one file, then wait for approval.
- **Ask rather than assume** when requirements are ambiguous.
- **One task at a time.** Mention unrelated problems instead of fixing them.
- **Don't mark a task done when part of it is unverified.** Say which part.

## Workflow

Ramble (`docs/RAMBLE.md`) -> formalised requirements -> `docs/PLAN.md` -> parallel agents execute tasks from the plan.
