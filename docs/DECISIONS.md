# Decisions

Newest last. Each entry: what, why, and what would make us revisit it.

## 001. Public code, private data
Repo is public. Recipes are private to their owner by default. Privacy is enforced by auth plus row-level security, not by hiding the code. Revisit: never; this is a premise.

## 002. Supabase backend
Postgres, Auth, Realtime, Storage. Chosen over CloudKit (awkward on web) and Firebase (NoSQL fits relational recipe data poorly). Revisit if free-tier limits or pausing become a problem.

## 003. Monorepo
`apps/ios`, `apps/web`, `supabase/`, `docs/`. One person, two clients, one schema.

## 004. Recipe sharing is a core feature
Recipes can be shared with other users. This means a sharing model in the schema from day one (who can see or edit what), and RLS policies that express it. Details TBD in the ramble.

## 005. Scaling supports both modes
Scale the number only, keeping units as entered, and also convert between metric and imperial. Ingredients are stored as structured data (amount, unit, name), not free text. Details TBD.

## 006. Heartbeat job keeps the free tier alive
A daily `pg_cron` job writes to a single-row table so the project is not paused after a week of inactivity. Unverified that a cron write counts as activity (informal source). Check after a week. See `supabase/migrations/20261012000000_init_heartbeat.sql`.
