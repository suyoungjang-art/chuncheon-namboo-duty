-- 당직근무 관리앱 · Supabase 테이블 설정
-- Supabase 대시보드 → SQL Editor 에서 이 파일 내용을 그대로 붙여넣고 "Run" 하세요.

-- 1) 데이터를 저장할 테이블 (키-값 저장소 방식)
--    - key: '로스터', '공휴일', '2026-08 배정표'처럼 데이터 종류를 구분하는 이름
--    - value: 실제 데이터(JSON)
create table if not exists public.duty_kv (
  key text primary key,
  value jsonb not null,
  updated_at timestamptz not null default now()
);

-- 2) 보안 설정: 로그인 없이도 링크를 아는 직원 누구나 같은 자료를 보고 수정할 수 있게 합니다.
--    (내부 업무용 앱 기준. 더 강한 보안이 필요하면 이후 Supabase Auth로 정책을 바꿀 수 있습니다.)
alter table public.duty_kv enable row level security;

drop policy if exists "public read" on public.duty_kv;
create policy "public read" on public.duty_kv
  for select using (true);

drop policy if exists "public insert" on public.duty_kv;
create policy "public insert" on public.duty_kv
  for insert with check (true);

drop policy if exists "public update" on public.duty_kv;
create policy "public update" on public.duty_kv
  for update using (true) with check (true);

-- 3) 실시간 동기화(다른 사람이 저장하면 내 화면도 자동 새로고침) 사용을 위해 추가
alter publication supabase_realtime add table public.duty_kv;
