-- COMMENT
-- �˻�(SELECT)

/*
MULTILINE COMMNET
Ű���� - �빮��
������ - ��ҹ��ڸ� �����Ѵ�.
�������� ���ؼ� �� ���� �����ؼ� �ۼ��ϴ� ���� ����.

SELECT * | COLUMN_NAME | EXPR | AS ALIAS    - ���������� �ϴ� �÷� ����Ʈ
FROM    TABLE_NAME                          - ��� ���̺�
WHERE   SEARCH_CONDITION                    - �࿡ ���� ����
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


-- ǥ����(�÷����� ���� ��� ����)
-- ��Ī ����) Ư������(����, ��ȣ, &) ���Ե� ��� �ݵ�� ""
SELECT  EMP_NAME,
        SALARY,
        SALARY * 12 AS ANNUL_SALARY,
        SALARY + (SALARY * BONUS_PCT) * 12 AS "(����)"
FROM    EMPLOYEE ;

-- ���� �÷� �߰�
SELECT  EMP_ID,
        EMPLOYEE,
        '����' AS �ٹ�����
FROM    EMPLOYEE ;

-- DISTINCT (�ߺ� ����), SELECT ���� �� �� ���� ����� �� �ִ�.
SELECT  DISTINCT DEPT_ID
        JOB_ID
FROM    EMPLOYEE ;


-- WHERE �࿡ ���� ����
-- �޿��� 4000000 ���� ���� ����� �̸��� �޿��� ��ȸ�Ѵٸ� ?
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY > 4000000 ;

-- �μ��ڵ尡 90�̰� �޿��� 2000000 ���� ���� ����� �μ��ڵ�, �޿� ��ȸ
SELECT  DEPT_ID AS  �μ��ڵ�,
        SALARY  AS  �޿�
FROM    EMPLOYEE
WHERE   DEPT_ID = 90 AND SALARY > 2000000 ;


-- �μ��ڵ尡 90�̰ų� 20�� �μ����� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT  EMP_NAME    AS  �̸�,
        DEPT_ID     AS  �μ��ڵ�,
        SALARY      AS  �޿�
FROM    EMPLOYEE
WHERE   DEPT_ID = 20 OR DEPT_ID = 90 ;

-- WHERE (������)
-- ���� ������ || 

SELECT  EMP_NAME||'�� ������ '||SALARY||' �Դϴ�.' AS ����
FROM    EMPLOYEE ;

-- �� ������(AND, OR, NOT)
-- �� ������( = , > , < , >= , <= , != , BETWEEN AND , LIKE , NOT LIKE , IS NULL , IS NOT NULL , IN )

-- ��� ���̺�κ��� �޿��� 3500000 ���� ���� �ް� 5500000 ���� ���� �޴� ������ �̸�, �޿� ��ȸ
-- ���Ѱ��� ���� ���� ���� ��踦 ���Խ��Ѽ� 
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE 
WHERE   SALARY >= 3500000 AND SALARY <= 5500000 ;

SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE 
WHERE   SALARY BETWEEN 3500000 AND 5500000 ;

-- ������̺�κ��� '��'�� ���� ���� ������ �̸�, �޿��� ��ȸ�Ѵٸ� ?
-- LIKE ���� �˻� % , _ <- ������ھ� �ϳ��� �ѱ���

SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   EMP_NAME LIKE '��__' ;

SELECT  EMP_NAME,
        EMAIL
FROM    EMPLOYEE
WHERE   EMAIL LIKE '___#_%' ESCAPE '#' ; /* �� ������ #�� ���� Ư�����ڸ� ������, �ڱⰡ ���ϴ� Ư������ �־ �� _ �� ������, */

-- �����ȣ�� ���� �μ� ��ġ�� ���� ���� ����� �̸��� ��ȸ�Ѵٸ� ?
-- �����Ͱ� NULL�� ��� = �񱳰� �ȵȴ�.

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

-- �μ� ��ġ�� ���� �ʾ������� ���ʽ��� ���޹޴� ������ �̸��� ��ȸ�Ѵٸ� ?
SELECT  EMP_NAME
FROM    EMPLOYEE
WHERE   DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL;


-- OR �� IN
SELECT  EMP_NAME    AS  �̸�,
        DEPT_ID     AS  �μ��ڵ�,
        SALARY      AS  �޿�
FROM    EMPLOYEE
WHERE   DEPT_ID = 20 OR DEPT_ID = 90 ;

SELECT  EMP_NAME    AS  �̸�,
        DEPT_ID     AS  �μ��ڵ�,
        SALARY      AS  �޿�
FROM    EMPLOYEE
WHERE   DEPT_ID IN ('20', '90') ;

-- ��� > ���� > �� > ��(NOT, AND, OR) ������ �켱����


SELECT *
FROM TB_STUDENT ;
--1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭" ���� ǥ���ϵ��� �Ѵ�.
SELECT  DEPARTMENT_NAME AS "�а� ��",
        CATEGORY        AS �迭
FROM    TB_DEPARTMENT ;

/*2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 �������.
�а��� ����
------------------------------------------------
������а��� ������ 20 �� �Դϴ�
*/
SELECT  DEPARTMENT_NAME || '�� ������ ' || CAPACITY || '�� �Դϴ�.' AS "�а��� ����"
FROM    TB_DEPARTMENT ;


/* 3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û��
���Դ�. �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ�
ã�� ������ ����)*/

SELECT  *
FROM    TB_STUDENT ;


SELECT  STUDENT_NAME, ABSENCE_YN, DEPARTMENT_NAME, STUDENT_SSN
FROM    TB_DEPARTMENT, TB_STUDENT
WHERE   ABSENCE_YN = 'Y' AND DEPARTMENT_NAME = '������а�' AND STUDENT_SSN LIKE '_______2%' ESCAPE '#' ;

--AND TB_DEPARTMENT.DEPARTMENT_NAME IN '������а�' ;

/*4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� ����. �� ����ڵ���
�й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
A513079, A513090, A513091, A513110, A513119
*/
SELECT  STUDENT_NAME
FROM    TB_STUDENT
WHERE   STUDENT_NO IN ('A513079','A513090', 'A513091', 'A513110', 'A513119') ;

/*5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.*/

SELECT  DEPARTMENT_NAME, CATEGORY
FROM    TB_DEPARTMENT
WHERE   CAPACITY BETWEEN 20 AND 30 ;

/*6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�. �׷� ��
������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
*/

SELECT  PROFESSOR_NAME
FROM    TB_PROFESSOR
WHERE   DEPARTMENT_NO IS NULL ;

/*7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� ����. 
��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
*/

SELECT  STUDENT_NAME
FROM    TB_STUDENT
WHERE   DEPARTMENT_NO IS NULL ;

/*8. ������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ�
������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
*/

SELECT  CLASS_NO
FROM    TB_CLASS
WHERE   preattending_class_no IS NOT NULL ;

/*9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.*/

SELECT  DISTINCT CATEGORY
FROM    TB_DEPARTMENT ;

/*10. 02 �й� ���� �����ڵ��� ������ ������� ����. ������ ������� ������ ��������
�л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�. */

SELECT  STUDENT_NO, STUDENT_NAME, STUDENT_SSN, student_address
FROM    TB_STUDENT
WHERE   ABSENCE_YN = 'N' AND student_address LIKE '%����%' ;
