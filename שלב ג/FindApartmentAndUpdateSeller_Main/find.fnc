CREATE OR REPLACE FUNCTION find(
    in_city_name IN VARCHAR2,
    in_min_rooms IN NUMBER,
    in_max_rooms IN NUMBER,
    in_min_price IN NUMBER,
    in_max_price IN NUMBER
) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT
            a.Apartment_ID,
            a.Apartment_Size,
            a.Num_Floor,
            a.Num_Rooms,
            a.Price
        FROM
            Apartment a
        JOIN
            City c ON a.City_ID = c.City_ID
        WHERE
            c.City_Name = in_city_name
            AND a.Num_Rooms BETWEEN in_min_rooms AND in_max_rooms
            AND a.Price BETWEEN in_min_price AND in_max_price
            AND a.Sold = 0;

    -- Return the cursor
    RETURN v_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        RETURN NULL;
END find;
/
