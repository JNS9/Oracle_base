-- DAY02(�Լ�)
/*
�Լ� ����
 - ���� �� �Լ� (Single row function)
 - �׷� �Լ� (group function)

�÷�Ÿ��(���� - number , ���� - char , varchar2 , ��¥ - date)
 - ���� �Լ�
 - ���� �Լ�
 - ��¥ �Լ�
 - ��Ÿ �Լ�
 
*/

-- ���� �Լ�
-- LENGTH
SELECT  *
FROM    COLUMN_LENGTH ;

-- CHAR �ѱ��� ��� LENGTH
-- �ѱ� �ѱ��ڿ� 3 , 6���� * 3����Ʈ = 18 , 20 - 18 = 2 + 6(����) = 8 BYTE

SELECT  LENGTH(CHARTYPE),
        LENGTH(VARCHARTYPE)
FROM    COLUMN_LENGTH ;

-- INSTR() : ã�� ���ڿ��� �ε����� �����ϴ� �Լ� 
-- INSTR(STRING, SUBSTRING, [POSITION, OCCURRENCE] ) : NUMBER
-- �Լ� ���ڰ� ���ڿ������� ���ϰ��� ������ ���� ����

SELECT  *
FROM    EMPLOYEE ;


-- '@VCC.COM' ���ڿ� ��, ���� ���� 'C'�� �ε����� ���ϰ��� �Ѵٸ�?
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
-- ���ڸ� ������ �� ���(�⺻���� ���� ����)
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

-- �߿�
-- SUBSTR ( STRING, POSITION, [LENGTH] )

SELECT  EMP_NO,
        SUBSTR(EMP_NO, 1, 6),
        SUBSTR(EMP_NO, 8, 1)
FROM    EMPLOYEE ;

-- ��� ���̺��� ������ ������ ����� ��� ������ ��ȸ�Ѵٸ� ?
SELECT  *
FROM    EMPLOYEE 
WHERE   SUBSTR(EMP_NO, 8, 1) = '1' ;


-- �����Լ�
-- ROUND( NUMBER , [DECIMAL_PLACES] ) , TRUNC( NUMBER , [DECIMAL_PLACES] )

SELECT  ROUND(123.315 , 0),
        ROUND(123.315 , 2),
        ROUND(125.315 , -1),    --�ݿø�
        TRUNC(125.315 , -1)     -- ����
FROM    DUAL ;

-- ��¥ �Լ�
-- SYSDATE, ADD_MONTHS( DATE , N ) , MONTHS_BETWEEN()

SELECT  SYSDATE + 1
FROM    DUAL ;

-- �ټӳ���� 20�� �̻��� ����� ��� ������ ��ȸ�Ѵٸ� ?

SELECT  HIRE_DATE,
        ADD_MONTHS(HIRE_DATE , 240), -- �����̵Ǵ� ��¥�� ���� ���;� �Ѵ�.
        MONTHS_BETWEEN(SYSDATE , HIRE_DATE)
FROM    EMPLOYEE ;

-- �ټӳ�� ���
SELECT  EMP_NAME,
        HIRE_DATE,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) AS �ټӳ��
FROM    EMPLOYEE
WHERE   MONTHS_BETWEEN(SYSDATE , HIRE_DATE) >= 240 ; 

SELECT *
FROM    EMPLOYEE;

-- Ÿ�� ��ȯ �Լ�
/*
<-  TO_NUMBER()  TO_CHAR( DATE , ǥ�� ����)
NUMBER - CHARACTER - DATE
->  TO_CHAR()    TO_DATE()

��¥ -> ����
 - YYYY / YY / YEAR         �⵵
 - MONTH / MON / MM / RM    ��
 - DDDD / DD / D            ��¥
 - HH : MI : SS             �� : �� : ��
 - AM , PM                  ����, ����   
 - HH24                     (24�ð� ǥ��)
 - DAY(����) , Q(�б�)
*/

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = TO_CHAR(90) ;

SELECT  TO_CHAR(SYSDATE , 'YYYY-MM-DD DAY'),
        TO_CHAR(SYSDATE , 'MM-DD , YYYY'), -- ��¥�� ���ڷ� ���� ǥ��
        TO_CHAR(SYSDATE , 'AM HH24:MI:SS'),
        TO_CHAR(SYSDATE , 'YEAR , Q')
