-- 媽媽的手帳：在 Supabase「SQL Editor」貼上整份，按 Run 一次就好

-- 1. 資料表：每個帳號一列，整本手帳存在 data 裡
create table if not exists public.app_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;

drop policy if exists "only my own notebook" on public.app_state;
create policy "only my own notebook" on public.app_state
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- 2. 放畫作照片的空間
insert into storage.buckets (id, name, public)
values ('paintings', 'paintings', true)
on conflict (id) do nothing;

drop policy if exists "upload my paintings" on storage.objects;
create policy "upload my paintings" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'paintings' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "delete my paintings" on storage.objects;
create policy "delete my paintings" on storage.objects
  for delete to authenticated
  using (bucket_id = 'paintings' and (storage.foldername(name))[1] = auth.uid()::text);
