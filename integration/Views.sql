--Apartment view
CREATE OR REPLACE VIEW Full_Details_View_AP AS
SELECT
    v.VISIT_ID,
    v.DATE_OF_VISIT,
    v.HOUR_OF_VISIT,
    v.APARTMENT_ID,
    v.BUYER_ID,
    v.AGENT_ID,
    v.PRESENT_STATUS,
    a.AGENT_NAME,
    a.PHONE_NUMBER AS AGENT_PHONE,
    a.VISIT_RATE,
    a.SALE_RATE,
    a.EXIT_DATE,
    a.ACTIVE_STATUS,
    s.SELLER_ID,
    s.SELLER_NAME,
    s.PHONE_NUMBER AS SELLER_PHONE,
    b.BUYER_NAME,
    b.PHONE_NUMBER AS BUYER_PHONE,
    ap.APARTMENT_SIZE,
    ap.NUM_FLOOR,
    ap.NUM_ROOMS,
    ap.PRICE AS APARTMENT_PRICE,
    c.CITY_NAME,
    c.RATING AS CITY_RATING,
    aps.SALE_ID,
    aps.FINAL_COST,
    aps.AGENT_FEE,
    aps.SIGN_DATE
FROM
    Visit v
    INNER JOIN Agent_Person a ON v.AGENT_ID = a.AGENT_ID
    INNER JOIN Buyer b ON v.BUYER_ID = b.BUYER_ID
    INNER JOIN Apartment ap ON v.APARTMENT_ID = ap.APARTMENT_ID
    INNER JOIN Seller s ON ap.SELLER_ID = s.SELLER_ID
    INNER JOIN City c ON ap.CITY_ID = c.CITY_ID
    LEFT JOIN Apartment_Sale aps ON v.VISIT_ID = aps.VISIT_ID;
    
--Show the view 
SELECT * from Full_Details_View_AP;

-- select that shows the buyer and the apartment that was purchased
SELECT
    b.BUYER_NAME,
    b.BUYER_PHONE,
    a.APARTMENT_ID,
    a.APARTMENT_SIZE,
    a.NUM_FLOOR,
    a.NUM_ROOMS,
    a.APARTMENT_PRICE,
    a.CITY_NAME
FROM
    Full_Details_View_AP a
    INNER JOIN Full_Details_View b ON a.BUYER_ID = b.BUYER_ID
WHERE
    a.SALE_ID IS NOT NULL;
    
    
-- select that shows buyers who didn't receive a notebook    
  SELECT
    BUYER_NAME,
    BUYER_PHONE,
    CITY_NAME,
    PRESENT_STATUS
    FROM
    Full_Details_View_AP
WHERE
    PRESENT_STATUS <> 'Notebook'
ORDER BY
    BUYER_NAME;


--view for flowers
CREATE OR REPLACE VIEW Full_New_Details_View_FL AS
SELECT
    i.InvitationID,
    i.FinalPrice,
    i.Datte,
    i.PackageID,
    p.PackageName,
    p.Price AS PackagePrice,
    i.DesignerID,
    d.DesignerName,
    d.Payment AS DesignerPayment,
    i.Agent_ID,  -- updated to Agent_ID
    ap.Agent_Name,  -- updated to Agent_Name
    ap.Phone_Number AS ClientPhone,  -- updated to Phone_Number
    ist.Amount AS StockAmount,
    e.EquipmentID,
    e.EquipmentName,
    s.SupplierID,
    s.SupplierName,
    s.Area AS SupplierArea
FROM
    Invitation i
JOIN
    Pakcage p ON i.PackageID = p.PackageID
LEFT JOIN
    Designer d ON i.DesignerID = d.DesignerID
LEFT JOIN
    Agent_Person ap ON i.Agent_ID = ap.Agent_ID  -- updated to Agent_Person
LEFT JOIN
    Containing con ON con.PackageID = i.PackageID
LEFT JOIN
    Equipment e ON con.EquipmentID = e.EquipmentID
LEFT JOIN
    InStock ist ON e.EquipmentID = ist.EquipmentID
LEFT JOIN
    Supplier_ s ON ist.SupplierID = s.SupplierID;

--show view results 
SELECT * from Full_New_Details_View_FL;



-- select customers who purchased something 
SELECT DISTINCT
    v.AGENT_NAME AS Client,
    v.INVITATIONID,
    v.FINALPRICE,
    v.DATTE,
    v.DESIGNERID,
    v.PACKAGEID
FROM 
    Full_New_Details_View_FL v
WHERE
    v.AGENT_ID IS NOT NULL;


--select suppliers and the equipment that they have in stock 
SELECT DISTINCT
    s.SupplierID,
    s.SupplierName,
    e.EquipmentID,
    e.EquipmentName,
    ist.Amount AS StockAmount
FROM
    Full_New_Details_View_FL fnd
JOIN
    Supplier_ s ON fnd.SupplierID = s.SupplierID
JOIN
    Equipment e ON fnd.EquipmentID = e.EquipmentID
JOIN
    InStock ist ON s.SupplierID = ist.SupplierID AND e.EquipmentID = ist.EquipmentID
ORDER BY
    s.SupplierID, e.EquipmentID;

commit;
