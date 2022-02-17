/*

DAY 03 ORDER BY

MULTILINE COMMNET

키워드 - 대문자
데이터 - 대소문자를 구별한다.
가독성을 위해서 각 절을 개행해서 작성하는 것이 좋다.

PARSING 순서
 - FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY

SELECT * | COLUMN_NAME | EXPR | AS ALIAS    - 가져오고자 하는 컬럼 리스트
FROM    TABLE_NAME                          - 대상 테이블
 -- WHERE   SEARCH_CONDITION                - 행에 대한 제한
 -- GROUP BY 기준컬럼                        - 그룹핑
 -- HAVING  SEARCH_CONDITION                - 그룹에 대한 조건
 -- ORDER BY 기준컬럼 [ ASC | DESC ]         - 정렬할 때 사용 , SELECT의 마지막에 한 번만 등장할 수 있다.

*/


SELECT  *
FROM    EMPLOYEE
ORDER BY    SALARY DESC , EMP_NAME DESC ;   -- 급여가 같을 때는 다른 기준 컬럼도 정의할 수 있다.

--별칭 사용 가능
SELECT  EMP_NAME AS 이름,
        HIRE_DATE AS 입사일,
        DEPT_ID AS  부서코드
FROM    EMPLOYEE
ORDER BY  부서코드 DESC , 입사일 , 이름 ;  -- 정해준 이름을 사용할 수 도 있다.


-- 인덱스 사용 가능
SELECT  EMP_NAME AS 이름,
        HIRE_DATE AS 입사일,
        DEPT_ID AS  부서코드
FROM    EMPLOYEE
ORDER BY  3 DESC , 2 , 1 ; 

-- GROUP BY : 하위 데이터 그룹
/*10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 맊들어 결과값이 출력되도록 하시오.*/
SELECT  DEPARTMENT_NO "학과번호",
        COUNT(*)      "학생수(명)"
FROM    TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1 ASC ;

-- 부서별 평균 급여를 조회하고 싶다면 ? 

SELECT  DEPT_ID,
        ROUND(AVG(SALARY) , -4) AS 평균 급여
FROM    EMPLOYEE
GROUP BY    DEPT_ID ;

-- 성별에 따른 평균 급여도 조회
SELECT  CASE WHEN SUBSTR(EMP_NO, 8 , 1) IN ('1' , '3') THEN 'MALE' ELSE 'FEMALE' END AS 성별,
        ROUND(AVG(SALARY), -4) AS 평균급여
FROM    EMPLOYEE
GROUP BY CASE WHEN SUBSTR(EMP_NO, 8 , 1) IN ('1' , '3') THEN 'MALE' ELSE 'FEMALE' END ;

SELECT  DEPT_ID,
        EMP_NAME,
        COUNT(*)
FROM    EMPLOYEE
GROUP BY DEPT_ID, EMP_NAME ;

SELECT       DEPT_ID,
             SUM(SALARY)
FROM         EMPLOYEE 
GROUP BY     DEPT_ID 
HAVING      SUM(SALARY) > 9000000 ;             -- WHERE 절에는 그룹함수가 쓰일 수 없다.


/*11. 지도 교수를 배정받지 못핚 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을
작성하시오.*/

SELECT *
FROM   TB_STUDENT ; 

SELECT  COUNT(*), coach_professor_no
FROM    TB_STUDENT
GROUP BY COACH_PROFESSOR_NO
HAVING  COACH_PROFESSOR_NO IS NULL ;


-- ANSI 표준
-- CASE EXPR WHEN SEARCH THE RESULT [ WHEN SEARCH THE RESULT ] ELSE DEFAULT END
-- CASE WHEN CONDITION THE RESULT [ WHEN SEARCH THE RESULT ] ELSE DEFAULT END
SELECT  SALARY, DEPT_ID,
        CASE DEPT_ID 
            WHEN '90' THEN SALARY * 1.1
            ELSE SALARY
            END AS 인상급여
