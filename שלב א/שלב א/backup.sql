prompt PL/SQL Developer import file
prompt Created on Thursday, May 23, 2024 by necha
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
  price          INTEGER,
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
  visit_id      NUMBER(3) not null,
  date_of_visit DATE,
  hour_of_visit NUMBER(2),
  apartment_id  NUMBER(3),
  buyer_id      NUMBER(3),
  agent_id      NUMBER(3)
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
alter table APARTMENT disable constraint SYS_C007132;
alter table APARTMENT disable constraint SYS_C007133;
prompt Disabling foreign key constraints for VISIT...
alter table VISIT disable constraint SYS_C007163;
alter table VISIT disable constraint SYS_C007164;
alter table VISIT disable constraint SYS_C007165;
prompt Disabling foreign key constraints for APARTMENT_SALE...
alter table APARTMENT_SALE disable constraint SYS_C007168;
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
values (1, 'Warren Vannelli', 61577);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (2, 'Dwight McCabe', 32625);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (3, 'Gates Martinez', 48338);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (4, 'Courtney Sewell', 84757);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (5, 'Irene Sarsgaard', 92238);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (6, 'Kelli Gershon', 28282);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (7, 'Gates Conway', 62607);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (8, 'Milla Kennedy', 15840);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (9, 'Brittany Sinatr', 46697);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (10, 'Janice Khan', 69547);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (11, 'Casey DiCaprio', 56474);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (12, 'Martin Hunter', 14403);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (13, 'Melba Del Toro', 99833);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (14, 'Tilda Arkenston', 91901);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (15, 'Merillee Winsto', 23327);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (16, 'Rachel Polley', 85201);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (17, 'Keanu Shalhoub', 14386);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (18, 'Trey Gertner', 75847);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (19, 'Cesar Rollins', 71320);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (20, 'Austin Fox', 22327);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (21, 'Edward Moreno', 14791);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (22, 'Derek Walker', 55789);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (23, 'Robbie Davison', 65556);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (24, 'Noah Vicious', 36187);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (25, 'Timothy Moorer', 65710);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (26, 'Max Dern', 66078);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (27, 'Ronny Sanchez', 55037);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (28, 'Morris Porter', 27395);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (29, 'Cuba Patton', 26047);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (30, 'Temuera Hartnet', 81863);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (31, 'Campbell Arthur', 51436);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (32, 'Claude Tisdale', 96503);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (33, 'Giancarlo Sanch', 21717);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (34, 'Roddy Ball', 34916);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (35, 'Gilberto Lloyd', 89189);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (36, 'Samuel Owen', 40960);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (37, 'Rita Vance', 42962);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (38, 'Ving Martinez', 97090);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (39, 'Mia Hagar', 78971);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (40, 'Jesus Lucas', 23225);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (41, 'Stockard Ermey', 44480);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (42, 'Rob Aglukark', 96550);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (43, 'Gil Lofgren', 69062);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (44, 'Charlize Brosna', 26414);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (45, 'Bradley Palin', 49170);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (46, 'Luis Woodard', 14449);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (47, 'Kelli Kravitz', 21653);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (48, 'Tramaine Alliso', 56417);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (49, 'Sinead Gagnon', 48750);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (50, 'Dwight Farris', 22202);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (51, 'Cuba Culkin', 33606);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (52, 'Nik Jackman', 11865);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (53, 'Yolanda Gill', 57050);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (54, 'Melba Ratzenber', 72008);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (55, 'Morgan Applegat', 63716);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (56, 'Steve Imperioli', 55869);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (57, 'Rade Ness', 64247);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (58, 'Eliza Mould', 65777);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (59, 'Tilda Cocker', 50997);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (60, 'Sam Thomas', 95935);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (61, 'Milla Black', 22827);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (62, 'Taylor Warren', 30132);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (63, 'Hugo Bandy', 71017);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (64, 'Herbie Carlyle', 60956);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (65, 'Gene Winwood', 18565);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (66, 'George Aiken', 17624);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (67, 'Madeleine Harne', 19834);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (68, 'Ahmad Coltrane', 76690);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (69, 'Shannyn Moore', 82288);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (70, 'Dennis Domino', 16820);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (71, 'Christmas Tambo', 47538);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (72, 'Rebeka Haggard', 23632);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (73, 'Ritchie Twilley', 20713);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (74, 'Bernie Hong', 86437);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (75, 'Gloria Chinlund', 15953);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (76, 'Art Skarsgard', 53685);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (77, 'Janice Ness', 27138);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (78, 'Holland Fogerty', 51153);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (79, 'Delbert Reinhol', 57515);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (80, 'Frederic Sinise', 64538);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (81, 'Beverley Appleg', 65269);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (82, 'Rosco Pony', 99272);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (83, 'Temuera Tierney', 14867);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (84, 'Sara Deejay', 23147);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (85, 'Pelvic Crouse', 91964);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (86, 'Russell Jonze', 44885);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (87, 'Morris Cash', 63194);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (88, 'Charles Kimball', 82246);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (89, 'Annette Elliott', 57169);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (90, 'Aaron Kane', 79693);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (91, 'Philip Renfro', 69835);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (92, 'Carol Suchet', 86269);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (93, 'Harvey Nash', 81840);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (94, 'Dave Gandolfini', 12144);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (95, 'Carole Burns', 38206);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (96, 'Mandy Arquette', 65615);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (97, 'Teri Tillis', 67117);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (98, 'Ernest Tah', 44039);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (99, 'Peter Washingto', 45552);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (100, 'Ned McGinley', 10639);
commit;
prompt 100 records committed...
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (101, 'Melba Rickman', 80546);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (102, 'Olga Metcalf', 37267);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (103, 'Solomon Guzman', 86576);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (104, 'Scarlett Blige', 29289);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (105, 'Meredith Hawkin', 97619);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (106, 'Michael Tyler', 95821);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (107, 'Jeffery Bracco', 77464);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (108, 'Willem Zahn', 34792);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (109, 'Giancarlo Frost', 39416);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (110, 'Dylan Scorsese', 90756);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (111, 'Pablo Calle', 27346);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (112, 'Queen Palin', 22299);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (113, 'Irene Torres', 79642);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (114, 'Cesar Deejay', 98240);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (115, 'Rod Burmester', 46713);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (116, 'Sheena Pesci', 35882);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (117, 'Kazem Sayer', 46812);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (118, 'Ian Chaplin', 53359);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (119, 'Gabrielle Reinh', 64835);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (120, 'Chubby Lipnicki', 29810);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (121, 'Chazz Archer', 99903);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (122, 'Kevin Gyllenhaa', 94831);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (123, 'Neve Crosby', 50700);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (124, 'Rachid Almond', 30487);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (125, 'Dianne Magnuson', 18219);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (126, 'Cole Holland', 38281);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (127, 'Woody Gordon', 24513);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (128, 'Jerry Pleasure', 37981);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (129, 'Colleen Orton', 48775);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (130, 'Nicky Zappacost', 38237);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (131, 'Natalie Heslov', 69278);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (132, 'Charlton Davidt', 28532);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (133, 'Lloyd Cozier', 66970);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (134, 'Nastassja Apple', 21510);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (135, 'Famke Avital', 34508);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (136, 'Garland Ali', 81954);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (137, 'Selma MacDowell', 38826);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (138, 'Allison Brock', 87096);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (139, 'Matthew Carnes', 86570);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (140, 'Eugene Holden', 50340);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (141, 'Jill Glover', 25593);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (142, 'Johnny Westerbe', 40279);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (143, 'Whoopi Andrews', 42733);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (144, 'Boz Rodgers', 96966);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (145, 'Eliza Portman', 63975);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (146, 'Embeth Gallaghe', 31068);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (147, 'Morris Heatherl', 38406);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (148, 'Giancarlo Thorn', 36809);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (149, 'Moe Price', 97783);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (150, 'Pierce Zappacos', 59647);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (151, 'Marty Moore', 59641);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (152, 'Bette Gill', 22587);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (153, 'Brad Masur', 69280);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (154, 'Mandy Hedaya', 93975);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (155, 'Tom Whitford', 35393);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (156, 'Nikki Choice', 12713);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (157, 'Avenged Idol', 31003);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (158, 'Karen Reno', 47204);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (159, 'Olympia Young', 46603);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (160, 'Jena Bergen', 70087);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (161, 'Helen Breslin', 71349);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (162, 'Curt Liu', 55070);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (163, 'Luke De Almeida', 51606);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (164, 'Robby Gore', 53124);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (165, 'Kelly Phillips', 49700);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (166, 'Dar Woods', 75905);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (167, 'John O''Neal', 79914);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (168, 'Emma Schwimmer', 72919);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (169, 'Kurtwood Isaacs', 59371);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (170, 'Randall Van Der', 18437);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (171, 'Pablo Tucci', 68903);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (172, 'Alec Keith', 52968);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (173, 'Dianne Shand', 39158);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (174, 'Maria Stormare', 95027);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (175, 'Vince Visnjic', 70420);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (176, 'Bradley Ceasar', 80338);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (177, 'Derrick Spector', 36780);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (178, 'Suzy Hersh', 40504);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (179, 'Lionel Oszajca', 46867);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (180, 'Arturo Taylor', 19699);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (181, 'Allison Kleinen', 39972);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (182, 'CeCe Gill', 89248);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (183, 'Cathy Boothe', 28770);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (184, 'Jimmie Ward', 34133);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (185, 'Kirsten Sizemor', 23540);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (186, 'CeCe Wilkinson', 55690);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (187, 'Hilary Gough', 78374);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (188, 'Marisa Patillo', 79098);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (189, 'Kieran Goodman', 73138);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (190, 'Clarence Lewin', 85860);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (191, 'Annette Fox', 66300);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (192, 'Bret Quatro', 58495);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (193, 'Stanley Peebles', 19052);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (194, 'Viggo Mars', 10177);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (195, 'Tamala DeGraw', 10783);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (196, 'First Fraser', 14200);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (197, 'Millie Bale', 15784);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (198, 'Collective Cond', 10095);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (199, 'Tilda Ness', 41533);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (200, 'Fats Harary', 13005);
commit;
prompt 200 records committed...
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (201, 'Horace Garcia', 15694);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (202, 'Kurt Rydell', 23800);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (203, 'Frankie Tomei', 62749);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (204, 'Tea Bancroft', 47345);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (205, 'Bruce Evans', 67513);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (206, 'Marley Fehr', 18585);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (207, 'Millie Kennedy', 22309);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (208, 'Juliette Magnus', 18744);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (209, 'Yolanda Isaacs', 62975);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (210, 'Debi Rea', 40072);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (211, 'Ronnie Clinton', 96673);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (212, 'Alana Rhymes', 75354);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (213, 'Oro Lynne', 97377);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (214, 'Marie O''Hara', 50944);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (215, 'Tcheky Baker', 33538);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (216, 'Gailard Mitchel', 67534);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (217, 'Petula Vanian', 22326);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (218, 'Angela Tomei', 44323);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (219, 'Ralph Kweller', 66759);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (220, 'Russell Lange', 57829);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (221, 'Dan Short', 31475);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (222, 'Larry Loggins', 39474);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (223, 'Nils Paxton', 80582);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (224, 'Spike Candy', 64301);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (225, 'Danni Paymer', 92508);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (226, 'Raul Briscoe', 39972);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (227, 'Gabrielle Mann', 22713);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (228, 'Juan Jeffreys', 28580);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (229, 'Mia Tinsley', 21175);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (230, 'Gordie Guest', 56999);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (231, 'Peter Turturro', 88256);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (232, 'Guy Studi', 32564);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (233, 'Robin O''Sulliva', 35644);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (234, 'Anjelica James', 52923);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (235, 'Neneh Hayek', 29053);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (236, 'Jean-Luc Lowe', 90172);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (237, 'Frederic Ratzen', 31960);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (238, 'Paul Midler', 42819);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (239, 'Bob Dupree', 25455);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (240, 'Wang Manning', 33044);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (241, 'Holly Field', 73885);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (242, 'Bebe Lewis', 74082);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (243, 'Woody Hopkins', 90056);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (244, 'Hookah McClinto', 31608);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (245, 'Gil Giamatti', 22906);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (246, 'Bobby Mahood', 96795);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (247, 'Kiefer Winter', 35415);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (248, 'Claude Thompson', 65409);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (249, 'Nick Church', 36691);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (250, 'Garth Holland', 30003);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (251, 'Kurt Gaines', 80319);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (252, 'Jamie Aaron', 99122);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (253, 'Liquid Snipes', 86773);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (254, 'Emerson Dourif', 81553);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (255, 'Juice Makowicz', 31585);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (256, 'Crispin Holland', 43132);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (257, 'Alana Akins', 88742);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (258, 'Vonda Winans', 51656);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (259, 'Rodney Peebles', 40958);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (260, 'Herbie Breslin', 40110);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (261, 'Jose Warden', 10732);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (262, 'Emily Langella', 62820);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (263, 'Kenneth Arden', 19132);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (264, 'Val Rapaport', 21480);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (265, 'Rene Carmen', 68475);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (266, 'Brittany Basing', 51325);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (267, 'Woody Kravitz', 31414);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (268, 'Patty Stoltz', 20180);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (269, 'Angelina Negbau', 57712);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (270, 'Leon Spiner', 57877);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (271, 'Donald Benet', 62074);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (272, 'Coley Kennedy', 48631);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (273, 'Humberto Wayans', 47240);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (274, 'Rosanna Sanchez', 47622);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (275, 'Vendetta Gersho', 76904);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (276, 'Maceo Kinney', 83324);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (277, 'Ronnie Dorn', 88371);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (278, 'Emily Rundgren', 82145);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (279, 'Arturo Winter', 76029);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (280, 'Treat Meniketti', 89908);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (281, 'Vendetta Atlas', 39091);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (282, 'Bret Briscoe', 68638);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (283, 'Teri Murray', 31483);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (284, 'Catherine Cagle', 45223);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (285, 'Adam Shaye', 83696);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (286, 'Harrison Russel', 43886);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (287, 'Charlize Jenkin', 76598);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (288, 'Illeana MacPher', 25144);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (289, 'Bret Eder', 31190);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (290, 'Juice Winans', 83208);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (291, 'Marisa Hong', 76734);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (292, 'Edgar Miller', 89673);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (293, 'Kurtwood Rossel', 88223);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (294, 'Gloria Neuwirth', 27042);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (295, 'Frederic Bates', 73367);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (296, 'Vonda Oates', 79170);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (297, 'Vin Marie', 64847);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (298, 'Machine Chan', 50305);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (299, 'Austin Carter', 56088);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (300, 'Ned Kinney', 88131);
commit;
prompt 300 records committed...
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (301, 'Garry Tankard', 23886);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (302, 'Wayman Pitt', 62189);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (303, 'Curtis Orton', 59532);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (304, 'Nelly Goodall', 65428);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (305, 'Charlie Murphy', 97178);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (306, 'Jessica Liotta', 86563);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (307, 'Rosanne Carrack', 74764);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (308, 'Denzel Marin', 72398);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (309, 'Karen Michael', 94492);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (310, 'Peter Diffie', 15617);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (311, 'Carlene Parsons', 97163);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (312, 'Alice Sevenfold', 52712);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (313, 'Pam Duschel', 93390);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (314, 'Kurt Vassar', 31921);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (315, 'Terrence Avalon', 25334);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (316, 'Jena Fariq', 60412);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (317, 'Ozzy Nunn', 70814);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (318, 'Cheech Stoltz', 46541);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (319, 'Julianne White', 48071);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (320, 'Rosie Devine', 25026);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (321, 'Jack Sepulveda', 79691);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (322, 'Rose Raye', 33388);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (323, 'Denzel Streep', 18915);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (324, 'Lin Heald', 45178);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (325, 'Marianne Warwic', 66318);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (326, 'Remy Applegate', 12430);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (327, 'Ramsey Perez', 30322);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (328, 'Ricardo McGover', 64578);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (329, 'Merle Beals', 66827);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (330, 'Karen Olyphant', 76944);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (331, 'Kitty Bullock', 11988);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (332, 'Shannon Fiennes', 56822);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (333, 'Carole Soul', 13506);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (334, 'Dom Keeslar', 72464);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (335, 'Wes Winstone', 70358);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (336, 'Azucar Beckham', 67889);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (337, 'Stockard Eat Wo', 24241);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (338, 'Juice Maguire', 87556);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (339, 'Wallace Gates', 68836);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (340, 'Breckin Womack', 27758);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (341, 'Campbell Perlma', 90893);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (342, 'Solomon Whitake', 59118);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (343, 'Rutger Flemyng', 30756);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (344, 'Doug Summer', 75032);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (345, 'Stockard Rush', 84857);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (346, 'Sinead Fonda', 57321);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (347, 'Fairuza Ward', 89612);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (348, 'Kasey Kier', 90997);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (349, 'Tara Osmond', 30605);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (350, 'Edie Tanon', 47870);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (351, 'Gavin Russo', 83607);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (352, 'Pam Walsh', 41999);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (353, 'Andre Pacino', 80491);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (354, 'Ben Sedaka', 21740);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (355, 'Jean Leto', 84031);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (356, 'Vern Sinise', 51569);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (357, 'Suzanne Winslet', 96596);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (358, 'Martin Williams', 55029);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (359, 'Yolanda Davies', 19515);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (360, 'Denise Rosas', 46184);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (361, 'Philip Spector', 27888);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (362, 'Russell Vinton', 64107);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (363, 'Rich Aiken', 90682);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (364, 'Katie Sayer', 11075);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (365, 'Ellen Gatlin', 43501);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (366, 'Terry Bridges', 33693);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (367, 'Mitchell Whitwa', 92231);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (368, 'Red Conlee', 24999);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (369, 'Andy Larter', 35379);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (370, 'Bebe Mollard', 78034);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (371, 'Balthazar Sharp', 11979);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (372, 'Connie Teng', 75361);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (373, 'Richie Remar', 16107);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (374, 'Sheena Cara', 77835);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (375, 'Rupert O''Keefe', 68905);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (376, 'Toshiro Herndon', 37613);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (377, 'Todd Ponty', 80169);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (378, 'Jimmie Adler', 98094);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (379, 'Liv Noseworthy', 84716);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (380, 'Connie Caviezel', 45321);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (381, 'Leonardo O''Hara', 59451);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (382, 'Natascha Steven', 24506);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (383, 'Judy Page', 85965);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (384, 'Gil Twilley', 59814);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (385, 'Cliff McBride', 16244);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (386, 'Stanley Moraz', 28586);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (387, 'Dermot Campbell', 96266);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (388, 'Emilio Gold', 80820);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (389, 'Tracy Garcia', 39542);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (390, 'Peabo Allen', 74167);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (391, 'Merle Keaton', 70620);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (392, 'LeVar Pfeiffer', 31996);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (393, 'Scott Judd', 82909);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (394, 'Ossie Paquin', 30435);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (395, 'Alannah Duke', 46396);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (396, 'Maceo Wiedlin', 87749);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (397, 'Kay Meyer', 64708);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (398, 'Suzi Connery', 89150);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (399, 'Goldie Parker', 67991);
insert into AGENT_PERSON (agent_id, agent_name, phone_number)
values (400, 'Ewan Bridges', 70276);
commit;
prompt 400 records loaded
prompt Loading CITY...
insert into CITY (city_id, city_name, rating)
values (1, 'New York', 75);
insert into CITY (city_id, city_name, rating)
values (2, 'Tokyo', 81);
insert into CITY (city_id, city_name, rating)
values (3, 'London', 63);
insert into CITY (city_id, city_name, rating)
values (4, 'Paris', 58);
insert into CITY (city_id, city_name, rating)
values (5, 'Berlin', 72);
insert into CITY (city_id, city_name, rating)
values (6, 'Rome', 49);
insert into CITY (city_id, city_name, rating)
values (7, 'Madrid', 66);
insert into CITY (city_id, city_name, rating)
values (8, 'Beijing', 91);
insert into CITY (city_id, city_name, rating)
values (9, 'Delhi', 83);
insert into CITY (city_id, city_name, rating)
values (10, 'Seoul', 54);
insert into CITY (city_id, city_name, rating)
values (11, 'Sydney', 78);
insert into CITY (city_id, city_name, rating)
values (12, 'Mumbai', 87);
insert into CITY (city_id, city_name, rating)
values (13, 'Shanghai', 92);
insert into CITY (city_id, city_name, rating)
values (14, 'Moscow', 73);
insert into CITY (city_id, city_name, rating)
values (15, 'Singapore', 68);
insert into CITY (city_id, city_name, rating)
values (16, 'Hong Kong', 74);
insert into CITY (city_id, city_name, rating)
values (17, 'Istanbul', 56);
insert into CITY (city_id, city_name, rating)
values (18, 'Bangkok', 89);
insert into CITY (city_id, city_name, rating)
values (19, 'Chicago', 67);
insert into CITY (city_id, city_name, rating)
values (20, 'Dubai', 85);
insert into CITY (city_id, city_name, rating)
values (21, 'Jakarta', 53);
insert into CITY (city_id, city_name, rating)
values (22, 'Lisbon', 48);
insert into CITY (city_id, city_name, rating)
values (23, 'Zurich', 59);
insert into CITY (city_id, city_name, rating)
values (24, 'Prague', 46);
insert into CITY (city_id, city_name, rating)
values (25, 'Vienna', 65);
insert into CITY (city_id, city_name, rating)
values (26, 'Boston', 62);
insert into CITY (city_id, city_name, rating)
values (27, 'Barcelona', 77);
insert into CITY (city_id, city_name, rating)
values (28, 'Miami', 70);
insert into CITY (city_id, city_name, rating)
values (29, 'Mexico City', 93);
insert into CITY (city_id, city_name, rating)
values (30, 'Santiago', 84);
insert into CITY (city_id, city_name, rating)
values (31, 'Athens', 47);
insert into CITY (city_id, city_name, rating)
values (32, 'Budapest', 51);
insert into CITY (city_id, city_name, rating)
values (33, 'Amsterdam', 64);
insert into CITY (city_id, city_name, rating)
values (34, 'Brussels', 52);
insert into CITY (city_id, city_name, rating)
values (35, 'Buenos Aires', 50);
insert into CITY (city_id, city_name, rating)
values (36, 'Melbourne', 57);
insert into CITY (city_id, city_name, rating)
values (37, 'Stockholm', 61);
insert into CITY (city_id, city_name, rating)
values (38, 'Helsinki', 45);
insert into CITY (city_id, city_name, rating)
values (39, 'Oslo', 55);
insert into CITY (city_id, city_name, rating)
values (40, 'Copenhagen', 60);
insert into CITY (city_id, city_name, rating)
values (41, 'Manila', 82);
insert into CITY (city_id, city_name, rating)
values (42, 'Karachi', 90);
insert into CITY (city_id, city_name, rating)
values (43, 'Riyadh', 88);
insert into CITY (city_id, city_name, rating)
values (44, 'Bucharest', 79);
insert into CITY (city_id, city_name, rating)
values (45, 'Warsaw', 76);
insert into CITY (city_id, city_name, rating)
values (46, 'Brisbane', 71);
insert into CITY (city_id, city_name, rating)
values (47, 'Basel', 69);
insert into CITY (city_id, city_name, rating)
values (48, 'Doha', 80);
insert into CITY (city_id, city_name, rating)
values (49, 'Montreal', 40);
insert into CITY (city_id, city_name, rating)
values (50, 'Edinburgh', 39);
insert into CITY (city_id, city_name, rating)
values (51, 'Glasgow', 38);
insert into CITY (city_id, city_name, rating)
values (52, 'Reykjavik', 37);
insert into CITY (city_id, city_name, rating)
values (53, 'Havana', 36);
insert into CITY (city_id, city_name, rating)
values (54, 'Baltimore', 35);
insert into CITY (city_id, city_name, rating)
values (55, 'Dublin', 33);
insert into CITY (city_id, city_name, rating)
values (56, 'Sofia', 32);
insert into CITY (city_id, city_name, rating)
values (57, 'Ottawa', 31);
insert into CITY (city_id, city_name, rating)
values (58, 'Hanoi', 30);
insert into CITY (city_id, city_name, rating)
values (59, 'Osaka', 29);
insert into CITY (city_id, city_name, rating)
values (60, 'Nairobi', 28);
insert into CITY (city_id, city_name, rating)
values (61, 'Manama', 27);
insert into CITY (city_id, city_name, rating)
values (62, 'Algiers', 26);
insert into CITY (city_id, city_name, rating)
values (63, 'Islamabad', 25);
insert into CITY (city_id, city_name, rating)
values (64, 'Kuwait City', 24);
insert into CITY (city_id, city_name, rating)
values (65, 'Belgrade', 23);
insert into CITY (city_id, city_name, rating)
values (66, 'Sarajevo', 22);
insert into CITY (city_id, city_name, rating)
values (67, 'Tunis', 21);
insert into CITY (city_id, city_name, rating)
values (68, 'Valletta', 20);
insert into CITY (city_id, city_name, rating)
values (69, 'Luxembourg', 19);
insert into CITY (city_id, city_name, rating)
values (70, 'Nicosia', 18);
insert into CITY (city_id, city_name, rating)
values (71, 'Tbilisi', 17);
insert into CITY (city_id, city_name, rating)
values (72, 'Riga', 16);
insert into CITY (city_id, city_name, rating)
values (73, 'Vilnius', 15);
insert into CITY (city_id, city_name, rating)
values (74, 'Skopje', 14);
insert into CITY (city_id, city_name, rating)
values (75, 'Tallinn', 13);
insert into CITY (city_id, city_name, rating)
values (76, 'Podgorica', 12);
insert into CITY (city_id, city_name, rating)
values (77, 'Monaco', 11);
insert into CITY (city_id, city_name, rating)
values (78, 'San Marino', 10);
insert into CITY (city_id, city_name, rating)
values (79, 'Vatican City', 9);
insert into CITY (city_id, city_name, rating)
values (80, 'Minsk', 8);
insert into CITY (city_id, city_name, rating)
values (81, 'Ljubljana', 7);
insert into CITY (city_id, city_name, rating)
values (82, 'Zagreb', 6);
insert into CITY (city_id, city_name, rating)
values (83, 'Kathmandu', 5);
insert into CITY (city_id, city_name, rating)
values (84, 'Kigali', 4);
insert into CITY (city_id, city_name, rating)
values (85, 'Lagos', 3);
insert into CITY (city_id, city_name, rating)
values (86, 'Casablanca', 2);
insert into CITY (city_id, city_name, rating)
values (87, 'Cairo', 1);
insert into CITY (city_id, city_name, rating)
values (88, 'Dakar', 99);
insert into CITY (city_id, city_name, rating)
values (89, 'Abuja', 98);
insert into CITY (city_id, city_name, rating)
values (90, 'Addis Ababa', 97);
insert into CITY (city_id, city_name, rating)
values (91, 'Luanda', 96);
insert into CITY (city_id, city_name, rating)
values (92, 'Antananarivo', 95);
insert into CITY (city_id, city_name, rating)
values (93, 'Khartoum', 94);
insert into CITY (city_id, city_name, rating)
values (94, 'Windhoek', 93);
insert into CITY (city_id, city_name, rating)
values (95, 'Harare', 92);
insert into CITY (city_id, city_name, rating)
values (96, 'Maputo', 91);
insert into CITY (city_id, city_name, rating)
values (97, 'Port Louis', 90);
insert into CITY (city_id, city_name, rating)
values (98, 'Lilongwe', 89);
insert into CITY (city_id, city_name, rating)
values (99, 'Libreville', 88);
insert into CITY (city_id, city_name, rating)
values (100, 'Accra', 87);
commit;
prompt 100 records committed...
insert into CITY (city_id, city_name, rating)
values (101, 'Lome', 86);
insert into CITY (city_id, city_name, rating)
values (102, 'Ouagadougou', 85);
insert into CITY (city_id, city_name, rating)
values (103, 'Bamako', 84);
insert into CITY (city_id, city_name, rating)
values (104, 'Niamey', 83);
insert into CITY (city_id, city_name, rating)
values (105, 'Djibouti', 82);
insert into CITY (city_id, city_name, rating)
values (106, 'Asuncion', 81);
insert into CITY (city_id, city_name, rating)
values (107, 'Lima', 80);
insert into CITY (city_id, city_name, rating)
values (108, 'La Paz', 79);
insert into CITY (city_id, city_name, rating)
values (109, 'Quito', 78);
insert into CITY (city_id, city_name, rating)
values (110, 'Montevideo', 77);
insert into CITY (city_id, city_name, rating)
values (111, 'Caracas', 76);
insert into CITY (city_id, city_name, rating)
values (112, 'Kingston', 75);
insert into CITY (city_id, city_name, rating)
values (113, 'Nassau', 74);
insert into CITY (city_id, city_name, rating)
values (114, 'Santo Domingo', 73);
insert into CITY (city_id, city_name, rating)
values (115, 'Port-au-Prince', 72);
insert into CITY (city_id, city_name, rating)
values (116, 'Tegucigalpa', 71);
insert into CITY (city_id, city_name, rating)
values (117, 'San Salvador', 70);
insert into CITY (city_id, city_name, rating)
values (118, 'Managua', 69);
insert into CITY (city_id, city_name, rating)
values (119, 'Panama City', 68);
insert into CITY (city_id, city_name, rating)
values (120, 'Belize City', 67);
insert into CITY (city_id, city_name, rating)
values (121, 'Guatemala City', 66);
insert into CITY (city_id, city_name, rating)
values (122, 'San Jose', 65);
insert into CITY (city_id, city_name, rating)
values (123, 'Port-of-Spain', 64);
insert into CITY (city_id, city_name, rating)
values (124, 'Bridgetown', 63);
insert into CITY (city_id, city_name, rating)
values (125, 'Castries', 62);
insert into CITY (city_id, city_name, rating)
values (126, 'Basseterre', 61);
insert into CITY (city_id, city_name, rating)
values (127, 'St. John''s', 60);
insert into CITY (city_id, city_name, rating)
values (128, 'Kingstown', 59);
insert into CITY (city_id, city_name, rating)
values (129, 'Roseau', 58);
insert into CITY (city_id, city_name, rating)
values (130, 'St. George''s', 57);
insert into CITY (city_id, city_name, rating)
values (131, 'Bogota', 56);
insert into CITY (city_id, city_name, rating)
values (132, 'Paramaribo', 55);
insert into CITY (city_id, city_name, rating)
values (133, 'Georgetown', 54);
insert into CITY (city_id, city_name, rating)
values (134, 'Cayenne', 53);
insert into CITY (city_id, city_name, rating)
values (135, 'Sucre', 52);
insert into CITY (city_id, city_name, rating)
values (136, 'Colombo', 51);
insert into CITY (city_id, city_name, rating)
values (137, 'Dhaka', 50);
insert into CITY (city_id, city_name, rating)
values (138, 'Phnom Penh', 49);
insert into CITY (city_id, city_name, rating)
values (139, 'Yangon', 48);
insert into CITY (city_id, city_name, rating)
values (140, 'Vientiane', 47);
insert into CITY (city_id, city_name, rating)
values (141, 'Ho Chi Minh', 46);
insert into CITY (city_id, city_name, rating)
values (142, 'Taipei', 45);
insert into CITY (city_id, city_name, rating)
values (143, 'Ulaanbaatar', 44);
insert into CITY (city_id, city_name, rating)
values (144, 'Thimphu', 43);
insert into CITY (city_id, city_name, rating)
values (145, 'New Delhi', 42);
insert into CITY (city_id, city_name, rating)
values (146, 'Astana', 41);
commit;
prompt 146 records loaded
prompt Loading SELLER...
insert into SELLER (seller_id, seller_name, phone_number)
values (1, 'John Smith', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (2, 'Emily Johnson', 6789);
insert into SELLER (seller_id, seller_name, phone_number)
values (500, 'John Doe', 12345);
insert into SELLER (seller_id, seller_name, phone_number)
values (3, 'Max Smith', 54321);
insert into SELLER (seller_id, seller_name, phone_number)
values (4, 'Ana Bell', 98765);
insert into SELLER (seller_id, seller_name, phone_number)
values (5, 'Tom Fox', 13579);
insert into SELLER (seller_id, seller_name, phone_number)
values (6, 'Sam King', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (7, 'Leo Cruz', 13579);
insert into SELLER (seller_id, seller_name, phone_number)
values (8, 'Joe Wong', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (9, 'Ray Lee', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (10, 'Amy Kim', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (11, 'Eva Fox', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (12, 'Dan Lim', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (13, 'Mia Roy', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (14, 'Ivy Ma', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (15, 'Kai Lou', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (16, 'Zoe May', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (17, 'Ada Liu', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (18, 'Jay Ng', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (19, 'Kim Yu', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (20, 'Lia Wu', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (21, 'Max Li', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (22, 'Joe Qi', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (23, 'Tim Ho', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (24, 'Eli Zhi', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (25, 'Tom Du', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (26, 'Mia Fu', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (27, 'Joy Mo', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (28, 'Ana Pu', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (29, 'Ray Tu', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (30, 'Sam Gu', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (31, 'Ada Ru', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (32, 'Leo Su', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (33, 'Eva Xu', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (34, 'Kai Yu', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (35, 'Zoe Wu', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (36, 'Jay Hu', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (37, 'Amy Ku', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (38, 'Joe Lu', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (39, 'Mia Mu', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (40, 'Dan Nu', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (41, 'Tim Ou', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (42, 'Eli Pi', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (43, 'Tom Qi', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (44, 'Joy Ri', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (45, 'Ray Si', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (46, 'Sam Ti', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (47, 'Ivy Ui', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (48, 'Ada Vi', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (49, 'Leo Wi', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (50, 'Eva Xi', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (51, 'Kai Yi', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (52, 'Zoe Zi', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (53, 'Jay Ao', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (54, 'Amy Bo', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (55, 'Joe Co', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (56, 'Mia Do', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (57, 'Dan Eo', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (58, 'Tim Fo', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (59, 'Eli Go', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (60, 'Tom Ho', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (61, 'Joy Io', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (62, 'Ray Jo', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (63, 'Sam Ko', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (64, 'Ivy Lo', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (65, 'Ada Mo', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (66, 'Leo No', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (67, 'Eva Oo', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (68, 'Kai Po', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (69, 'Zoe Qo', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (70, 'Jay Ro', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (71, 'Amy So', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (72, 'Joe To', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (73, 'Mia Uo', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (74, 'Dan Vo', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (75, 'Tim Wo', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (76, 'Eli Xo', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (77, 'Tom Yo', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (78, 'Joy Zo', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (79, 'Ray Au', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (80, 'Sam Bu', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (81, 'Ivy Cu', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (82, 'Ada Du', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (83, 'Leo Eu', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (84, 'Eva Fu', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (85, 'Kai Gu', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (86, 'Zoe Hu', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (87, 'Jay Iu', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (88, 'Amy Ju', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (89, 'Joe Ku', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (90, 'Mia Lu', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (91, 'Dan Mu', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (92, 'Tim Nu', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (93, 'Eli Ou', 75319);
insert into SELLER (seller_id, seller_name, phone_number)
values (94, 'Tom Pu', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (95, 'Joy Qu', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (96, 'Ray Ru', 13524);
insert into SELLER (seller_id, seller_name, phone_number)
values (97, 'Sam Su', 24680);
insert into SELLER (seller_id, seller_name, phone_number)
values (98, 'Ivy Tu', 97531);
insert into SELLER (seller_id, seller_name, phone_number)
values (99, 'Ada Uu', 75319);
commit;
prompt 100 records committed...
insert into SELLER (seller_id, seller_name, phone_number)
values (100, 'Leo Vu', 86420);
insert into SELLER (seller_id, seller_name, phone_number)
values (101, 'Eva Wu', 15973);
insert into SELLER (seller_id, seller_name, phone_number)
values (501, 'Jane Smith', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (502, 'David Johns', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (503, 'Jennifer B', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (504, 'Michael D', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (505, 'Susan Wils', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (506, 'James Moor', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (507, 'Linda Tayl', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (508, 'William A', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (509, 'Karen Thom', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (510, 'Richard J', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (511, 'Patricia W', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (512, 'Charles H', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (513, 'Barbara M', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (514, 'Matthew T', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (515, 'Elizabeth ', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (516, 'Joseph Ma', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (517, 'Dorothy R', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (518, 'Christoph', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (519, 'Lisa Rodr', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (520, 'Daniel Lew', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (521, 'Nancy Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (522, 'Paul Walke', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (523, 'Betty Hall', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (524, 'Mark Young', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (525, 'Margaret ', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (526, 'Donald Kin', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (527, 'Sarah Wrig', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (528, 'Steven Sco', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (529, 'Karen Gree', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (530, 'Edward Bak', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (531, 'Helen Adam', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (532, 'Brian Nels', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (533, 'Emily Hill', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (534, 'Kevin Rami', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (535, 'Alice Camp', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (536, 'Thomas Mit', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (537, 'Jessica Pe', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (538, 'Ryan Rober', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (539, 'Carol Wood', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (540, 'Jason Garc', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (541, 'Ruth Stewa', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (542, 'Amanda Flo', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (543, 'Gary Morri', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (544, 'Sandra San', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (545, 'Eric Brook', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (546, 'Frank Cox', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (547, 'Anna Rive', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (548, 'Kenneth W', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (549, 'Deborah B', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (550, 'Larry Barn', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (551, 'Teresa Pri', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (552, 'Gerald Gr', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (553, 'Julie Evan', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (554, 'Carl Reed', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (555, 'Martha Col', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (556, 'Albert Rus', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (557, 'Beverly S', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (558, 'Arthur Fos', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (559, 'Tammy Murp', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (560, 'Henry Perr', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (561, 'Katherine ', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (562, 'Philip Lon', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (563, 'Lori Torre', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (564, 'Bobby Lope', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (565, 'Janet Perr', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (566, 'Steve Reed', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (567, 'Jane Simmo', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (568, 'Johnny Fos', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (569, 'Victoria M', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (570, 'Carlos Per', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (571, 'Mildred L', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (572, 'Louis Torr', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (573, 'Judith Lop', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (574, 'Phillip Re', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (575, 'Cheryl Sim', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (576, 'Jimmy Fost', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (577, 'Bonnie Mur', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (578, 'Roger Perr', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (579, 'Gloria Lon', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (580, 'Randy T', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (581, 'Phyllis L', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (582, 'Diane Reed', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (583, 'Wayne Sim', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (584, 'Rebecca F', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (585, 'Jeremy M', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (586, 'Stephanie ', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (587, 'Brandon L', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (588, 'Evelyn T', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (589, 'Clarence L', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (590, 'Tina Reed', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (591, 'Russell S', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (592, 'Charlotte ', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (593, 'Lawrence M', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (594, 'Samantha P', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (595, 'Alberta Lo', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (596, 'Harry Torr', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (597, 'Shirley L', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (598, 'Gerald Re', 56789);
commit;
prompt 200 records committed...
insert into SELLER (seller_id, seller_name, phone_number)
values (599, 'Catherine ', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (600, 'Bruce Fos', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (601, 'Donna Mart', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (602, 'Justin Tho', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (603, 'Carolyn G', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (604, 'Keith Mart', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (605, 'Sara Thomp', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (606, 'Joyce Gar', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (607, 'Russell H', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (608, 'Marilyn N', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (609, 'Wayne John', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (610, 'Phyllis H', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (611, 'Susan Nels', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (612, 'Dennis An', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (613, 'Gloria Da', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (614, 'Ralph Mart', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (615, 'Joyce Brow', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (616, 'Eugene Ma', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (617, 'Geraldine ', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (618, 'Patrick P', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (619, 'Laura Lew', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (620, 'Marie Hall', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (621, 'Bruce Pere', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (622, 'Diane Nels', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (623, 'Bobby Scot', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (624, 'Judith Ada', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (625, 'Harold Hal', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (626, 'Alice Rodr', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (627, 'Howard Bel', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (628, 'Lois King', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (629, 'Billy Wood', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (630, 'Shirley J', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (631, 'Larry Fos', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (632, 'Karen Cart', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (633, 'Gerald Bu', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (634, 'Jacquelin', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (635, 'Jonathan ', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (636, 'Martha Le', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (637, 'Alan Hill', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (638, 'Catherine', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (639, 'Keith Turn', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (640, 'Deborah L', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (641, 'Douglas H', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (642, 'Janice Phi', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (643, 'Albert Co', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (644, 'Joyce Alle', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (645, 'Arthur Tu', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (646, 'Joyce Lew', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (647, 'Joshua Bel', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (648, 'Julie Whit', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (649, 'Henry Par', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (650, 'Deborah M', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (651, 'Keith Ram', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (652, 'Andrea How', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (653, 'Jeremy Co', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (654, 'Kathleen ', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (655, 'Adam Mart', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (656, 'Debra Turn', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (657, 'Nicholas ', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (658, 'Janet Kell', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (659, 'Billy Pow', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (660, 'Marie Scot', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (661, 'Jason Fos', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (662, 'Jane Lewi', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (663, 'Carl Jenki', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (664, 'Susan Phil', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (665, 'Philip Ev', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (666, 'Mary Rodr', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (667, 'Eugene Bu', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (668, 'Mildred L', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (669, 'Keith Kin', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (670, 'Martha Ho', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (671, 'Gary Ross', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (673, 'Alan Thompson', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (674, 'Julie Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (675, 'Bruce Foster', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (676, 'Jane Lewis', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (677, 'Carl Jenkins', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (678, 'Susan Phillips', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (679, 'Philip Evans', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (680, 'Mary Rodriguez', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (681, 'Eugene Butler', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (682, 'Mildred Lee', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (683, 'Keith King', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (684, 'Martha Howard', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (685, 'Gary Ross', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (686, 'Linda Clark', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (687, 'Alan Thompson', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (688, 'Julie Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (689, 'Bruce Foster', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (690, 'Jane Lewis', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (691, 'Carl Jenkins', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (692, 'Susan Phillips', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (693, 'Philip Evans', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (694, 'Mary Rodriguez', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (695, 'Eugene Butler', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (696, 'Mildred Lee', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (697, 'Keith King', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (698, 'Martha Howard', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (699, 'Gary Ross', 1234);
commit;
prompt 300 records committed...
insert into SELLER (seller_id, seller_name, phone_number)
values (700, 'Linda Clark', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (701, 'Alan Thompson', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (702, 'Julie Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (703, 'Bruce Foster', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (704, 'Jane Lewis', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (705, 'Carl Jenkins', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (706, 'Susan Phillips', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (707, 'Philip Evans', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (708, 'Mary Rodriguez', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (709, 'Eugene Butler', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (710, 'Mildred Lee', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (711, 'Keith King', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (712, 'Martha Howard', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (713, 'Gary Ross', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (714, 'Linda Clark', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (715, 'Alan Thompson', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (716, 'Julie Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (717, 'Bruce Foster', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (718, 'Jane Lewis', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (719, 'Carl Jenkins', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (720, 'Susan Phillips', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (721, 'Philip Evans', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (722, 'Mary Rodriguez', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (723, 'Eugene Butler', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (724, 'Mildred Lee', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (725, 'Keith King', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (726, 'Martha Howard', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (727, 'Gary Ross', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (728, 'Linda Clark', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (729, 'Alan Thompson', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (730, 'Julie Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (731, 'Bruce Foster', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (732, 'Jane Lewis', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (733, 'Carl Jenkins', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (734, 'Susan Phillips', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (735, 'Philip Evans', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (736, 'Mary Rodriguez', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (737, 'Eugene Butler', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (738, 'Mildred Lee', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (739, 'Keith King', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (740, 'Martha Howard', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (741, 'Gary Ross', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (742, 'Linda Clark', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (743, 'Alan Thompson', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (744, 'Julie Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (745, 'Bruce Foster', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (746, 'Jane Lewis', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (747, 'Carl Jenkins', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (748, 'Susan Phillips', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (749, 'Philip Evans', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (750, 'Mary Rodriguez', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (751, 'Eugene Butler', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (752, 'Mildred Lee', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (753, 'Keith King', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (754, 'Martha Howard', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (755, 'Gary Ross', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (756, 'Linda Clark', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (757, 'Alan Thompson', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (758, 'Julie Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (759, 'Bruce Foster', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (760, 'Jane Lewis', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (761, 'Carl Jenkins', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (762, 'Susan Phillips', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (763, 'Philip Evans', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (764, 'Mary Rodriguez', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (765, 'Eugene Butler', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (766, 'Mildred Lee', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (767, 'Keith King', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (768, 'Martha Howard', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (769, 'Gary Ross', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (770, 'Linda Clark', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (771, 'Alan Thompson', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (772, 'Julie Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (773, 'Bruce Foster', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (774, 'Jane Lewis', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (775, 'Carl Jenkins', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (776, 'Susan Phillips', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (777, 'Philip Evans', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (778, 'Mary Rodriguez', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (779, 'Eugene Butler', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (780, 'Mildred Lee', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (781, 'Keith King', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (782, 'Martha Howard', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (783, 'Gary Ross', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (784, 'Linda Clark', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (785, 'Alan Thompson', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (786, 'Julie Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (787, 'Bruce Foster', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (788, 'Jane Lewis', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (789, 'Carl Jenkins', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (790, 'Susan Phillips', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (791, 'Philip Evans', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (792, 'Mary Rodriguez', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (793, 'Eugene Butler', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (794, 'Mildred Lee', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (795, 'Keith King', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (796, 'Martha Howard', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (797, 'Gary Ross', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (798, 'Linda Clark', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (799, 'Alan Thompson', 23456);
commit;
prompt 400 records committed...
insert into SELLER (seller_id, seller_name, phone_number)
values (800, 'Julie Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (801, 'Bruce Foster', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (802, 'Jane Lewis', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (803, 'Carl Jenkins', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (804, 'Susan Phillips', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (805, 'Philip Evans', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (806, 'Mary Rodriguez', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (807, 'Eugene Butler', 89012);
insert into SELLER (seller_id, seller_name, phone_number)
values (808, 'Mildred Lee', 45678);
insert into SELLER (seller_id, seller_name, phone_number)
values (809, 'Keith King', 90123);
insert into SELLER (seller_id, seller_name, phone_number)
values (810, 'Martha Howard', 56789);
insert into SELLER (seller_id, seller_name, phone_number)
values (811, 'Gary Ross', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (812, 'Linda Clark', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (813, 'Alan Thompson', 23456);
insert into SELLER (seller_id, seller_name, phone_number)
values (814, 'Julie Lee', 78901);
insert into SELLER (seller_id, seller_name, phone_number)
values (815, 'Bruce Foster', 34567);
insert into SELLER (seller_id, seller_name, phone_number)
values (816, 'Jane Lewis', 1234);
insert into SELLER (seller_id, seller_name, phone_number)
values (817, 'Carl Jenkins', 67890);
insert into SELLER (seller_id, seller_name, phone_number)
values (818, 'Susan Phill', null);
commit;
prompt 419 records loaded
prompt Loading APARTMENT...
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (1, 107, 7, 2, 1000000, 713, 75);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (2, 178, 4, 7, 1050000, 801, 68);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (3, 84, 5, 3, 1100000, 604, 108);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (4, 196, 3, 7, 1150000, 512, 62);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (5, 168, 2, 5, 1200000, 669, 23);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (6, 108, 1, 1, 1250000, 28, 75);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (7, 163, 1, 1, 1300000, 742, 33);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (8, 165, 8, 6, 1350000, 642, 71);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (9, 102, 5, 7, 1400000, 807, 85);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (10, 199, 2, 1, 1450000, 550, 69);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (11, 198, 4, 2, 1500000, 664, 121);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (12, 65, 0, 7, 1550000, 734, 1);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (13, 67, 5, 2, 1600000, 522, 60);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (14, 162, 2, 6, 1650000, 4, 119);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (15, 101, 0, 2, 1700000, 506, 6);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (16, 38, 4, 4, 1750000, 810, 33);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (17, 185, 1, 7, 1800000, 647, 129);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (18, 118, 7, 6, 1850000, 548, 101);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (19, 130, 1, 8, 1900000, 543, 8);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (20, 42, 1, 7, 1950000, 757, 101);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (21, 174, 6, 1, 2000000, 31, 32);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (22, 147, 7, 7, 2050000, 627, 16);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (23, 132, 5, 2, 2100000, 704, 43);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (24, 63, 6, 5, 2150000, 590, 56);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (25, 125, 1, 7, 2200000, 35, 118);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (26, 155, 5, 2, 2250000, 667, 28);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (27, 180, 6, 1, 2300000, 749, 136);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (28, 88, 7, 3, 2350000, 91, 118);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (29, 32, 3, 3, 2400000, 743, 30);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (30, 48, 2, 3, 2450000, 650, 32);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (31, 159, 5, 3, 2500000, 652, 51);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (32, 34, 0, 7, 2550000, 775, 64);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (33, 147, 8, 3, 2600000, 48, 25);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (34, 84, 7, 7, 2650000, 620, 51);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (35, 171, 1, 3, 2700000, 717, 81);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (36, 199, 4, 3, 2750000, 520, 118);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (37, 147, 3, 8, 2800000, 547, 143);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (38, 65, 6, 7, 2850000, 653, 5);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (39, 192, 2, 2, 2900000, 537, 120);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (40, 184, 5, 5, 2950000, 642, 94);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (41, 122, 5, 7, 3000000, 755, 70);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (42, 78, 2, 8, 3050000, 680, 135);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (43, 99, 5, 6, 3100000, 617, 98);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (44, 156, 8, 8, 3150000, 610, 32);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (45, 66, 2, 5, 3200000, 84, 14);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (46, 120, 4, 5, 3250000, 657, 116);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (47, 86, 3, 2, 3300000, 596, 63);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (48, 188, 3, 4, 3350000, 664, 19);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (49, 69, 3, 4, 3400000, 23, 116);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (50, 57, 2, 2, 3450000, 807, 51);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (51, 83, 0, 6, 3500000, 810, 75);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (52, 80, 7, 8, 3550000, 85, 136);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (53, 191, 1, 7, 3600000, 787, 57);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (54, 65, 2, 4, 3650000, 502, 131);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (55, 118, 7, 4, 3700000, 603, 142);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (56, 79, 7, 6, 3750000, 509, 39);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (57, 92, 5, 1, 3800000, 7, 122);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (58, 180, 4, 4, 3850000, 782, 34);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (59, 146, 5, 8, 3900000, 752, 11);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (60, 57, 0, 5, 3950000, 37, 62);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (61, 55, 0, 8, 4000000, 89, 52);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (62, 45, 1, 7, 4050000, 59, 31);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (63, 178, 8, 5, 4100000, 675, 119);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (64, 36, 6, 2, 4150000, 52, 68);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (65, 129, 8, 2, 4200000, 668, 70);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (66, 140, 7, 4, 4250000, 671, 132);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (67, 163, 8, 3, 4300000, 543, 93);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (68, 193, 8, 2, 4350000, 799, 69);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (69, 150, 8, 5, 4400000, 616, 58);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (70, 181, 7, 8, 4450000, 100, 48);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (71, 43, 5, 8, 4500000, 14, 124);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (72, 111, 0, 4, 4550000, 801, 54);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (73, 186, 2, 5, 4600000, 60, 30);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (74, 180, 5, 6, 4650000, 795, 146);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (75, 199, 8, 1, 4700000, 12, 73);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (76, 82, 0, 4, 4750000, 717, 68);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (77, 136, 3, 8, 4800000, 516, 131);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (78, 97, 2, 2, 4850000, 749, 144);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (79, 45, 6, 8, 4900000, 610, 90);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (80, 44, 0, 1, 4950000, 634, 107);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (81, 192, 6, 5, 5000000, 516, 39);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (82, 70, 0, 1, 5050000, 770, 18);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (83, 53, 5, 1, 5100000, 630, 17);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (84, 82, 1, 2, 5150000, 815, 42);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (85, 91, 7, 1, 5200000, 684, 3);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (86, 163, 5, 8, 5250000, 600, 74);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (87, 78, 1, 3, 5300000, 762, 123);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (88, 198, 0, 4, 5350000, 28, 119);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (89, 170, 2, 8, 5400000, 62, 105);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (90, 142, 1, 4, 5450000, 584, 85);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (91, 44, 8, 8, 5500000, 633, 67);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (92, 124, 8, 2, 5550000, 550, 104);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (93, 192, 4, 4, 5600000, 812, 64);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (94, 193, 3, 2, 5650000, 685, 42);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (95, 37, 6, 8, 5700000, 1, 31);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (96, 37, 0, 7, 5750000, 625, 45);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (97, 31, 0, 4, 5800000, 636, 34);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (98, 116, 8, 8, 5850000, 742, 25);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (99, 151, 6, 2, 5900000, 664, 110);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (100, 150, 1, 6, 5950000, 733, 59);
commit;
prompt 100 records committed...
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (101, 198, 3, 7, 6000000, 586, 112);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (102, 193, 2, 2, 6050000, 570, 58);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (103, 126, 0, 2, 6100000, 46, 79);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (104, 101, 6, 8, 6150000, 767, 132);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (105, 188, 1, 7, 6200000, 815, 108);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (106, 162, 6, 7, 6250000, 658, 4);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (107, 50, 7, 4, 6300000, 527, 76);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (108, 141, 0, 4, 6350000, 711, 71);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (109, 89, 3, 5, 6400000, 716, 132);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (110, 103, 6, 1, 6450000, 582, 23);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (111, 35, 4, 1, 6500000, 809, 23);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (112, 168, 4, 3, 6550000, 10, 51);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (113, 91, 7, 2, 6600000, 2, 130);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (114, 83, 0, 4, 6650000, 752, 77);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (115, 66, 8, 4, 6700000, 50, 131);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (116, 67, 1, 7, 6750000, 740, 93);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (117, 168, 0, 5, 6800000, 23, 14);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (118, 61, 1, 3, 6850000, 593, 130);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (119, 43, 3, 8, 6900000, 540, 102);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (120, 53, 0, 6, 6950000, 610, 12);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (121, 146, 6, 6, 7000000, 554, 45);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (122, 61, 6, 1, 7050000, 676, 38);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (123, 128, 7, 8, 7100000, 717, 42);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (124, 103, 4, 8, 7150000, 687, 116);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (125, 99, 6, 4, 7200000, 628, 130);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (126, 160, 6, 7, 7250000, 30, 94);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (127, 127, 1, 3, 7300000, 517, 20);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (128, 182, 6, 6, 7350000, 510, 70);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (129, 188, 7, 3, 7400000, 677, 98);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (130, 200, 1, 5, 7450000, 17, 13);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (131, 142, 3, 4, 7500000, 101, 53);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (132, 88, 2, 5, 7550000, 562, 52);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (133, 140, 1, 3, 7600000, 656, 124);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (134, 53, 0, 4, 7650000, 608, 3);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (135, 144, 6, 3, 7700000, 707, 24);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (136, 194, 1, 5, 7750000, 746, 86);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (137, 134, 0, 3, 7800000, 572, 86);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (138, 99, 3, 8, 7850000, 68, 35);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (139, 71, 2, 1, 7900000, 78, 44);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (140, 107, 6, 7, 7950000, 751, 2);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (141, 119, 0, 1, 8000000, 627, 14);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (142, 98, 7, 7, 8050000, 83, 8);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (143, 79, 0, 5, 8100000, 810, 128);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (144, 45, 0, 4, 8150000, 714, 71);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (145, 105, 4, 6, 8200000, 770, 47);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (146, 125, 4, 1, 8250000, 667, 64);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (147, 82, 5, 7, 8300000, 48, 59);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (148, 141, 1, 3, 8350000, 701, 16);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (149, 86, 0, 1, 8400000, 733, 99);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (150, 128, 0, 6, 8450000, 100, 21);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (151, 161, 5, 7, 8500000, 518, 116);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (152, 175, 6, 8, 8550000, 575, 24);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (153, 158, 7, 3, 8600000, 545, 41);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (154, 153, 7, 4, 8650000, 639, 26);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (155, 47, 8, 5, 8700000, 754, 144);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (156, 156, 7, 2, 8750000, 678, 82);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (157, 85, 4, 6, 8800000, 748, 107);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (158, 109, 2, 4, 8850000, 612, 13);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (159, 187, 5, 4, 8900000, 622, 19);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (160, 63, 1, 8, 8950000, 56, 146);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (161, 174, 6, 7, 9000000, 804, 54);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (162, 176, 4, 2, 9050000, 573, 142);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (163, 134, 8, 7, 9100000, 787, 89);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (164, 117, 5, 2, 9150000, 721, 51);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (165, 56, 3, 4, 9200000, 616, 71);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (166, 122, 8, 2, 9250000, 699, 18);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (167, 92, 2, 5, 9300000, 808, 64);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (168, 131, 0, 2, 9350000, 609, 111);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (169, 42, 4, 1, 9400000, 87, 14);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (170, 91, 6, 6, 9450000, 661, 106);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (171, 79, 8, 8, 9500000, 62, 88);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (172, 101, 8, 5, 9550000, 555, 85);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (173, 51, 1, 3, 9600000, 36, 3);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (174, 191, 2, 5, 9650000, 92, 10);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (175, 63, 1, 7, 9700000, 815, 81);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (176, 144, 7, 1, 9750000, 73, 28);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (177, 159, 4, 7, 9800000, 754, 80);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (178, 163, 7, 8, 9850000, 67, 19);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (179, 53, 2, 7, 9900000, 48, 130);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (180, 158, 3, 8, 9950000, 90, 15);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (181, 80, 2, 3, 10000000, 670, 130);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (182, 119, 4, 6, 10050000, 687, 76);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (183, 188, 5, 7, 10100000, 805, 121);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (184, 114, 3, 4, 10150000, 760, 25);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (185, 189, 0, 2, 10200000, 610, 22);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (186, 145, 6, 5, 10250000, 723, 21);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (187, 38, 0, 2, 10300000, 764, 24);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (188, 104, 0, 6, 10350000, 757, 96);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (189, 89, 8, 1, 10400000, 515, 82);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (190, 183, 6, 6, 10450000, 611, 14);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (191, 165, 2, 3, 10500000, 75, 101);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (192, 88, 6, 7, 10550000, 684, 62);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (193, 180, 2, 2, 10600000, 729, 34);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (194, 108, 2, 2, 10650000, 43, 80);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (195, 118, 8, 6, 10700000, 641, 52);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (196, 90, 3, 1, 10750000, 569, 97);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (197, 78, 7, 3, 10800000, 680, 90);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (198, 144, 8, 8, 10850000, 40, 112);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (199, 86, 1, 4, 10900000, 732, 79);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (200, 41, 5, 6, 10950000, 735, 114);
commit;
prompt 200 records committed...
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (201, 114, 1, 6, 11000000, 790, 63);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (202, 91, 7, 6, 11050000, 662, 73);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (203, 138, 3, 7, 11100000, 529, 57);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (204, 71, 5, 5, 11150000, 661, 69);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (205, 194, 3, 3, 11200000, 539, 120);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (206, 134, 0, 3, 11250000, 793, 35);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (207, 79, 3, 7, 11300000, 770, 132);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (208, 41, 6, 4, 11350000, 579, 1);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (209, 107, 2, 7, 11400000, 30, 129);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (210, 102, 5, 8, 11450000, 550, 38);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (211, 95, 0, 1, 11500000, 751, 45);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (212, 57, 3, 5, 11550000, 509, 41);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (213, 98, 3, 6, 11600000, 559, 141);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (214, 195, 5, 7, 11650000, 608, 57);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (215, 171, 5, 7, 11700000, 626, 138);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (216, 152, 5, 6, 11750000, 30, 32);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (217, 62, 1, 2, 11800000, 13, 35);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (218, 131, 6, 6, 11850000, 572, 125);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (219, 76, 4, 7, 11900000, 615, 93);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (220, 113, 2, 2, 11950000, 718, 75);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (221, 189, 1, 7, 12000000, 755, 79);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (222, 167, 8, 6, 12050000, 783, 111);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (223, 42, 4, 7, 12100000, 16, 42);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (224, 109, 3, 5, 12150000, 56, 119);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (225, 148, 4, 1, 12200000, 689, 71);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (226, 169, 7, 6, 12250000, 547, 132);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (227, 78, 6, 2, 12300000, 100, 21);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (228, 121, 2, 5, 12350000, 501, 123);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (229, 55, 8, 5, 12400000, 646, 35);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (230, 102, 8, 5, 12450000, 610, 22);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (231, 191, 0, 1, 12500000, 17, 16);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (232, 101, 3, 4, 12550000, 744, 5);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (233, 52, 2, 4, 12600000, 780, 87);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (234, 75, 4, 4, 12650000, 556, 66);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (235, 46, 5, 3, 12700000, 581, 122);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (236, 144, 7, 4, 12750000, 749, 108);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (237, 142, 8, 5, 12800000, 715, 29);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (238, 170, 7, 5, 12850000, 45, 35);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (239, 82, 1, 7, 12900000, 783, 91);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (240, 124, 4, 4, 12950000, 547, 2);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (241, 70, 2, 4, 13000000, 8, 142);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (242, 128, 6, 1, 13050000, 513, 128);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (243, 142, 0, 8, 13100000, 57, 46);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (244, 39, 4, 5, 13150000, 511, 84);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (245, 144, 1, 5, 13200000, 727, 27);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (246, 73, 4, 2, 13250000, 88, 40);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (247, 106, 4, 8, 13300000, 23, 112);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (248, 102, 2, 4, 13350000, 612, 64);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (249, 128, 1, 4, 13400000, 772, 104);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (250, 56, 4, 7, 13450000, 501, 131);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (251, 42, 3, 7, 13500000, 50, 63);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (252, 180, 8, 3, 13550000, 755, 44);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (253, 95, 6, 3, 13600000, 6, 63);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (254, 168, 4, 7, 13650000, 777, 120);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (255, 175, 5, 1, 13700000, 530, 46);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (256, 112, 1, 8, 13750000, 585, 108);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (257, 125, 7, 6, 13800000, 616, 100);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (258, 131, 8, 6, 13850000, 605, 80);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (259, 158, 4, 5, 13900000, 35, 36);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (260, 68, 4, 7, 13950000, 679, 103);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (261, 62, 6, 8, 14000000, 745, 62);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (262, 43, 6, 2, 14050000, 666, 89);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (263, 77, 1, 3, 14100000, 593, 33);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (264, 189, 2, 2, 14150000, 763, 133);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (265, 86, 3, 4, 14200000, 96, 60);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (266, 46, 7, 6, 14250000, 671, 52);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (267, 192, 0, 8, 14300000, 784, 47);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (268, 105, 5, 7, 14350000, 77, 28);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (269, 145, 8, 2, 14400000, 534, 66);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (270, 183, 4, 2, 14450000, 743, 55);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (271, 63, 1, 4, 14500000, 710, 48);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (272, 59, 6, 7, 14550000, 605, 116);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (273, 101, 0, 7, 14600000, 570, 115);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (274, 194, 1, 2, 14650000, 6, 62);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (275, 124, 8, 7, 14700000, 5, 41);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (276, 51, 3, 4, 14750000, 41, 26);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (277, 108, 4, 5, 14800000, 669, 134);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (278, 48, 0, 8, 14850000, 74, 122);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (279, 111, 4, 1, 14900000, 586, 49);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (280, 164, 5, 4, 14950000, 746, 143);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (281, 67, 5, 7, 15000000, 733, 83);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (282, 62, 5, 3, 15050000, 643, 107);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (283, 64, 5, 6, 15100000, 670, 113);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (284, 136, 4, 6, 15150000, 621, 142);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (285, 170, 8, 1, 15200000, 722, 80);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (286, 101, 3, 6, 15250000, 807, 99);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (287, 102, 0, 2, 15300000, 652, 19);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (288, 40, 6, 3, 15350000, 505, 44);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (289, 82, 1, 7, 15400000, 553, 104);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (290, 45, 4, 6, 15450000, 783, 53);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (291, 155, 0, 5, 15500000, 579, 91);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (292, 51, 8, 7, 15550000, 614, 47);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (293, 59, 0, 3, 15600000, 788, 51);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (294, 84, 8, 2, 15650000, 6, 92);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (295, 51, 3, 5, 15700000, 687, 61);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (296, 57, 1, 7, 15750000, 587, 120);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (297, 116, 4, 8, 15800000, 715, 78);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (298, 198, 2, 8, 15850000, 739, 129);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (299, 190, 1, 8, 15900000, 735, 60);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (300, 84, 1, 3, 15950000, 743, 62);
commit;
prompt 300 records committed...
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (301, 81, 6, 2, 16000000, 627, 65);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (302, 39, 4, 1, 16050000, 603, 89);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (303, 48, 0, 7, 16100000, 566, 91);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (304, 156, 7, 6, 16150000, 37, 64);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (305, 177, 5, 5, 16200000, 92, 90);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (306, 192, 8, 2, 16250000, 724, 107);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (307, 131, 2, 4, 16300000, 651, 40);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (308, 127, 4, 3, 16350000, 29, 81);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (309, 105, 3, 2, 16400000, 730, 91);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (310, 142, 3, 6, 16450000, 643, 128);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (311, 80, 3, 4, 16500000, 625, 26);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (312, 71, 1, 5, 16550000, 768, 2);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (313, 87, 3, 3, 16600000, 501, 89);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (314, 142, 2, 8, 16650000, 536, 109);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (315, 178, 7, 5, 16700000, 698, 13);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (316, 154, 1, 6, 16750000, 73, 36);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (317, 63, 4, 8, 16800000, 659, 117);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (318, 38, 8, 3, 16850000, 800, 50);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (319, 79, 1, 5, 16900000, 776, 9);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (320, 142, 6, 6, 16950000, 779, 14);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (321, 89, 4, 3, 17000000, 655, 115);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (322, 70, 3, 7, 17050000, 45, 92);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (323, 199, 1, 8, 17100000, 708, 138);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (324, 106, 8, 7, 17150000, 34, 7);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (325, 63, 1, 8, 17200000, 596, 36);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (326, 65, 3, 1, 17250000, 813, 122);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (327, 195, 8, 7, 17300000, 98, 99);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (328, 187, 7, 4, 17350000, 513, 27);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (329, 57, 0, 1, 17400000, 40, 65);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (330, 67, 3, 1, 17450000, 731, 87);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (331, 70, 5, 4, 17500000, 719, 130);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (332, 41, 7, 1, 17550000, 750, 113);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (333, 140, 6, 2, 17600000, 581, 90);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (334, 96, 6, 4, 17650000, 759, 77);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (335, 96, 3, 5, 17700000, 536, 5);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (336, 170, 0, 8, 17750000, 37, 83);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (337, 35, 2, 8, 17800000, 696, 15);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (338, 125, 7, 3, 17850000, 743, 4);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (339, 76, 3, 1, 17900000, 76, 7);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (340, 47, 6, 6, 17950000, 799, 63);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (341, 139, 7, 7, 18000000, 16, 119);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (342, 98, 3, 1, 18050000, 584, 50);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (343, 199, 5, 2, 18100000, 23, 36);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (344, 113, 7, 1, 18150000, 707, 105);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (345, 63, 8, 6, 18200000, 603, 73);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (346, 145, 2, 3, 18250000, 800, 27);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (347, 156, 4, 5, 18300000, 634, 2);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (348, 69, 7, 8, 18350000, 43, 89);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (349, 78, 1, 8, 18400000, 645, 99);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (350, 198, 1, 6, 18450000, 4, 70);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (351, 55, 2, 2, 18500000, 638, 53);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (352, 110, 4, 8, 18550000, 587, 37);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (353, 145, 6, 1, 18600000, 767, 66);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (354, 136, 0, 2, 18650000, 661, 1);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (355, 68, 1, 3, 18700000, 651, 84);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (356, 185, 5, 4, 18750000, 48, 70);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (357, 146, 1, 1, 18800000, 20, 62);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (358, 63, 6, 8, 18850000, 704, 144);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (359, 30, 6, 3, 18900000, 618, 65);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (360, 82, 8, 8, 18950000, 505, 65);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (361, 176, 5, 1, 19000000, 670, 67);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (362, 70, 6, 5, 19050000, 46, 139);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (363, 113, 5, 3, 19100000, 54, 109);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (364, 113, 6, 7, 19150000, 515, 52);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (365, 143, 3, 4, 19200000, 617, 145);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (366, 181, 3, 1, 19250000, 818, 54);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (367, 131, 6, 3, 19300000, 544, 9);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (368, 160, 4, 1, 19350000, 62, 47);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (369, 191, 0, 2, 19400000, 560, 27);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (370, 103, 1, 3, 19450000, 609, 133);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (371, 32, 3, 1, 19500000, 72, 12);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (372, 193, 7, 3, 19550000, 806, 116);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (373, 95, 4, 3, 19600000, 502, 16);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (374, 73, 8, 3, 19650000, 649, 46);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (375, 91, 6, 7, 19700000, 650, 142);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (376, 116, 7, 8, 19750000, 671, 44);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (377, 59, 7, 8, 19800000, 627, 102);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (378, 112, 3, 3, 19850000, 617, 29);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (379, 187, 7, 3, 19900000, 38, 55);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (380, 61, 6, 2, 19950000, 646, 43);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (381, 149, 7, 8, 20000000, 87, 35);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (382, 102, 1, 3, 20050000, 659, 59);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (383, 186, 7, 6, 20100000, 564, 37);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (384, 110, 4, 1, 20150000, 667, 60);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (385, 177, 3, 6, 20200000, 28, 82);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (386, 108, 7, 2, 20250000, 45, 82);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (387, 48, 3, 8, 20300000, 720, 87);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (388, 158, 4, 5, 20350000, 742, 73);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (389, 94, 4, 2, 20400000, 507, 42);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (390, 53, 3, 7, 20450000, 502, 144);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (391, 49, 0, 3, 20500000, 759, 91);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (392, 144, 5, 1, 20550000, 611, 8);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (393, 73, 4, 7, 20600000, 634, 104);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (394, 131, 5, 3, 20650000, 760, 42);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (395, 162, 4, 5, 20700000, 760, 24);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (396, 96, 4, 2, 20750000, 62, 8);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (397, 49, 6, 1, 20800000, 754, 26);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (398, 105, 3, 5, 20850000, 530, 3);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (399, 110, 8, 6, 20900000, 681, 21);
insert into APARTMENT (apartment_id, apartment_size, num_floor, num_rooms, price, seller_id, city_id)
values (400, 143, 1, 2, 20950000, 657, 49);
commit;
prompt 400 records loaded
prompt Loading BUYER...
insert into BUYER (buyer_id, buyer_name, phone_number)
values (1, 'John Doe', 12345);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (2, 'Jane Doe', 67890);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (3, 'Max Smith', 54321);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (4, 'Ana Bell', 98765);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (5, 'Tom Fox', 13579);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (6, 'Sam King', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (7, 'Leo Cruz', 13579);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (8, 'Joe Wong', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (9, 'Ray Lee', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (10, 'Amy Kim', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (11, 'Eva Fox', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (12, 'Dan Lim', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (13, 'Mia Roy', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (14, 'Ivy Ma', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (15, 'Kai Lou', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (16, 'Zoe May', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (17, 'Ada Liu', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (18, 'Jay Ng', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (19, 'Kim Yu', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (20, 'Lia Wu', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (21, 'Max Li', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (22, 'Joe Qi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (23, 'Tim Ho', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (24, 'Eli Zhi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (25, 'Tom Du', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (26, 'Mia Fu', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (27, 'Joy Mo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (28, 'Ana Pu', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (29, 'Ray Tu', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (30, 'Sam Gu', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (31, 'Ada Ru', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (32, 'Leo Su', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (33, 'Eva Xu', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (34, 'Kai Yu', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (35, 'Zoe Wu', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (36, 'Jay Hu', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (37, 'Amy Ku', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (38, 'Joe Lu', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (39, 'Mia Mu', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (40, 'Dan Nu', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (41, 'Tim Ou', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (42, 'Eli Pi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (43, 'Tom Qi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (44, 'Joy Ri', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (45, 'Ray Si', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (46, 'Sam Ti', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (47, 'Ivy Ui', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (48, 'Ada Vi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (49, 'Leo Wi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (50, 'Eva Xi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (51, 'Kai Yi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (52, 'Zoe Zi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (53, 'Jay Ao', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (54, 'Amy Bo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (55, 'Joe Co', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (56, 'Mia Do', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (57, 'Dan Eo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (58, 'Tim Fo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (59, 'Eli Go', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (60, 'Tom Ho', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (61, 'Joy Io', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (62, 'Ray Jo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (63, 'Sam Ko', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (64, 'Ivy Lo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (65, 'Ada Mo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (66, 'Leo No', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (67, 'Eva Oo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (68, 'Kai Po', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (69, 'Zoe Qo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (70, 'Jay Ro', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (71, 'Amy So', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (72, 'Joe To', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (73, 'Mia Uo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (74, 'Dan Vo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (75, 'Tim Wo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (76, 'Eli Xo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (77, 'Tom Yo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (78, 'Joy Zo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (79, 'Ray Au', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (80, 'Sam Bu', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (81, 'Ivy Cu', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (82, 'Ada Du', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (83, 'Leo Eu', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (84, 'Eva Fu', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (85, 'Kai Gu', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (86, 'Zoe Hu', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (87, 'Jay Iu', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (88, 'Amy Ju', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (89, 'Joe Ku', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (90, 'Mia Lu', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (91, 'Dan Mu', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (92, 'Tim Nu', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (93, 'Eli Ou', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (94, 'Tom Pu', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (95, 'Joy Qu', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (96, 'Ray Ru', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (97, 'Sam Su', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (98, 'Ivy Tu', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (99, 'Ada Uu', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (100, 'Leo Vu', 86420);
commit;
prompt 100 records committed...
insert into BUYER (buyer_id, buyer_name, phone_number)
values (101, 'Eva Wu', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (102, 'Kai Xu', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (103, 'Zoe Yu', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (104, 'Jay Zu', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (105, 'Amy Ai', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (106, 'Joe Bi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (107, 'Mia Ci', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (108, 'Dan Di', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (109, 'Tim Ei', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (110, 'Eli Fi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (111, 'Tom Gi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (112, 'Joy Hi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (113, 'Ray Ii', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (114, 'Sam Ji', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (115, 'Ivy Ki', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (116, 'Ada Li', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (117, 'Leo Mi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (118, 'Eva Ni', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (119, 'Kai Oi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (120, 'Zoe Pi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (121, 'Jay Qi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (122, 'Amy Ri', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (123, 'Joe Si', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (124, 'Mia Ti', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (125, 'Dan Ui', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (126, 'Tim Vi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (127, 'Eli Wi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (128, 'Tom Xi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (129, 'Joy Yi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (130, null, null);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (131, 'Sam Ao', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (132, 'Ivy Bo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (133, 'Ada Co', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (134, 'Leo Do', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (135, 'Eva Eo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (136, 'Kai Fo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (137, 'Zoe Go', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (138, 'Jay Ho', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (139, 'Amy Io', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (140, 'Joe Jo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (141, 'Mia Ko', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (142, 'Dan Lo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (143, 'Tim Mo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (144, 'Eli No', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (145, 'Tom Oo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (146, 'Joy Po', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (147, 'Ray Qo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (148, 'Sam Ro', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (149, 'Ivy So', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (150, 'Ada To', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (151, 'Leo Uo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (152, 'Eva Vo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (153, 'Kai Wo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (154, 'Zoe Xo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (155, 'Jay Yo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (156, 'Amy Zo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (157, 'Joe Ai', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (158, 'Mia Bi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (159, 'Dan Ci', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (160, 'Tim Di', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (161, 'Eli Ei', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (162, 'Tom Fi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (163, 'Joy Gi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (164, 'Ray Hi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (165, 'Sam Ii', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (166, 'Ivy Ji', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (167, 'Ada Ki', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (168, 'Leo Li', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (169, 'Eva Mi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (170, 'Kai Ni', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (171, 'Zoe Oi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (172, 'Jay Pi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (173, 'Amy Qi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (174, 'Joe Ri', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (175, 'Mia Si', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (176, 'Dan Ti', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (177, 'Tim Ui', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (178, 'Eli Vi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (179, 'Tom Wi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (180, 'Joy Xi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (181, 'Ray Yi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (182, 'Sam Zi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (183, 'Ivy Ao', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (184, 'Ada Bo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (185, 'Leo Co', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (186, 'Eva Do', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (187, 'Kai Eo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (188, 'Zoe Fo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (189, 'Jay Go', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (190, 'Amy Ho', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (191, 'Joe Io', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (192, 'Mia Jo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (193, 'Dan Ko', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (194, 'Tim Lo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (195, 'Eli Mo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (196, 'Tom No', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (197, 'Joy Oo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (198, 'Ray Po', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (199, 'Sam Qo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (200, 'Ivy Ro', 97531);
commit;
prompt 200 records committed...
insert into BUYER (buyer_id, buyer_name, phone_number)
values (201, 'Ada So', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (202, 'Leo To', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (203, 'Eva Uo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (204, 'Kai Vo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (205, 'Zoe Wo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (206, 'Jay Xo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (207, 'Amy Yo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (208, 'Joe Zo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (209, 'Mia Ai', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (210, 'Dan Bi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (211, 'Tim Ci', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (212, 'Eli Di', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (213, 'Tom Ei', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (214, 'Joy Fi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (215, 'Ray Gi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (216, 'Sam Hi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (217, 'Ivy Ii', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (218, 'Ada Ji', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (219, 'Leo Ki', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (220, 'Eva Li', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (221, 'Kai Mi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (222, 'Zoe Ni', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (223, 'Jay Oi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (224, 'Amy Pi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (225, 'Joe Qi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (226, 'Mia Ri', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (227, 'Dan Si', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (228, 'Tim Ti', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (229, 'Eli Ui', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (230, 'Tom Vi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (231, 'Joy Wi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (232, 'Ray Xi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (233, 'Sam Yi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (234, 'Ivy Zi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (235, 'Ada Ao', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (236, 'Leo Bo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (237, 'Eva Co', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (238, 'Kai Do', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (239, 'Zoe Eo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (240, 'Jay Fo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (241, 'Amy Go', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (242, 'Joe Ho', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (243, 'Mia Io', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (244, 'Dan Jo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (245, 'Tim Ko', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (246, 'Eli Lo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (247, 'Tom Mo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (248, 'Joy No', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (249, 'Ray Oo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (250, 'Sam Po', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (251, 'Ivy Qo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (252, 'Ada Ro', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (253, 'Leo So', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (254, 'Eva To', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (255, 'Kai Uo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (256, 'Zoe Vo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (257, 'Jay Wo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (258, 'Amy Xo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (259, 'Joe Yo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (260, 'Mia Zo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (261, 'Dan Ai', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (262, 'Tim Bi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (263, 'Eli Ci', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (264, 'Tom Di', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (265, 'Joy Ei', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (266, 'Ray Fi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (267, 'Sam Gi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (268, 'Ivy Hi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (269, 'Ada Ii', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (270, 'Leo Ji', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (271, 'Eva Ki', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (272, 'Kai Li', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (273, 'Zoe Mi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (274, 'Jay Ni', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (275, 'Amy Oi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (276, 'Joe Pi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (277, 'Mia Qi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (278, 'Dan Ri', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (279, 'Tim Si', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (280, 'Eli Ti', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (281, 'Tom Ui', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (282, 'Joy Vi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (283, 'Ray Wi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (284, 'Sam Xi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (285, 'Ivy Yi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (286, 'Ada Zi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (287, 'Leo Ao', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (288, 'Eva Bo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (289, 'Kai Co', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (290, 'Zoe Do', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (291, 'Jay Eo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (292, 'Amy Fo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (293, 'Joe Go', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (294, 'Mia Ho', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (295, 'Dan Io', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (296, 'Tim Jo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (297, 'Eli Ko', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (298, 'Tom Lo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (299, 'Joy Mo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (300, 'Ray No', 13524);
commit;
prompt 300 records committed...
insert into BUYER (buyer_id, buyer_name, phone_number)
values (301, 'Sam Oo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (302, 'Ivy Po', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (303, 'Ada Qo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (304, 'Leo Ro', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (305, 'Eva So', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (306, 'Kai To', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (307, 'Zoe Uo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (308, 'Jay Vo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (309, 'Amy Wo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (310, 'Joe Xo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (311, 'Mia Yo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (312, 'Dan Zo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (313, 'Tim Ai', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (314, 'Eli Bi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (315, 'Tom Ci', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (316, 'Joy Di', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (317, 'Ray Ei', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (318, 'Sam Fi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (319, 'Ivy Gi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (320, 'Ada Hi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (321, 'Leo Ii', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (322, 'Eva Ji', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (323, 'Kai Ki', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (324, 'Zoe Li', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (325, 'Jay Mi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (326, 'Amy Ni', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (327, 'Joe Oi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (328, 'Mia Pi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (329, 'Dan Qi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (330, 'Tim Ri', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (331, 'Eli Si', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (332, 'Tom Ti', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (333, 'Joy Ui', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (334, 'Ray Vi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (335, 'Sam Wi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (336, 'Ivy Xi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (337, 'Ada Yi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (338, 'Leo Zi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (339, 'Eva Ao', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (340, 'Kai Bo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (341, 'Zoe Co', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (342, 'Jay Do', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (343, 'Amy Eo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (344, 'Joe Fo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (345, 'Mia Go', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (346, 'Dan Ho', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (347, 'Tim Io', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (348, 'Eli Jo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (349, 'Tom Ko', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (350, 'Joy Lo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (351, 'Ray Mo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (352, 'Sam No', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (353, 'Ivy Oo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (354, 'Ada Po', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (355, 'Leo Qo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (356, 'Eva Ro', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (357, 'Kai So', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (358, 'Zoe To', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (359, 'Jay Uo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (360, 'Amy Vo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (361, 'Joe Wo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (362, 'Mia Xo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (363, 'Dan Yo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (364, 'Tim Zo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (365, 'Eli Ai', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (366, 'Tom Bi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (367, 'Joy Ci', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (368, 'Ray Di', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (369, 'Sam Ei', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (370, 'Ivy Fi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (371, 'Ada Gi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (372, 'Leo Hi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (373, 'Eva Ii', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (374, 'Kai Ji', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (375, 'Zoe Ki', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (376, 'Jay Li', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (377, 'Amy Mi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (378, 'Joe Ni', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (379, 'Mia Oi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (380, 'Dan Pi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (381, 'Tim Qi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (384, 'Joy Ti', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (385, 'Ray Ui', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (386, 'Sam Vi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (387, 'Ivy Wi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (388, 'Ada Xi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (389, 'Leo Yi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (390, 'Eva Zi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (391, 'Kai Ao', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (392, 'Zoe Bo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (393, 'Jay Co', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (394, 'Amy Do', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (395, 'Joe Eo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (396, 'Mia Fo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (397, 'Dan Go', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (398, 'Tim Ho', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (399, 'Eli Io', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (400, 'Tom Jo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (401, 'Joy Ko', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (402, 'Ray Lo', 15973);
commit;
prompt 400 records committed...
insert into BUYER (buyer_id, buyer_name, phone_number)
values (403, 'Sam Mo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (404, 'Ivy No', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (405, 'Ada Oo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (406, 'Leo Po', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (407, 'Eva Qo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (408, 'Kai Ro', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (409, 'Zoe So', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (410, 'Jay To', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (411, 'Amy Uo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (412, 'Joe Vo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (413, 'Mia Wo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (414, 'Dan Xo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (415, 'Tim Yo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (416, 'Eli Zo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (417, 'Tom Ai', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (418, 'Joy Bi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (419, 'Ray Ci', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (420, 'Sam Di', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (421, 'Ivy Ei', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (422, 'Ada Fi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (423, 'Leo Gi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (424, 'Eva Hi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (425, 'Kai Ii', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (426, 'Zoe Ji', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (427, 'Jay Ki', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (428, 'Amy Li', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (429, 'Joe Mi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (430, 'Mia Ni', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (431, 'Dan Oi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (432, 'Tim Pi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (433, 'Eli Qi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (434, 'Tom Ri', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (435, 'Joy Si', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (436, 'Ray Ti', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (437, 'Sam Ui', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (438, 'Ivy Vi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (439, 'Ada Wi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (440, 'Leo Xi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (441, 'Eva Yi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (442, 'Kai Zi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (443, 'Zoe Ao', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (444, 'Jay Bo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (445, 'Amy Co', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (446, 'Joe Do', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (447, 'Mia Eo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (448, 'Dan Fo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (449, 'Tim Go', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (450, 'Eli Ho', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (451, 'Tom Io', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (452, 'Joy Jo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (453, 'Ray Ko', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (454, 'Sam Lo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (455, 'Ivy Mo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (456, 'Ada No', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (457, 'Leo Oo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (458, 'Eva Po', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (459, 'Kai Qo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (460, 'Zoe Ro', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (461, 'Jay So', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (462, 'Amy To', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (463, 'Joe Uo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (464, 'Mia Vo', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (465, 'Dan Wo', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (466, 'Tim Xo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (467, 'Eli Yo', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (468, 'Tom Zo', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (469, 'Joy Ai', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (470, 'Ray Bi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (471, 'Sam Ci', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (472, 'Ivy Di', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (473, 'Ada Ei', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (474, 'Leo Fi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (475, 'Eva Gi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (476, 'Kai Hi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (477, 'Zoe Ii', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (478, 'Jay Ji', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (479, 'Amy Ki', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (480, 'Joe Li', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (481, 'Mia Mi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (482, 'Dan Ni', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (483, 'Tim Oi', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (484, 'Eli Pi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (485, 'Tom Qi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (486, 'Joy Ri', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (487, 'Ray Si', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (488, 'Sam Ti', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (489, 'Ivy Ui', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (490, 'Ada Vi', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (491, 'Leo Wi', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (492, 'Eva Xi', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (493, 'Kai Yi', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (494, 'Zoe Zi', 24680);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (495, 'Jay Ao', 97531);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (496, 'Amy Bo', 75319);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (497, 'Joe Co', 86420);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (498, 'Mia Do', 15973);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (499, 'Dan Eo', 13524);
insert into BUYER (buyer_id, buyer_name, phone_number)
values (500, 'Tim Fo', 24680);
commit;
prompt 498 records loaded
prompt Loading VISIT...
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (1, to_date('28-02-2022', 'dd-mm-yyyy'), 18, 342, 100, 129);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (2, to_date('27-09-2010', 'dd-mm-yyyy'), 9, 162, 378, 22);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (3, to_date('22-07-2017', 'dd-mm-yyyy'), 18, 129, 261, 266);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (4, to_date('31-12-2001', 'dd-mm-yyyy'), 15, 94, 172, 110);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (5, to_date('12-12-2023', 'dd-mm-yyyy'), 12, 66, 137, 259);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (6, to_date('27-07-2011', 'dd-mm-yyyy'), 10, 235, 353, 348);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (7, to_date('15-11-2006', 'dd-mm-yyyy'), 9, 276, 438, 98);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (8, to_date('23-02-2009', 'dd-mm-yyyy'), 12, 356, 131, 191);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (9, to_date('22-04-2002', 'dd-mm-yyyy'), 13, 65, 273, 381);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (10, to_date('27-08-2001', 'dd-mm-yyyy'), 12, 56, 99, 144);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (11, to_date('02-01-2000', 'dd-mm-yyyy'), 11, 237, 404, 350);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (12, to_date('17-02-2021', 'dd-mm-yyyy'), 9, 91, 401, 308);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (13, to_date('16-04-2008', 'dd-mm-yyyy'), 14, 16, 24, 396);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (14, to_date('03-02-2023', 'dd-mm-yyyy'), 10, 285, 290, 260);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (15, to_date('21-04-2000', 'dd-mm-yyyy'), 15, 336, 389, 254);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (16, to_date('15-01-2015', 'dd-mm-yyyy'), 14, 369, 403, 180);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (17, to_date('24-04-2009', 'dd-mm-yyyy'), 14, 119, 496, 103);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (18, to_date('31-07-2007', 'dd-mm-yyyy'), 14, 210, 259, 209);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (19, to_date('22-06-2009', 'dd-mm-yyyy'), 10, 297, 147, 264);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (20, to_date('22-02-2002', 'dd-mm-yyyy'), 10, 104, 86, 81);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (21, to_date('16-05-2007', 'dd-mm-yyyy'), 16, 346, 401, 164);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (22, to_date('09-09-2023', 'dd-mm-yyyy'), 12, 128, 61, 134);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (23, to_date('20-07-2016', 'dd-mm-yyyy'), 18, 208, 90, 180);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (24, to_date('30-11-2008', 'dd-mm-yyyy'), 10, 296, 427, 295);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (25, to_date('27-05-2005', 'dd-mm-yyyy'), 14, 382, 4, 113);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (26, to_date('20-07-2018', 'dd-mm-yyyy'), 13, 264, 462, 21);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (27, to_date('06-09-2023', 'dd-mm-yyyy'), 15, 10, 190, 318);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (28, to_date('16-01-2015', 'dd-mm-yyyy'), 18, 357, 417, 170);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (29, to_date('05-04-2022', 'dd-mm-yyyy'), 10, 203, 110, 62);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (30, to_date('11-08-2022', 'dd-mm-yyyy'), 12, 235, 291, 395);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (31, to_date('19-10-2013', 'dd-mm-yyyy'), 9, 379, 72, 274);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (32, to_date('28-01-2004', 'dd-mm-yyyy'), 17, 158, 337, 267);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (33, to_date('14-05-2004', 'dd-mm-yyyy'), 18, 25, 66, 78);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (34, to_date('21-01-2016', 'dd-mm-yyyy'), 10, 346, 263, 48);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (35, to_date('28-04-2011', 'dd-mm-yyyy'), 13, 367, 357, 263);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (36, to_date('15-04-2000', 'dd-mm-yyyy'), 10, 345, 198, 4);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (37, to_date('25-03-2016', 'dd-mm-yyyy'), 9, 30, 394, 107);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (38, to_date('16-07-2005', 'dd-mm-yyyy'), 18, 109, 448, 40);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (39, to_date('26-12-2008', 'dd-mm-yyyy'), 13, 67, 443, 187);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (40, to_date('09-06-2019', 'dd-mm-yyyy'), 11, 367, 374, 74);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (41, to_date('23-11-2017', 'dd-mm-yyyy'), 10, 392, 305, 204);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (42, to_date('10-11-2001', 'dd-mm-yyyy'), 13, 287, 260, 117);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (43, to_date('23-12-2019', 'dd-mm-yyyy'), 11, 281, 489, 22);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (44, to_date('30-12-2010', 'dd-mm-yyyy'), 14, 157, 90, 249);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (45, to_date('06-07-2007', 'dd-mm-yyyy'), 13, 223, 465, 141);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (46, to_date('01-03-2003', 'dd-mm-yyyy'), 18, 52, 419, 192);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (47, to_date('07-06-2016', 'dd-mm-yyyy'), 11, 50, 104, 65);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (48, to_date('03-07-2019', 'dd-mm-yyyy'), 15, 311, 12, 52);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (49, to_date('29-01-2017', 'dd-mm-yyyy'), 18, 161, 479, 364);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (50, to_date('06-05-2022', 'dd-mm-yyyy'), 15, 150, 434, 30);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (51, to_date('01-07-2001', 'dd-mm-yyyy'), 11, 224, 217, 42);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (52, to_date('27-08-2006', 'dd-mm-yyyy'), 13, 114, 370, 286);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (53, to_date('26-07-2007', 'dd-mm-yyyy'), 16, 206, 248, 365);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (54, to_date('03-04-2011', 'dd-mm-yyyy'), 18, 270, 388, 380);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (55, to_date('30-12-2011', 'dd-mm-yyyy'), 13, 129, 366, 211);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (56, to_date('14-10-2005', 'dd-mm-yyyy'), 14, 51, 113, 335);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (57, to_date('10-06-2003', 'dd-mm-yyyy'), 14, 139, 416, 239);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (58, to_date('26-04-2020', 'dd-mm-yyyy'), 16, 102, 286, 107);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (59, to_date('24-11-2022', 'dd-mm-yyyy'), 12, 107, 176, 67);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (60, to_date('23-04-2014', 'dd-mm-yyyy'), 10, 343, 243, 205);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (61, to_date('04-11-2020', 'dd-mm-yyyy'), 12, 332, 266, 96);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (62, to_date('31-03-2002', 'dd-mm-yyyy'), 11, 96, 489, 347);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (63, to_date('09-09-2018', 'dd-mm-yyyy'), 9, 5, 474, 376);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (64, to_date('17-10-2019', 'dd-mm-yyyy'), 18, 362, 128, 17);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (65, to_date('07-06-2021', 'dd-mm-yyyy'), 12, 72, 106, 92);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (66, to_date('14-05-2018', 'dd-mm-yyyy'), 18, 392, 265, 57);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (67, to_date('27-09-2022', 'dd-mm-yyyy'), 12, 165, 89, 347);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (68, to_date('12-04-2009', 'dd-mm-yyyy'), 15, 263, 162, 135);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (69, to_date('24-01-2010', 'dd-mm-yyyy'), 14, 214, 184, 353);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (70, to_date('27-04-2004', 'dd-mm-yyyy'), 17, 138, 231, 177);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (71, to_date('06-11-2001', 'dd-mm-yyyy'), 11, 395, 23, 275);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (72, to_date('16-06-2009', 'dd-mm-yyyy'), 16, 277, 311, 33);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (73, to_date('19-06-2016', 'dd-mm-yyyy'), 18, 289, 458, 161);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (74, to_date('28-08-2009', 'dd-mm-yyyy'), 12, 268, 454, 167);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (75, to_date('12-01-2001', 'dd-mm-yyyy'), 10, 88, 281, 60);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (76, to_date('09-05-2019', 'dd-mm-yyyy'), 18, 8, 196, 86);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (77, to_date('17-12-2018', 'dd-mm-yyyy'), 17, 275, 14, 263);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (78, to_date('23-12-2007', 'dd-mm-yyyy'), 12, 154, 221, 352);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (79, to_date('02-10-2005', 'dd-mm-yyyy'), 11, 360, 311, 127);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (80, to_date('06-02-2015', 'dd-mm-yyyy'), 12, 178, 475, 178);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (81, to_date('04-06-2018', 'dd-mm-yyyy'), 15, 163, 191, 284);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (82, to_date('13-04-2012', 'dd-mm-yyyy'), 15, 211, 53, 23);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (83, to_date('15-08-2018', 'dd-mm-yyyy'), 18, 364, 95, 167);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (84, to_date('29-06-2020', 'dd-mm-yyyy'), 18, 169, 426, 331);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (85, to_date('25-07-2020', 'dd-mm-yyyy'), 10, 124, 472, 98);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (86, to_date('10-02-2012', 'dd-mm-yyyy'), 12, 252, 150, 135);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (87, to_date('13-10-2003', 'dd-mm-yyyy'), 11, 67, 70, 15);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (88, to_date('18-11-2002', 'dd-mm-yyyy'), 11, 395, 270, 238);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (89, to_date('04-09-2002', 'dd-mm-yyyy'), 16, 205, 415, 142);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (91, to_date('24-01-2006', 'dd-mm-yyyy'), 14, 245, 202, 287);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (92, to_date('19-01-2008', 'dd-mm-yyyy'), 14, 259, 359, 299);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (94, to_date('04-08-2017', 'dd-mm-yyyy'), 11, 212, 78, 270);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (95, to_date('12-01-2014', 'dd-mm-yyyy'), 9, 170, 113, 84);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (96, to_date('02-10-2017', 'dd-mm-yyyy'), 10, 136, 12, 54);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (97, to_date('02-08-2004', 'dd-mm-yyyy'), 14, 174, 323, 132);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (98, to_date('01-01-2015', 'dd-mm-yyyy'), 16, 286, 230, 386);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (99, to_date('18-01-2006', 'dd-mm-yyyy'), 14, 354, 337, 3);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (100, to_date('12-06-2003', 'dd-mm-yyyy'), 16, 312, 402, 3);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (101, to_date('21-07-2020', 'dd-mm-yyyy'), 12, 10, 404, 115);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (102, to_date('07-05-2016', 'dd-mm-yyyy'), 15, 137, 483, 18);
commit;
prompt 100 records committed...
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (103, to_date('28-06-2000', 'dd-mm-yyyy'), 18, 222, 391, 349);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (104, to_date('01-12-2007', 'dd-mm-yyyy'), 15, 348, 14, 111);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (105, to_date('18-07-2007', 'dd-mm-yyyy'), 10, 23, 95, 63);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (106, to_date('02-11-2001', 'dd-mm-yyyy'), 10, 231, 57, 364);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (107, to_date('03-04-2009', 'dd-mm-yyyy'), 10, 292, 426, 187);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (108, to_date('21-05-2020', 'dd-mm-yyyy'), 15, 393, 325, 389);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (109, to_date('02-11-2018', 'dd-mm-yyyy'), 12, 151, 244, 206);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (110, to_date('09-12-2023', 'dd-mm-yyyy'), 15, 27, 105, 109);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (111, to_date('22-08-2015', 'dd-mm-yyyy'), 10, 105, 451, 139);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (112, to_date('05-10-2016', 'dd-mm-yyyy'), 16, 92, 474, 246);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (113, to_date('19-06-2012', 'dd-mm-yyyy'), 9, 56, 401, 75);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (114, to_date('30-08-2002', 'dd-mm-yyyy'), 18, 17, 217, 342);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (115, to_date('07-10-2007', 'dd-mm-yyyy'), 15, 99, 118, 352);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (116, to_date('30-07-2014', 'dd-mm-yyyy'), 13, 48, 309, 206);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (117, to_date('30-08-2016', 'dd-mm-yyyy'), 9, 22, 261, 82);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (118, to_date('19-08-2011', 'dd-mm-yyyy'), 13, 278, 70, 23);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (119, to_date('18-08-2008', 'dd-mm-yyyy'), 9, 89, 303, 357);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (120, to_date('07-05-2022', 'dd-mm-yyyy'), 15, 53, 380, 85);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (121, to_date('26-10-2000', 'dd-mm-yyyy'), 17, 326, 104, 187);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (122, to_date('06-08-2001', 'dd-mm-yyyy'), 11, 219, 44, 139);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (123, to_date('13-12-2001', 'dd-mm-yyyy'), 14, 312, 243, 29);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (124, to_date('24-11-2008', 'dd-mm-yyyy'), 17, 68, 469, 212);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (125, to_date('28-12-2013', 'dd-mm-yyyy'), 9, 107, 38, 308);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (126, to_date('27-12-2001', 'dd-mm-yyyy'), 10, 308, 281, 397);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (127, to_date('24-11-2018', 'dd-mm-yyyy'), 10, 319, 196, 176);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (128, to_date('26-04-2000', 'dd-mm-yyyy'), 9, 365, 457, 7);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (129, to_date('19-02-2007', 'dd-mm-yyyy'), 11, 44, 99, 67);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (130, to_date('27-02-2023', 'dd-mm-yyyy'), 18, 294, 263, 4);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (131, to_date('08-11-2008', 'dd-mm-yyyy'), 11, 271, 153, 172);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (132, to_date('19-02-2010', 'dd-mm-yyyy'), 18, 186, 448, 291);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (133, to_date('05-03-2009', 'dd-mm-yyyy'), 17, 66, 291, 317);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (134, to_date('05-12-2015', 'dd-mm-yyyy'), 15, 100, 111, 155);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (135, to_date('27-04-2011', 'dd-mm-yyyy'), 10, 120, 290, 151);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (136, to_date('24-05-2018', 'dd-mm-yyyy'), 14, 371, 124, 231);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (137, to_date('09-01-2013', 'dd-mm-yyyy'), 17, 220, 310, 231);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (138, to_date('26-01-2011', 'dd-mm-yyyy'), 14, 88, 459, 9);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (139, to_date('03-02-2000', 'dd-mm-yyyy'), 13, 233, 478, 184);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (140, to_date('04-03-2005', 'dd-mm-yyyy'), 17, 287, 29, 310);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (141, to_date('17-09-2013', 'dd-mm-yyyy'), 15, 91, 331, 222);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (142, to_date('29-04-2015', 'dd-mm-yyyy'), 11, 285, 357, 361);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (143, to_date('04-11-2000', 'dd-mm-yyyy'), 17, 332, 244, 156);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (144, to_date('16-04-2002', 'dd-mm-yyyy'), 18, 303, 15, 23);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (145, to_date('11-09-2022', 'dd-mm-yyyy'), 12, 330, 346, 259);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (146, to_date('13-08-2014', 'dd-mm-yyyy'), 15, 276, 287, 171);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (147, to_date('25-03-2009', 'dd-mm-yyyy'), 10, 122, 293, 166);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (148, to_date('07-09-2012', 'dd-mm-yyyy'), 16, 361, 278, 285);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (149, to_date('09-07-2008', 'dd-mm-yyyy'), 13, 277, 163, 47);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (150, to_date('24-01-2009', 'dd-mm-yyyy'), 18, 336, 497, 2);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (151, to_date('21-08-2010', 'dd-mm-yyyy'), 18, 268, 208, 155);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (152, to_date('14-03-2013', 'dd-mm-yyyy'), 9, 85, 499, 240);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (153, to_date('17-12-2007', 'dd-mm-yyyy'), 13, 206, 315, 45);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (154, to_date('11-06-2010', 'dd-mm-yyyy'), 10, 121, 1, 88);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (155, to_date('11-09-2000', 'dd-mm-yyyy'), 15, 100, 190, 2);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (156, to_date('11-05-2022', 'dd-mm-yyyy'), 18, 364, 217, 286);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (157, to_date('11-09-2009', 'dd-mm-yyyy'), 14, 29, 251, 387);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (158, to_date('26-08-2010', 'dd-mm-yyyy'), 12, 91, 203, 94);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (159, to_date('21-09-2007', 'dd-mm-yyyy'), 13, 100, 221, 186);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (160, to_date('23-09-2004', 'dd-mm-yyyy'), 11, 65, 252, 384);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (161, to_date('05-10-2010', 'dd-mm-yyyy'), 16, 346, 287, 69);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (162, to_date('29-11-2007', 'dd-mm-yyyy'), 10, 164, 227, 110);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (163, to_date('23-02-2004', 'dd-mm-yyyy'), 11, 161, 245, 51);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (164, to_date('30-07-2013', 'dd-mm-yyyy'), 18, 12, 30, 61);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (165, to_date('12-10-2003', 'dd-mm-yyyy'), 11, 289, 447, 90);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (166, to_date('01-04-2015', 'dd-mm-yyyy'), 12, 206, 160, 111);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (167, to_date('13-02-2008', 'dd-mm-yyyy'), 18, 263, 12, 378);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (168, to_date('08-05-2019', 'dd-mm-yyyy'), 18, 72, 356, 196);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (169, to_date('10-03-2019', 'dd-mm-yyyy'), 13, 260, 424, 288);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (170, to_date('25-11-2005', 'dd-mm-yyyy'), 16, 232, 55, 36);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (171, to_date('17-05-2010', 'dd-mm-yyyy'), 18, 354, 410, 286);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (172, to_date('25-08-2005', 'dd-mm-yyyy'), 18, 102, 300, 382);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (173, to_date('12-07-2016', 'dd-mm-yyyy'), 17, 188, 53, 167);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (174, to_date('15-04-2020', 'dd-mm-yyyy'), 16, 327, 149, 339);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (175, to_date('28-06-2015', 'dd-mm-yyyy'), 17, 293, 211, 193);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (176, to_date('12-05-2008', 'dd-mm-yyyy'), 15, 393, 422, 160);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (177, to_date('24-12-2000', 'dd-mm-yyyy'), 17, 30, 251, 62);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (178, to_date('26-02-2017', 'dd-mm-yyyy'), 11, 377, 378, 126);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (179, to_date('08-09-2012', 'dd-mm-yyyy'), 14, 29, 288, 236);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (180, to_date('26-06-2019', 'dd-mm-yyyy'), 16, 152, 283, 120);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (181, to_date('07-03-2003', 'dd-mm-yyyy'), 12, 121, 73, 325);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (182, to_date('15-07-2017', 'dd-mm-yyyy'), 13, 192, 417, 160);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (183, to_date('08-04-2009', 'dd-mm-yyyy'), 12, 283, 469, 87);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (184, to_date('05-05-2019', 'dd-mm-yyyy'), 14, 281, 245, 149);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (185, to_date('22-07-2022', 'dd-mm-yyyy'), 15, 303, 107, 297);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (186, to_date('11-02-2016', 'dd-mm-yyyy'), 11, 337, 41, 46);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (187, to_date('25-10-2001', 'dd-mm-yyyy'), 10, 106, 344, 170);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (188, to_date('21-10-2022', 'dd-mm-yyyy'), 12, 371, 199, 247);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (189, to_date('16-03-2016', 'dd-mm-yyyy'), 16, 52, 89, 126);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (190, to_date('02-09-2004', 'dd-mm-yyyy'), 16, 48, 329, 256);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (191, to_date('26-04-2006', 'dd-mm-yyyy'), 17, 169, 473, 4);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (192, to_date('05-02-2007', 'dd-mm-yyyy'), 13, 385, 10, 176);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (193, to_date('08-07-2021', 'dd-mm-yyyy'), 17, 306, 222, 219);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (194, to_date('19-03-2002', 'dd-mm-yyyy'), 10, 325, 242, 137);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (195, to_date('13-04-2010', 'dd-mm-yyyy'), 17, 373, 493, 295);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (196, to_date('13-11-2002', 'dd-mm-yyyy'), 12, 349, 72, 357);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (197, to_date('07-08-2002', 'dd-mm-yyyy'), 13, 240, 312, 371);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (198, to_date('13-05-2016', 'dd-mm-yyyy'), 10, 11, 306, 338);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (199, to_date('18-01-2004', 'dd-mm-yyyy'), 11, 34, 379, 285);
insert into VISIT (visit_id, date_of_visit, hour_of_visit, apartment_id, buyer_id, agent_id)
values (200, to_date('12-02-2012', 'dd-mm-yyyy'), 17, 306, 496, 92);
commit;
prompt 198 records loaded
prompt Loading APARTMENT_SALE...
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (1, 1000000, 44698, to_date('14-07-2026', 'dd-mm-yyyy'), 46);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (2, 1050000, 73388, to_date('19-07-2026', 'dd-mm-yyyy'), 126);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (3, 1100000, 14796, to_date('07-02-2026', 'dd-mm-yyyy'), 166);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (4, 1150000, 60506, to_date('14-11-2026', 'dd-mm-yyyy'), 9);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (5, 1200000, 65104, to_date('26-01-2028', 'dd-mm-yyyy'), 15);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (6, 1250000, 50405, to_date('11-04-2026', 'dd-mm-yyyy'), 27);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (7, 1300000, 82798, to_date('07-12-2025', 'dd-mm-yyyy'), 50);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (8, 1350000, 43789, to_date('05-01-2026', 'dd-mm-yyyy'), 91);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (9, 1400000, 72713, to_date('21-11-2027', 'dd-mm-yyyy'), 75);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (10, 1450000, 39258, to_date('02-03-2028', 'dd-mm-yyyy'), 114);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (11, 1500000, 42907, to_date('18-06-2028', 'dd-mm-yyyy'), 107);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (12, 1550000, 76585, to_date('26-08-2027', 'dd-mm-yyyy'), 92);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (13, 1600000, 40701, to_date('17-01-2027', 'dd-mm-yyyy'), 186);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (14, 1650000, 43458, to_date('09-05-2028', 'dd-mm-yyyy'), 76);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (15, 1700000, 70360, to_date('14-11-2026', 'dd-mm-yyyy'), 20);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (16, 1750000, 21210, to_date('16-11-2027', 'dd-mm-yyyy'), 113);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (17, 1800000, 22114, to_date('28-05-2027', 'dd-mm-yyyy'), 11);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (18, 1850000, 51673, to_date('30-10-2025', 'dd-mm-yyyy'), 175);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (19, 1900000, 32297, to_date('01-08-2027', 'dd-mm-yyyy'), 159);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (20, 1950000, 67108, to_date('03-10-2027', 'dd-mm-yyyy'), 98);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (21, 2000000, 85074, to_date('26-12-2026', 'dd-mm-yyyy'), 153);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (22, 2050000, 43006, to_date('11-01-2026', 'dd-mm-yyyy'), 79);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (23, 2100000, 82564, to_date('17-03-2028', 'dd-mm-yyyy'), 163);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (24, 2150000, 74598, to_date('16-07-2025', 'dd-mm-yyyy'), 149);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (25, 2200000, 17137, to_date('21-04-2025', 'dd-mm-yyyy'), 100);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (26, 2250000, 67042, to_date('30-01-2027', 'dd-mm-yyyy'), 9);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (27, 2300000, 42194, to_date('06-12-2027', 'dd-mm-yyyy'), 56);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (28, 2350000, 11523, to_date('20-01-2026', 'dd-mm-yyyy'), 142);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (29, 2400000, 40988, to_date('22-07-2025', 'dd-mm-yyyy'), 177);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (30, 2450000, 19903, to_date('31-01-2026', 'dd-mm-yyyy'), 51);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (31, 2500000, 61862, to_date('08-05-2026', 'dd-mm-yyyy'), 75);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (32, 2550000, 74039, to_date('27-02-2027', 'dd-mm-yyyy'), 197);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (33, 2600000, 47701, to_date('03-03-2026', 'dd-mm-yyyy'), 59);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (34, 2650000, 37580, to_date('03-09-2027', 'dd-mm-yyyy'), 76);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (35, 2700000, 42531, to_date('28-11-2027', 'dd-mm-yyyy'), 79);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (36, 2750000, 62782, to_date('15-01-2028', 'dd-mm-yyyy'), 16);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (37, 2800000, 73837, to_date('02-05-2027', 'dd-mm-yyyy'), 8);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (38, 2850000, 47765, to_date('29-03-2026', 'dd-mm-yyyy'), 51);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (39, 2900000, 30554, to_date('27-11-2025', 'dd-mm-yyyy'), 72);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (40, 2950000, 85697, to_date('27-02-2025', 'dd-mm-yyyy'), 135);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (41, 3000000, 48613, to_date('18-01-2027', 'dd-mm-yyyy'), 95);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (42, 3050000, 81466, to_date('02-02-2026', 'dd-mm-yyyy'), 37);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (43, 3100000, 63483, to_date('21-03-2025', 'dd-mm-yyyy'), 194);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (44, 3150000, 38738, to_date('07-09-2026', 'dd-mm-yyyy'), 189);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (45, 3200000, 57411, to_date('29-03-2026', 'dd-mm-yyyy'), 98);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (46, 3250000, 85622, to_date('30-10-2028', 'dd-mm-yyyy'), 6);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (47, 3300000, 42822, to_date('19-09-2027', 'dd-mm-yyyy'), 185);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (48, 3350000, 55723, to_date('17-03-2025', 'dd-mm-yyyy'), 161);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (49, 3400000, 67848, to_date('17-07-2027', 'dd-mm-yyyy'), 3);
insert into APARTMENT_SALE (sale_id, final_cost, agent_fee, sign_date, visit_id)
values (50, 3450000, 77996, to_date('10-05-2026', 'dd-mm-yyyy'), 44);
commit;
prompt 50 records loaded
prompt Enabling foreign key constraints for APARTMENT...
alter table APARTMENT enable constraint SYS_C007132;
alter table APARTMENT enable constraint SYS_C007133;
prompt Enabling foreign key constraints for VISIT...
alter table VISIT enable constraint SYS_C007163;
alter table VISIT enable constraint SYS_C007164;
alter table VISIT enable constraint SYS_C007165;
prompt Enabling foreign key constraints for APARTMENT_SALE...
alter table APARTMENT_SALE enable constraint SYS_C007168;
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
