-- COMMENT
-- 검색(SELECT)

/*
MULTILINE COMMNET
키워드 - 대문자
데이터 - 대소문자를 구별한다.
가독성을 위해서 각 절을 개행해서 작성하는 것이 좋다.

SELECT * | COLUMN_NAME | EXPR | AS ALIAS    - 가져오고자 하는 컬럼 리스트
FROM    TABLE_NAME                          - 대상 테이블
WHERE   SEARCH_CONDITION                    - 행에 대한 제한
*/

SELECT *
FROM    EMPLOYEE ;


SELECT EMP_ID,
       EMP_NAME,
       DEPT_ID
FROM   EMPLOYEE ;


SELECT EMP_ID,
       EMP_NAME,
       DEPT_ID
FROM   EMPLOYEE 
WHERE   DEPT_ID = 90 ;


SELECT  EMP_ID,
        EMP_NAME,
        JOB_ID
FROM    EMPLOYEE 
WHERE   DEPT_ID = 'J1' ;


-- 표현식(컬럼값에 대한 산술 연산)
-- 별칭 주의) 특수문자(공백, 괄호, &) 포함될 경우 반드시 ""
SELECT  EMP_NAME,
        SALARY,
        SALARY * 12 AS ANNUL_SALARY,
        SALARY + (SALARY * BONUS_PCT) * 12 AS "(연봉)"
FROM    EMPLOYEE ;

-- 더미 컬럼 추가
SELECT  EMP_ID,
        EMPLOYEE,
        '재직' AS 근무여부
FROM    EMPLOYEE ;

-- DISTINCT (중복 제거), SELECT 절에 단 한 번만 기술될 수 있다.
SELECT  DISTINCT DEPT_ID
        JOB_ID
FROM    EMPLOYEE ;


-- WHERE 행에 대한 제한
-- 급여가 4000000 보다 많은 사원의 이름과 급여를 조회한다면 ?
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY > 4000000 ;

-- 부서코드가 90이고 급여가 2000000 보다 많은 사원의 부서코드, 급여 조회
SELECT  DEPT_ID AS  부서코드,
        SALARY  AS  급여
FROM    EMPLOYEE
WHERE   DEPT_ID = 90 AND SALARY > 2000000 ;


-- 부서코드가 90이거나 20인 부서원의 이름, 부서코드, 급여 조회
SELECT  EMP_NAME    AS  이름,
        DEPT_ID     AS  부서코드,
        SALARY      AS  급여
FROM    EMPLOYEE
WHERE   DEPT_ID = 20 OR DEPT_ID = 90 ;

-- WHERE (연산자)
-- 연결 연산자 || 

SELECT  EMP_NAME||'의 월급은 '||SALARY||' 입니다.' AS 문장
FROM    EMPLOYEE ;

-- 논리 연산자(AND, OR, NOT)
-- 비교 연산자( = , > , < , >= , <= , != , BETWEEN AND , LIKE , NOT LIKE , IS NULL , IS NOT NULL , IN )

-- 사원 테이블로부터 급여가 3500000 보다 많이 받고 5500000 보다 적게 받는 직원의 이름, 급여 조회
-- 하한값의 경계와 상한 값의 경계를 포함시켜서 
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE 
WHERE   SALARY >= 3500000 AND SALARY <= 5500000 ;

SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE 
WHERE   SALARY BETWEEN 3500000 AND 5500000 ;

-- 사원테이블로부터 '김'씨 성을 가진 직원의 이름, 급여를 조회한다면 ?
-- LIKE 패턴 검색 % , _ <- 언더스코어 하나당 한글자

SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   EMP_NAME LIKE '김__' ;

SELECT  EMP_NAME,
        EMAIL
FROM    EMPLOYEE
WHERE   EMAIL LIKE '___#_%' ESCAPE '#' ; /* 맨 마지막 #을 통해 특수문자를 가져옴, 자기가 원하는 특수문자 넣어도 됨 _ 는 데이터, */

-- 사수번호가 없고 부서 배치도 받지 않은 사원의 이름을 조회한다면 ?
-- 데이터가 NULL인 경우 = 비교가 안된다.

SELECT  EMP_NAME,
        MGR_ID,
        DEPT_ID
