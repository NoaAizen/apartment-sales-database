CREATE TABLE Seller
(
  Seller_ID NUMERIC(3) NOT NULL,
  Seller_Name VARCHAR(15),
  Phone_Number NUMERIC(5),
  PRIMARY KEY (Seller_ID)
);

CREATE TABLE Buyer
(
  Buyer_ID NUMERIC(3) NOT NULL,
  Buyer_Name VARCHAR(15),
  Phone_Number NUMERIC(5),
  PRIMARY KEY (Buyer_ID)
);

CREATE TABLE City
(
  City_ID NUMERIC(3) NOT NULL,
  City_Name VARCHAR(15),
  Rating NUMERIC(3) ,
  PRIMARY KEY (City_ID)
);

CREATE TABLE Agent_Person
(
  Agent_ID NUMERIC(3) NOT NULL,
  Agent_Name VARCHAR(15),
  Phone_Number NUMERIC(5),
  PRIMARY KEY (Agent_ID)
);


CREATE TABLE Apartment
(
  Apartment_ID NUMERIC(3) NOT NULL,
  Apartment_Size NUMERIC(3),
  Num_Floor INT,
  Num_Rooms INT,
  Price INT,
  Seller_ID NUMERIC(3),
  City_ID NUMERIC(3),
  PRIMARY KEY (Apartment_ID),
  FOREIGN KEY (Seller_ID) REFERENCES Seller(Seller_ID),
  FOREIGN KEY (City_ID) REFERENCES City(City_ID)
);

CREATE TABLE Visit
(
  Visit_ID NUMERIC(3) NOT NULL,
  Date_of_visit DATE,
  Hour_of_visit NUMERIC(2),
  Apartment_ID NUMERIC(3),
  Buyer_ID NUMERIC(3),
  Agent_ID NUMERIC(3),
  PRIMARY KEY (Visit_ID),
  FOREIGN KEY (Apartment_ID) REFERENCES Apartment(Apartment_ID),
  FOREIGN KEY (Buyer_ID) REFERENCES Buyer(Buyer_ID),
  FOREIGN KEY (Agent_ID) REFERENCES Agent_Person(Agent_ID),
  UNIQUE (Date_of_visit)
);

CREATE TABLE Apartment_Sale
(
  Sale_ID NUMERIC(3) NOT NULL,
  Final_Cost NUMERIC(10),
  Agent_Fee NUMERIC(6),
  Sign_Date DATE,
  Visit_ID NUMERIC(3),
  PRIMARY KEY (Sale_ID),
  FOREIGN KEY (Visit_ID) REFERENCES Visit(Visit_ID)
);