FROM    EMPLOYEE ;



/*12. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 단, 
이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여
소수점 이하 핚 자리까지맊 표시핚다*/

SELECT  SUBSTR(TERM_NO , 1, 4) AS 년도,
        CASE
            WHEN SUBSTR(TERM_NO, 1, 4) = '2001' THEN ROUND(AVG(POINT), 1)
            WHEN SUBSTR(TERM_NO, 1, 4) = '2002' THEN ROUND(AVG(POINT), 1)
            WHEN SUBSTR(TERM_NO, 1, 4) = '2003' THEN ROUND(AVG(POINT), 1)
            WHEN SUBSTR(TERM_NO, 1, 4) = '2004' THEN ROUND(AVG(POINT), 1)
            END AS "년도 별 평점"
FROM    TB_GRADE
WHERE   STUDENT_NO = 'A112113'
GROUP BY    SUBSTR(TERM_NO, 1, 4)
ORDER BY    SUBSTR(TERM_NO, 1, 4);
        

/*13. 학과 별 휴학생 수를 파악하고자 핚다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을
작성하시오.*/

SELECT *
FROM    TB_STUDENT ;

SELECT  DEPARTMENT_NO 학과코드명 ,
        COUNT(CASE WHEN ABSENCE_YN = 'Y' THEN 1 -- THEN은 같은걸 세는 거라 뭘 넣어도 상관 없는 듯?
        END) AS "휴학생 수"
FROM    TB_STUDENT 
GROUP BY DEPARTMENT_NO
ORDER BY 1 ;

/*14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 핚다. 어떤 SQL 
문장을 사용하면 가능하겠는가?*/

SELECT  *  
FROM    TB_STUDENT ;

SELECT  STUDENT_NAME 동일이름,
        COUNT(*) "동명인 수"
FROM    TB_STUDENT 
GROUP BY    STUDENT_NAME
HAVING  COUNT(*) > 1
ORDER BY    1 ;

-- ROLLUP()
-- 누적 총계

SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY ROLLUP(DEPT_ID , JOB_ID);

-- 누적 소계
SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY DEPT_ID , ROLLUP(JOB_ID) ; 

-- 소계, 총계 확인
SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY ROLLUP(DEPT_ID , JOB_ID) ; 

/*
ROLLUP(DEPT_ID , JOB_ID)
DEPT_ID , JOB_ID
DEPT_ID
()
*/


/*15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총
평점을 구하는 SQL 문을 작성하시오. (단, 평점은 소수점 1 자리까지맊 반올림하여
표시핚다.) */

SELECT  TERM_NO,
        AVG(POINT)
FROM    TB_GRADE
WHERE   STUDENT_NO = 'A112113'
GROUP BY   ROLLUP(TERM_NO, POINT);


--ERD
--EMPLOYEE , DEPARTMENT

SELECT *
FROM    DEPARTMENT ;

SELECT *
FROM    EMPLOYEE ;

-- 사원의 이름, 부서를 조회하고 싶다면 ?
-- 즉, 두 개의 칼럼을 한 번에 볼 수 있는 방법
-- JOIN
SELECT  EMP_NAME,
        DEPT_NAME,
        D.DEPT_ID
FROM    EMPLOYEE E, DEPARTMENT D
WHERE   E.DEPT_ID = D.DEPT_ID ;

/*
SELECT  ...
FROM    TABLE1
[INNER] JOIN    TABLE2 ON       (CONDITION)
[INNER] JOIN    TABLE2 USING    (COLUMN)           부모의 기본키와 자식의 기본키가 다르면 USING을 못쓴다.

-- OUTER JOIN 조건에 만족하지 않는 데이터까지 포함시키는 조인
LEFT | RIGHT | FULL [OUTER] JOIN    TABLE2 ON       (CONDITION)
LEFT | RIGHT | FULL [OUTER] JOIN    TABLE2 USING    (COLUMN)
*/

SELECT  EMP_NAME,
        DEPT_NAME,
        DEPT_ID
        JOB_TITLE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D USING(DEPT_ID) -- USING을 쓸땐 SELECT에 D.DEPT_ID 이런식으로 TABLE 별칭을 못씀
JOIN    JOB         J USING(JOB_ID)
JOIN    LOCATIONL   L ON(L.LOCATION_ID = D.LOC_ID) ; 

SELECT  EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID,
        JOB_TITLE,
        LOC_DESCRIBE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D ON(D.DEPT_ID = E.DEPT_ID) 
JOIN    JOB         J ON(E.JOB_ID = J.JOB.ID);

SELECT  *
FROM    SAL_GRADE ;

SELECT  EMP_NAME,
        SALARY,
        SLEVEL
FROM    EMPLOYEE
JOIN    SAL_GRADE ON ( ) ;


-- OUTER JOIN
SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E, DEPARTMENT D
WHERE   E.DEPT_ID(+) = D.DEPT_ID(+) ;     --풀조인을 지원하지 않는다.


SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
LEFT JOIN   DEPARTMENT D USING(DEPT_ID) ;

-- 사원의 이름과 사수의 이름을 셀프조인으로 조회한다면?
SELECT  E.EMP_NAME,
        M.EMP_NAME,
        S.EMP_NAME
FROM    EMPLOYEE E
LEFT JOIN    EMPLOYEE M ON(E.MGR_ID = M.EMP_ID)
LEFT JOIN    EMPLOYEE S ON(M.MGR_ID = S.EMP_ID) ;

-- LOC_DESCRIBE 아시아로 시작하고 직급이 대리인 사원의 이름, 부서 이름을 조회한다면 ?

SELECT  *
FROM    LOCATION ;

SELECT  EMP_NAME,
        DEPT_NAME
FROM    JOB
JOIN    EMPLOYEE    USING(JOB_ID)
JOIN    DEPARTMENT  USING(DEPT_ID)
JOIN    LOCATION    ON(LOC_ID = LOCATION_ID)
WHERE   LOC_DESCRIBE    LIKE '아시아%' AND JOB_TITLE = '대리' ;


-- SET 연산자
/*
두 개 이상의 쿼리 결과를 하나로 결합시키는 연산자
 - UNION        겹치는거 빼고 두 테이블 결과 다 출력
 - UNION ALL    겹치는거 포함해서 결과 다 출력
 - INTERSECT    교집합
 - MINUS        차집합
 주 의 사 항 ) 반드시 동일( 컬럼 개수 , 데이터 타입 ) -- 안그러면 오류
*/

SELECT  EMP_ID,
        ROLE_NAME
FROM    EMPLOYEE_ROLE 
UNION ALL
SELECT  EMP_ID,
        ROLE_NAME
FROM    ROLE_HISTORY ;

SELECT  EMP_NAME,
        JOB_ID,
        HIRE_DATE
FROM    EMPLOYEE
UNION
SELECT  DEPT_NAME,
        DEPT_ID,
        NULL
FROM    DEPARTMENT
WHERE   DEPT_ID = 20 ;

-- UNION 부서 번호가 50번 부서의 부서원을 관리자와 직원으로 구분하여 표시하고 싶다면 ?
-- 기준 EMP_ID = '141' 이면 관리자

SELECT  EMP_ID,
        EMP_NAME,
        '관리자' AS 구분
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' AND EMP_ID = '141' 
UNION
SELECT  EMP_ID,
        EMP_NAME,
        '직원' AS 구분
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' AND EMP_ID != '141' 
ORDER BY 3;



SELECT EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB ID)
WHERE   JOB_TITLE IN ('대리' , '사원') ;
-- 위 구문을 UNION을 이용해서 변경한다면 ?

SELECT EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '대리'
UNION
SELECT EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE  = '사원' 
ORDER BY 2, 1 ;


-- 13번까지 푸세요
