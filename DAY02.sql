-- DAY02(함수)
/*
함수 유형
 - 단일 행 함수 (Single row function)
 - 그룹 함수 (group function)

컬럼타입(숫자 - number , 문자 - char , varchar2 , 날짜 - date)
 - 숫자 함수
 - 문자 함수
 - 날짜 함수
 - 기타 함수
 
*/

-- 문자 함수
-- LENGTH
SELECT  *
FROM    COLUMN_LENGTH ;

-- CHAR 한글일 경우 LENGTH
-- 한글 한글자에 3 , 6글자 * 3바이트 = 18 , 20 - 18 = 2 + 6(글자) = 8 BYTE

SELECT  LENGTH(CHARTYPE),
        LENGTH(VARCHARTYPE)
FROM    COLUMN_LENGTH ;

-- INSTR() : 찾는 문자열의 인덱스를 리턴하는 함수 
-- INSTR(STRING, SUBSTRING, [POSITION, OCCURRENCE] ) : NUMBER
-- 함수 인자가 문자열이지만 리턴값은 숫자일 수도 있음

SELECT  *
FROM    EMPLOYEE ;


-- '@VCC.COM' 문자열 중, 앞의 문자 'C'의 인덱스를 구하고자 한다면?
SELECT  EMAIL,
        INSTR(EMAIL, 'c' , -1 , 2)
FROM    EMPLOYEE ;


-- LPAD | RPAD
-- LPAD(STRING, N , [STR])
SELECT  EMAIL,
        LENGTH(EMAIL),
        LPAD(EMAIL, 20, '*'),
        RPAD(EMAIL, 20, '*')
FROM    EMPLOYEE ;

-- TRIM, LTRIM, RTRIM
-- 문자를 제거할 때 사용(기본으로 공백 제거)
-- LTRIM(STRING, [STR])
-- RTRIM(STRING, [STR])
-- TRIM(LEADING | TRAILING | BOTH FROM TRIM_SOURCE)

SELECT  LENGTH('    TECH    '),
        LTRIM('    TECH    '),
        LENGTH(LTRIM('    TECH    ')),
        RTRIM('    TECH    '),
        LENGTH(RTRIM('    TECH    '))
FROM    DUAL ;

SELECT  TRIM(LEADING 'A' FROM 'AATECHAA'),
        TRIM(TRAILING 'A' FROM 'AATECHAA'),
        TRIM(BOTH 'A' FROM 'AATECHAA')
FROM    DUAL;

-- 중요
-- SUBSTR ( STRING, POSITION, [LENGTH] )

SELECT  EMP_NO,
        SUBSTR(EMP_NO, 1, 6),
        SUBSTR(EMP_NO, 8, 1)
FROM    EMPLOYEE ;

-- 사원 테이블에서 성별이 남자인 사원의 모든 정보를 조회한다면 ?
SELECT  *
FROM    EMPLOYEE 
WHERE   SUBSTR(EMP_NO, 8, 1) = '1' ;


-- 숫자함수
-- ROUND( NUMBER , [DECIMAL_PLACES] ) , TRUNC( NUMBER , [DECIMAL_PLACES] )

SELECT  ROUND(123.315 , 0),
        ROUND(123.315 , 2),
        ROUND(125.315 , -1),    --반올림
        TRUNC(125.315 , -1)     -- 내림
FROM    DUAL ;

-- 날짜 함수
-- SYSDATE, ADD_MONTHS( DATE , N ) , MONTHS_BETWEEN()

SELECT  SYSDATE + 1
FROM    DUAL ;

-- 근속년수가 20년 이상인 사원의 모든 정보를 조회한다면 ?

SELECT  HIRE_DATE,
        ADD_MONTHS(HIRE_DATE , 240), -- 기준이되는 날짜가 먼저 나와야 한다.
        MONTHS_BETWEEN(SYSDATE , HIRE_DATE)
FROM    EMPLOYEE ;

-- 근속년수 출력
SELECT  EMP_NAME,
        HIRE_DATE,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) AS 근속년수
FROM    EMPLOYEE
WHERE   MONTHS_BETWEEN(SYSDATE , HIRE_DATE) >= 240 ; 

SELECT *
FROM    EMPLOYEE;

-- 타입 변환 함수
/*
<-  TO_NUMBER()  TO_CHAR( DATE , 표현 형식)
NUMBER - CHARACTER - DATE
->  TO_CHAR()    TO_DATE()

날짜 -> 문자
 - YYYY / YY / YEAR         년도
 - MONTH / MON / MM / RM    월
 - DDDD / DD / D            날짜
 - HH : MI : SS             시 : 분 : 초
 - AM , PM                  오전, 오후   
 - HH24                     (24시간 표현)
 - DAY(요일) , Q(분기)
*/

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = TO_CHAR(90) ;

