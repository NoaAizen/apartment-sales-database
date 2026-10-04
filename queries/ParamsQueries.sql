SELECT *
FROM City
WHERE Rating > &<name = min_rating type=integer hint="Enter minimum" required=true>;

SELECT * 
FROM Visit 
WHERE date_of_visit >= TO_DATE('&visit_date', 'YYYY-MM-DD')
AND present_status = &<name = p_status type=String list="Notebook, Pen, Nothing" hint="Enter status of Present" required=true>;

SELECT City.City_ID, City_Name, Apartment_ID, Apartment_Size, Num_Floor, Num_Rooms, Price
FROM City
JOIN Apartment ON City.City_ID = Apartment.City_ID
AND City_Name = &<name = city_name type=String list="New Deli, Jamal, Sisero" hint="Enter city" required=true>
AND Price > &<name = min_price type=integer hint="Enter minimum" required=true>;


SELECT *
FROM Apartment
WHERE Seller_ID = (SELECT Seller_ID FROM Seller WHERE Seller_Name = '&seller_name');
