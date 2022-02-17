/*

DAY 03 ORDER BY

MULTILINE COMMNET

Ű���� - �빮��
������ - ��ҹ��ڸ� �����Ѵ�.
�������� ���ؼ� �� ���� �����ؼ� �ۼ��ϴ� ���� ����.

PARSING ����
 - FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY

SELECT * | COLUMN_NAME | EXPR | AS ALIAS    - ���������� �ϴ� �÷� ����Ʈ
FROM    TABLE_NAME                          - ��� ���̺�
 -- WHERE   SEARCH_CONDITION                - �࿡ ���� ����
 -- GROUP BY �����÷�                        - �׷���
 -- HAVING  SEARCH_CONDITION                - �׷쿡 ���� ����
 -- ORDER BY �����÷� [ ASC | DESC ]         - ������ �� ��� , SELECT�� �������� �� ���� ������ �� �ִ�.

*/


SELECT  *
FROM    EMPLOYEE
ORDER BY    SALARY DESC , EMP_NAME DESC ;   -- �޿��� ���� ���� �ٸ� ���� �÷��� ������ �� �ִ�.

--��Ī ��� ����
SELECT  EMP_NAME AS �̸�,
        HIRE_DATE AS �Ի���,
        DEPT_ID AS  �μ��ڵ�
FROM    EMPLOYEE
ORDER BY  �μ��ڵ� DESC , �Ի��� , �̸� ;  -- ������ �̸��� ����� �� �� �ִ�.


-- �ε��� ��� ����
SELECT  EMP_NAME AS �̸�,
        HIRE_DATE AS �Ի���,
        DEPT_ID AS  �μ��ڵ�
FROM    EMPLOYEE
ORDER BY  3 DESC , 2 , 1 ; 

-- GROUP BY : ���� ������ �׷�
/*10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� ������� ��µǵ��� �Ͻÿ�.*/
SELECT  DEPARTMENT_NO "�а���ȣ",
        COUNT(*)      "�л���(��)"
FROM    TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1 ASC ;

-- �μ��� ��� �޿��� ��ȸ�ϰ� �ʹٸ� ? 

SELECT  DEPT_ID,
        ROUND(AVG(SALARY) , -4) AS ��� �޿�
FROM    EMPLOYEE
GROUP BY    DEPT_ID ;

-- ������ ���� ��� �޿��� ��ȸ
SELECT  CASE WHEN SUBSTR(EMP_NO, 8 , 1) IN ('1' , '3') THEN 'MALE' ELSE 'FEMALE' END AS ����,
        ROUND(AVG(SALARY), -4) AS ��ձ޿�
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
HAVING      SUM(SALARY) > 9000000 ;             -- WHERE ������ �׷��Լ��� ���� �� ����.


/*11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ����
�ۼ��Ͻÿ�.*/

SELECT *
FROM   TB_STUDENT ; 

SELECT  COUNT(*), coach_professor_no
FROM    TB_STUDENT
GROUP BY COACH_PROFESSOR_NO
HAVING  COACH_PROFESSOR_NO IS NULL ;


-- ANSI ǥ��
-- CASE EXPR WHEN SEARCH THE RESULT [ WHEN SEARCH THE RESULT ] ELSE DEFAULT END
-- CASE WHEN CONDITION THE RESULT [ WHEN SEARCH THE RESULT ] ELSE DEFAULT END
SELECT  SALARY, DEPT_ID,
        CASE DEPT_ID 
            WHEN '90' THEN SALARY * 1.1
            ELSE SALARY
            END AS �λ�޿�
FROM    EMPLOYEE ;



/*12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��, 
�̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ�
�Ҽ��� ���� �� �ڸ������� ǥ������*/

SELECT  SUBSTR(TERM_NO , 1, 4) AS �⵵,
        CASE
            WHEN SUBSTR(TERM_NO, 1, 4) = '2001' THEN ROUND(AVG(POINT), 1)
            WHEN SUBSTR(TERM_NO, 1, 4) = '2002' THEN ROUND(AVG(POINT), 1)
            WHEN SUBSTR(TERM_NO, 1, 4) = '2003' THEN ROUND(AVG(POINT), 1)
            WHEN SUBSTR(TERM_NO, 1, 4) = '2004' THEN ROUND(AVG(POINT), 1)
            END AS "�⵵ �� ����"
FROM    TB_GRADE
WHERE   STUDENT_NO = 'A112113'
GROUP BY    SUBSTR(TERM_NO, 1, 4)
ORDER BY    SUBSTR(TERM_NO, 1, 4);
        

/*13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������
�ۼ��Ͻÿ�.*/

SELECT *
FROM    TB_STUDENT ;

SELECT  DEPARTMENT_NO �а��ڵ�� ,
        COUNT(CASE WHEN ABSENCE_YN = 'Y' THEN 1 -- THEN�� ������ ���� �Ŷ� �� �־ ��� ���� ��?
        END) AS "���л� ��"
