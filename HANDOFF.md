# 📋 원서살롱 Voca Notes App — 세션 핸드오프 (Handoff) 문서

- **최종 업데이트**: 2026-10-25 17:15
- **프로젝트**: 원서살롱 프라이빗 어휘 노트 & 플래시카드 웹앱 (`WONSEO SALON VOCA NOTES`)
- **라이브 서비스 URL**: https://wonseo-salon.netlify.app/
- **GitHub 저장소**: https://github.com/galaxy-eunhacho/wonseo-salon (`main` 브랜치)
- **Supabase 프로젝트 ID**: `wvavbcozkqmrrflgcvlw`
- **Netlify Site ID**: `aaa1ed83-f17d-4b23-9f63-16505e7ac58c`
- **핵심 파일**: `index.html` 및 `WONSEO SALON_VocaNotesApp/index.html` (상시 동기화)

---

## 1. 📌 최근 완료된 작업 요약 (2026-10-25)

### 📚 1) American Hagwon — BOOK II 어휘 데이터 추가 (총 595개 어휘)
- **어휘 범위**: ID `806` ~ `1400` (총 595개 행)
- **챕터 구성 (총 15개)**:
  - `Epigraph` (`b2q1`): 3개
  - `Ch 1. Letters` (`b2c1`): 30개
  - `Ch 2. Suneung` (`b2c2`): 73개
  - `Ch 3. Transit` (`b2c3`): 45개
  - `Ch 4. SUDS` (`b2c4`): 74개
  - `Ch 5. Financial Crisis` (`b2c5`): 58개
  - `Ch 6. Economy` (`b2c6`): 30개
  - `Ch 7. Property` (`b2c7`): 50개
  - `Ch 8. Solace` (`b2c8`): 27개
  - `Ch 9. Self-Determination` (`b2c9`): 41개
  - `Ch 10. Orange County` (`b2c10`): 23개
  - `Ch 11. Mall` (`b2c11`): 30개
  - `Ch 12. Lost and Found` (`b2c12`): 32개
  - `Ch 13. Rescue` (`b2c13`): 27개
  - `Ch 14. Debtors` (`b2c14`): 52개
