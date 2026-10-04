SELECT A.Apartment_ID, C.City_Name, C.Rating, V.Visit_Count
FROM Apartment A
JOIN City C ON A.City_ID = C.City_ID
JOIN (
    SELECT Apartment_ID, COUNT(*) AS Visit_Count
    FROM Visit
    GROUP BY Apartment_ID
    HAVING COUNT(*) >= 2
) V ON A.Apartment_ID = V.Apartment_ID
WHERE C.Rating > 80;

SELECT A.Agent_ID, A.Agent_Name, V.Visit_Count 
FROM Agent_Person A 
JOIN (
    SELECT Agent_ID, COUNT(*) AS Visit_Count
    FROM Visit
    GROUP BY Agent_ID
    HAVING COUNT(*) >= 1
) V ON A.Agent_ID = V.Agent_ID;

SELECT A.Apartment_ID, Apartment_Sale.Final_Cost, Apartment_Sale.Sign_Date, VC.Visit_Count
FROM Apartment_Sale
JOIN Visit ON Apartment_Sale.Visit_ID = Visit.Visit_ID
JOIN Apartment A ON Visit.Apartment_ID = A.Apartment_ID
JOIN (
        SELECT Apartment_ID, COUNT(*) AS Visit_Count
        FROM Visit
        GROUP BY Apartment_ID
     ) VC ON A.Apartment_ID = VC.Apartment_ID
ORDER BY A.Apartment_ID;

SELECT
    A.Apartment_ID,
    A.City_ID,
    C.City_Name,
    COUNT(V.Visit_ID) AS Total_Visits
FROM
    Visit V
JOIN
    Apartment A ON V.Apartment_ID = A.Apartment_ID
JOIN
    City C ON A.City_ID = C.City_ID
GROUP BY
    A.Apartment_ID, A.City_ID, C.City_Name;

SELECT
    V.Visit_ID,
    V.Apartment_ID,
    V.DATE_OF_VISIT,
    C.City_Name
FROM
    Visit V
JOIN
    Apartment A ON V.Apartment_ID = A.Apartment_ID
JOIN
    City C ON A.City_ID = C.City_ID
WHERE
    V.DATE_OF_VISIT BETWEEN TO_DATE('1986-01-01', 'YYYY-MM-DD') AND TO_DATE('2029-12-31', 'YYYY-MM-DD')
ORDER BY
    V.DATE_OF_VISIT ASC;


DELETE FROM Apartment_Sale
WHERE Sale_ID IN (
    SELECT Sale_ID
    FROM (
        SELECT
            Sale_ID,
            ROW_NUMBER() OVER (PARTITION BY V.Apartment_ID ORDER BY ASale.Sale_ID DESC) AS rn
        FROM Apartment_Sale ASale
        JOIN Visit V ON ASale.Visit_ID = V.Visit_ID
    ) duplicates
    WHERE rn > 1
);
DELETE FROM City
WHERE City_ID NOT IN (
    SELECT DISTINCT City_ID
    FROM Apartment
);
UPDATE Apartment
SET Price = Price * 1.05
WHERE City_ID = (SELECT City_ID FROM City WHERE City_Name = 'Male');

UPDATE apartment_sale
SET sign_date = (
    SELECT date_of_visit
    FROM visit v
    WHERE v.visit_id = apartment_sale.visit_id
)
WHERE sign_date < (
    SELECT date_of_visit
    FROM visit v
    WHERE v.visit_id = apartment_sale.visit_id
);


Commit;