FROM    EMPLOYEE
WHERE   MGR_ID IS NULL AND DEPT_ID IS NULL ;

SELECT  EMP_NAME,
        MGR_ID,
        DEPT_ID
FROM    EMPLOYEE
WHERE   MGR_ID IS NOT NULL AND DEPT_ID IS NOT NULL ;

-- 부서 배치를 받지 않았음에도 보너스를 지급받는 직원의 이름을 조회한다면 ?
SELECT  EMP_NAME
FROM    EMPLOYEE
WHERE   DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL;


-- OR 와 IN
SELECT  EMP_NAME    AS  이름,
        DEPT_ID     AS  부서코드,
        SALARY      AS  급여
FROM    EMPLOYEE
WHERE   DEPT_ID = 20 OR DEPT_ID = 90 ;

SELECT  EMP_NAME    AS  이름,
        DEPT_ID     AS  부서코드,
        SALARY      AS  급여
FROM    EMPLOYEE
WHERE   DEPT_ID IN ('20', '90') ;

-- 산술 > 연결 > 비교 > 논리(NOT, AND, OR) 순서로 우선순위


SELECT *
FROM TB_STUDENT ;
--1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명", "계열" 으로 표시하도록 한다.
SELECT  DEPARTMENT_NAME AS "학과 명",
        CATEGORY        AS 계열
FROM    TB_DEPARTMENT ;

/*2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력핚다.
학과별 정원
------------------------------------------------
국어국문학과의 정원은 20 명 입니다
*/
SELECT  DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || '명 입니다.' AS "학과별 정원"
FROM    TB_DEPARTMENT ;


/* 3. "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이
들어왔다. 누구인가? (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서
찾아 내도록 하자)*/

SELECT  *
FROM    TB_STUDENT ;


SELECT  STUDENT_NAME, ABSENCE_YN, DEPARTMENT_NAME, STUDENT_SSN
FROM    TB_DEPARTMENT, TB_STUDENT
WHERE   ABSENCE_YN = 'Y' AND DEPARTMENT_NAME = '국어국문학과' AND STUDENT_SSN LIKE '_______2%' ESCAPE '#' ;

--AND TB_DEPARTMENT.DEPARTMENT_NAME IN '국어국문학과' ;

/*4. 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 핚다. 그 대상자들의
학번이 다음과 같을 때 대상자들을 찾는 적젃핚 SQL 구문을 작성하시오.
A513079, A513090, A513091, A513110, A513119
*/
SELECT  STUDENT_NAME
FROM    TB_STUDENT
WHERE   STUDENT_NO IN ('A513079','A513090', 'A513091', 'A513110', 'A513119') ;

/*5. 입학정원이 20 명 이상 30 명 이하인 학과들의 학과 이름과 계열을 출력하시오.*/

SELECT  DEPARTMENT_NAME, CATEGORY
FROM    TB_DEPARTMENT
WHERE   CAPACITY BETWEEN 20 AND 30 ;

/*6. 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다. 그럼 춘
기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
*/

SELECT  PROFESSOR_NAME
FROM    TB_PROFESSOR
WHERE   DEPARTMENT_NO IS NULL ;

/*7. 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 핚다. 
어떠한 SQL 문장을 사용하면 될 것인지 작성하시오.
*/

SELECT  STUDENT_NAME
FROM    TB_STUDENT
WHERE   DEPARTMENT_NO IS NULL ;

/*8. 수강신청을 하려고 핚다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는
과목들은 어떤 과목인지 과목번호를 조회해보시오.
*/

SELECT  CLASS_NO
FROM    TB_CLASS
WHERE   preattending_class_no IS NOT NULL ;

/*9. 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오.*/

SELECT  DISTINCT CATEGORY
FROM    TB_DEPARTMENT ;

/*10. 02 학번 전주 거주자들의 모임을 맊들려고 핚다. 휴학핚 사람들은 제외핚 재학중인
학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오. */

SELECT  STUDENT_NO, STUDENT_NAME, STUDENT_SSN, student_address
FROM    TB_STUDENT
WHERE   ABSENCE_YN = 'N' AND student_address LIKE '%전주%' ;