- **DB 및 파일 반영**:
  - Supabase `voca_notes` 테이블에 일괄 적재 완료.
  - 통합 CSV [VN-american-hagwon.csv](file:///c:/Users/USER/Documents/%EC%9B%90%EC%84%9C%EC%82%B4%EB%A1%B1/Voca%20Notes%20App/VN-american-hagwon.csv)에 병합 (Book I 805행 + Book II 595행 = 총 1,400행).
  - 원본 [VN-american-hagwon-Book II.csv](file:///c:/Users/USER/Documents/%EC%9B%90%EC%84%9C%EC%82%B4%EB%A1%B1/Voca%20Notes%20App/VN-american-hagwon-Book%20II.csv) 보관.

### 📄 2) 표(Table) 페이지 번호 100자리 줄 바꿈 방지
- **개선 상세**: `.col-page` 셀 스타일을 `width: 80px; min-width: 78px; white-space: nowrap !important;`로 설정하여 `p. 107`, `p. 125`, `p. 230` 등 세 자리 페이지 번호가 모바일/PC 상관없이 절대 두 줄로 분리되지 않도록 처리.

### 📖 3) 목차(TOC) 아코디언 접기/펼치기 UI 구현
- **초기 상태**: 책(American Hagwon)에 처음 들어갔을 때 모든 챕터가 펼쳐지지 않고, `BOOK I`, `BOOK II`, `BOOK III`...이 깔끔하게 접힌 카드 형태로 노출.
- **클릭 동작**: 헤더 클릭 시 셰브론(`▼` ➔ `▲`) 회전 애니메이션과 함께 하위 챕터 메뉴가 부드럽게 펼쳐짐/접힘 (`toggleTocSection`).
- **스마트 뒤로가기**: 단어장/플래시카드를 보다가 상단 뒤로가기(`‹`)를 누르면 직전에 읽던 Book 섹션이 자동으로 열린 상태로 복원되어 탐색 연속성 보장.

### 🏷️ 4) 챕터 수 배지 및 네비게이션 표기 규칙 (지속 규칙)
- **규칙 1 (배지 카운트)**: `Epigraph`는 번호가 부여된 챕터가 아니므로 챕터 수 배지에서 제외.
  - Book I: `12 Chapters` (Ch 1~12)
  - Book II: `14 Chapters` (Ch 1~14)
- **규칙 2 (네비게이션 링크 표기)**: Prev / Next 버튼에서 Book II 이후의 Epigraph는 소설 맨 앞으로 돌아가는 오해를 방지하기 위해 반드시 `Book II. Epigraph`, `Book III. Epigraph` 등으로 표기 (`getNavChapterTitle`).

---

## 2. ⚙️ 핵심 개발 및 운영 규칙 (AI 항시 준수 원칙)

> [!IMPORTANT]
> **핸드오프 문서 자동 갱신 원칙**:
> 사용자가 별도로 요청하지 않더라도 작업이 완료되거나 주요 변경이 발생할 때마다 본 `HANDOFF.md` 문서를 항상 최신 상태로 업데이트할 것.

1. **파일 이중 동기화**:
   - `index.html`과 `WONSEO SALON_VocaNotesApp/index.html`은 항상 100% 동일한 내용으로 유지해야 합니다.
2. **배포 파이프라인**:
   - 코드나 데이터 수정 후 반드시 `powershell -ExecutionPolicy Bypass -File push_to_github.ps1`을 실행하여 GitHub에 반영 ➔ Netlify 자동 배포 트리거.
   - 배포 후 `check_deploy_status.ps1` 및 `verify_live.ps1`로 라이브 반영 여부 확인.
3. **새로운 북/권(Book) 데이터 추가 시 체크리스트**:
   - [ ] 엑셀/CSV 데이터의 컬럼 매핑: `id`, `book_id`, `section`, `ch_id`, `chapter`, `page`, `expression`, `meaning`, `context`
   - [ ] Supabase `voca_notes`에 `service_role` 키로 일괄 upsert (`upload_book*.ps1` 패턴)
   - [ ] `VN-american-hagwon.csv`에 추가 병합
   - [ ] `index.html` 내 `booksData`의 목차(`toc`) 챕터 배열 갱신 및 `hasData: true` 설정
   - [ ] `push_to_github.ps1` 내 `$filesToUpload` 목록에 신규 CSV 포함 여부 확인 후 배포

---

## 3. 📂 현재 프로젝트 파일 구조

```
Voca Notes App/
├── index.html                           # 메인 웹앱 소스 (루트)
├── WONSEO SALON_VocaNotesApp/
│   └── index.html                       # 메인 웹앱 소스 (동기화 복사본)
├── AmericanHagwon.jpg                   # 도서 표지 이미지
├── VN-american-hagwon.csv               # 북1 + 북2 통합 어휘 DB (1,400행)
├── VN-american-hagwon-Book II.csv       # 북2 원본 어휘 데이터 (595행)
├── VN-american-hagwon - members.csv     # 회원 목록 및 로그인 비밀번호 (9명)
├── netlify.toml                         # Netlify 배포 및 보안 헤더 설정
├── supabase_security_setup.sql          # Supabase RLS 보안 및 RPC 로그인 함수 SQL
├── push_to_github.ps1                   # GitHub API 직접 커밋 & 푸시 스크립트
├── check_deploy_status.ps1              # Netlify 배포 상태 실시간 확인 스크립트
├── verify_live.ps1                      # 라이브 사이트 무결성 검증 스크립트
└── HANDOFF.md                           # 본 인수인계 문서
```

---

## 4. 🚀 다음 예정 작업 (Backlog)

1. **BOOK III 어휘 데이터 준비 시 연동**:
   - 기간: `October 1999–January 2001`
   - CSV 수령 ➔ Supabase 적재 ➔ 목차 활성화
2. **BOOK IV, BOOK V 순차 확장**:
   - 전체 American Hagwon 시리즈 완성
3. **추가 도서 (Pachinko 등) 등록**:
   - 필요 시 목차 및 어휘 데이터베이스 추가 구성
