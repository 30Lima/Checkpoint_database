--Primeiro exercício
CREATE TABLE AUDIT_EMPLOYEES(
    EMPLOYEE_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    EMAIL VARCHAR(100),
    PHONE_NUMBER VARCHAR(50),
    HIRE_DATE DATE NOT NULL,
    JOB_ID VARCHAR(20)NOT NULL,
    SALARY DECIMAL(10,2),
    COMMISSION_PCT DECIMAL(10,2),
    MANAGER_ID INT,
    DEPARTMENT_ID INT,
    
    --NOVOS CAMPOS ADICIONADOS
    AUDIT_USER VARCHAR(30) NOT NULL,
    AUDIT_ACTION CHAR(1) NOT NULL,
    AUDIT_DATE TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL  
);


--Segundo exercício
INSERT INTO EMPLOYEES (
    EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, 
    JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
)
VALUES (
    (SELECT MAX(EMPLOYEE_ID) + 1 FROM EMPLOYEES), 
    'Pedro', 
    'Santos',
    'rm558243@fiap.com.br',  
    '11919199191',  
    TO_DATE('2025-02-02', 'YYYY-MM-DD'),  
    'MK_REP',  
    (SELECT (MIN_SALARY + MAX_SALARY) / 2 FROM JOBS WHERE JOB_ID = 'MK_REP'),  
    NULL,  
    201, 
    20 
);

--Terceiro exercício
DECLARE
    v_employee_id EMPLOYEES.EMPLOYEE_ID%TYPE;
    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
    v_email EMPLOYEES.EMAIL%TYPE;
    v_phone_number EMPLOYEES.PHONE_NUMBER%TYPE;
    v_hire_date EMPLOYEES.HIRE_DATE%TYPE;
    v_job_id EMPLOYEES.JOB_ID%TYPE;
    v_salary EMPLOYEES.SALARY%TYPE;
    v_commission_pct EMPLOYEES.COMMISSION_PCT%TYPE;
    v_manager_id EMPLOYEES.MANAGER_ID%TYPE;
    v_department_id EMPLOYEES.DEPARTMENT_ID%TYPE;
BEGIN
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
           HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
    INTO v_employee_id, v_first_name, v_last_name, v_email, v_phone_number,
         v_hire_date, v_job_id, v_salary, v_commission_pct, v_manager_id, v_department_id
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = (SELECT MAX(EMPLOYEE_ID) FROM EMPLOYEES);


    INSERT INTO AUDIT_EMPLOYEES (
        EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, 
        HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID, 
        AUDIT_USER, AUDIT_ACTION
    ) 
    VALUES (
        v_employee_id, v_first_name, v_last_name, v_email, v_phone_number,
        v_hire_date, v_job_id, v_salary, v_commission_pct, v_manager_id, v_department_id,
        'rm558243', 
        'I'        
    );

    COMMIT;
END;


