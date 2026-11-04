-- Her görev bir kullanıcıya ait
alter table public.todos
  add column if not exists user_id uuid default auth.uid()
  references auth.users(id) on delete cascade;

create index if not exists todos_user_id_idx on public.todos(user_id);

-- Anonim erişimi kaldır
drop policy if exists "anon full access" on public.todos;

-- Giriş yapan kullanıcı sadece kendi görevlerini görür ve değiştirir
create policy "own todos" on public.todos
  for all to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));