FROM    DUAL ;

SELECT  HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM    EMPLOYEE ;

SELECT  HIRE_DATE,
        SUBSTR(HIRE_DATE, 1, 2) || '��' || 
        SUBSTR(HIRE_DATE, 4, 2) || '��' || 
        SUBSTR(HIRE_DATE, 7, 2) || '��' AS �Ի���
FROM    EMPLOYEE 
WHERE   DEPT_ID = '90' ;

-- CHAR -> DATE
-- '20220215' -> 22/02/15
SELECT  TO_DATE('20220215' , 'YYYYMMDD'),
        TO_DATE('220215' , 'YYMMDD'),
        TO_CHAR(TO_DATE('20220215' , 'YYYYMMDD') , 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE(TO_CHAR(20220215) , 'YYYYMMDD') , 'YYYY-MM-DD') -- �����̶� ���� 20220215���� TO_CHAR�� ���������� ���ִٰ� ���� �ȴ�.

FROM    DUAL ;

-- �⵵�� �������� �� YYYY, RRRR

SELECT  HIRE_DATE ,
        TO_CHAR(HIRE_DATE , 'YYYY-MM-DD')
FROM    EMPLOYEE
WHERE   EMP_NAME = '�Ѽ���' ;

SELECT  SYSDATE AS ����,
        '95/02/15' AS �Է�,
        TO_CHAR( TO_DATE('95/02/15' , 'YY/MM/DD') , 'YYYY' ),
        TO_CHAR( TO_DATE('95/02/15' , 'RR/MM/DD') , 'RRRR' )
FROM    DUAL ;

-- ��Ÿ �Լ�
-- NULL �� ó�� �Լ� NVL()

SELECT  EMP_NAME,
        BONUS_PCT,
        NVL(BONUS_PCT , 0)
FROM    EMPLOYEE
WHERE   SALARY > 3500000 ;


SELECT  EMP_NAME,
        SALARY,
        SALARY * 12 AS ANNUL_SALARY,
        (SALARY + (SALARY * NVL(BONUS_PCT, 0 ))) * 12 AS "12 ���� ����)"
FROM    EMPLOYEE ;

-- ����Ŭ �����Լ�
-- DECODE( EXPR, SEARCH , RESULT , [SEARCH , RESULT] , [DEFAULT] )
-- IF ~ ELSE �� ����.

-- �μ���ȣ�� 50���� ������� �̸�, ������ ��ȸ�Ѵٸ� ?

SELECT  EMP_NAME,
        DECODE(SUBSTR(EMP_NO, 8 , 1) ,
                '1' , '����' ,
                '2' , '����' ,
                '3' , '����' ,
                '4' , '����')
                AS GENDER
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' ;

SELECT  EMP_NAME,
        DECODE(SUBSTR(EMP_NO, 8 , 1) ,
                '1' , '����' ,
                '3' , '����' ,
                '����' ) AS GENDER
FROM    EMPLOYEE
WHERE   DEPT_ID = '50' ;

SELECT  SALARY,
        DEPT_ID,
        DECODE(DEPT_ID ,
                    '90' , SALARY * 1.1 ,
                    SALARY ) AS �λ�޿�
FROM    EMPLOYEE ;

-- ANSI ǥ��
-- CASE EXPR WHEN SEARCH THE RESULT [ WHEN SEARCH THE RESULT ] ELSE DEFAULT END
-- CASE WHEN CONDITION THE RESULT [ WHEN SEARCH THE RESULT ] ELSE DEFAULT END
SELECT  SALARY,
        DEPT_ID,
        CASE DEPT_ID WHEN '90' THEN SALARY * 1.1
                     ELSE SALARY
        END AS �λ�޿�
FROM    EMPLOYEE ;

SELECT  SALARY,
        DEPT_ID,
        CASE WHEN DEPT_ID = '90' THEN SALARY * 1.1
                     ELSE SALARY
        END AS �λ�޿�
FROM    EMPLOYEE ;

-- �޿��� ���� �޿� ����� Ȯ���Ϸ��� �Ѵ�.
-- 3000000 ���ϸ� �ʱ�, 4000000 ���ϸ� �߱� �ʰ��� ������� �����ϰ� �ʹٸ�?

