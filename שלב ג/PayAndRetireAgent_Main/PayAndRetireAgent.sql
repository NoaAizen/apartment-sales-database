DECLARE
    v_agent_id_1 NUMBER;
    v_start_date DATE;
    v_exit_date DATE;
    v_agent_id_2 NUMBER;
    v_salary NUMBER;
BEGIN
    -- Prompt the user for inputs
    DBMS_OUTPUT.PUT_LINE('Enter the ID of the retiring agent:');
    v_agent_id_1 := &agent_id_1;

    DBMS_OUTPUT.PUT_LINE('Enter the start date (MM/DD/YYYY):');
    v_start_date := TO_DATE('&start_date', 'MM/DD/YYYY');

    DBMS_OUTPUT.PUT_LINE('Enter the exit date (MM/DD/YYYY):');
    v_exit_date := TO_DATE('&exit_date', 'MM/DD/YYYY');

    DBMS_OUTPUT.PUT_LINE('Enter the ID of the replacing agent:');
    v_agent_id_2 := &agent_id_2;

    -- Calculate the salary for the retiring agent
    v_salary := calc_salary(v_start_date, v_exit_date, v_agent_id_1);

    -- Deactivate the retiring agent and reassign their visits
    Update_Agent_Exit(v_agent_id_1, v_exit_date, v_agent_id_2);

END;
/
