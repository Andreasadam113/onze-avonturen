create extension if not exists pgcrypto;

create table if not exists public.avonturen (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  emoji text not null default '🌿',
  done boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.avonturen enable row level security;

-- Voor een gedeelde openbare lijst zonder login.
drop policy if exists "avonturen_select_public" on public.avonturen;
create policy "avonturen_select_public"
  on public.avonturen
  for select
  to anon
  using (true);

drop policy if exists "avonturen_insert_public" on public.avonturen;
create policy "avonturen_insert_public"
  on public.avonturen
  for insert
  to anon
  with check (true);

drop policy if exists "avonturen_update_public" on public.avonturen;
create policy "avonturen_update_public"
  on public.avonturen
  for update
  to anon
  using (true)
  with check (true);

drop policy if exists "avonturen_delete_public" on public.avonturen;
create policy "avonturen_delete_public"
  on public.avonturen
  for delete
  to anon
  using (true);

alter publication supabase_realtime add table public.avonturen;
