create table if not exists public.todos (
  id bigint generated always as identity primary key,
  text text not null,
  done boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.todos enable row level security;

-- Kişisel, yerelde açılan sayfa: anon anahtarla tam erişim
create policy "anon full access" on public.todos
  for all to anon using (true) with check (true);
