prompt PL/SQL Developer import file
prompt Created on Friday, July 19, 2024 by necha
set feedback off
set define off
prompt Creating AGENT_PERSON...
create table AGENT_PERSON
(
  agent_id      NUMBER(10) not null,
  agent_name    VARCHAR2(15),
  phone_number  NUMBER(10),
  visit_rate    NUMBER default 100,
  sale_rate     NUMBER default 0.8,
  active_status NUMBER(1) default (0),
  exit_date     DATE
)
;
alter table AGENT_PERSON
  add primary key (AGENT_ID);
alter table AGENT_PERSON
  add constraint CHECK_SALE_RATE
  check (Sale_Rate BETWEEN 0 AND 1);

prompt Creating CITY...
create table CITY
(
  city_id   NUMBER(3) not null,
  city_name VARCHAR2(15),
  rating    NUMBER(3)
)
;
alter table CITY
  add primary key (CITY_ID);

prompt Creating SELLER...
create table SELLER
(
  seller_id    NUMBER(3) not null,
  seller_name  VARCHAR2(15),
  phone_number NUMBER(15)
)
;
alter table SELLER
  add primary key (SELLER_ID);

prompt Creating APARTMENT...
create table APARTMENT
(
  apartment_id   NUMBER(3) not null,
  apartment_size NUMBER(3),
  num_floor      INTEGER,
  num_rooms      INTEGER,
  price          INTEGER not null,
  seller_id      NUMBER(3),
  city_id        NUMBER(3),
  sold           NUMBER(1) default 0
)
;
alter table APARTMENT
  add primary key (APARTMENT_ID);
alter table APARTMENT
  add foreign key (SELLER_ID)
  references SELLER (SELLER_ID);
alter table APARTMENT
  add foreign key (CITY_ID)
  references CITY (CITY_ID);

prompt Creating BUYER...
create table BUYER
(
  buyer_id     NUMBER(3) not null,
  buyer_name   VARCHAR2(15),
  phone_number NUMBER(5)
)
;
alter table BUYER
  add primary key (BUYER_ID);

prompt Creating VISIT...
create table VISIT
(
  visit_id       NUMBER(3) not null,
  date_of_visit  DATE,
  hour_of_visit  NUMBER(2),
  apartment_id   NUMBER(3),
  buyer_id       NUMBER(3),
  agent_id       NUMBER(3),
  present_status VARCHAR2(15) default 'Nothing',
  flowersid      NUMBER(5)
)
;
alter table VISIT
  add primary key (VISIT_ID);
alter table VISIT
  add unique (DATE_OF_VISIT);
alter table VISIT
  add foreign key (APARTMENT_ID)
  references APARTMENT (APARTMENT_ID);
alter table VISIT
  add foreign key (BUYER_ID)
  references BUYER (BUYER_ID);
alter table VISIT
  add foreign key (AGENT_ID)
  references AGENT_PERSON (AGENT_ID);

prompt Creating APARTMENT_SALE...
create table APARTMENT_SALE
(
  sale_id    NUMBER(3) not null,
  final_cost NUMBER(10),
  agent_fee  NUMBER(6),
  sign_date  DATE,
  visit_id   NUMBER(3)
)
;
alter table APARTMENT_SALE
  add primary key (SALE_ID);
alter table APARTMENT_SALE
  add foreign key (VISIT_ID)
  references VISIT (VISIT_ID);
alter table APARTMENT_SALE
  add constraint CHECK_AGENT_FEE
  check (Agent_Fee > 0);

prompt Creating EQUIPMENT...
create table EQUIPMENT
(
  equipmentid   NUMBER(5) not null,
  equipmentname VARCHAR2(50) not null
)
;
alter table EQUIPMENT
  add primary key (EQUIPMENTID);

prompt Creating PAKCAGE...
create table PAKCAGE
(
  packageid   NUMBER(5) not null,
  packagename VARCHAR2(50) not null,
  price       NUMBER(5) not null
)
;
alter table PAKCAGE
  add primary key (PACKAGEID);
alter table PAKCAGE
  add constraint CHK_PRICE
  check (Price > 0);

prompt Creating CONTAINING...
create table CONTAINING
(
  amountc     NUMBER(5) not null,
  equipmentid NUMBER(5) not null,
  packageid   NUMBER(5) not null
)
;
alter table CONTAINING
  add primary key (EQUIPMENTID, PACKAGEID);
alter table CONTAINING
  add foreign key (EQUIPMENTID)
  references EQUIPMENT (EQUIPMENTID);
alter table CONTAINING
  add foreign key (PACKAGEID)
  references PAKCAGE (PACKAGEID);

prompt Creating DESIGNER...
create table DESIGNER
(
  designername VARCHAR2(15) not null,
  designerid   NUMBER(5) not null,
  payment      NUMBER(5) default 0 not null
)
;
alter table DESIGNER
  add primary key (DESIGNERID);

prompt Creating SUPPLIER_...
create table SUPPLIER_
(
  supplierid   NUMBER(5) not null,
  suppliername VARCHAR2(15) not null,
  area         VARCHAR2(30)
)
;
alter table SUPPLIER_
  add primary key (SUPPLIERID);

prompt Creating INSTOCK...
create table INSTOCK
(
  amount      NUMBER(5) not null,
  supplierid  NUMBER(5) not null,
  equipmentid NUMBER(5) not null
)
;
alter table INSTOCK
  add primary key (SUPPLIERID, EQUIPMENTID);
alter table INSTOCK
  add foreign key (SUPPLIERID)
  references SUPPLIER_ (SUPPLIERID);
alter table INSTOCK
  add foreign key (EQUIPMENTID)
  references EQUIPMENT (EQUIPMENTID);

prompt Creating INVITATION...
create table INVITATION
(
  finalprice   NUMBER(7),
  invitationid NUMBER(5) not null,
  datte        DATE not null,
  agent_id     NUMBER(10) not null,
  designerid   NUMBER(5),
  packageid    NUMBER(5)
)
;
alter table INVITATION
  add constraint PK_INVITATION2 primary key (INVITATIONID);
alter table INVITATION
  add constraint FK_INVITATION2_AGENT foreign key (AGENT_ID)
  references AGENT_PERSON (AGENT_ID);
alter table INVITATION
  add constraint FK_INVITATION2_DESIGNER foreign key (DESIGNERID)
  references DESIGNER (DESIGNERID);
alter table INVITATION
  add constraint FK_INVITATION2_PACKAGE foreign key (PACKAGEID)
  references PAKCAGE (PACKAGEID);

