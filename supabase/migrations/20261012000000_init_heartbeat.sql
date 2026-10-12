-- Keeps the free-tier project from being paused for inactivity.
-- A daily pg_cron job writes to a single-row table. Supabase pauses free
-- projects with little user database activity over 7 days, and a cron write
-- is database activity. Verify against the current "Project Pausing" docs.

create extension if not exists pg_cron with schema pg_catalog;

-- Single-row table: the boolean primary key with check (id) allows only `true`,
-- so the job updates one row instead of growing the table forever.
create table if not exists public.heartbeat (
  id      boolean primary key default true check (id),
  beat_at timestamptz not null default now()
);

-- RLS on with no policies: the anon and authenticated roles get no access via
-- the API. The cron job runs as postgres, which bypasses RLS. The revoke is
-- defence in depth in case RLS is ever switched off by mistake.
alter table public.heartbeat enable row level security;
revoke all on public.heartbeat from anon, authenticated;

-- cron.schedule with a job name replaces any existing job of that name,
-- so re-running this migration doesn't create duplicates.
select cron.schedule(
  'heartbeat',
  '0 6 * * *',  -- daily, 06:00 UTC
  $$
    insert into public.heartbeat (id, beat_at) values (true, now())
    on conflict (id) do update set beat_at = excluded.beat_at
  $$
);
