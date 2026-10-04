CREATE OR REPLACE PROCEDURE UpdateSellerPhoneNumbers IS
BEGIN
    FOR rec IN (
        SELECT s.Seller_ID, c.City_ID
        FROM Seller s
        JOIN Apartment a ON s.Seller_ID = a.Seller_ID
        JOIN City c ON a.City_ID = c.City_ID
    ) LOOP
        BEGIN
            UPDATE Seller
            SET Phone_Number = rec.City_ID * 100000 + Seller.Phone_Number
            WHERE Seller_ID = rec.Seller_ID;
        EXCEPTION
            WHEN OTHERS THEN
                -- Handle exceptions if needed
                DBMS_OUTPUT.PUT_LINE('Error updating Seller with Seller_ID: ' || rec.Seller_ID);
        END;
    END LOOP;
    
    COMMIT; -- Commit the transaction after updates
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions during the entire procedure
        DBMS_OUTPUT.PUT_LINE('Error in UpdateSellerPhoneNumbers procedure: ');
END;
/
