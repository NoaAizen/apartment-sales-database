-- Create or replace the procedure
CREATE OR REPLACE PROCEDURE Update_Agent_Exit (
    p_agent_id NUMBER,
    p_exit_date DATE,
    p_new_agent_id NUMBER
)
IS
    v_active NUMBER;
BEGIN
    -- Update the Agent_Person table to set Active_Status to 0 and Exit_Date
    UPDATE Agent_Person
    SET Active_Status = 0,
        Exit_Date = p_exit_date
    WHERE Agent_ID = p_agent_id;

    -- Check if the new Agent is active
    SELECT Active_Status INTO v_active
    FROM Agent_Person
    WHERE Agent_ID = p_new_agent_id;

    -- Check if the new Agent is inactive, exit without updating 
    IF v_active = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Agent ' || p_new_agent_id || ' is inactive. Exiting program');
        RETURN; -- Exit the procedure if the new agent is inactive
    END IF;

    -- Update the Visit table to set the new Agent_ID for visits after the exit date
    UPDATE Visit v
    SET v.Agent_ID = p_new_agent_id
    WHERE v.Date_of_visit > p_exit_date
      AND v.Agent_ID = p_agent_id;

    -- Commit the changes
    COMMIT;

    -- Provide feedback to the user
    DBMS_OUTPUT.PUT_LINE('Agent ' || p_agent_id || ' deactivated.');
    DBMS_OUTPUT.PUT_LINE('Visits reassigned to agent ' || p_new_agent_id || '.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: No data found.');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/


-- Usage example
BEGIN
    Update_Agent_Exit(993, TO_DATE('01/01/2003', 'MM/DD/YYYY'), 990);
END;
/



