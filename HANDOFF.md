# 📋 원서살롱 Voca Notes App — 세션 핸드오프 (Handoff) 문서

- **작성 일시**: 2026-10-13 21:21
- **프로젝트**: 원서살롱 프라이빗 어휘 노트 & 플래시카드 웹앱 (`WONSEO SALON VOCA NOTES`)
- **작업 파일**: `WONSEO SALON_VocaNotesApp/index.html`
- **현재 배포 URL**: https://wonseo-salon.netlify.app/
- **Supabase 프로젝트 ID**: `wvavbcozkqmrrflgcvlw`

---

## 1. 📌 오늘 완료된 작업 (Completed Today)

### 🔊 단어 읽어주는 기능 (TTS - Text to Speech) 구현 완료
- **적용 기술**: 브라우저 내장 Web Speech API (`window.speechSynthesis`)
- **주요 구현 상세**:
  1. **표 (List 모드)**:
     - 어휘(`Expression`) 옆에 원형 스피커 아이콘 버튼(`.table-tts-btn`) 배치.
     - 클릭 시 표 행 클릭(카드 모드로 전환)이 발생하지 않도록 `event.stopPropagation()` 완벽 처리.
  2. **플래시카드 (Card 모드)**:
     - 단어 바로 아래에 터치하기 편한 타원형 `[🔊 Listen]` 버튼(`.card-tts-btn`) 추가.
  3. **자연스러운 고음질 음성 매칭**:
     - `Google US English`, `Samantha`, `Ava`, `Natural` 등 미국 영어(`en-US`) 최상위 음성을 자동 감지하여 우선 재생.
     - 발음 재생 속도를 `0.92`로 설정하여 명확하고 자연스럽게 발음.
  4. **시각적 애니메이션 피드백**:
     - 음성 재생 중 버튼 색상이 테라코타 포인트 컬러로 전환되며 은은한 음파 파동(`soundWave`) 애니메이션 실행.
  5. **모바일/연속 클릭 방어 코드**:
     - `speechSynthesis.cancel()` 선처리로 연속 탭 시 오디오 겹침 및 끊김 방지.

---

## 2. 🚀 다음 세션에서 바로 진행할 작업 (Next Steps)

사용자께서 **"API 토큰을 전달하여 AI가 100% 자동 처리"** 방식을 선택하셨으므로, 다음 세션 시작 시 **3가지 토큰**을 전달해 주시면 AI가 즉시 자동 연동 작업을 수행합니다.

### 🔑 다음 세션 시작 시 준비할 3가지 토큰
1. **Supabase `service_role` (Secret) 키**:
   - [Supabase API 설정](https://supabase.com/dashboard/project/wvavbcozkqmrrflgcvlw/settings/api) ➔ **Project API keys** ➔ `service_role` 복사
2. **GitHub Personal Access Token**:
   - [GitHub 토큰 생성](https://github.com/settings/tokens/new) ➔ Note: `voca-app`, Scope: **`repo`** 체크 후 발급
3. **Netlify Personal Access Token**:
   - [Netlify 토큰 설정](https://app.netlify.com/user/applications#personal-access-tokens) ➔ **New access token** 클릭 후 발급

---

## 3. 🤖 AI가 다음 세션에서 자동 실행할 작업 파이프라인

토큰이 전달되면 다음 순서로 일괄 자동 실행됩니다:

1. **GitHub**: 원격 저장소 생성 및 현재 프로젝트 파일 일괄 커밋 & 푸시
2. **Supabase DB 보안 (RLS & RPC)**:
   - `verify_member_login(p_name, p_password)` PostgreSQL 보안 함수 원격 생성
   - `members` 테이블 RLS 활성화 (외부 회원정보 탈취 원천 차단)
   - `voca_notes` 테이블 RLS 활성화 (공개 읽기 허용, 비인가 쓰기 차단)
   - `index.html`의 로그인 코드를 보안 RPC 호출 방식으로 변경
3. **Netlify 자동 배포 연결**:
   - Netlify 사이트에 GitHub 저장소 연결 및 자동 빌드/배포 활성화

---

## 4. 📂 파일 현황 요약
- `WONSEO SALON_VocaNotesApp/index.html`: 단어 발음 듣기(TTS) 기능 적용 완료
- `VN-american-hagwon.csv`: American Hagwon 북1 어휘 데이터 (800행)
- `VN-american-hagwon - members.csv`: 멤버 초기 데이터 (8명)
- `HANDOFF.md`: 본 인수인계 문서
