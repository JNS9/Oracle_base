/*
서브쿼리 (하나의 쿼리가 다른 쿼리를 포함하는 구조)

SELECT  EXPR(SELECT)    -- SCALAR SUBQUERY
FROM        (SELECT)    -- INLINE VIEW
WHERE   EXPR OPERATOR   (SUBQUERY)
GROUP BY    (SELECT)
HAVING      (SELECT)
*/

-- 나승원 직원과 같은 부서원을 조회한다면 ?

SELECT  DEPT_ID
FROM    EMPLOYEE
WHERE   EMP_NAME = '나승원' ;

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = ( SELECT  DEPT_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '나승원');
                    
                    
-- 나승원과 같은 직급이면서 급여가 나승원보다 많이 받는 직원을 조회

SELECT  *
FROM    EMPLOYEE
WHERE   JOB_ID = ( SELECT  JOB_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '나승원')
AND     SALARY > ( SELECT   SALARY
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '나승원') ;
                    
-- 최저 급여를 받는 사원의 정보를 검색한다면 ?

SELECT  *
FROM    EMPLOYEE
WHERE   SALARY = ( SELECT   MAX(SALARY)
                    FROM    EMPLOYEE) ;
                    
                    
-- 부서별 급여 총합이 가장 높은 부서의 부서 이름, 급여 총합을 조회