SELECT  EMP_NAME,
        SALARY,
        CASE
        WHEN SALARY <= 3000000 THEN '�ʱ�'
        WHEN SALARY <= 4000000 THEN '�߱�'
        ELSE '���'
    END AS �޿����
FROM    EMPLOYEE ;

-- �׷��Լ�( SUM , AVG , MIN , MAX , COUNT )
-- INPUT N -> OUTPUT 1
-- SELECT EMP_ID , SUM(SALARY) <- �̷��� �׷��Լ��� �Ϲ� ȣ�� �Լ��� ���� �� �� ����.

SELECT  SUM(SALARY) ,
        AVG(SALARY) ,
        MIN(SALARY) , 
        MAX(SALARY) ,
        COUNT(SALARY)
FROM    EMPLOYEE ;


/*1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ����
������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" ��
ǥ�õǵ��� ����.)
*/

SELECT  STUDENT_NO      AS �й�    ,
        STUDENT_NAME    AS �̸�    ,
        TO_CHAR((ENTRANCE_DATE), 'YYYY-MM-DD')   AS ���г⵵ 
FROM    TB_STUDENT 
ORDER BY    ENTRANCE_DATE ;

/*2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� ����. �� ������
�̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL 
������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��) */

SELECT  PROFESSOR_NAME, PROFESSOR_SSN
FROM    TB_PROFESSOR
WHERE   LENGTH(PROFESSOR_NAME) = '2';

/*3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��
�̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� ��
2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� ����. ���̴� ����������
�������.)*/

SELECT  PROFESSOR_NAME AS �����̸�, 
        ROUND(MONTHS_BETWEEN( SYSDATE , (TO_CHAR(TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6) , 'YYMMDD'))))/12) AS ����,
        PROFESSOR_SSN
FROM    TB_PROFESSOR
WHERE   SUBSTR(PROFESSOR_SSN, 8, 1) = '1'  
ORDER BY professor_ssn;

/* 4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� �����
?�̸�? �� �������� ����. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�) */

SELECT  SUBSTR(PROFESSOR_NAME, 2, 2) AS �̸�
FROM    TB_PROFESSOR ;


/*5. �� ������б��� ����� �����ڸ� ���Ϸ��� ����. ��� ã�Ƴ� ���ΰ�? �̶�, 
19 �쿡 �����ϸ� ����� ���� ���� ������ �A������.*/


/*6. 2020 �� ũ���������� ���� �����ΰ�? */

SELECT TO_CHAR(TO_DATE(20201225) , 'YYYYMMDD, DAY')
FROM   DUAL ;

/*7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� ��
�� �� ���� �ǹ�����? �� TO_DATE('99/10/11','RR/MM/DD'), 
TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ�����? */

SELECT  TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'), 'YYYY'),
        TO_CHAR(TO_DATE('49/10/11','YY/MM/DD') , 'YYYY'),
        TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'), 'RRRR'),
        TO_CHAR(TO_DATE('49/10/11','RR/MM/DD') , 'RRRR')
FROM    DUAL ;


/*8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 2000 �⵵
�̠� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.*/

SELECT  STUDENT_NO       ,
        STUDENT_NAME    
FROM    TB_STUDENT 
WHERE   TO_CHAR(TO_DATE(ENTRANCE_DATE,'RR/MM/DD') , 'RRRR') > 2000 ;

/*9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
�̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ��
�ڸ������� ǥ������*/

SELECT  AVG(ROUND(POINT , 1))
FROM    TB_GRADE
WHERE   STUDENT_NO = 'A517178';

/*10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� �������
��µǵ��� �Ͻÿ�.*/

SELECT  DEPARTMENT_NO   AS "�а���ȣ",
        CAPACITY        AS "�л���(��)"
FROM    TB_DEPARTMENT


/*11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ����
�ۼ��Ͻÿ�.*/

/*12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��, 
�̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ�
�Ҽ��� ���� �� �ڸ������� ǥ������*/

/*13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������
�ۼ��Ͻÿ�.*/

/*14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� ����. � SQL 
������ ����ϸ� �����ϰڴ°�?*/


/*15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , ��
������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ�
ǥ������.)*/