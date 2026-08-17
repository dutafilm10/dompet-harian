create table if not exists public.categories (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 name text not null,
 budget numeric(14,2) not null default 0 check (budget >= 0),
 created_at timestamptz not null default now()
);
create table if not exists public.expenses (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 category_id uuid not null references public.categories(id) on delete restrict,
 expense_date date not null,
 amount numeric(14,2) not null check (amount > 0),
 note text not null default '',
 created_at timestamptz not null default now()
);
create index if not exists categories_user_id_idx on public.categories(user_id);
create index if not exists expenses_user_id_idx on public.expenses(user_id);
create index if not exists expenses_date_idx on public.expenses(user_id,expense_date);

alter table public.categories enable row level security;
alter table public.expenses enable row level security;

drop policy if exists categories_select_own on public.categories;
drop policy if exists categories_insert_own on public.categories;
drop policy if exists categories_update_own on public.categories;
drop policy if exists categories_delete_own on public.categories;
create policy categories_select_own on public.categories for select to authenticated using ((select auth.uid())=user_id);
create policy categories_insert_own on public.categories for insert to authenticated with check ((select auth.uid())=user_id);
create policy categories_update_own on public.categories for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
create policy categories_delete_own on public.categories for delete to authenticated using ((select auth.uid())=user_id);

drop policy if exists expenses_select_own on public.expenses;
drop policy if exists expenses_insert_own on public.expenses;
drop policy if exists expenses_update_own on public.expenses;
drop policy if exists expenses_delete_own on public.expenses;
create policy expenses_select_own on public.expenses for select to authenticated using ((select auth.uid())=user_id);
create policy expenses_insert_own on public.expenses for insert to authenticated with check ((select auth.uid())=user_id);
create policy expenses_update_own on public.expenses for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
create policy expenses_delete_own on public.expenses for delete to authenticated using ((select auth.uid())=user_id);

grant select,insert,update,delete on public.categories to authenticated;
grant select,insert,update,delete on public.expenses to authenticated;

do $$
begin
 begin alter publication supabase_realtime add table public.categories; exception when duplicate_object then null; end;
 begin alter publication supabase_realtime add table public.expenses; exception when duplicate_object then null; end;
end $$;
