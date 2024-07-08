prompt PL/SQL Developer import file
prompt Created on Monday, July 8, 2024 by necha
set feedback off
set define off
prompt Creating AGENT_PERSON...
create table AGENT_PERSON
(
  agent_id      NUMBER(3) not null,
  agent_name    VARCHAR2(15),
  phone_number  NUMBER(5),
  visit_rate    NUMBER default 100,
  sale_rate     NUMBER default 0.8,
  active_status NUMBER(1) default 1,
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
  present_status VARCHAR2(15) default 'Nothing'
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
prompt Disabling foreign key constraints for APARTMENT...
alter table APARTMENT disable constraint SYS_C007828;
alter table APARTMENT disable constraint SYS_C007829;
prompt Disabling foreign key constraints for VISIT...
alter table VISIT disable constraint SYS_C007835;
alter table VISIT disable constraint SYS_C007836;
alter table VISIT disable constraint SYS_C007837;
prompt Disabling foreign key constraints for APARTMENT_SALE...
alter table APARTMENT_SALE disable constraint SYS_C007840;
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
commit;
prompt 10 records loaded
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
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (980, to_date('03-05-2014', 'dd-mm-yyyy'), 12, 954, 999, 999, 'Notebook');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (981, to_date('12-04-2012', 'dd-mm-yyyy'), 10, 953, 789, 998, 'Pen');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (982, to_date('11-02-2013', 'dd-mm-yyyy'), 15, 952, 778, 997, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (983, to_date('10-01-2007', 'dd-mm-yyyy'), 11, 951, 983, 996, 'Pen');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (984, to_date('23-02-2004', 'dd-mm-yyyy'), 11, 950, 987, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (985, to_date('21-03-2003', 'dd-mm-yyyy'), 10, 949, 678, 994, 'Pen');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (986, to_date('22-04-2002', 'dd-mm-yyyy'), 14, 948, 983, 993, 'Pen');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (987, to_date('21-05-2012', 'dd-mm-yyyy'), 12, 947, 984, 992, 'Notebook');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (988, to_date('12-04-2014', 'dd-mm-yyyy'), 14, 946, 964, 991, 'Pen');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (989, to_date('12-05-2013', 'dd-mm-yyyy'), 12, 945, 954, 990, 'Pen');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (999, to_date('04-05-2014', 'dd-mm-yyyy'), 13, 954, 999, 999, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (1, to_date('01-12-2005', 'dd-mm-yyyy'), 13, 954, 983, 996, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (2, to_date('28-04-2012', 'dd-mm-yyyy'), 13, 949, 983, 991, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (3, to_date('19-03-2019', 'dd-mm-yyyy'), 18, 945, 987, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (4, to_date('18-10-2006', 'dd-mm-yyyy'), 11, 954, 678, 994, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (5, to_date('02-10-2013', 'dd-mm-yyyy'), 10, 950, 954, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (6, to_date('03-08-2011', 'dd-mm-yyyy'), 11, 947, 678, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (7, to_date('24-07-2023', 'dd-mm-yyyy'), 18, 949, 984, 999, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (8, to_date('13-07-2006', 'dd-mm-yyyy'), 12, 951, 982, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (9, to_date('24-11-2013', 'dd-mm-yyyy'), 9, 952, 987, 991, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (10, to_date('18-02-2005', 'dd-mm-yyyy'), 17, 947, 984, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (11, to_date('20-10-2004', 'dd-mm-yyyy'), 14, 954, 678, 999, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (12, to_date('31-03-2013', 'dd-mm-yyyy'), 14, 945, 964, 992, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (13, to_date('16-03-2021', 'dd-mm-yyyy'), 18, 946, 999, 996, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (14, to_date('12-07-2013', 'dd-mm-yyyy'), 18, 947, 778, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (15, to_date('18-05-2018', 'dd-mm-yyyy'), 15, 946, 954, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (16, to_date('11-12-2013', 'dd-mm-yyyy'), 17, 952, 789, 997, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (17, to_date('20-07-2013', 'dd-mm-yyyy'), 13, 948, 999, 999, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (18, to_date('04-02-2019', 'dd-mm-yyyy'), 18, 953, 789, 999, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (19, to_date('15-05-2002', 'dd-mm-yyyy'), 18, 949, 999, 993, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (20, to_date('30-09-2003', 'dd-mm-yyyy'), 18, 947, 678, 997, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (21, to_date('09-07-2015', 'dd-mm-yyyy'), 13, 954, 789, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (22, to_date('22-09-2021', 'dd-mm-yyyy'), 16, 950, 678, 992, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (23, to_date('25-09-2016', 'dd-mm-yyyy'), 17, 948, 964, 994, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (24, to_date('10-04-2010', 'dd-mm-yyyy'), 10, 954, 678, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (25, to_date('01-07-2013', 'dd-mm-yyyy'), 16, 949, 789, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (26, to_date('21-10-2004', 'dd-mm-yyyy'), 10, 951, 678, 997, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (27, to_date('28-11-2005', 'dd-mm-yyyy'), 16, 947, 987, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (28, to_date('27-09-2022', 'dd-mm-yyyy'), 9, 948, 954, 991, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (29, to_date('18-07-2016', 'dd-mm-yyyy'), 9, 948, 778, 991, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (30, to_date('07-06-2011', 'dd-mm-yyyy'), 18, 952, 954, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (31, to_date('04-10-2019', 'dd-mm-yyyy'), 9, 953, 984, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (32, to_date('12-12-2004', 'dd-mm-yyyy'), 18, 946, 984, 999, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (33, to_date('30-08-2015', 'dd-mm-yyyy'), 12, 947, 982, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (34, to_date('28-04-2010', 'dd-mm-yyyy'), 11, 948, 678, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (35, to_date('30-12-2013', 'dd-mm-yyyy'), 11, 953, 999, 992, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (36, to_date('31-10-2009', 'dd-mm-yyyy'), 10, 953, 954, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (37, to_date('11-04-2007', 'dd-mm-yyyy'), 14, 951, 983, 994, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (38, to_date('10-12-2002', 'dd-mm-yyyy'), 16, 948, 999, 996, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (39, to_date('19-06-2009', 'dd-mm-yyyy'), 9, 945, 982, 994, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (40, to_date('24-12-2011', 'dd-mm-yyyy'), 18, 953, 678, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (41, to_date('16-03-2013', 'dd-mm-yyyy'), 9, 952, 982, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (42, to_date('10-05-2015', 'dd-mm-yyyy'), 11, 947, 999, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (43, to_date('19-09-2006', 'dd-mm-yyyy'), 14, 953, 964, 999, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (44, to_date('09-07-2014', 'dd-mm-yyyy'), 12, 954, 983, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (45, to_date('25-05-2011', 'dd-mm-yyyy'), 12, 947, 789, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (46, to_date('19-04-2007', 'dd-mm-yyyy'), 15, 948, 778, 996, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (47, to_date('30-03-2016', 'dd-mm-yyyy'), 11, 948, 987, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (48, to_date('31-12-2010', 'dd-mm-yyyy'), 11, 946, 789, 994, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (49, to_date('13-01-2009', 'dd-mm-yyyy'), 17, 949, 987, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (50, to_date('10-06-2000', 'dd-mm-yyyy'), 17, 950, 954, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (51, to_date('23-11-2019', 'dd-mm-yyyy'), 16, 953, 964, 992, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (52, to_date('17-04-2011', 'dd-mm-yyyy'), 17, 953, 964, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (53, to_date('03-10-2016', 'dd-mm-yyyy'), 15, 954, 983, 997, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (54, to_date('23-05-2015', 'dd-mm-yyyy'), 18, 954, 982, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (55, to_date('21-03-2020', 'dd-mm-yyyy'), 13, 948, 964, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (56, to_date('26-07-2011', 'dd-mm-yyyy'), 9, 947, 982, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (57, to_date('11-10-2023', 'dd-mm-yyyy'), 10, 954, 984, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (58, to_date('15-08-2011', 'dd-mm-yyyy'), 12, 945, 987, 997, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (59, to_date('20-04-2005', 'dd-mm-yyyy'), 9, 945, 982, 991, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (60, to_date('05-08-2009', 'dd-mm-yyyy'), 18, 947, 778, 999, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (61, to_date('20-01-2008', 'dd-mm-yyyy'), 15, 951, 987, 993, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (62, to_date('11-07-2006', 'dd-mm-yyyy'), 13, 949, 954, 991, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (63, to_date('24-09-2021', 'dd-mm-yyyy'), 16, 951, 983, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (64, to_date('26-03-2005', 'dd-mm-yyyy'), 15, 953, 789, 996, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (65, to_date('22-06-2021', 'dd-mm-yyyy'), 18, 952, 789, 999, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (66, to_date('13-02-2005', 'dd-mm-yyyy'), 18, 954, 678, 994, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (67, to_date('28-08-2003', 'dd-mm-yyyy'), 17, 949, 987, 991, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (68, to_date('23-08-2003', 'dd-mm-yyyy'), 17, 947, 982, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (69, to_date('25-12-2012', 'dd-mm-yyyy'), 18, 954, 789, 990, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (70, to_date('14-05-2000', 'dd-mm-yyyy'), 9, 947, 789, 993, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (71, to_date('15-07-2017', 'dd-mm-yyyy'), 15, 948, 983, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (72, to_date('10-11-2020', 'dd-mm-yyyy'), 18, 951, 964, 994, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (73, to_date('06-05-2016', 'dd-mm-yyyy'), 15, 954, 987, 992, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (74, to_date('18-10-2022', 'dd-mm-yyyy'), 15, 953, 983, 994, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (75, to_date('25-10-2007', 'dd-mm-yyyy'), 9, 950, 987, 993, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (76, to_date('27-07-2001', 'dd-mm-yyyy'), 9, 948, 778, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (77, to_date('16-03-2018', 'dd-mm-yyyy'), 13, 947, 982, 999, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (78, to_date('23-08-2008', 'dd-mm-yyyy'), 16, 950, 983, 997, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (79, to_date('08-06-2002', 'dd-mm-yyyy'), 11, 948, 789, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (80, to_date('30-10-2019', 'dd-mm-yyyy'), 14, 954, 982, 992, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (81, to_date('24-06-2001', 'dd-mm-yyyy'), 12, 949, 954, 991, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (82, to_date('12-11-2003', 'dd-mm-yyyy'), 17, 950, 789, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (83, to_date('19-01-2019', 'dd-mm-yyyy'), 16, 946, 678, 992, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (84, to_date('19-02-2014', 'dd-mm-yyyy'), 16, 945, 789, 991, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (85, to_date('01-07-2018', 'dd-mm-yyyy'), 16, 953, 964, 992, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (86, to_date('14-04-2006', 'dd-mm-yyyy'), 9, 948, 982, 993, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (87, to_date('20-04-2020', 'dd-mm-yyyy'), 16, 948, 984, 994, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (88, to_date('15-03-2014', 'dd-mm-yyyy'), 12, 947, 987, 991, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (89, to_date('12-09-2010', 'dd-mm-yyyy'), 14, 948, 999, 996, 'Nothing');
commit;
prompt 100 records committed...
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (90, to_date('17-03-2023', 'dd-mm-yyyy'), 10, 948, 999, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (91, to_date('06-01-2009', 'dd-mm-yyyy'), 15, 953, 983, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (92, to_date('26-01-2003', 'dd-mm-yyyy'), 14, 953, 984, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (93, to_date('15-07-2007', 'dd-mm-yyyy'), 12, 951, 982, 991, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (94, to_date('18-10-2017', 'dd-mm-yyyy'), 9, 951, 778, 995, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (95, to_date('06-02-2001', 'dd-mm-yyyy'), 10, 952, 678, 993, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (96, to_date('04-11-2000', 'dd-mm-yyyy'), 10, 947, 678, 997, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (97, to_date('05-05-2002', 'dd-mm-yyyy'), 12, 947, 964, 997, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (98, to_date('20-04-2022', 'dd-mm-yyyy'), 16, 949, 987, 996, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (99, to_date('14-12-2002', 'dd-mm-yyyy'), 10, 945, 984, 998, 'Nothing');
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id, present_status)
values (100, to_date('23-06-2004', 'dd-mm-yyyy'), 13, 953, 778, 996, 'Nothing');
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
prompt Enabling foreign key constraints for APARTMENT...
alter table APARTMENT enable constraint SYS_C007828;
alter table APARTMENT enable constraint SYS_C007829;
prompt Enabling foreign key constraints for VISIT...
alter table VISIT enable constraint SYS_C007835;
alter table VISIT enable constraint SYS_C007836;
alter table VISIT enable constraint SYS_C007837;
prompt Enabling foreign key constraints for APARTMENT_SALE...
alter table APARTMENT_SALE enable constraint SYS_C007840;
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
set feedback on
set define on
prompt Done.
