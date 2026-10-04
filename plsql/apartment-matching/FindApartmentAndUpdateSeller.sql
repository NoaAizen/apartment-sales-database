DECLARE
    v_result SYS_REFCURSOR;
    v_apartment_id Apartment.Apartment_ID%TYPE;
    v_apartment_size Apartment.Apartment_Size%TYPE;
    v_num_floor Apartment.Num_Floor%TYPE;
    v_num_rooms Apartment.Num_Rooms%TYPE;
    v_price Apartment.Price%TYPE;
    v_found BOOLEAN := FALSE;

    -- Input variables
    v_in_city_name VARCHAR2(50) := '&in_city_name';
    v_in_min_rooms NUMBER := &in_min_rooms;
    v_in_max_rooms NUMBER := &in_max_rooms;
    v_in_min_price NUMBER := &in_min_price;
    v_in_max_price NUMBER := &in_max_price;
BEGIN
    -- Call the function to update seller phone numbers
    updatesellerphonenumbers;

    -- Call the find function and get the cursor
    v_result := find(in_city_name => v_in_city_name,
                     in_min_rooms => v_in_min_rooms,
                     in_max_rooms => v_in_max_rooms,
                     in_min_price => v_in_min_price,
                     in_max_price => v_in_max_price);

    -- Loop through the results and print each row
    LOOP
        FETCH v_result INTO v_apartment_id, v_apartment_size, v_num_floor, v_num_rooms, v_price;
        EXIT WHEN v_result%NOTFOUND;
        v_found := TRUE;
        DBMS_OUTPUT.PUT_LINE('Apartment ID: ' || v_apartment_id || ', Size: ' || v_apartment_size || ', Floor: ' || v_num_floor || ', Rooms: ' || v_num_rooms || ', Price: ' || v_price);
    END LOOP;

    -- Check if no results found
    IF NOT v_found THEN
        DBMS_OUTPUT.PUT_LINE('No apartments found matching the criteria.');
    END IF;

    -- Close the cursor
    CLOSE v_result;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        IF v_result%ISOPEN THEN
            CLOSE v_result;
        END IF;
END;
/
