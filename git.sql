/*
�������� (�ϳ��� ������ �ٸ� ������ �����ϴ� ����)

SELECT  EXPR(SELECT)    -- SCALAR SUBQUERY
FROM        (SELECT)    -- INLINE VIEW
WHERE   EXPR OPERATOR   (SUBQUERY)
GROUP BY    (SELECT)
HAVING      (SELECT)
*/

-- ���¿� ������ ���� �μ����� ��ȸ�Ѵٸ� ?

SELECT  DEPT_ID
FROM    EMPLOYEE
WHERE   EMP_NAME = '���¿�' ;

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = ( SELECT  DEPT_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '���¿�');
                    
                    
-- ���¿��� ���� �����̸鼭 �޿��� ���¿����� ���� �޴� ������ ��ȸ

SELECT  *
FROM    EMPLOYEE
WHERE   JOB_ID = ( SELECT  JOB_ID
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '���¿�')
AND     SALARY > ( SELECT   SALARY
                    FROM    EMPLOYEE
                    WHERE   EMP_NAME = '���¿�') ;
                    
-- ���� �޿��� �޴� ����� ������ �˻��Ѵٸ� ?

SELECT  *
FROM    EMPLOYEE
WHERE   SALARY = ( SELECT   MAX(SALARY)
                    FROM    EMPLOYEE) ;
                    
                    
-- �μ��� �޿� ������ ���� ���� �μ��� �μ� �̸�, �޿� ������ ��ȸ