FROM    TB_STUDENT 
GROUP BY DEPARTMENT_NO
ORDER BY 1 ;

/*14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� ����. � SQL 
������ ����ϸ� �����ϰڴ°�?*/

SELECT  *  
FROM    TB_STUDENT ;

SELECT  STUDENT_NAME �����̸�,
        COUNT(*) "������ ��"
FROM    TB_STUDENT 
GROUP BY    STUDENT_NAME
HAVING  COUNT(*) > 1
ORDER BY    1 ;

-- ROLLUP()
-- ���� �Ѱ�

SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY ROLLUP(DEPT_ID , JOB_ID);

-- ���� �Ұ�
SELECT  DEPT_ID,
        JOB_ID,
        SUM(SALARY)
FROM    EMPLOYEE
GROUP BY DEPT_ID , ROLLUP(JOB_ID) ; 

-- �Ұ�, �Ѱ� Ȯ��
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


/*15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , ��
������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ�
ǥ������.) */

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

-- ����� �̸�, �μ��� ��ȸ�ϰ� �ʹٸ� ?
-- ��, �� ���� Į���� �� ���� �� �� �ִ� ���
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
[INNER] JOIN    TABLE2 USING    (COLUMN)           �θ��� �⺻Ű�� �ڽ��� �⺻Ű�� �ٸ��� USING�� ������.

-- OUTER JOIN ���ǿ� �������� �ʴ� �����ͱ��� ���Խ�Ű�� ����
LEFT | RIGHT | FULL [OUTER] JOIN    TABLE2 ON       (CONDITION)
LEFT | RIGHT | FULL [OUTER] JOIN    TABLE2 USING    (COLUMN)
*/

SELECT  EMP_NAME,
        DEPT_NAME,
        DEPT_ID
        JOB_TITLE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D USING(DEPT_ID) -- USING�� ���� SELECT�� D.DEPT_ID �̷������� TABLE ��Ī�� ����
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
WHERE   E.DEPT_ID(+) = D.DEPT_ID(+) ;     --Ǯ������ �������� �ʴ´�.


SELECT  EMP_NAME,
        DEPT_NAME
FROM    EMPLOYEE E
LEFT JOIN   DEPARTMENT D USING(DEPT_ID) ;

-- ����� �̸��� ����� �̸��� ������������ ��ȸ�Ѵٸ�?
SELECT  E.EMP_NAME,
        M.EMP_NAME,
        S.EMP_NAME
FROM    EMPLOYEE E
LEFT JOIN    EMPLOYEE M ON(E.MGR_ID = M.EMP_ID)
LEFT JOIN    EMPLOYEE S ON(M.MGR_ID = S.EMP_ID) ;

-- LOC_DESCRIBE �ƽþƷ� �����ϰ� ������ �븮�� ����� �̸�, �μ� �̸��� ��ȸ�Ѵٸ� ?

SELECT  *
FROM    LOCATION ;

SELECT  EMP_NAME,
        DEPT_NAME
FROM    JOB
JOIN    EMPLOYEE    USING(JOB_ID)
JOIN    DEPARTMENT  USING(DEPT_ID)
JOIN    LOCATION    ON(LOC_ID = LOCATION_ID)
WHERE   LOC_DESCRIBE    LIKE '�ƽþ�%' AND JOB_TITLE = '�븮' ;


-- SET ������
/*
�� �� �̻��� ���� ����� �ϳ��� ���ս�Ű�� ������
 - UNION        ��ġ�°� ���� �� ���̺� ��� �� ���
 - UNION ALL    ��ġ�°� �����ؼ� ��� �� ���
 - INTERSECT    ������
 - MINUS        ������
 �� �� �� �� ) �ݵ�� ����( �÷� ���� , ������ Ÿ�� ) -- �ȱ׷��� ����
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

-- UNION �μ� ��ȣ�� 50�� �μ��� �μ����� �����ڿ� �������� �����Ͽ� ǥ���ϰ� �ʹٸ� ?
-- ���� EMP_ID = '141' �̸� ������

SELECT  EMP_ID,
        EMP_NAME,
        '������' AS ����
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' AND EMP_ID = '141' 
UNION
SELECT  EMP_ID,
        EMP_NAME,
        '����' AS ����
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' AND EMP_ID != '141' 
ORDER BY 3;



SELECT EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB ID)
WHERE   JOB_TITLE IN ('�븮' , '���') ;
-- �� ������ UNION�� �̿��ؼ� �����Ѵٸ� ?

SELECT EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE = '�븮'
UNION
SELECT EMP_NAME,
        JOB_TITLE
FROM    EMPLOYEE
JOIN    JOB USING(JOB_ID)
WHERE   JOB_TITLE  = '���' 
ORDER BY 2, 1 ;


-- 13������ Ǫ����
