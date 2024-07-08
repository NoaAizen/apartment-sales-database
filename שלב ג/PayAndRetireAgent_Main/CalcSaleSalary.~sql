CREATE OR REPLACE FUNCTION calc_sale_salary(p_start_date DATE, p_end_date DATE, p_agent_id NUMBER)
RETURN NUMBER
IS
    v_sale_salary NUMBER := 0;
    v_agent_fee NUMBER;
    v_sale_rate NUMBER;

    -- Cursor to fetch agent fee and sale rate for the given period
    CURSOR sale_cursor IS
        SELECT Apartment_Sale.Agent_Fee, Agent_Person.Sale_Rate
        FROM Visit
        JOIN Apartment_Sale ON Visit.Visit_ID = Apartment_Sale.Visit_ID
        JOIN Agent_Person ON Visit.Agent_ID = Agent_Person.Agent_ID
        WHERE Visit.Agent_ID = p_agent_id
        AND Apartment_Sale.Sign_Date BETWEEN p_start_date AND p_end_date;

BEGIN
    -- Open the cursor
    OPEN sale_cursor;
    
    -- Loop through each record
    LOOP
        FETCH sale_cursor INTO v_agent_fee, v_sale_rate;
        EXIT WHEN sale_cursor%NOTFOUND;

        -- Calculate the partial sale salary and accumulate
        v_sale_salary := v_sale_salary + (v_agent_fee * NVL(v_sale_rate, 0));
    END LOOP;
    
    -- Close the cursor
    CLOSE sale_cursor;

    RETURN v_sale_salary;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Return 0 if no sales found for the agent in the given period
    WHEN OTHERS THEN
        RAISE; -- Raise any other exceptions
END;
/



-- Example Usage
DECLARE
    v_start_date DATE := TO_DATE('01/01/2000', 'MM/DD/YYYY');
    v_end_date DATE := TO_DATE('01/01/2030', 'MM/DD/YYYY');
    v_agent_id NUMBER := 999;  -- Example agent ID
    v_sale_salary NUMBER;
BEGIN
    v_sale_salary := calc_sale_salary(v_start_date, v_end_date, v_agent_id);
    DBMS_OUTPUT.PUT_LINE('Sale Salary: ' || v_sale_salary);
END;
/
