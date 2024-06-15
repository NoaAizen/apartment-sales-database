prompt PL/SQL Developer import file
prompt Created on Saturday, June 15, 2024 by necha
set feedback off
set define off
prompt Creating AGENT_PERSON...
create table AGENT_PERSON
(
  agent_id     NUMBER(3) not null,
  agent_name   VARCHAR2(15),
  phone_number NUMBER(5)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table AGENT_PERSON
  add primary key (AGENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CITY...
create table CITY
(
  city_id   NUMBER(3) not null,
  city_name VARCHAR2(15),
  rating    NUMBER(3)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CITY
  add primary key (CITY_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating SELLER...
create table SELLER
(
  seller_id    NUMBER(3) not null,
  seller_name  VARCHAR2(15),
  phone_number NUMBER(5)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SELLER
  add primary key (SELLER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating APARTMENT...
create table APARTMENT
(
  apartment_id   NUMBER(3) not null,
  apartment_size NUMBER(3),
  num_floor      INTEGER,
  num_rooms      INTEGER,
  price          INTEGER not null,
  seller_id      NUMBER(3),
  city_id        NUMBER(3)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table APARTMENT
  add primary key (APARTMENT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BUYER
  add primary key (BUYER_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table VISIT
  add primary key (VISIT_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table VISIT
  add unique (DATE_OF_VISIT)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table APARTMENT_SALE
  add primary key (SALE_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
alter table APARTMENT disable constraint SYS_C007623;
alter table APARTMENT disable constraint SYS_C007624;
prompt Disabling foreign key constraints for VISIT...
alter table VISIT disable constraint SYS_C007628;
alter table VISIT disable constraint SYS_C007629;
alter table VISIT disable constraint SYS_C007630;
prompt Disabling foreign key constraints for APARTMENT_SALE...
alter table APARTMENT_SALE disable constraint SYS_C007633;
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
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (999, 'Shimmy Brown', 12347);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (998, 'Vicky Gee', 12347);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (997, 'Dudi Cohen', 11287);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (996, 'Rikki Gold', 12387);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (995, 'Bonnie Field', 12287);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (994, 'Sam Smith', 23387);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (993, 'Mike Wazowski', 12187);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (992, 'Molly Weasley', 12237);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (991, 'Ronald McDonald', 12323);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (990, 'Sam McSam', 43387);
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
values (999, 'Yosef Cohen', 12387);
insert into SELLER (seller_id, seller_name, phone_number)
values (998, 'Yakov Cohen', 12387);
insert into SELLER (seller_id, seller_name, phone_number)
values (997, 'Yuri Cohen', 12387);
insert into SELLER (seller_id, seller_name, phone_number)
values (996, 'Yisroel Cohen', 12387);
insert into SELLER (seller_id, seller_name, phone_number)
values (995, 'Yael Cohen', 12387);
insert into SELLER (seller_id, seller_name, phone_number)
values (994, 'Yirmi Cohen', 12387);
insert into SELLER (seller_id, seller_name, phone_number)
values (993, 'Yechiel Cohen', 12387);
insert into SELLER (seller_id, seller_name, phone_number)
values (992, 'Yari Cohen', 12387);
insert into SELLER (seller_id, seller_name, phone_number)
values (991, 'Yoel Cohen', 12387);
insert into SELLER (seller_id, seller_name, phone_number)
values (990, 'Yitzchak Cohen', 12387);
insert into SELLER (seller_id, seller_name, phone_number)
values (989, 'Yishmael Cohen', 12387);
commit;
prompt 11 records loaded
prompt Loading APARTMENT...
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (954, 50, 2, 3, 173643750, 999, 919);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (953, 54, 0, 3, 150000000, 998, 929);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (952, 30, 7, 1, 150000000, 997, 939);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (951, 20, 1, 1, 100000000, 996, 949);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (950, 65, 1, 2, 300000000, 995, 959);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (949, 36, 1, 1, 150000000, 994, 959);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (948, 90, 2, 3, 350000000, 993, 959);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (947, 62, 0, 3, 200000000, 992, 959);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (946, 48, 3, 2, 250000000, 991, 921);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (945, 63, 1, 3, 350000000, 990, 922);
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
commit;
prompt 11 records loaded
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
alter table APARTMENT enable constraint SYS_C007623;
alter table APARTMENT enable constraint SYS_C007624;
prompt Enabling foreign key constraints for VISIT...
alter table VISIT enable constraint SYS_C007628;
alter table VISIT enable constraint SYS_C007629;
alter table VISIT enable constraint SYS_C007630;
prompt Enabling foreign key constraints for APARTMENT_SALE...
alter table APARTMENT_SALE enable constraint SYS_C007633;
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