SELECT  TO_CHAR(SYSDATE , 'YYYY-MM-DD DAY'),
        TO_CHAR(SYSDATE , 'MM-DD , YYYY'), -- 날짜를 문자로 만들어서 표현
        TO_CHAR(SYSDATE , 'AM HH24:MI:SS'),
        TO_CHAR(SYSDATE , 'YEAR , Q')
FROM    DUAL ;

SELECT  HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM    EMPLOYEE ;

SELECT  HIRE_DATE,
        SUBSTR(HIRE_DATE, 1, 2) || '년' || 
        SUBSTR(HIRE_DATE, 4, 2) || '월' || 
        SUBSTR(HIRE_DATE, 7, 2) || '일' AS 입사일
FROM    EMPLOYEE 
WHERE   DEPT_ID = '90' ;

-- CHAR -> DATE
-- '20220215' -> 22/02/15
SELECT  TO_DATE('20220215' , 'YYYYMMDD'),
        TO_DATE('220215' , 'YYMMDD'),
        TO_CHAR(TO_DATE('20220215' , 'YYYYMMDD') , 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE(TO_CHAR(20220215) , 'YYYYMMDD') , 'YYYY-MM-DD') -- 윗줄이랑 같음 20220215에는 TO_CHAR가 묵시적으로 들어가있다고 보면 된다.

FROM    DUAL ;

-- 년도를 포맷팅할 때 YYYY, RRRR

SELECT  HIRE_DATE ,
        TO_CHAR(HIRE_DATE , 'YYYY-MM-DD')
FROM    EMPLOYEE
WHERE   EMP_NAME = '한선기' ;

SELECT  SYSDATE AS 현재,
        '95/02/15' AS 입력,
        TO_CHAR( TO_DATE('95/02/15' , 'YY/MM/DD') , 'YYYY' ),
        TO_CHAR( TO_DATE('95/02/15' , 'RR/MM/DD') , 'RRRR' )
FROM    DUAL ;

-- 기타 함수
-- NULL 값 처리 함수 NVL()

SELECT  EMP_NAME,
        BONUS_PCT,
        NVL(BONUS_PCT , 0)
FROM    EMPLOYEE
WHERE   SALARY > 3500000 ;


SELECT  EMP_NAME,
        SALARY,
        SALARY * 12 AS ANNUL_SALARY,
        (SALARY + (SALARY * NVL(BONUS_PCT, 0 ))) * 12 AS "12 개월 연봉)"
FROM    EMPLOYEE ;

-- 오라클 전용함수
-- DECODE( EXPR, SEARCH , RESULT , [SEARCH , RESULT] , [DEFAULT] )
-- IF ~ ELSE 와 같다.

-- 부서번호가 50번인 사원들의 이름, 성별을 조회한다면 ?

SELECT  EMP_NAME,
        DECODE(SUBSTR(EMP_NO, 8 , 1) ,
                '1' , '남자' ,
                '2' , '여자' ,
                '3' , '남자' ,
                '4' , '여자')
                AS GENDER
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' ;

SELECT  EMP_NAME,
        DECODE(SUBSTR(EMP_NO, 8 , 1) ,
                '1' , '남자' ,
                '3' , '남자' ,
                '여자' ) AS GENDER
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' ;

SELECT  SALARY,
        DEPT_ID,
        DECODE(DEPT_ID ,
                    '90' , SALARY * 1.1 ,
                    SALARY ) AS 인상급여
FROM    EMPLOYEE ;

-- ANSI 표준
-- CASE EXPR WHEN SEARCH THE RESULT [ WHEN SEARCH THE RESULT ] ELSE DEFAULT END
-- CASE WHEN CONDITION THE RESULT [ WHEN SEARCH THE RESULT ] ELSE DEFAULT END
SELECT  SALARY,
        DEPT_ID,
        CASE DEPT_ID WHEN '90' THEN SALARY * 1.1
                     ELSE SALARY
        END AS 인상급여
FROM    EMPLOYEE ;

SELECT  SALARY,
        DEPT_ID,
        CASE WHEN DEPT_ID = '90' THEN SALARY * 1.1
                     ELSE SALARY
        END AS 인상급여
FROM    EMPLOYEE ;

-- 급여에 따른 급여 등급을 확인하려고 한다.
-- 3000000 이하면 초급, 4000000 이하면 중급 초과면 고급으로 구분하고 싶다면?

