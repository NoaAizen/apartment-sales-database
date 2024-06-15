ALTER TABLE Apartment
MODIFY Price NOT NULL;

ALTER TABLE Apartment_Sale
ADD CONSTRAINT check_agent_fee CHECK (Agent_Fee > 0);

ALTER TABLE Visit
MODIFY Present_Status VARCHAR2(15) DEFAULT 'Nothing';