prompt Disabling triggers for AGENT_PERSON...
alter table AGENT_PERSON disable all triggers;
prompt Disabling triggers for CITY...
alter table CITY disable all triggers;
prompt Disabling triggers for SELLER...
alter table SELLER disable all triggers;
prompt Disabling triggers for APARTMENT...
alter table APARTMENT disable all triggers;
prompt Disabling triggers for BUYER...
alter table BUYER disable all triggers;
prompt Disabling triggers for VISIT...
alter table VISIT disable all triggers;
prompt Disabling triggers for APARTMENT_SALE...
alter table APARTMENT_SALE disable all triggers;
prompt Disabling triggers for EQUIPMENT...
alter table EQUIPMENT disable all triggers;
prompt Disabling triggers for PAKCAGE...
alter table PAKCAGE disable all triggers;
prompt Disabling triggers for CONTAINING...
alter table CONTAINING disable all triggers;
prompt Disabling triggers for DESIGNER...
alter table DESIGNER disable all triggers;
prompt Disabling triggers for SUPPLIER_...
alter table SUPPLIER_ disable all triggers;
prompt Disabling triggers for INSTOCK...
alter table INSTOCK disable all triggers;
prompt Disabling triggers for INVITATION...
alter table INVITATION disable all triggers;
prompt Disabling foreign key constraints for APARTMENT...
alter table APARTMENT disable constraint SYS_C008321;
alter table APARTMENT disable constraint SYS_C008322;
prompt Disabling foreign key constraints for VISIT...
alter table VISIT disable constraint SYS_C008328;
alter table VISIT disable constraint SYS_C008329;
alter table VISIT disable constraint SYS_C008330;
prompt Disabling foreign key constraints for APARTMENT_SALE...
alter table APARTMENT_SALE disable constraint SYS_C008333;
prompt Disabling foreign key constraints for CONTAINING...
alter table CONTAINING disable constraint SYS_C008287;
alter table CONTAINING disable constraint SYS_C008288;
prompt Disabling foreign key constraints for INSTOCK...
alter table INSTOCK disable constraint SYS_C008300;
alter table INSTOCK disable constraint SYS_C008301;
prompt Disabling foreign key constraints for INVITATION...
alter table INVITATION disable constraint FK_INVITATION2_AGENT;
alter table INVITATION disable constraint FK_INVITATION2_DESIGNER;
alter table INVITATION disable constraint FK_INVITATION2_PACKAGE;
prompt Deleting INVITATION...
delete from INVITATION;
commit;
prompt Deleting INSTOCK...
delete from INSTOCK;
commit;
prompt Deleting SUPPLIER_...
delete from SUPPLIER_;
commit;
prompt Deleting DESIGNER...
delete from DESIGNER;
commit;
prompt Deleting CONTAINING...
delete from CONTAINING;
commit;
prompt Deleting PAKCAGE...
delete from PAKCAGE;
commit;
prompt Deleting EQUIPMENT...
delete from EQUIPMENT;
commit;
prompt Deleting APARTMENT_SALE...
delete from APARTMENT_SALE;
commit;
prompt Deleting VISIT...
delete from VISIT;
commit;
prompt Deleting BUYER...
delete from BUYER;
commit;
prompt Deleting APARTMENT...
delete from APARTMENT;
commit;
prompt Deleting SELLER...
delete from SELLER;
commit;
prompt Deleting CITY...
delete from CITY;
commit;
prompt Deleting AGENT_PERSON...
delete from AGENT_PERSON;
commit;
prompt Loading AGENT_PERSON...
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (999, 'Shimmy Brown', 12347, 100, .8, 1, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (998, 'Vicky Gee', 12347, 100, .8, 1, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (997, 'Dudi Cohen', 11287, 100, .8, 1, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (996, 'Rikki Gold', 12387, 100, .8, 1, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (995, 'Bonnie Field', 12287, 100, .8, 1, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (994, 'Sam Smith', 23387, 100, .8, 1, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (993, 'Mike Wazowski', 12187, 100, .8, 0, to_date('01-01-2010', 'dd-mm-yyyy'));
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (992, 'Molly Weasley', 12237, 100, .8, 1, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (991, 'Ronald McDonald', 12323, 100, .8, 1, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (990, 'Sam McSam', 43387, 100, .8, 1, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (214378218, 'debi', 547683445, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (214378214, 'dani', 548983445, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (567878214, 'tali', 547683445, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (278378218, 'yair', 523478945, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (214820218, 'dadi', 537829887, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (345678218, 'mali', 533456778, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (28920218, 'noa', 537862116, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (282089218, 'moshe', 54098765, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (21437821, 'debi', 547683445, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (56787821, 'tali', 547683445, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (27837821, 'yair', 523478945, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (214389221, 'chana', 39090555, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (21482021, 'dadi', 537829887, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (34567821, 'mali', 533456778, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (2892028, 'noa', 537862116, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (28208921, 'moshe', 54098765, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (345678291, 'orit', 543283445, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (21837821, 'dani', 548983445, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (20, 'Irene', 4541224787, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (21, 'Merillee', 4136921532, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (22, 'Wang', 7461644214, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (23, 'Crispin', 8197196194, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (24, 'Juliana', 1365284321, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (25, 'Rosie', 1689743385, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (26, 'Parker', 2222844349, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (27, 'Jeroen', 7919314538, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (28, 'Oliver', 5765684594, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (29, 'Rolando', 3343352918, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (30, 'Minnie', 6455388273, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (31, 'Mint', 7514718542, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (32, 'Don', 6854184878, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (33, 'Gran', 8792991651, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (34, 'Alessandro', 5689547885, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (40, 'Thomas', 7926966328, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (41, 'Jude', 4291951679, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (42, 'Bob', 1286586982, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (43, 'David', 1614514774, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (44, 'Sharon', 8446627179, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (45, 'April', 5678853123, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (46, 'Emilio', 9297744443, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (47, 'Kurt', 2263662325, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (48, 'Fionnula', 7875815785, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (49, 'Leelee', 5584789691, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (50, 'Vondie', 7832558366, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (51, 'Joe', 9177662451, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (52, 'Leelee', 8118978176, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (53, 'Bob', 5399577665, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (54, 'Hex', 4458431942, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (55, 'Gina', 4116614918, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (56, 'Kim', 3829733469, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (57, 'Gilberto', 9848533466, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (58, 'Cameron', 6767179553, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (59, 'Angelina', 5587612386, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (60, 'Powers', 1247498366, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (61, 'Jay', 5368559157, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (62, 'Mary Beth', 1428326468, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (63, 'Clive', 3233337743, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (64, 'Lynn', 4498614726, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (65, 'Ethan', 3898657883, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (66, 'Wang', 1926614236, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (67, 'Joshua', 4267298891, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (68, 'Franz', 7426718615, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (69, 'Raul', 3983469596, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (70, 'Emerson', 2651127966, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (71, 'Armin', 4855194256, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (72, 'Danni', 4192735233, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (73, 'Loreena', 4155836956, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (74, 'Kris', 7599531452, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (75, 'Fred', 2132698791, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (76, 'CeCe', 5491732544, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (77, 'Michael', 8328111216, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (78, 'Rueben', 3611436298, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (79, 'Trey', 8697797899, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (80, 'Terri', 8526351448, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (81, 'Miriam', 5512363831, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (82, 'Christopher', 7169634989, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (83, 'Uma', 3726542561, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (84, 'Kathy', 2943293146, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (85, 'Sara', 2466427131, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (86, 'Collin', 6976885744, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (87, 'Samantha', 6572344585, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (88, 'Adina', 3319634273, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (89, 'Billy', 9481535229, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (90, 'Olga', 2549755375, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (91, 'Ian', 6581371681, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (92, 'Scarlett', 9837416384, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (93, 'Cary', 9765159424, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (94, 'Vendetta', 8488334961, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (95, 'Martha', 1359693646, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (96, 'Rachael', 2618561256, 100, .8, 0, null);
commit;
prompt 100 records committed...
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (97, 'Kristin', 8116276795, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (98, 'Kate', 8481293376, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (99, 'Raymond', 6412511395, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (100, 'Clive', 3323663458, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (101, 'Doug', 5246663927, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (102, 'Raymond', 8917283713, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (103, 'Naomi', 8778732436, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (104, 'Joely', 9316381224, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (105, 'Herbie', 3661343854, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (106, 'Jann', 4356496864, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (107, 'Mary', 6856781542, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (108, 'Wang', 1723133426, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (109, 'Gil', 1685879772, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (110, 'Orlando', 5416379923, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (111, 'Judge', 6574517861, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (112, 'Rita', 4732791932, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (113, 'Horace', 3657817457, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (114, 'Collin', 7596266918, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (115, 'Bo', 7659565241, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (116, 'Queen', 4562377443, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (117, 'Kelly', 6123432269, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (118, 'Reese', 8694764565, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (119, 'Richie', 6643419298, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (120, 'Victor', 6657725754, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (121, 'Rascal', 7659966468, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (122, 'Kiefer', 7374263474, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (123, 'Rosanne', 3241726919, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (124, 'Burton', 5797596264, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (125, 'Sophie', 6498519517, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (126, 'Gilberto', 4512892276, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (127, 'Ryan', 3688268624, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (128, 'Curt', 2788527799, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (129, 'Leo', 6548161789, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (130, 'Judy', 2342337388, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (131, 'Rodney', 5823627515, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (132, 'Gloria', 7927973478, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (133, 'Robert', 9169719845, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (134, 'Rosco', 5349672656, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (135, 'Danny', 2841482183, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (136, 'Alfred', 9244292724, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (137, 'Freddy', 5133924369, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (138, 'Scarlett', 2878645214, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (139, 'Temuera', 3888726129, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (140, 'Nicolas', 7553493826, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (141, 'Kirk', 4918787344, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (142, 'Fionnula', 1114983989, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (143, 'Lucinda', 8914999346, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (144, 'Taylor', 8686268645, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (145, 'Cathy', 9571535586, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (146, 'Kitty', 1198414329, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (147, 'Earl', 2837947497, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (148, 'Benjamin', 8934412652, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (149, 'Andre', 6794455426, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (150, 'Debi', 8848335771, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (151, 'Geraldine', 2552446138, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (152, 'Maria', 1485324393, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (153, 'Trey', 1193858873, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (154, 'Ann', 7697467714, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (155, 'Jon', 5325181743, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (156, 'Gordon', 4742699468, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (157, 'Frankie', 8534473994, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (158, 'Courtney', 5455294972, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (159, 'Robin', 8878854348, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (160, 'Adam', 5164396684, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (161, 'Cathy', 6754938366, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (162, 'Carlos', 7552358592, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (163, 'Micky', 4483963278, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (164, 'Gina', 1666238597, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (165, 'Sharon', 7646612749, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (166, 'Rob', 6666544215, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (167, 'Laurie', 3175725768, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (168, 'Joshua', 8841131524, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (169, 'Katrin', 5733931428, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (170, 'Ewan', 1213387182, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (171, 'Eddie', 8841346551, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (172, 'Charlie', 3784991873, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (173, 'Lili', 6737866787, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (174, 'Kurtwood', 5315498227, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (175, 'Emily', 5673289543, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (176, 'Viggo', 3523863969, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (177, 'Kelly', 7956354931, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (178, 'Lionel', 1451874549, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (179, 'Nikka', 2585965716, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (180, 'Debbie', 3898682549, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (181, 'Ronny', 4864141141, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (182, 'Nils', 2184917772, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (183, 'Nickel', 5766563277, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (184, 'Jeff', 5986739252, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (185, 'Rufus', 1888645453, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (186, 'Daryl', 3887268294, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (187, 'Salma', 1416862179, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (188, 'Timothy', 9586635353, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (189, 'Alan', 6846888694, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (190, 'Lenny', 1322132393, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (191, 'Bonnie', 6145359967, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (192, 'Allison', 1658525953, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (193, 'Desmond', 7333318475, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (194, 'Julianne', 4392298952, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (195, 'Crystal', 9618113187, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (196, 'Natacha', 6862385447, 100, .8, 0, null);
commit;
prompt 200 records committed...
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (197, 'Freddie', 5399445349, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (198, 'Derek', 5172494681, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (199, 'Ozzy', 4793475811, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (200, 'Neil', 5154426729, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (201, 'Richie', 9863551399, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (202, 'Manu', 1455377279, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (203, 'Bobbi', 4138514689, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (204, 'Mickey', 9441943663, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (205, 'Red', 6815781782, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (206, 'Anita', 4816264849, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (207, 'Cherry', 9849756568, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (208, 'Joaquin', 9157786757, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (209, 'Goldie', 9742647628, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (210, 'Machine', 7732987579, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (211, 'Juliet', 9486741337, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (212, 'Willem', 1327728799, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (213, 'Pat', 5272384725, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (214, 'Luke', 4992734354, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (215, 'Connie', 3416565562, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (216, 'Clarence', 5125468112, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (217, 'Harris', 8573822188, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (218, 'Geoff', 6135139693, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (219, 'Randy', 1515877945, 100, .8, 0, null);
insert into AGENT_PERSON (agent_id, agent_name, phone_number, visit_rate, sale_rate, active_status, exit_date)
values (546765043, 'tt', 65342235, 100, .8, 0, null);
commit;
prompt 224 records loaded
prompt Loading CITY...
insert into CITY (city_id, city_name, rating)
values (919, 'Male', 133);
insert into CITY (city_id, city_name, rating)
values (929, 'Sisero', 234);
insert into CITY (city_id, city_name, rating)
values (939, 'Jamal', 445);
insert into CITY (city_id, city_name, rating)
values (949, 'Impogo', 346);
insert into CITY (city_id, city_name, rating)
values (959, 'New Deli', 236);
insert into CITY (city_id, city_name, rating)
values (921, 'Temen', 123);
insert into CITY (city_id, city_name, rating)
values (922, 'Shunami', 187);
commit;
prompt 7 records loaded
prompt Loading SELLER...
insert into SELLER (seller_id, seller_name, phone_number)
values (999, 'Yosef Cohen', 459512387);
insert into SELLER (seller_id, seller_name, phone_number)
values (998, 'Yakov Cohen', 464512387);
insert into SELLER (seller_id, seller_name, phone_number)
values (997, 'Yuri Cohen', 469512387);
insert into SELLER (seller_id, seller_name, phone_number)
values (996, 'Yisroel Cohen', 474512387);
insert into SELLER (seller_id, seller_name, phone_number)
values (995, 'Yael Cohen', 479512387);
insert into SELLER (seller_id, seller_name, phone_number)
values (994, 'Yirmi Cohen', 479512387);
insert into SELLER (seller_id, seller_name, phone_number)
values (993, 'Yechiel Cohen', 479512387);
insert into SELLER (seller_id, seller_name, phone_number)
values (992, 'Yari Cohen', 479512387);
insert into SELLER (seller_id, seller_name, phone_number)
values (991, 'Yoel Cohen', 460512387);
insert into SELLER (seller_id, seller_name, phone_number)
values (990, 'Yitzchak Cohen', 461012387);
insert into SELLER (seller_id, seller_name, phone_number)
values (989, 'Yishmael Cohen', 12387);
commit;
prompt 11 records loaded
prompt Loading APARTMENT...
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id, sold)
values (954, 50, 2, 3, 173643750, 999, 919, 0);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id, sold)
values (953, 54, 0, 3, 150000000, 998, 929, 0);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id, sold)
values (952, 30, 7, 1, 150000000, 997, 939, 0);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id, sold)
values (951, 20, 1, 1, 100000000, 996, 949, 0);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id, sold)
values (950, 65, 1, 2, 300000000, 995, 959, 0);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id, sold)
values (949, 36, 1, 1, 150000000, 994, 959, 0);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id, sold)
values (948, 90, 2, 3, 350000000, 993, 959, 0);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id, sold)
values (947, 62, 0, 3, 200000000, 992, 959, 0);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id, sold)
values (946, 48, 3, 2, 250000000, 991, 921, 0);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id, sold)
values (945, 63, 1, 3, 350000000, 990, 922, 0);
commit;
prompt 10 records loaded
prompt Loading BUYER...
insert into BUYER (buyer_id, buyer_name, phone_number)
values (999, 'Noa Nos', 32452);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (789, 'Noa Aizrncn', 53222);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (778, 'Ori Yajo', 95458);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (983, 'rachel  mag', 54325);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (987, 'shora mag', 35452);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (678, 'noa rnxd', 93848);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (982, 'rachel  aizen', 64224);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (984, 'ori yayay', 12345);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (964, 'ori yemen', 12435);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (954, 'ori yoni', 12235);
commit;
prompt 10 records loaded
prompt Loading VISIT...
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (980, to_date('03-05-2014', 'dd-mm-yyyy'), 12, 954, 999, 999, 'Notebook', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (981, to_date('12-04-2012', 'dd-mm-yyyy'), 10, 953, 789, 998, 'Pen', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (982, to_date('11-02-2013', 'dd-mm-yyyy'), 15, 952, 778, 997, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (983, to_date('10-01-2007', 'dd-mm-yyyy'), 11, 951, 983, 996, 'Pen', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (984, to_date('23-02-2004', 'dd-mm-yyyy'), 11, 950, 987, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (985, to_date('21-03-2003', 'dd-mm-yyyy'), 10, 949, 678, 994, 'Pen', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (986, to_date('22-04-2002', 'dd-mm-yyyy'), 14, 948, 983, 993, 'Pen', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (987, to_date('21-05-2012', 'dd-mm-yyyy'), 12, 947, 984, 992, 'Notebook', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (988, to_date('12-04-2014', 'dd-mm-yyyy'), 14, 946, 964, 991, 'Pen', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (989, to_date('12-05-2013', 'dd-mm-yyyy'), 12, 945, 954, 990, 'Pen', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (999, to_date('04-05-2014', 'dd-mm-yyyy'), 13, 954, 999, 999, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (1, to_date('01-12-2005', 'dd-mm-yyyy'), 13, 954, 983, 996, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (2, to_date('28-04-2012', 'dd-mm-yyyy'), 13, 949, 983, 991, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (3, to_date('19-03-2019', 'dd-mm-yyyy'), 18, 945, 987, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (4, to_date('18-10-2006', 'dd-mm-yyyy'), 11, 954, 678, 994, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (5, to_date('02-10-2013', 'dd-mm-yyyy'), 10, 950, 954, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (6, to_date('03-08-2011', 'dd-mm-yyyy'), 11, 947, 678, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (7, to_date('24-07-2023', 'dd-mm-yyyy'), 18, 949, 984, 999, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (8, to_date('13-07-2006', 'dd-mm-yyyy'), 12, 951, 982, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (9, to_date('24-11-2013', 'dd-mm-yyyy'), 9, 952, 987, 991, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (10, to_date('18-02-2005', 'dd-mm-yyyy'), 17, 947, 984, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (11, to_date('20-10-2004', 'dd-mm-yyyy'), 14, 954, 678, 999, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (12, to_date('31-03-2013', 'dd-mm-yyyy'), 14, 945, 964, 992, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (13, to_date('16-03-2021', 'dd-mm-yyyy'), 18, 946, 999, 996, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (14, to_date('12-07-2013', 'dd-mm-yyyy'), 18, 947, 778, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (15, to_date('18-05-2018', 'dd-mm-yyyy'), 15, 946, 954, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (16, to_date('11-12-2013', 'dd-mm-yyyy'), 17, 952, 789, 997, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (17, to_date('20-07-2013', 'dd-mm-yyyy'), 13, 948, 999, 999, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (18, to_date('04-02-2019', 'dd-mm-yyyy'), 18, 953, 789, 999, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (19, to_date('15-05-2002', 'dd-mm-yyyy'), 18, 949, 999, 993, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (20, to_date('30-09-2003', 'dd-mm-yyyy'), 18, 947, 678, 997, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (21, to_date('09-07-2015', 'dd-mm-yyyy'), 13, 954, 789, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (22, to_date('22-09-2021', 'dd-mm-yyyy'), 16, 950, 678, 992, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (23, to_date('25-09-2016', 'dd-mm-yyyy'), 17, 948, 964, 994, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (24, to_date('10-04-2010', 'dd-mm-yyyy'), 10, 954, 678, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (25, to_date('01-07-2013', 'dd-mm-yyyy'), 16, 949, 789, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (26, to_date('21-10-2004', 'dd-mm-yyyy'), 10, 951, 678, 997, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (27, to_date('28-11-2005', 'dd-mm-yyyy'), 16, 947, 987, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (28, to_date('27-09-2022', 'dd-mm-yyyy'), 9, 948, 954, 991, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (29, to_date('18-07-2016', 'dd-mm-yyyy'), 9, 948, 778, 991, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (30, to_date('07-06-2011', 'dd-mm-yyyy'), 18, 952, 954, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (31, to_date('04-10-2019', 'dd-mm-yyyy'), 9, 953, 984, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (32, to_date('12-12-2004', 'dd-mm-yyyy'), 18, 946, 984, 999, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (33, to_date('30-08-2015', 'dd-mm-yyyy'), 12, 947, 982, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (34, to_date('28-04-2010', 'dd-mm-yyyy'), 11, 948, 678, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (35, to_date('30-12-2013', 'dd-mm-yyyy'), 11, 953, 999, 992, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (36, to_date('31-10-2009', 'dd-mm-yyyy'), 10, 953, 954, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (37, to_date('11-04-2007', 'dd-mm-yyyy'), 14, 951, 983, 994, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (38, to_date('10-12-2002', 'dd-mm-yyyy'), 16, 948, 999, 996, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (39, to_date('19-06-2009', 'dd-mm-yyyy'), 9, 945, 982, 994, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (40, to_date('24-12-2011', 'dd-mm-yyyy'), 18, 953, 678, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (41, to_date('16-03-2013', 'dd-mm-yyyy'), 9, 952, 982, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (42, to_date('10-05-2015', 'dd-mm-yyyy'), 11, 947, 999, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (43, to_date('19-09-2006', 'dd-mm-yyyy'), 14, 953, 964, 999, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (44, to_date('09-07-2014', 'dd-mm-yyyy'), 12, 954, 983, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (45, to_date('25-05-2011', 'dd-mm-yyyy'), 12, 947, 789, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (46, to_date('19-04-2007', 'dd-mm-yyyy'), 15, 948, 778, 996, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (47, to_date('30-03-2016', 'dd-mm-yyyy'), 11, 948, 987, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (48, to_date('31-12-2010', 'dd-mm-yyyy'), 11, 946, 789, 994, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (49, to_date('13-01-2009', 'dd-mm-yyyy'), 17, 949, 987, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (50, to_date('10-06-2000', 'dd-mm-yyyy'), 17, 950, 954, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (51, to_date('23-11-2019', 'dd-mm-yyyy'), 16, 953, 964, 992, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (52, to_date('17-04-2011', 'dd-mm-yyyy'), 17, 953, 964, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (53, to_date('03-10-2016', 'dd-mm-yyyy'), 15, 954, 983, 997, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (54, to_date('23-05-2015', 'dd-mm-yyyy'), 18, 954, 982, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (55, to_date('21-03-2020', 'dd-mm-yyyy'), 13, 948, 964, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (56, to_date('26-07-2011', 'dd-mm-yyyy'), 9, 947, 982, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (57, to_date('11-10-2023', 'dd-mm-yyyy'), 10, 954, 984, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (58, to_date('15-08-2011', 'dd-mm-yyyy'), 12, 945, 987, 997, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (59, to_date('20-04-2005', 'dd-mm-yyyy'), 9, 945, 982, 991, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (60, to_date('05-08-2009', 'dd-mm-yyyy'), 18, 947, 778, 999, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (61, to_date('20-01-2008', 'dd-mm-yyyy'), 15, 951, 987, 993, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (62, to_date('11-07-2006', 'dd-mm-yyyy'), 13, 949, 954, 991, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (63, to_date('24-09-2021', 'dd-mm-yyyy'), 16, 951, 983, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (64, to_date('26-03-2005', 'dd-mm-yyyy'), 15, 953, 789, 996, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (65, to_date('22-06-2021', 'dd-mm-yyyy'), 18, 952, 789, 999, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (66, to_date('13-02-2005', 'dd-mm-yyyy'), 18, 954, 678, 994, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (67, to_date('28-08-2003', 'dd-mm-yyyy'), 17, 949, 987, 991, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (68, to_date('23-08-2003', 'dd-mm-yyyy'), 17, 947, 982, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (69, to_date('25-12-2012', 'dd-mm-yyyy'), 18, 954, 789, 990, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (70, to_date('14-05-2000', 'dd-mm-yyyy'), 9, 947, 789, 993, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (71, to_date('15-07-2017', 'dd-mm-yyyy'), 15, 948, 983, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (72, to_date('10-11-2020', 'dd-mm-yyyy'), 18, 951, 964, 994, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (73, to_date('06-05-2016', 'dd-mm-yyyy'), 15, 954, 987, 992, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (74, to_date('18-10-2022', 'dd-mm-yyyy'), 15, 953, 983, 994, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (75, to_date('25-10-2007', 'dd-mm-yyyy'), 9, 950, 987, 993, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (76, to_date('27-07-2001', 'dd-mm-yyyy'), 9, 948, 778, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (77, to_date('16-03-2018', 'dd-mm-yyyy'), 13, 947, 982, 999, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (78, to_date('23-08-2008', 'dd-mm-yyyy'), 16, 950, 983, 997, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (79, to_date('08-06-2002', 'dd-mm-yyyy'), 11, 948, 789, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (80, to_date('30-10-2019', 'dd-mm-yyyy'), 14, 954, 982, 992, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (81, to_date('24-06-2001', 'dd-mm-yyyy'), 12, 949, 954, 991, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (82, to_date('12-11-2003', 'dd-mm-yyyy'), 17, 950, 789, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (83, to_date('19-01-2019', 'dd-mm-yyyy'), 16, 946, 678, 992, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (84, to_date('19-02-2014', 'dd-mm-yyyy'), 16, 945, 789, 991, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (85, to_date('01-07-2018', 'dd-mm-yyyy'), 16, 953, 964, 992, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (86, to_date('14-04-2006', 'dd-mm-yyyy'), 9, 948, 982, 993, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (87, to_date('20-04-2020', 'dd-mm-yyyy'), 16, 948, 984, 994, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (88, to_date('15-03-2014', 'dd-mm-yyyy'), 12, 947, 987, 991, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (89, to_date('12-09-2010', 'dd-mm-yyyy'), 14, 948, 999, 996, 'Nothing', null);
commit;
prompt 100 records committed...
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (90, to_date('17-03-2023', 'dd-mm-yyyy'), 10, 948, 999, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (91, to_date('06-01-2009', 'dd-mm-yyyy'), 15, 953, 983, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (92, to_date('26-01-2003', 'dd-mm-yyyy'), 14, 953, 984, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (93, to_date('15-07-2007', 'dd-mm-yyyy'), 12, 951, 982, 991, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (94, to_date('18-10-2017', 'dd-mm-yyyy'), 9, 951, 778, 995, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (95, to_date('06-02-2001', 'dd-mm-yyyy'), 10, 952, 678, 993, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (96, to_date('04-11-2000', 'dd-mm-yyyy'), 10, 947, 678, 997, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (97, to_date('05-05-2002', 'dd-mm-yyyy'), 12, 947, 964, 997, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (98, to_date('20-04-2022', 'dd-mm-yyyy'), 16, 949, 987, 996, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (99, to_date('14-12-2002', 'dd-mm-yyyy'), 10, 945, 984, 998, 'Nothing', null);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status, flowersid)
values (100, to_date('23-06-2004', 'dd-mm-yyyy'), 13, 953, 778, 996, 'Nothing', null);
commit;
prompt 111 records loaded
prompt Loading APARTMENT_SALE...
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (924, 150000000, 19919, to_date('03-05-2014', 'dd-mm-yyyy'), 980);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (923, 150000000, 19929, to_date('11-01-2024', 'dd-mm-yyyy'), 981);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (922, 150000000, 19939, to_date('22-06-2026', 'dd-mm-yyyy'), 982);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (921, 100000000, 19949, to_date('24-09-2027', 'dd-mm-yyyy'), 983);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (930, 300000000, 10159, to_date('25-10-2026', 'dd-mm-yyyy'), 984);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (939, 150000000, 19969, to_date('07-11-2025', 'dd-mm-yyyy'), 985);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (938, 350000000, 20979, to_date('09-05-2025', 'dd-mm-yyyy'), 986);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (937, 200000000, 29989, to_date('07-04-2026', 'dd-mm-yyyy'), 987);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (936, 250000000, 29921, to_date('02-01-2027', 'dd-mm-yyyy'), 988);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (935, 6350000000, 29922, to_date('01-06-2028', 'dd-mm-yyyy'), 989);
commit;
prompt 10 records loaded
prompt Loading EQUIPMENT...
insert into EQUIPMENT (equipmentid, equipmentname)
values (2, ' Daisy');
insert into EQUIPMENT (equipmentid, equipmentname)
values (3, ' Rose');
insert into EQUIPMENT (equipmentid, equipmentname)
values (4, ' Orchid');
insert into EQUIPMENT (equipmentid, equipmentname)
values (5, ' Lily');
insert into EQUIPMENT (equipmentid, equipmentname)
values (6, ' Plant Mister');
insert into EQUIPMENT (equipmentid, equipmentname)
values (7, ' Hyacinth');
insert into EQUIPMENT (equipmentid, equipmentname)
values (8, ' Bud Vase');
insert into EQUIPMENT (equipmentid, equipmentname)
values (9, ' Iris');
insert into EQUIPMENT (equipmentid, equipmentname)
values (10, ' Sunflower');
insert into EQUIPMENT (equipmentid, equipmentname)
values (11, ' Flower Pot');
insert into EQUIPMENT (equipmentid, equipmentname)
values (12, ' Carnation');
insert into EQUIPMENT (equipmentid, equipmentname)
values (13, ' Azalea');
insert into EQUIPMENT (equipmentid, equipmentname)
values (14, ' Trowel');
insert into EQUIPMENT (equipmentid, equipmentname)
values (15, ' Dahlia');
insert into EQUIPMENT (equipmentid, equipmentname)
values (16, ' Weed Whacker');
insert into EQUIPMENT (equipmentid, equipmentname)
values (17, ' Freesia');
insert into EQUIPMENT (equipmentid, equipmentname)
values (18, ' Terrarium');
insert into EQUIPMENT (equipmentid, equipmentname)
values (19, ' Bougainvillea');
insert into EQUIPMENT (equipmentid, equipmentname)
values (20, ' Pansy');
insert into EQUIPMENT (equipmentid, equipmentname)
values (21, ' Mulch');
insert into EQUIPMENT (equipmentid, equipmentname)
values (22, ' Poppy');
insert into EQUIPMENT (equipmentid, equipmentname)
values (23, ' Cold Frame');
insert into EQUIPMENT (equipmentid, equipmentname)
values (24, ' Hydrangea');
insert into EQUIPMENT (equipmentid, equipmentname)
values (25, ' Gladiolus');
insert into EQUIPMENT (equipmentid, equipmentname)
values (26, ' Lavender');
insert into EQUIPMENT (equipmentid, equipmentname)
values (27, ' Aster');
insert into EQUIPMENT (equipmentid, equipmentname)
values (28, ' Geranium');
insert into EQUIPMENT (equipmentid, equipmentname)
values (29, ' Zinnia');
insert into EQUIPMENT (equipmentid, equipmentname)
values (30, ' Bulb Planter');
insert into EQUIPMENT (equipmentid, equipmentname)
values (31, ' Begonia');
insert into EQUIPMENT (equipmentid, equipmentname)
values (33, ' Daffodil');
insert into EQUIPMENT (equipmentid, equipmentname)
values (34, ' Garden Rake');
insert into EQUIPMENT (equipmentid, equipmentname)
values (35, ' Crocus');
insert into EQUIPMENT (equipmentid, equipmentname)
values (36, ' Violet');
insert into EQUIPMENT (equipmentid, equipmentname)
values (37, ' Garden Marker');
insert into EQUIPMENT (equipmentid, equipmentname)
values (38, ' Marigold');
insert into EQUIPMENT (equipmentid, equipmentname)
values (39, ' Columbine');
insert into EQUIPMENT (equipmentid, equipmentname)
values (40, ' Cosmos');
insert into EQUIPMENT (equipmentid, equipmentname)
values (41, ' Wisteria');
insert into EQUIPMENT (equipmentid, equipmentname)
values (42, ' Trellis');
insert into EQUIPMENT (equipmentid, equipmentname)
values (43, ' Clematis');
insert into EQUIPMENT (equipmentid, equipmentname)
values (44, ' Hand Trowel');
insert into EQUIPMENT (equipmentid, equipmentname)
values (45, ' Foxglove');
insert into EQUIPMENT (equipmentid, equipmentname)
values (46, ' Pruning Hook');
insert into EQUIPMENT (equipmentid, equipmentname)
values (47, ' Phlox');
insert into EQUIPMENT (equipmentid, equipmentname)
values (48, ' Hollyhock');
insert into EQUIPMENT (equipmentid, equipmentname)
values (49, ' Anemone');
insert into EQUIPMENT (equipmentid, equipmentname)
values (51, ' Hyacinth');
insert into EQUIPMENT (equipmentid, equipmentname)
values (52, ' FlowerBasket');
insert into EQUIPMENT (equipmentid, equipmentname)
values (53, ' Iris');
insert into EQUIPMENT (equipmentid, equipmentname)
values (54, ' Sunflower');
insert into EQUIPMENT (equipmentid, equipmentname)
values (55, ' GardenSpade');
insert into EQUIPMENT (equipmentid, equipmentname)
values (56, ' Carnation');
insert into EQUIPMENT (equipmentid, equipmentname)
values (57, ' Azalea');
insert into EQUIPMENT (equipmentid, equipmentname)
values (58, ' Dahlia');
insert into EQUIPMENT (equipmentid, equipmentname)
values (59, ' Freesia');
insert into EQUIPMENT (equipmentid, equipmentname)
values (61, ' Bougainvillea');
insert into EQUIPMENT (equipmentid, equipmentname)
values (62, ' GardenEdging');
insert into EQUIPMENT (equipmentid, equipmentname)
values (63, ' Pansy');
insert into EQUIPMENT (equipmentid, equipmentname)
values (64, ' Poppy');
insert into EQUIPMENT (equipmentid, equipmentname)
values (65, ' Hydrangea');
insert into EQUIPMENT (equipmentid, equipmentname)
values (66, ' Gladiolus');
insert into EQUIPMENT (equipmentid, equipmentname)
values (67, ' Lavender');
insert into EQUIPMENT (equipmentid, equipmentname)
values (68, ' Aster');
insert into EQUIPMENT (equipmentid, equipmentname)
values (69, ' Geranium');
insert into EQUIPMENT (equipmentid, equipmentname)
values (70, ' Sprayer');
insert into EQUIPMENT (equipmentid, equipmentname)
values (71, ' Zinnia');
insert into EQUIPMENT (equipmentid, equipmentname)
values (72, ' Begonia');
insert into EQUIPMENT (equipmentid, equipmentname)
values (73, ' Daffodil');
insert into EQUIPMENT (equipmentid, equipmentname)
values (74, ' Crocus');
insert into EQUIPMENT (equipmentid, equipmentname)
values (75, ' BirdFeeder');
insert into EQUIPMENT (equipmentid, equipmentname)
values (76, ' Violet');
insert into EQUIPMENT (equipmentid, equipmentname)
values (77, ' Marigold');
insert into EQUIPMENT (equipmentid, equipmentname)
values (78, ' GardenKneeler');
insert into EQUIPMENT (equipmentid, equipmentname)
values (79, ' Columbine');
insert into EQUIPMENT (equipmentid, equipmentname)
values (81, ' Cosmos');
insert into EQUIPMENT (equipmentid, equipmentname)
values (82, ' Wisteria');
insert into EQUIPMENT (equipmentid, equipmentname)
values (83, ' Clematis');
insert into EQUIPMENT (equipmentid, equipmentname)
values (84, ' GardenBench');
insert into EQUIPMENT (equipmentid, equipmentname)
values (85, ' Foxglove');
insert into EQUIPMENT (equipmentid, equipmentname)
values (86, ' Phlox');
insert into EQUIPMENT (equipmentid, equipmentname)
values (87, ' Hollyhock');
insert into EQUIPMENT (equipmentid, equipmentname)
values (88, ' Anemone');
insert into EQUIPMENT (equipmentid, equipmentname)
values (90, ' braidchair');
insert into EQUIPMENT (equipmentid, equipmentname)
values (91, ' hoop');
insert into EQUIPMENT (equipmentid, equipmentname)
values (92, ' vase');
insert into EQUIPMENT (equipmentid, equipmentname)
values (93, ' minivase');
insert into EQUIPMENT (equipmentid, equipmentname)
values (94, ' bigvase');
insert into EQUIPMENT (equipmentid, equipmentname)
values (95, ' thinvase');
insert into EQUIPMENT (equipmentid, equipmentname)
values (96, ' ugevase');
insert into EQUIPMENT (equipmentid, equipmentname)
values (97, ' pinkmap');
insert into EQUIPMENT (equipmentid, equipmentname)
values (98, ' purplemap');
insert into EQUIPMENT (equipmentid, equipmentname)
values (99, ' greenmap');
insert into EQUIPMENT (equipmentid, equipmentname)
values (100, ' yellowmap');
insert into EQUIPMENT (equipmentid, equipmentname)
values (101, ' bluemap');
insert into EQUIPMENT (equipmentid, equipmentname)
values (102, ' lightbluemap');
insert into EQUIPMENT (equipmentid, equipmentname)
values (103, ' lightgreenmap');
insert into EQUIPMENT (equipmentid, equipmentname)
values (104, ' begemap');
insert into EQUIPMENT (equipmentid, equipmentname)
values (105, ' whitemap');
insert into EQUIPMENT (equipmentid, equipmentname)
values (106, ' pinkraner');
commit;
prompt 100 records committed...
insert into EQUIPMENT (equipmentid, equipmentname)
values (107, ' purpleraner');
insert into EQUIPMENT (equipmentid, equipmentname)
values (108, ' greenraner');
insert into EQUIPMENT (equipmentid, equipmentname)
values (110, ' blueraner');
insert into EQUIPMENT (equipmentid, equipmentname)
values (111, ' lightblueraner');
insert into EQUIPMENT (equipmentid, equipmentname)
values (112, ' begeraner');
insert into EQUIPMENT (equipmentid, equipmentname)
values (113, ' whiteraner');
insert into EQUIPMENT (equipmentid, equipmentname)
values (114, ' bigsponge');
insert into EQUIPMENT (equipmentid, equipmentname)
values (115, ' tinysponge');
insert into EQUIPMENT (equipmentid, equipmentname)
values (116, ' squresponge');
insert into EQUIPMENT (equipmentid, equipmentname)
values (117, ' sand');
insert into EQUIPMENT (equipmentid, equipmentname)
values (118, ' Tulip');
insert into EQUIPMENT (equipmentid, equipmentname)
values (120, ' bigchandelier');
insert into EQUIPMENT (equipmentid, equipmentname)
values (32, ' Landscape Fabric');
insert into EQUIPMENT (equipmentid, equipmentname)
values (50, ' LilyoftheValley');
insert into EQUIPMENT (equipmentid, equipmentname)
values (60, ' PropagationDome');
insert into EQUIPMENT (equipmentid, equipmentname)
values (80, ' DiatomaceousEarth');
insert into EQUIPMENT (equipmentid, equipmentname)
values (89, ' LilyoftheValley');
insert into EQUIPMENT (equipmentid, equipmentname)
values (109, ' lightgreenraner');
insert into EQUIPMENT (equipmentid, equipmentname)
values (119, ' smallchandelier');
insert into EQUIPMENT (equipmentid, equipmentname)
values (121, ' normalchandelier');
insert into EQUIPMENT (equipmentid, equipmentname)
values (122, ' pomegranates');
insert into EQUIPMENT (equipmentid, equipmentname)
values (123, ' pinktulle');
insert into EQUIPMENT (equipmentid, equipmentname)
values (124, ' purpletulle');
insert into EQUIPMENT (equipmentid, equipmentname)
values (125, ' greentulle');
insert into EQUIPMENT (equipmentid, equipmentname)
values (126, ' lightgreentulle');
insert into EQUIPMENT (equipmentid, equipmentname)
values (127, ' redtulle');
insert into EQUIPMENT (equipmentid, equipmentname)
values (128, ' begetulle');
insert into EQUIPMENT (equipmentid, equipmentname)
values (129, ' bluetulle');
insert into EQUIPMENT (equipmentid, equipmentname)
values (130, ' lightbluetulle');
commit;
prompt 129 records loaded
prompt Loading PAKCAGE...
insert into PAKCAGE (packageid, packagename, price)
values (1, ' bridachair', 5500);
insert into PAKCAGE (packageid, packagename, price)
values (2, ' Tabledecoration', 5000);
insert into PAKCAGE (packageid, packagename, price)
values (3, ' Bridalbouquet', 2000);
insert into PAKCAGE (packageid, packagename, price)
values (4, ' Bridalchair + tabledesign', 7000);
insert into PAKCAGE (packageid, packagename, price)
values (6, ' Bardesign', 6000);
insert into PAKCAGE (packageid, packagename, price)
values (7, ' tablegarlands', 8500);
insert into PAKCAGE (packageid, packagename, price)
values (8, ' Backtoabridalchair+bridachair', 7000);
insert into PAKCAGE (packageid, packagename, price)
values (9, ' tablegarlands+Tabledecoration', 8000);
insert into PAKCAGE (packageid, packagename, price)
values (10, ' Designedchandeliers', 10000);
insert into PAKCAGE (packageid, packagename, price)
values (11, 'Basic Package', 10000);
commit;
prompt 10 records loaded
prompt Loading CONTAINING...
insert into CONTAINING (amountc, equipmentid, packageid)
values (5687, 41, 4);
insert into CONTAINING (amountc, equipmentid, packageid)
values (2572, 120, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (2011, 89, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (312, 45, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (2178, 65, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (1685, 112, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (319, 50, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (6327, 77, 2);
insert into CONTAINING (amountc, equipmentid, packageid)
values (9352, 120, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (7736, 45, 7);
insert into CONTAINING (amountc, equipmentid, packageid)
values (9287, 123, 10);
insert into CONTAINING (amountc, equipmentid, packageid)
values (789, 64, 9);
insert into CONTAINING (amountc, equipmentid, packageid)
values (7809, 105, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (8017, 44, 7);
insert into CONTAINING (amountc, equipmentid, packageid)
values (3380, 68, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (4843, 21, 7);
insert into CONTAINING (amountc, equipmentid, packageid)
values (5629, 100, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (3395, 9, 10);
insert into CONTAINING (amountc, equipmentid, packageid)
values (9925, 102, 2);
insert into CONTAINING (amountc, equipmentid, packageid)
values (5518, 112, 10);
insert into CONTAINING (amountc, equipmentid, packageid)
values (2689, 10, 4);
insert into CONTAINING (amountc, equipmentid, packageid)
values (1966, 88, 9);
insert into CONTAINING (amountc, equipmentid, packageid)
values (4904, 46, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (8685, 118, 2);
insert into CONTAINING (amountc, equipmentid, packageid)
values (1385, 3, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (7572, 38, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (5243, 73, 9);
insert into CONTAINING (amountc, equipmentid, packageid)
values (76, 101, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (6455, 13, 4);
insert into CONTAINING (amountc, equipmentid, packageid)
values (8089, 77, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (1203, 59, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (625, 24, 7);
insert into CONTAINING (amountc, equipmentid, packageid)
values (7769, 66, 2);
insert into CONTAINING (amountc, equipmentid, packageid)
values (9528, 58, 10);
insert into CONTAINING (amountc, equipmentid, packageid)
values (9928, 127, 10);
insert into CONTAINING (amountc, equipmentid, packageid)
values (3974, 76, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (6369, 38, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (7958, 22, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (7517, 43, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (141, 124, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (8518, 37, 7);
insert into CONTAINING (amountc, equipmentid, packageid)
values (9784, 35, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (1764, 33, 9);
insert into CONTAINING (amountc, equipmentid, packageid)
values (1510, 69, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (3902, 25, 2);
insert into CONTAINING (amountc, equipmentid, packageid)
values (7613, 48, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (8288, 115, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (930, 126, 10);
insert into CONTAINING (amountc, equipmentid, packageid)
values (9623, 53, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (3523, 54, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (4521, 130, 9);
insert into CONTAINING (amountc, equipmentid, packageid)
values (8374, 96, 7);
insert into CONTAINING (amountc, equipmentid, packageid)
values (4612, 129, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (2651, 5, 2);
insert into CONTAINING (amountc, equipmentid, packageid)
values (8966, 127, 4);
insert into CONTAINING (amountc, equipmentid, packageid)
values (2744, 7, 8);
insert into CONTAINING (amountc, equipmentid, packageid)
values (5014, 33, 2);
insert into CONTAINING (amountc, equipmentid, packageid)
values (4720, 109, 9);
insert into CONTAINING (amountc, equipmentid, packageid)
values (3048, 4, 8);
insert into CONTAINING (amountc, equipmentid, packageid)
values (7493, 100, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (3655, 108, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (4771, 48, 2);
insert into CONTAINING (amountc, equipmentid, packageid)
values (2194, 26, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (5619, 85, 4);
insert into CONTAINING (amountc, equipmentid, packageid)
values (9669, 11, 4);
insert into CONTAINING (amountc, equipmentid, packageid)
values (7826, 90, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (8191, 17, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (8845, 20, 2);
insert into CONTAINING (amountc, equipmentid, packageid)
values (3928, 32, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (1650, 8, 4);
insert into CONTAINING (amountc, equipmentid, packageid)
values (3839, 57, 2);
insert into CONTAINING (amountc, equipmentid, packageid)
values (1082, 49, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (5211, 81, 4);
insert into CONTAINING (amountc, equipmentid, packageid)
values (9574, 40, 6);
insert into CONTAINING (amountc, equipmentid, packageid)
values (3952, 7, 3);
insert into CONTAINING (amountc, equipmentid, packageid)
values (4681, 83, 2);
insert into CONTAINING (amountc, equipmentid, packageid)
values (7683, 16, 1);
insert into CONTAINING (amountc, equipmentid, packageid)
values (3083, 37, 9);
insert into CONTAINING (amountc, equipmentid, packageid)
values (2499, 98, 8);
insert into CONTAINING (amountc, equipmentid, packageid)
values (6407, 52, 8);
insert into CONTAINING (amountc, equipmentid, packageid)
values (9282, 114, 7);
commit;
prompt 81 records loaded
prompt Loading DESIGNER...
insert into DESIGNER (designername, designerid, payment)
values (' Debbie', 1, 5000);
insert into DESIGNER (designername, designerid, payment)
values (' Daniel', 2, 8000);
insert into DESIGNER (designername, designerid, payment)
values (' Anna', 3, 4500);
insert into DESIGNER (designername, designerid, payment)
values (' John', 4, 7000);
insert into DESIGNER (designername, designerid, payment)
values (' Linda', 5, 6200);
insert into DESIGNER (designername, designerid, payment)
values (' Michael', 6, 9200);
insert into DESIGNER (designername, designerid, payment)
values (' Emily', 7, 4800);
insert into DESIGNER (designername, designerid, payment)
values (' Robert', 8, 7600);
insert into DESIGNER (designername, designerid, payment)
values (' Laura', 9, 5300);
insert into DESIGNER (designername, designerid, payment)
values (' David', 10, 8400);
insert into DESIGNER (designername, designerid, payment)
values (' Jessica', 11, 4900);
insert into DESIGNER (designername, designerid, payment)
values (' Richard', 12, 7100);
insert into DESIGNER (designername, designerid, payment)
values (' Karen', 13, 6500);
insert into DESIGNER (designername, designerid, payment)
values (' Thomas', 14, 7900);
insert into DESIGNER (designername, designerid, payment)
values (' Susan', 15, 5700);
insert into DESIGNER (designername, designerid, payment)
values (' Charles', 16, 8600);
insert into DESIGNER (designername, designerid, payment)
values (' Sarah', 17, 4700);
insert into DESIGNER (designername, designerid, payment)
values (' Joseph', 18, 7300);
insert into DESIGNER (designername, designerid, payment)
values (' Karen', 19, 6900);
insert into DESIGNER (designername, designerid, payment)
values (' James', 20, 8300);
insert into DESIGNER (designername, designerid, payment)
values (' Patricia', 21, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Christopher', 22, 9100);
insert into DESIGNER (designername, designerid, payment)
values (' Barbara', 23, 5800);
insert into DESIGNER (designername, designerid, payment)
values (' Matthew', 24, 7800);
insert into DESIGNER (designername, designerid, payment)
values (' Elizabeth', 25, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Anthony', 26, 8500);
insert into DESIGNER (designername, designerid, payment)
values (' Lisa', 27, 4900);
insert into DESIGNER (designername, designerid, payment)
values (' Joshua', 28, 7200);
insert into DESIGNER (designername, designerid, payment)
values (' Nancy', 29, 6300);
insert into DESIGNER (designername, designerid, payment)
values (' Andrew', 30, 8800);
insert into DESIGNER (designername, designerid, payment)
values (' Karen', 31, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Steven', 32, 7400);
insert into DESIGNER (designername, designerid, payment)
values (' Margaret', 33, 6200);
insert into DESIGNER (designername, designerid, payment)
values (' Kevin', 34, 9000);
insert into DESIGNER (designername, designerid, payment)
values (' Sandra', 35, 5600);
insert into DESIGNER (designername, designerid, payment)
values (' Brian', 36, 7700);
insert into DESIGNER (designername, designerid, payment)
values (' Ashley', 37, 5800);
insert into DESIGNER (designername, designerid, payment)
values (' Edward', 38, 9300);
insert into DESIGNER (designername, designerid, payment)
values (' Donna', 39, 5700);
insert into DESIGNER (designername, designerid, payment)
values (' Ronald', 40, 7600);
insert into DESIGNER (designername, designerid, payment)
values (' Michelle', 41, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Timothy', 42, 8400);
insert into DESIGNER (designername, designerid, payment)
values (' Carol', 43, 6300);
insert into DESIGNER (designername, designerid, payment)
values (' Jason', 44, 8700);
insert into DESIGNER (designername, designerid, payment)
values (' Dorothy', 45, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Jeffrey', 46, 8900);
insert into DESIGNER (designername, designerid, payment)
values (' Rebecca', 47, 5500);
insert into DESIGNER (designername, designerid, payment)
values (' Ryan', 48, 7400);
insert into DESIGNER (designername, designerid, payment)
values (' Sharon', 49, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Gary', 50, 8100);
insert into DESIGNER (designername, designerid, payment)
values (' Cynthia', 51, 5300);
insert into DESIGNER (designername, designerid, payment)
values (' Jacob', 52, 8000);
insert into DESIGNER (designername, designerid, payment)
values (' Kathleen', 53, 5800);
insert into DESIGNER (designername, designerid, payment)
values (' Nicholas', 54, 8900);
insert into DESIGNER (designername, designerid, payment)
values (' Shirley', 55, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Eric', 56, 7800);
insert into DESIGNER (designername, designerid, payment)
values (' Amy', 57, 5400);
insert into DESIGNER (designername, designerid, payment)
values (' Stephen', 58, 8300);
insert into DESIGNER (designername, designerid, payment)
values (' Angela', 59, 5800);
insert into DESIGNER (designername, designerid, payment)
values (' Jonathan', 60, 9100);
insert into DESIGNER (designername, designerid, payment)
values (' Helen', 61, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Larry', 62, 7500);
insert into DESIGNER (designername, designerid, payment)
values (' Anna', 63, 6300);
insert into DESIGNER (designername, designerid, payment)
values (' Justin', 64, 9400);
insert into DESIGNER (designername, designerid, payment)
values (' Ruth', 65, 5700);
insert into DESIGNER (designername, designerid, payment)
values (' Scott', 66, 8600);
insert into DESIGNER (designername, designerid, payment)
values (' Brenda', 67, 6200);
insert into DESIGNER (designername, designerid, payment)
values (' Brandon', 68, 9000);
insert into DESIGNER (designername, designerid, payment)
values (' Pamela', 69, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Frank', 70, 8700);
insert into DESIGNER (designername, designerid, payment)
values (' Nicole', 71, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Benjamin', 72, 8300);
insert into DESIGNER (designername, designerid, payment)
values (' Katherine', 73, 6200);
insert into DESIGNER (designername, designerid, payment)
values (' Gregory', 74, 9200);
insert into DESIGNER (designername, designerid, payment)
values (' Samantha', 75, 5800);
insert into DESIGNER (designername, designerid, payment)
values (' Raymond', 76, 7600);
insert into DESIGNER (designername, designerid, payment)
values (' Carolyn', 77, 5700);
insert into DESIGNER (designername, designerid, payment)
values (' Patrick', 78, 8100);
insert into DESIGNER (designername, designerid, payment)
values (' Janet', 79, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Jack', 80, 8800);
insert into DESIGNER (designername, designerid, payment)
values (' Christine', 81, 6300);
insert into DESIGNER (designername, designerid, payment)
values (' Dennis', 82, 9100);
insert into DESIGNER (designername, designerid, payment)
values (' Maria', 83, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Jerry', 84, 8900);
insert into DESIGNER (designername, designerid, payment)
values (' Heather', 85, 5600);
insert into DESIGNER (designername, designerid, payment)
values (' Tyler', 86, 8300);
insert into DESIGNER (designername, designerid, payment)
values (' Diane', 87, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Aaron', 88, 8700);
insert into DESIGNER (designername, designerid, payment)
values (' Julie', 89, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Henry', 90, 8200);
insert into DESIGNER (designername, designerid, payment)
values (' Teresa', 91, 5700);
insert into DESIGNER (designername, designerid, payment)
values (' Adam', 92, 9000);
insert into DESIGNER (designername, designerid, payment)
values (' Gloria', 93, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Jose', 94, 7500);
insert into DESIGNER (designername, designerid, payment)
values (' Alice', 95, 6400);
insert into DESIGNER (designername, designerid, payment)
values (' Nathan', 96, 9200);
insert into DESIGNER (designername, designerid, payment)
values (' Ann', 97, 5700);
insert into DESIGNER (designername, designerid, payment)
values (' Bryan', 98, 8800);
insert into DESIGNER (designername, designerid, payment)
values (' Jean', 99, 6200);
insert into DESIGNER (designername, designerid, payment)
values (' Samuel', 100, 9300);
commit;
prompt 100 records committed...
insert into DESIGNER (designername, designerid, payment)
values (' Megan', 101, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Jordan', 102, 8500);
insert into DESIGNER (designername, designerid, payment)
values (' Marie', 103, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Willie', 104, 8700);
insert into DESIGNER (designername, designerid, payment)
values (' Julia', 105, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Ralph', 106, 8100);
insert into DESIGNER (designername, designerid, payment)
values (' Victoria', 107, 6200);
insert into DESIGNER (designername, designerid, payment)
values (' Carl', 108, 9400);
insert into DESIGNER (designername, designerid, payment)
values (' Judith', 109, 5800);
insert into DESIGNER (designername, designerid, payment)
values (' Billy', 110, 8300);
insert into DESIGNER (designername, designerid, payment)
values (' Megan', 111, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Wayne', 112, 9200);
insert into DESIGNER (designername, designerid, payment)
values (' Amber', 113, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Louis', 114, 8600);
insert into DESIGNER (designername, designerid, payment)
values (' Brittany', 115, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Roy', 116, 8900);
insert into DESIGNER (designername, designerid, payment)
values (' Madison', 117, 5700);
insert into DESIGNER (designername, designerid, payment)
values (' Eugene', 118, 7800);
insert into DESIGNER (designername, designerid, payment)
values (' Grace', 119, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Keith', 120, 8700);
insert into DESIGNER (designername, designerid, payment)
values (' Rose', 121, 6300);
insert into DESIGNER (designername, designerid, payment)
values (' Dylan', 122, 9100);
insert into DESIGNER (designername, designerid, payment)
values (' Beverly', 123, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Elijah', 124, 9000);
insert into DESIGNER (designername, designerid, payment)
values (' Denise', 125, 5600);
insert into DESIGNER (designername, designerid, payment)
values (' Randy', 126, 8200);
insert into DESIGNER (designername, designerid, payment)
values (' Marilyn', 127, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Vincent', 128, 8700);
insert into DESIGNER (designername, designerid, payment)
values (' Olivia', 129, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Jesse', 130, 9100);
insert into DESIGNER (designername, designerid, payment)
values (' Emma', 131, 5700);
insert into DESIGNER (designername, designerid, payment)
values (' Alexander', 132, 8600);
insert into DESIGNER (designername, designerid, payment)
values (' Madison', 133, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Russell', 134, 9300);
insert into DESIGNER (designername, designerid, payment)
values (' Abigail', 135, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Bruce', 136, 8800);
insert into DESIGNER (designername, designerid, payment)
values (' Alexis', 137, 6300);
insert into DESIGNER (designername, designerid, payment)
values (' Craig', 138, 9400);
insert into DESIGNER (designername, designerid, payment)
values (' Isabella', 139, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Jerry', 140, 7800);
insert into DESIGNER (designername, designerid, payment)
values (' Evelyn', 141, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Lawrence', 142, 9000);
insert into DESIGNER (designername, designerid, payment)
values (' Gabriella', 143, 5800);
insert into DESIGNER (designername, designerid, payment)
values (' Alan', 144, 8100);
insert into DESIGNER (designername, designerid, payment)
values (' Marilyn', 145, 6200);
insert into DESIGNER (designername, designerid, payment)
values (' Shaun', 146, 8700);
insert into DESIGNER (designername, designerid, payment)
values (' Charlotte', 147, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Philip', 148, 9300);
insert into DESIGNER (designername, designerid, payment)
values (' Isabella', 149, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Wayne', 150, 7500);
insert into DESIGNER (designername, designerid, payment)
values (' Alyssa', 151, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Terry', 152, 8200);
insert into DESIGNER (designername, designerid, payment)
values (' Katherine', 153, 5800);
insert into DESIGNER (designername, designerid, payment)
values (' Dylan', 154, 9400);
insert into DESIGNER (designername, designerid, payment)
values (' Lauren', 155, 5700);
insert into DESIGNER (designername, designerid, payment)
values (' Johnny', 156, 8700);
insert into DESIGNER (designername, designerid, payment)
values (' Anna', 157, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Jeff', 158, 8900);
insert into DESIGNER (designername, designerid, payment)
values (' Jill', 159, 6300);
insert into DESIGNER (designername, designerid, payment)
values (' Steve', 160, 9100);
insert into DESIGNER (designername, designerid, payment)
values (' Janet', 161, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Bradley', 162, 9300);
insert into DESIGNER (designername, designerid, payment)
values (' Rachel', 163, 5800);
insert into DESIGNER (designername, designerid, payment)
values (' Jeremy', 164, 7800);
insert into DESIGNER (designername, designerid, payment)
values (' Lauren', 165, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Harold', 166, 8000);
insert into DESIGNER (designername, designerid, payment)
values (' Stephanie', 167, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Walter', 168, 8900);
insert into DESIGNER (designername, designerid, payment)
values (' Susan', 169, 6200);
insert into DESIGNER (designername, designerid, payment)
values (' Ethan', 170, 9300);
insert into DESIGNER (designername, designerid, payment)
values (' Ann', 171, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Arthur', 172, 8600);
insert into DESIGNER (designername, designerid, payment)
values (' Shannon', 173, 5700);
insert into DESIGNER (designername, designerid, payment)
values (' Peter', 174, 9400);
insert into DESIGNER (designername, designerid, payment)
values (' Diane', 175, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Jesse', 176, 8300);
insert into DESIGNER (designername, designerid, payment)
values (' Christina', 177, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Dylan', 178, 8700);
insert into DESIGNER (designername, designerid, payment)
values (' Megan', 179, 6200);
insert into DESIGNER (designername, designerid, payment)
values (' Howard', 180, 8800);
insert into DESIGNER (designername, designerid, payment)
values (' Gloria', 181, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Jonathan', 182, 9000);
insert into DESIGNER (designername, designerid, payment)
values (' Jessica', 183, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Shawn', 184, 8600);
insert into DESIGNER (designername, designerid, payment)
values (' Andrea', 185, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Bryan', 186, 9100);
insert into DESIGNER (designername, designerid, payment)
values (' Brenda', 187, 5700);
insert into DESIGNER (designername, designerid, payment)
values (' George', 188, 8300);
insert into DESIGNER (designername, designerid, payment)
values (' Victoria', 189, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Harold', 190, 9400);
insert into DESIGNER (designername, designerid, payment)
values (' Lisa', 191, 5800);
insert into DESIGNER (designername, designerid, payment)
values (' Mark', 192, 8200);
insert into DESIGNER (designername, designerid, payment)
values (' Tiffany', 193, 6100);
insert into DESIGNER (designername, designerid, payment)
values (' Rodney', 194, 8700);
insert into DESIGNER (designername, designerid, payment)
values (' Rachel', 195, 6000);
insert into DESIGNER (designername, designerid, payment)
values (' Joe', 196, 9100);
insert into DESIGNER (designername, designerid, payment)
values (' Amber', 197, 5900);
insert into DESIGNER (designername, designerid, payment)
values (' Henry', 198, 8600);
insert into DESIGNER (designername, designerid, payment)
values (' Stephanie', 199, 6200);
insert into DESIGNER (designername, designerid, payment)
values (' Ethan', 200, 9400);
commit;
prompt 200 records committed...
insert into DESIGNER (designername, designerid, payment)
values ('Jane Smith', 1001, 0);
insert into DESIGNER (designername, designerid, payment)
values ('Jane Smith', 1002, 0);
insert into DESIGNER (designername, designerid, payment)
values ('Jane Smith', 1003, 0);
commit;
prompt 203 records loaded
prompt Loading SUPPLIER_...
insert into SUPPLIER_ (supplierid, suppliername, area)
values (12345, 'debi', 'north');
insert into SUPPLIER_ (supplierid, suppliername, area)
values (12365, 'chani', 'south');
insert into SUPPLIER_ (supplierid, suppliername, area)
values (14565, 'yael', 'south');
insert into SUPPLIER_ (supplierid, suppliername, area)
values (89065, 'meir', 'gushdDan');
insert into SUPPLIER_ (supplierid, suppliername, area)
values (12395, 'chavi', 'jerusalem');
insert into SUPPLIER_ (supplierid, suppliername, area)
values (87655, 'dasi', 'gushdDan');
insert into SUPPLIER_ (supplierid, suppliername, area)
values (89365, 'riki', 'north');
insert into SUPPLIER_ (supplierid, suppliername, area)
values (23565, 'eti', 'south');
insert into SUPPLIER_ (supplierid, suppliername, area)
values (19475, 'talia', 'jerusalem');
insert into SUPPLIER_ (supplierid, suppliername, area)
values (15365, 'noa', 'gushdDan');
commit;
prompt 10 records loaded
prompt Loading INSTOCK...
insert into INSTOCK (amount, supplierid, equipmentid)
values (85558, 14565, 43);
insert into INSTOCK (amount, supplierid, equipmentid)
values (67739, 89365, 83);
insert into INSTOCK (amount, supplierid, equipmentid)
values (24854, 12365, 114);
insert into INSTOCK (amount, supplierid, equipmentid)
values (40983, 12365, 43);
insert into INSTOCK (amount, supplierid, equipmentid)
values (22616, 14565, 52);
insert into INSTOCK (amount, supplierid, equipmentid)
values (16226, 89365, 77);
insert into INSTOCK (amount, supplierid, equipmentid)
values (10494, 19475, 125);
insert into INSTOCK (amount, supplierid, equipmentid)
values (20391, 15365, 117);
insert into INSTOCK (amount, supplierid, equipmentid)
values (33008, 15365, 94);
insert into INSTOCK (amount, supplierid, equipmentid)
values (52634, 89065, 46);
insert into INSTOCK (amount, supplierid, equipmentid)
values (24814, 89365, 59);
insert into INSTOCK (amount, supplierid, equipmentid)
values (52953, 14565, 60);
insert into INSTOCK (amount, supplierid, equipmentid)
values (84691, 12365, 76);
insert into INSTOCK (amount, supplierid, equipmentid)
values (15527, 87655, 84);
insert into INSTOCK (amount, supplierid, equipmentid)
values (75540, 12345, 50);
insert into INSTOCK (amount, supplierid, equipmentid)
values (3922, 87655, 42);
insert into INSTOCK (amount, supplierid, equipmentid)
values (83480, 19475, 24);
insert into INSTOCK (amount, supplierid, equipmentid)
values (77002, 87655, 101);
insert into INSTOCK (amount, supplierid, equipmentid)
values (51192, 89065, 28);
insert into INSTOCK (amount, supplierid, equipmentid)
values (48609, 14565, 97);
insert into INSTOCK (amount, supplierid, equipmentid)
values (9952, 19475, 8);
insert into INSTOCK (amount, supplierid, equipmentid)
values (73742, 15365, 65);
insert into INSTOCK (amount, supplierid, equipmentid)
values (9403, 12365, 115);
insert into INSTOCK (amount, supplierid, equipmentid)
values (89877, 89065, 9);
insert into INSTOCK (amount, supplierid, equipmentid)
values (34026, 19475, 54);
insert into INSTOCK (amount, supplierid, equipmentid)
values (58825, 12365, 69);
insert into INSTOCK (amount, supplierid, equipmentid)
values (41189, 14565, 115);
insert into INSTOCK (amount, supplierid, equipmentid)
values (95788, 15365, 51);
insert into INSTOCK (amount, supplierid, equipmentid)
values (92920, 19475, 71);
insert into INSTOCK (amount, supplierid, equipmentid)
values (37000, 19475, 101);
insert into INSTOCK (amount, supplierid, equipmentid)
values (386, 19475, 20);
insert into INSTOCK (amount, supplierid, equipmentid)
values (49942, 12365, 5);
insert into INSTOCK (amount, supplierid, equipmentid)
values (41356, 19475, 16);
insert into INSTOCK (amount, supplierid, equipmentid)
values (96646, 12365, 45);
insert into INSTOCK (amount, supplierid, equipmentid)
values (78952, 14565, 102);
insert into INSTOCK (amount, supplierid, equipmentid)
values (12011, 14565, 17);
insert into INSTOCK (amount, supplierid, equipmentid)
values (13378, 14565, 65);
insert into INSTOCK (amount, supplierid, equipmentid)
values (88159, 89365, 52);
insert into INSTOCK (amount, supplierid, equipmentid)
values (49360, 89065, 125);
insert into INSTOCK (amount, supplierid, equipmentid)
values (45252, 87655, 38);
insert into INSTOCK (amount, supplierid, equipmentid)
values (20725, 14565, 44);
insert into INSTOCK (amount, supplierid, equipmentid)
values (13531, 15365, 29);
insert into INSTOCK (amount, supplierid, equipmentid)
values (79962, 14565, 33);
insert into INSTOCK (amount, supplierid, equipmentid)
values (46930, 87655, 122);
insert into INSTOCK (amount, supplierid, equipmentid)
values (38393, 89365, 48);
insert into INSTOCK (amount, supplierid, equipmentid)
values (76023, 23565, 94);
insert into INSTOCK (amount, supplierid, equipmentid)
values (40592, 12365, 84);
insert into INSTOCK (amount, supplierid, equipmentid)
values (25219, 12345, 16);
insert into INSTOCK (amount, supplierid, equipmentid)
values (69005, 87655, 77);
insert into INSTOCK (amount, supplierid, equipmentid)
values (96099, 12345, 9);
insert into INSTOCK (amount, supplierid, equipmentid)
values (5675, 12345, 55);
insert into INSTOCK (amount, supplierid, equipmentid)
values (37405, 12365, 83);
insert into INSTOCK (amount, supplierid, equipmentid)
values (85274, 23565, 129);
insert into INSTOCK (amount, supplierid, equipmentid)
values (12896, 89065, 82);
insert into INSTOCK (amount, supplierid, equipmentid)
values (62961, 14565, 67);
insert into INSTOCK (amount, supplierid, equipmentid)
values (23888, 19475, 31);
insert into INSTOCK (amount, supplierid, equipmentid)
values (47566, 87655, 13);
insert into INSTOCK (amount, supplierid, equipmentid)
values (72933, 14565, 113);
insert into INSTOCK (amount, supplierid, equipmentid)
values (23163, 12395, 127);
insert into INSTOCK (amount, supplierid, equipmentid)
values (52015, 15365, 17);
insert into INSTOCK (amount, supplierid, equipmentid)
values (54353, 15365, 85);
insert into INSTOCK (amount, supplierid, equipmentid)
values (32685, 12365, 68);
insert into INSTOCK (amount, supplierid, equipmentid)
values (50678, 89065, 111);
insert into INSTOCK (amount, supplierid, equipmentid)
values (8887, 12345, 113);
insert into INSTOCK (amount, supplierid, equipmentid)
values (8438, 23565, 48);
insert into INSTOCK (amount, supplierid, equipmentid)
values (26325, 87655, 27);
insert into INSTOCK (amount, supplierid, equipmentid)
values (60951, 19475, 76);
insert into INSTOCK (amount, supplierid, equipmentid)
values (7090, 19475, 51);
insert into INSTOCK (amount, supplierid, equipmentid)
values (6646, 12365, 54);
insert into INSTOCK (amount, supplierid, equipmentid)
values (75497, 87655, 61);
insert into INSTOCK (amount, supplierid, equipmentid)
values (54550, 87655, 92);
insert into INSTOCK (amount, supplierid, equipmentid)
values (92538, 23565, 75);
insert into INSTOCK (amount, supplierid, equipmentid)
values (85923, 15365, 15);
insert into INSTOCK (amount, supplierid, equipmentid)
values (42500, 12345, 95);
insert into INSTOCK (amount, supplierid, equipmentid)
values (83411, 23565, 64);
insert into INSTOCK (amount, supplierid, equipmentid)
values (68426, 89065, 116);
insert into INSTOCK (amount, supplierid, equipmentid)
values (83587, 12345, 11);
insert into INSTOCK (amount, supplierid, equipmentid)
values (53446, 87655, 89);
insert into INSTOCK (amount, supplierid, equipmentid)
values (69538, 15365, 102);
insert into INSTOCK (amount, supplierid, equipmentid)
values (74282, 15365, 101);
insert into INSTOCK (amount, supplierid, equipmentid)
values (94490, 23565, 90);
insert into INSTOCK (amount, supplierid, equipmentid)
values (21423, 12395, 64);
commit;
prompt 82 records loaded
prompt Loading INVITATION...
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (925483, 1, to_date('19-06-2018', 'dd-mm-yyyy'), 34567821, 164, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7729242, 2, to_date('22-07-2020', 'dd-mm-yyyy'), 28208921, 148, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3088278, 3, to_date('20-07-2023', 'dd-mm-yyyy'), 21437821, 78, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4058395, 4, to_date('04-01-2005', 'dd-mm-yyyy'), 21837821, 7, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7510631, 25, to_date('14-09-2004', 'dd-mm-yyyy'), 28920218, 26, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (808891, 26, to_date('04-06-2003', 'dd-mm-yyyy'), 2892028, 52, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3789223, 28, to_date('15-09-2022', 'dd-mm-yyyy'), 21437821, 30, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1403364, 29, to_date('21-05-2021', 'dd-mm-yyyy'), 34567821, 14, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (733614, 30, to_date('14-04-2023', 'dd-mm-yyyy'), 21482021, 35, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3092483, 31, to_date('02-12-2010', 'dd-mm-yyyy'), 34567821, 110, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9011314, 32, to_date('06-05-2018', 'dd-mm-yyyy'), 2892028, 30, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (440513, 33, to_date('31-10-2010', 'dd-mm-yyyy'), 34567821, 97, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4045956, 34, to_date('26-05-2010', 'dd-mm-yyyy'), 21482021, 122, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (752614, 35, to_date('26-12-2023', 'dd-mm-yyyy'), 21437821, 93, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5897997, 36, to_date('27-09-2007', 'dd-mm-yyyy'), 21837821, 199, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (58712, 37, to_date('05-11-2021', 'dd-mm-yyyy'), 21837821, 104, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (651911, 39, to_date('29-09-2002', 'dd-mm-yyyy'), 21437821, 93, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7949636, 40, to_date('19-07-2004', 'dd-mm-yyyy'), 56787821, 71, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7288155, 41, to_date('15-08-2015', 'dd-mm-yyyy'), 21482021, 174, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9750932, 43, to_date('08-11-2006', 'dd-mm-yyyy'), 21437821, 98, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1916000, 45, to_date('23-08-2001', 'dd-mm-yyyy'), 21837821, 93, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1180297, 46, to_date('29-06-2007', 'dd-mm-yyyy'), 28208921, 167, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7930466, 47, to_date('15-11-2003', 'dd-mm-yyyy'), 21437821, 134, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4599656, 48, to_date('14-04-2019', 'dd-mm-yyyy'), 21837821, 42, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (271743, 49, to_date('11-05-2026', 'dd-mm-yyyy'), 2892028, 65, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (6126702, 50, to_date('27-01-2011', 'dd-mm-yyyy'), 21837821, 68, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2895159, 51, to_date('11-07-2021', 'dd-mm-yyyy'), 56787821, 131, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5633516, 52, to_date('27-11-2008', 'dd-mm-yyyy'), 21437821, 140, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9363453, 54, to_date('14-06-2007', 'dd-mm-yyyy'), 28920218, 4, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (8290798, 55, to_date('10-05-2019', 'dd-mm-yyyy'), 21482021, 29, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4829218, 56, to_date('28-08-2001', 'dd-mm-yyyy'), 28920218, 174, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (6171004, 57, to_date('20-06-2025', 'dd-mm-yyyy'), 28208921, 104, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5360663, 58, to_date('18-09-2005', 'dd-mm-yyyy'), 21482021, 117, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5776229, 59, to_date('24-10-2006', 'dd-mm-yyyy'), 56787821, 119, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3197057, 61, to_date('17-07-2010', 'dd-mm-yyyy'), 2892028, 46, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (792236, 62, to_date('29-01-2020', 'dd-mm-yyyy'), 28208921, 64, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2020865, 63, to_date('09-12-2016', 'dd-mm-yyyy'), 21482021, 142, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (6998151, 64, to_date('13-02-2005', 'dd-mm-yyyy'), 56787821, 120, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (8499867, 65, to_date('22-01-2015', 'dd-mm-yyyy'), 21482021, 155, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9627741, 66, to_date('25-03-2022', 'dd-mm-yyyy'), 34567821, 96, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4728437, 67, to_date('01-02-2001', 'dd-mm-yyyy'), 21437821, 152, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4197290, 68, to_date('19-03-2018', 'dd-mm-yyyy'), 21482021, 47, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2835193, 69, to_date('01-11-2021', 'dd-mm-yyyy'), 28208921, 102, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1237383, 70, to_date('26-11-2019', 'dd-mm-yyyy'), 34567821, 154, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9445155, 71, to_date('11-10-2000', 'dd-mm-yyyy'), 21437821, 124, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2299977, 72, to_date('27-12-2006', 'dd-mm-yyyy'), 21437821, 57, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9198265, 73, to_date('30-05-2007', 'dd-mm-yyyy'), 21437821, 131, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9712235, 74, to_date('06-12-2002', 'dd-mm-yyyy'), 21482021, 185, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5613672, 75, to_date('09-06-2025', 'dd-mm-yyyy'), 56787821, 131, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9436867, 76, to_date('06-06-2007', 'dd-mm-yyyy'), 56787821, 137, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5334866, 77, to_date('28-11-2026', 'dd-mm-yyyy'), 56787821, 184, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (6836748, 78, to_date('25-10-2020', 'dd-mm-yyyy'), 34567821, 16, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5080018, 79, to_date('16-10-2015', 'dd-mm-yyyy'), 28920218, 61, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9567299, 80, to_date('19-07-2011', 'dd-mm-yyyy'), 21437821, 101, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5085120, 81, to_date('27-09-2007', 'dd-mm-yyyy'), 21437821, 184, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (8351730, 82, to_date('02-02-2009', 'dd-mm-yyyy'), 21437821, 179, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9087950, 83, to_date('07-05-2024', 'dd-mm-yyyy'), 21837821, 118, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (8161815, 84, to_date('28-05-2015', 'dd-mm-yyyy'), 34567821, 58, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4582153, 85, to_date('02-11-2013', 'dd-mm-yyyy'), 34567821, 35, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7455373, 86, to_date('25-05-2010', 'dd-mm-yyyy'), 27837821, 22, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (8798359, 87, to_date('26-06-2011', 'dd-mm-yyyy'), 21482021, 134, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4731126, 88, to_date('25-07-2024', 'dd-mm-yyyy'), 21482021, 199, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1272285, 89, to_date('04-01-2008', 'dd-mm-yyyy'), 27837821, 91, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7883371, 90, to_date('17-11-2011', 'dd-mm-yyyy'), 2892028, 175, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2173722, 91, to_date('14-01-2006', 'dd-mm-yyyy'), 21437821, 72, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3055608, 92, to_date('15-04-2005', 'dd-mm-yyyy'), 27837821, 27, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5598241, 93, to_date('08-05-2019', 'dd-mm-yyyy'), 21437821, 59, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4891860, 94, to_date('23-03-2011', 'dd-mm-yyyy'), 21482021, 196, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4091619, 95, to_date('18-08-2026', 'dd-mm-yyyy'), 27837821, 78, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3040476, 96, to_date('12-05-2015', 'dd-mm-yyyy'), 21837821, 152, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4674559, 97, to_date('03-11-2005', 'dd-mm-yyyy'), 56787821, 200, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3861676, 98, to_date('17-07-2018', 'dd-mm-yyyy'), 21837821, 190, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1417384, 99, to_date('11-05-2021', 'dd-mm-yyyy'), 28920218, 90, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2759729, 100, to_date('01-09-2005', 'dd-mm-yyyy'), 2892028, 85, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3793004, 101, to_date('14-02-2023', 'dd-mm-yyyy'), 28920218, 181, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3417580, 102, to_date('29-05-2025', 'dd-mm-yyyy'), 21437821, 187, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2529439, 103, to_date('05-08-2025', 'dd-mm-yyyy'), 21482021, 23, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7493978, 104, to_date('17-06-2001', 'dd-mm-yyyy'), 21437821, 97, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (8707616, 105, to_date('21-07-2003', 'dd-mm-yyyy'), 27837821, 105, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (108751, 106, to_date('25-06-2005', 'dd-mm-yyyy'), 21437821, 56, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4482610, 110, to_date('25-12-2018', 'dd-mm-yyyy'), 27837821, 118, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9431495, 111, to_date('29-08-2002', 'dd-mm-yyyy'), 21482021, 176, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3445522, 115, to_date('22-05-2023', 'dd-mm-yyyy'), 56787821, 94, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2932311, 116, to_date('16-07-2020', 'dd-mm-yyyy'), 27837821, 169, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (8526123, 117, to_date('21-09-2021', 'dd-mm-yyyy'), 21482021, 142, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3626498, 118, to_date('17-01-2003', 'dd-mm-yyyy'), 27837821, 123, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3116796, 119, to_date('30-07-2014', 'dd-mm-yyyy'), 28208921, 1, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9929146, 120, to_date('27-04-2024', 'dd-mm-yyyy'), 2892028, 102, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9593470, 121, to_date('13-10-2007', 'dd-mm-yyyy'), 27837821, 140, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4335602, 122, to_date('23-09-2024', 'dd-mm-yyyy'), 28208921, 57, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9450919, 123, to_date('04-04-2023', 'dd-mm-yyyy'), 27837821, 143, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (6334806, 124, to_date('27-06-2015', 'dd-mm-yyyy'), 27837821, 79, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (796068, 126, to_date('18-06-2007', 'dd-mm-yyyy'), 28208921, 118, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2034597, 127, to_date('19-01-2022', 'dd-mm-yyyy'), 21437821, 6, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (332617, 128, to_date('18-03-2016', 'dd-mm-yyyy'), 56787821, 17, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (6103662, 129, to_date('13-12-2004', 'dd-mm-yyyy'), 27837821, 30, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5549036, 130, to_date('17-06-2007', 'dd-mm-yyyy'), 28208921, 79, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9792768, 131, to_date('25-05-2023', 'dd-mm-yyyy'), 21482021, 121, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7750837, 132, to_date('04-11-2018', 'dd-mm-yyyy'), 2892028, 182, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (8823004, 133, to_date('03-01-2026', 'dd-mm-yyyy'), 27837821, 163, 9);
commit;
prompt 100 records committed...
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7219292, 134, to_date('06-11-2002', 'dd-mm-yyyy'), 34567821, 115, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (772855, 136, to_date('08-05-2012', 'dd-mm-yyyy'), 28920218, 170, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7982304, 137, to_date('31-05-2004', 'dd-mm-yyyy'), 21482021, 89, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1327349, 138, to_date('16-09-2017', 'dd-mm-yyyy'), 56787821, 53, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3881911, 139, to_date('04-02-2008', 'dd-mm-yyyy'), 56787821, 21, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3780990, 140, to_date('26-06-2000', 'dd-mm-yyyy'), 27837821, 138, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (526171, 141, to_date('17-09-2006', 'dd-mm-yyyy'), 21437821, 97, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2908328, 142, to_date('28-06-2000', 'dd-mm-yyyy'), 21437821, 125, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5330985, 143, to_date('24-10-2015', 'dd-mm-yyyy'), 56787821, 52, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3242937, 144, to_date('13-06-2004', 'dd-mm-yyyy'), 21837821, 179, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7379570, 145, to_date('07-08-2024', 'dd-mm-yyyy'), 21482021, 3, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2656816, 146, to_date('07-01-2020', 'dd-mm-yyyy'), 56787821, 146, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (6652874, 147, to_date('01-09-2023', 'dd-mm-yyyy'), 21437821, 103, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9653911, 149, to_date('17-07-2016', 'dd-mm-yyyy'), 27837821, 27, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (815070, 150, to_date('21-01-2026', 'dd-mm-yyyy'), 56787821, 47, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2113173, 151, to_date('10-06-2007', 'dd-mm-yyyy'), 21482021, 44, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5924247, 152, to_date('10-01-2008', 'dd-mm-yyyy'), 56787821, 94, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5524474, 154, to_date('12-02-2021', 'dd-mm-yyyy'), 21837821, 164, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3072828, 155, to_date('20-04-2017', 'dd-mm-yyyy'), 34567821, 190, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5673620, 156, to_date('04-07-2010', 'dd-mm-yyyy'), 2892028, 14, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1383710, 157, to_date('15-12-2005', 'dd-mm-yyyy'), 56787821, 140, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4858907, 158, to_date('18-12-2011', 'dd-mm-yyyy'), 21482021, 137, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (741816, 159, to_date('12-04-2024', 'dd-mm-yyyy'), 21482021, 47, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5057572, 160, to_date('24-04-2019', 'dd-mm-yyyy'), 21482021, 22, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4257829, 162, to_date('09-01-2007', 'dd-mm-yyyy'), 56787821, 101, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5152743, 163, to_date('22-09-2012', 'dd-mm-yyyy'), 34567821, 7, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7938530, 164, to_date('14-10-2016', 'dd-mm-yyyy'), 21437821, 46, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7677661, 165, to_date('07-12-2011', 'dd-mm-yyyy'), 27837821, 172, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3579134, 166, to_date('03-09-2008', 'dd-mm-yyyy'), 27837821, 135, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3949717, 167, to_date('07-04-2016', 'dd-mm-yyyy'), 21837821, 184, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (8894718, 169, to_date('25-05-2003', 'dd-mm-yyyy'), 28920218, 138, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (489612, 170, to_date('22-01-2010', 'dd-mm-yyyy'), 34567821, 150, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (242430, 171, to_date('14-07-2017', 'dd-mm-yyyy'), 27837821, 17, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1489576, 172, to_date('15-05-2009', 'dd-mm-yyyy'), 21482021, 26, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (216497, 173, to_date('29-01-2010', 'dd-mm-yyyy'), 28208921, 17, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2104228, 176, to_date('16-02-2024', 'dd-mm-yyyy'), 28208921, 74, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7747578, 178, to_date('29-10-2008', 'dd-mm-yyyy'), 56787821, 183, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7729953, 180, to_date('28-11-2017', 'dd-mm-yyyy'), 34567821, 10, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3117487, 181, to_date('20-11-2024', 'dd-mm-yyyy'), 2892028, 147, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3593119, 182, to_date('23-01-2007', 'dd-mm-yyyy'), 56787821, 87, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2589151, 183, to_date('03-08-2004', 'dd-mm-yyyy'), 21437821, 69, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7760822, 184, to_date('06-02-2022', 'dd-mm-yyyy'), 34567821, 152, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1918575, 185, to_date('28-05-2018', 'dd-mm-yyyy'), 28208921, 170, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1669843, 186, to_date('04-02-2012', 'dd-mm-yyyy'), 2892028, 82, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5870643, 187, to_date('27-12-2000', 'dd-mm-yyyy'), 21482021, 2, 10);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5012138, 188, to_date('18-01-2019', 'dd-mm-yyyy'), 56787821, 62, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7126151, 189, to_date('11-03-2012', 'dd-mm-yyyy'), 56787821, 44, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (6685067, 190, to_date('31-10-2019', 'dd-mm-yyyy'), 34567821, 10, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (8638214, 191, to_date('13-07-2012', 'dd-mm-yyyy'), 21837821, 177, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7348323, 192, to_date('28-07-2009', 'dd-mm-yyyy'), 27837821, 128, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4953461, 193, to_date('02-12-2014', 'dd-mm-yyyy'), 28208921, 172, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (5843877, 194, to_date('21-08-2002', 'dd-mm-yyyy'), 2892028, 141, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2758243, 196, to_date('26-01-2019', 'dd-mm-yyyy'), 28208921, 161, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (9135947, 197, to_date('23-10-2026', 'dd-mm-yyyy'), 2892028, 48, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4729511, 198, to_date('07-10-2020', 'dd-mm-yyyy'), 28208921, 86, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (4525396, 199, to_date('25-02-2019', 'dd-mm-yyyy'), 27837821, 198, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (8345808, 200, to_date('07-06-2021', 'dd-mm-yyyy'), 28920218, 191, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3272226, 202, to_date('09-01-2011', 'dd-mm-yyyy'), 34567821, 130, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3652098, 203, to_date('24-06-2017', 'dd-mm-yyyy'), 21437821, 113, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (6206463, 204, to_date('15-12-2009', 'dd-mm-yyyy'), 28920218, 62, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3180270, 205, to_date('16-05-2000', 'dd-mm-yyyy'), 27837821, 8, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1024511, 206, to_date('08-01-2025', 'dd-mm-yyyy'), 21837821, 39, 9);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1655982, 208, to_date('24-12-2018', 'dd-mm-yyyy'), 34567821, 126, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (6181505, 209, to_date('20-04-2000', 'dd-mm-yyyy'), 34567821, 149, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3461687, 210, to_date('27-04-2022', 'dd-mm-yyyy'), 27837821, 16, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (7369311, 211, to_date('11-10-2014', 'dd-mm-yyyy'), 28208921, 11, 4);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1782314, 212, to_date('27-11-2014', 'dd-mm-yyyy'), 28920218, 126, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (1210428, 213, to_date('05-05-2020', 'dd-mm-yyyy'), 2892028, 159, 3);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (3526891, 214, to_date('29-04-2004', 'dd-mm-yyyy'), 21437821, 182, 1);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2395, 215, to_date('16-05-2020', 'dd-mm-yyyy'), 27837821, 17, 6);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (89900, 217, to_date('16-07-2020', 'dd-mm-yyyy'), 27837821, 12, 2);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (70050, 218, to_date('16-06-2020', 'dd-mm-yyyy'), 27837821, 20, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (50000, 219, to_date('17-04-2020', 'dd-mm-yyyy'), 27837821, 161, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (90000, 220, to_date('14-05-2020', 'dd-mm-yyyy'), 27837821, 141, 8);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (80000, 221, to_date('16-08-2020', 'dd-mm-yyyy'), 27837821, 26, 7);
insert into INVITATION (finalprice, invitationid, datte, agent_id, designerid, packageid)
values (2699, 229, to_date('13-05-2020', 'dd-mm-yyyy'), 27837821, 17, 7);
commit;
prompt 176 records loaded
prompt Enabling foreign key constraints for APARTMENT...
alter table APARTMENT enable constraint SYS_C008321;
alter table APARTMENT enable constraint SYS_C008322;
prompt Enabling foreign key constraints for VISIT...
alter table VISIT enable constraint SYS_C008328;
alter table VISIT enable constraint SYS_C008329;
alter table VISIT enable constraint SYS_C008330;
prompt Enabling foreign key constraints for APARTMENT_SALE...
alter table APARTMENT_SALE enable constraint SYS_C008333;
prompt Enabling foreign key constraints for CONTAINING...
alter table CONTAINING enable constraint SYS_C008287;
alter table CONTAINING enable constraint SYS_C008288;
prompt Enabling foreign key constraints for INSTOCK...
alter table INSTOCK enable constraint SYS_C008300;
alter table INSTOCK enable constraint SYS_C008301;
prompt Enabling foreign key constraints for INVITATION...
alter table INVITATION enable constraint FK_INVITATION2_AGENT;
alter table INVITATION enable constraint FK_INVITATION2_DESIGNER;
alter table INVITATION enable constraint FK_INVITATION2_PACKAGE;
prompt Enabling triggers for AGENT_PERSON...
alter table AGENT_PERSON enable all triggers;
prompt Enabling triggers for CITY...
alter table CITY enable all triggers;
prompt Enabling triggers for SELLER...
alter table SELLER enable all triggers;
prompt Enabling triggers for APARTMENT...
alter table APARTMENT enable all triggers;
prompt Enabling triggers for BUYER...
alter table BUYER enable all triggers;
prompt Enabling triggers for VISIT...
alter table VISIT enable all triggers;
prompt Enabling triggers for APARTMENT_SALE...
alter table APARTMENT_SALE enable all triggers;
prompt Enabling triggers for EQUIPMENT...
alter table EQUIPMENT enable all triggers;
prompt Enabling triggers for PAKCAGE...
alter table PAKCAGE enable all triggers;
prompt Enabling triggers for CONTAINING...
alter table CONTAINING enable all triggers;
prompt Enabling triggers for DESIGNER...
alter table DESIGNER enable all triggers;
prompt Enabling triggers for SUPPLIER_...
alter table SUPPLIER_ enable all triggers;
prompt Enabling triggers for INSTOCK...
alter table INSTOCK enable all triggers;
prompt Enabling triggers for INVITATION...
alter table INVITATION enable all triggers;
set feedback on
set define on
prompt Done.
