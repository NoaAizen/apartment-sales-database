-- Adjusting Agent_Person so that the fields are large enough to match data from Client
ALTER TABLE Agent_Person
MODIFY (Agent_Id NUMBER(10));

ALTER TABLE Agent_Person
MODIFY (phone_number NUMBER(10));

-- Changing the default so that clients who bought flowers are not entered as active agents 
ALTER TABLE Agent_Person
MODIFY (ACTIVE_STATUS default (0) );

-- Adding the clients information into Agent_Person 
INSERT INTO Agent_Person (Agent_Id, Agent_Name, phone_number)
SELECT TO_NUMBER(clientid), clientname, TO_NUMBER(phone)
FROM client
WHERE TO_NUMBER(clientid) NOT IN (SELECT Agent_Id FROM Agent_Person);

-- Verifying that all records were copied 
select * from client c where c.clientid NOT IN (SELECT Agent_Id FROM Agent_Person);
Select count(*) from Agent_Person; 
Select count(*) from client;



--Creating new table Invitation2 to replace invitation 
CREATE TABLE Invitation2 (
    FINALPRICE   NUMBER(7)   NULL,
    INVITATIONID NUMBER(5)   NOT NULL,
    DATTE        DATE        NOT NULL,
    AGENT_ID      NUMBER(10)  NOT NULL,
    DESIGNERID   NUMBER(5)   NULL,
    PACKAGEID    NUMBER(5)   NULL,
    CONSTRAINT pk_invitation2 PRIMARY KEY (INVITATIONID)
);

-- Copy data from Invitation to Invitation2
INSERT INTO Invitation2 (FINALPRICE, INVITATIONID, DATTE, AGENT_ID, DESIGNERID, PACKAGEID)
SELECT FINALPRICE, INVITATIONID, DATTE, TO_NUMBER(CLIENTID), DESIGNERID, PACKAGEID
FROM Invitation;



-- Connect Invitation2 to Agent_Person
-- Add the foreign key constraint to Invitation2
ALTER TABLE Invitation2 ADD CONSTRAINT fk_invitation2_agent 
FOREIGN KEY (AGENT_ID) REFERENCES Agent_Person(Agent_ID);

--Connect Invitation2 to Designer and Pakcage
ALTER TABLE Invitation2 ADD CONSTRAINT fk_invitation2_package
FOREIGN KEY (PACKAGEID) REFERENCES Pakcage(PACKAGEID);

ALTER TABLE Invitation2 ADD CONSTRAINT fk_invitation2_designer
FOREIGN KEY (DESIGNERID)REFERENCES Designer(DESIGNERID);

--Erase table Invitation
DROP TABLE Invitation CASCADE CONSTRAINTS;
DROP TABLE Client CASCADE CONSTRAINTS;

--Rename Invitation2 as Invitation
RENAME Invitation2 TO Invitation;

ALTER TABLE Visit 
ADD FlowersID Number(5);

Commit;
