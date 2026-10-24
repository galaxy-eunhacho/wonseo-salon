-- ================================================================
-- 원서살롱 Voca Notes App — Supabase 보안 강화 (RLS & RPC 함수)
-- 실행 위치: Supabase 대시보드 -> SQL Editor -> New Query 에 붙여넣고 "Run"
-- ================================================================

-- 1. members 테이블 Row Level Security (RLS) 활성화
-- 기본적으로 모든 외부 직접 접근(SELECT, INSERT, UPDATE, DELETE)을 차단하여
-- 익명 키(anon key)로 멤버 목록 및 비밀번호가 탈취되는 것을 원천 방지합니다.
ALTER TABLE public.members ENABLE ROW LEVEL SECURITY;

-- 기존 정책 충돌 방지
DROP POLICY IF EXISTS "Deny all public direct access on members" ON public.members;
DROP POLICY IF EXISTS "Allow anon login RPC only" ON public.members;

-- 2. voca_notes 테이블 Row Level Security (RLS) 활성화
ALTER TABLE public.voca_notes ENABLE ROW LEVEL SECURITY;

-- voca_notes 정책: 누구나 읽을 수 있지만(SELECT), 웹에서 임의로 수정/삭제/추가는 불가능하게 제한
DROP POLICY IF EXISTS "Allow public read access on voca_notes" ON public.voca_notes;
CREATE POLICY "Allow public read access on voca_notes"
ON public.voca_notes
FOR SELECT
TO anon, authenticated
USING (true);

-- 3. 안전한 멤버 로그인 검증 RPC 함수 생성 (SECURITY DEFINER)
-- 비밀번호는 외부로 절대 반환하지 않으며, 일치 여부와 권한 컬럼만 안전하게 반환합니다.
CREATE OR REPLACE FUNCTION public.verify_member_login(
    p_name text,
    p_password text
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_member record;
BEGIN
    -- 공백 제거 및 대소문자 무시(LOWER)로 회원 조회
    SELECT "Name", is_active, auth_american, auth_pachinko
    INTO v_member
    FROM public.members
    WHERE LOWER(TRIM("Name")) = LOWER(TRIM(p_name))
      AND "Password" = TRIM(p_password);

    -- 일치하는 회원 정보가 없는 경우
    IF NOT FOUND THEN
        RETURN json_build_object(
            'success', false,
            'error', 'invalid_credentials'
        );
    END IF;

    -- 비활성화된 계정인 경우
    IF v_member.is_active = false THEN
        RETURN json_build_object(
            'success', false,
            'error', 'inactive_account'
        );
    END IF;

    -- 인증 성공: 비밀번호를 제외한 안전한 사용자 프로필 반환
    RETURN json_build_object(
        'success', true,
        'user', json_build_object(
            'Name', v_member."Name",
            'is_active', v_member.is_active,
            'auth_american', v_member.auth_american,
            'auth_pachinko', v_member.auth_pachinko
        )
    );
END;
$$;

-- 4. anon 및 authenticated 역할에 RPC 실행 권한 부여
GRANT EXECUTE ON FUNCTION public.verify_member_login(text, text) TO anon, authenticated, service_role;