SELECT  EMP_NAME,
        SALARY,
        CASE
        WHEN SALARY <= 3000000 THEN '초급'
        WHEN SALARY <= 4000000 THEN '중급'
        ELSE '고급'
    END AS 급여등급
FROM    EMPLOYEE ;

-- 그룹함수( SUM , AVG , MIN , MAX , COUNT )
-- INPUT N -> OUTPUT 1
-- SELECT EMP_ID , SUM(SALARY) <- 이렇게 그룹함수는 일반 호출 함수와 같이 쓸 수 없다.

SELECT  SUM(SALARY) ,
        AVG(SALARY) ,
        MIN(SALARY) , 
        MAX(SALARY) ,
        COUNT(SALARY)
FROM    EMPLOYEE ;


/*1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른
순으로 표시하는 SQL 문장을 작성하시오.( 단, 헤더는 "학번", "이름", "입학년도" 가
표시되도록 핚다.)
*/

SELECT  STUDENT_NO      AS 학번    ,
        STUDENT_NAME    AS 이름    ,
        TO_CHAR((ENTRANCE_DATE), 'YYYY-MM-DD')   AS 입학년도 
FROM    TB_STUDENT 
ORDER BY    ENTRANCE_DATE ;

/*2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 핚 명 있다고 핚다. 그 교수의
이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. (* 이때 올바르게 작성핚 SQL 
문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것) */

SELECT  PROFESSOR_NAME, PROFESSOR_SSN
FROM    TB_PROFESSOR
WHERE   LENGTH(PROFESSOR_NAME) = '2';

/*3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단
이때 나이가 적은 사람에서 맋은 사람 순서로 화면에 출력되도록 맊드시오. (단, 교수 중
2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 핚다. 나이는 ‘만’으로
계산핚다.)*/

SELECT  PROFESSOR_NAME AS 교수이름, 
        ROUND(MONTHS_BETWEEN( SYSDATE , (TO_CHAR(TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6) , 'YYMMDD'))))/12) AS 나이,
        PROFESSOR_SSN
FROM    TB_PROFESSOR
WHERE   SUBSTR(PROFESSOR_SSN, 8, 1) = '1'  
ORDER BY professor_ssn;

/* 4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는
?이름? 이 찍히도록 핚다. (성이 2 자인 경우는 교수는 없다고 가정하시오) */

SELECT  SUBSTR(PROFESSOR_NAME, 2, 2) AS 이름
FROM    TB_PROFESSOR ;


/*5. 춘 기술대학교의 재수생 입학자를 구하려고 핚다. 어떻게 찾아낼 것인가? 이때, 
19 살에 입학하면 재수를 하지 않은 것으로 갂주핚다.*/


/*6. 2020 년 크리스마스는 무슨 요일인가? */

SELECT TO_CHAR(TO_DATE(20201225) , 'YYYYMMDD, DAY')
FROM   DUAL ;

/*7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇 년 몇
월 몇 일을 의미핛까? 또 TO_DATE('99/10/11','RR/MM/DD'), 
TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미핛까? */

SELECT  TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'), 'YYYY'),
        TO_CHAR(TO_DATE('49/10/11','YY/MM/DD') , 'YYYY'),
        TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'), 'RRRR'),
        TO_CHAR(TO_DATE('49/10/11','RR/MM/DD') , 'RRRR')
FROM    DUAL ;


/*8. 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 2000 년도
이젂 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.*/

SELECT  STUDENT_NO       ,
        STUDENT_NAME    
FROM    TB_STUDENT 
WHERE   TO_CHAR(TO_DATE(ENTRANCE_DATE,'RR/MM/DD') , 'RRRR') > 2000 ;

/*9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 단,
이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 핚
자리까지맊 표시핚다*/

SELECT  AVG(ROUND(POINT , 1))
FROM    TB_GRADE
WHERE   STUDENT_NO = 'A517178';

/*10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 맊들어 결과값이
출력되도록 하시오.*/

SELECT  DEPARTMENT_NO   AS "학과번호",
        CAPACITY        AS "학생수(명)"
FROM    TB_DEPARTMENT


/*11. 지도 교수를 배정받지 못핚 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을
작성하시오.*/

/*12. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 단, 
이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여
소수점 이하 핚 자리까지맊 표시핚다*/

/*13. 학과 별 휴학생 수를 파악하고자 핚다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을
작성하시오.*/

/*14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 핚다. 어떤 SQL 
문장을 사용하면 가능하겠는가?*/


/*15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총
평점을 구하는 SQL 문을 작성하시오. (단, 평점은 소수점 1 자리까지맊 반올림하여
표시핚다.)*/