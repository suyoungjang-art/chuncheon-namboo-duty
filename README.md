# 당직근무표 웹앱 설정 방법 (Supabase 연동)

기존 문제: 앱이 화면에서만 데이터를 기억해서, 다시 열 때마다 초기 데이터로 되돌아갔습니다.
해결: Supabase(무료 온라인 데이터베이스)에 실제로 저장하도록 바꿨습니다. 이제 누가 열어도, 몇 번을 다시 열어도 같은 자료가 보이고, 한 사람이 근무를 바꾸면 다른 사람 화면에도 자동으로 반영됩니다.

## ✅ 이미 설정 완료됨

아래 설정을 대신 전부 마쳐뒀습니다. 직원들에게는 이 링크만 공유하시면 됩니다:

**https://suyoungjang-art.github.io/chuncheon-namboo-duty/**

- Supabase 프로젝트: `chuncheon-namboo-duty` (suyoungjang 계정, Seoul 리전)
- 데이터 테이블·보안 규칙(RLS) 생성 완료
- 앱 파일에 연결 정보 반영 완료
- GitHub Pages로 배포 완료 (위 링크로 접속하면 바로 사용 가능)
- 실제 맞바꾸기 동작 → Supabase 저장 → 재접속 시에도 유지되는 것까지 확인 완료

아래 1~5단계는 **참고용**입니다 (나중에 새 Supabase 프로젝트를 직접 만들거나, 다른 컴퓨터에 새로 설정해야 할 때 보시면 됩니다).

새로 만들어진 파일:
- `당직근무_관리앱_웹앱(Supabase).html` ← 실제로 사용할 앱 파일 (기존 파일은 그대로 두었습니다)
- `supabase_schema.sql` ← Supabase에 테이블을 만드는 코드
- 이 설명 파일

---

## 1단계. Supabase 계정 · 프로젝트 만들기 (본인이 직접 진행)

1. https://supabase.com 접속 → **Start your project** → 이메일 또는 구글 계정으로 가입/로그인
2. **New project** 클릭
   - Name: `chuncheon-namboo-duty` (아무 이름이나 가능)
   - Database Password: 임의로 정해서 별도로 기록해두기 (앱에는 사용하지 않지만 분실 방지용)
   - Region: `Northeast Asia (Seoul)` 선택 (가장 빠름)
3. 프로젝트가 만들어질 때까지 1~2분 대기

무료 요금제(Free)로 충분합니다.

## 2단계. 테이블 만들기

1. 왼쪽 메뉴에서 **SQL Editor** 클릭 → **New query**
2. 같은 폴더의 `supabase_schema.sql` 파일 내용을 전부 복사해서 붙여넣기
3. 오른쪽 위 **Run** 클릭 → "Success" 메시지 확인

## 3단계. API 주소 · 키 확인

1. 왼쪽 메뉴 **Project Settings**(톱니바퀴) → **API**
2. 아래 두 값을 복사해두기
   - **Project URL** (예: `https://abcdxyz.supabase.co`)
   - **anon public** 키 (긴 문자열, `service_role` 키는 절대 사용하지 마세요 — 그건 관리자 전용 비밀키입니다)

## 4단계. 앱 파일에 붙여넣기

1. `당직근무_관리앱_웹앱(Supabase).html` 파일을 메모장(또는 VS Code)으로 열기
2. 파일 위쪽 `<script>` 안에서 아래 두 줄을 찾기 (Ctrl+F로 `SUPABASE_URL` 검색)
   ```js
   const SUPABASE_URL = 'https://YOUR-PROJECT-REF.supabase.co';
   const SUPABASE_ANON_KEY = 'YOUR-ANON-PUBLIC-KEY';
   ```
3. 2단계·3단계에서 복사한 값으로 따옴표 안을 바꿔서 저장

이제 이 HTML 파일을 더블클릭해서 열면 바로 Supabase에 연결됩니다. (설정이 안 되어 있으면 화면 위에 빨간 안내 배너가 뜹니다.)

## 5단계. 직원들과 공유하기

이미 GitHub Pages에 배포되어 있습니다 → **https://suyoungjang-art.github.io/chuncheon-namboo-duty/**

이 링크를 직원들에게 그대로 보내주시면 됩니다 (북마크 추천). 앱 파일을 나중에 다시 수정하면, 아래 명령으로 같은 링크에 새 버전을 올릴 수 있습니다 (저장소 폴더에서):
```bash
git add -A && git commit -m "업데이트" && git push
```

---

## 참고 사항

- **보안**: 지금 설정은 "링크를 아는 직원이면 누구나 보고 수정 가능"한 방식입니다(로그인 없음). 내부 업무용으로는 충분하지만, 만약 더 엄격한 접근 제한(직원별 로그인 등)이 필요하면 말씀해 주세요 — Supabase Auth로 확장할 수 있습니다.
- **관리자 인증번호**: 기존 앱과 동일하게 "이 달 초기화", "공휴일 관리", "순번 관리"는 관리자 인증번호(기본 `5600`)로 보호됩니다. 이 번호도 이제 Supabase에 저장되므로, 한 번 바꾸면 모든 사람에게 동일하게 적용됩니다.
- **동시 저장 충돌**: 두 사람이 정확히 같은 순간에 저장하면 나중에 저장한 내용이 앞선 내용을 덮어씁니다. 당직 맞바꾸기처럼 가끔 일어나는 작업에서는 문제되지 않습니다.
- **기존 파일**: `당직근무_관리앱_10 (3) (1).html`은 그대로 남겨두었습니다(백업용). 실제 운영은 `(Supabase)` 파일로 해주세요.
- **GitHub 저장소는 공개(Public)입니다**: https://github.com/suyoungjang-art/chuncheon-namboo-duty — GitHub Pages 무료 배포 조건상 공개 저장소여야 합니다. 저장소 안에 있는 Supabase 키는 "anon(공개용)" 키로, 애초에 브라우저에 노출되도록 설계된 키이고 RLS 정책으로 보호되므로 공개되어도 안전합니다(운영자 전용 `service_role` 키는 어디에도 포함하지 않았습니다).
