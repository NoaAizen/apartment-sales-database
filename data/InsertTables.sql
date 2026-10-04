insert into Seller values(999, 'Yosef Cohen', 12387);
insert into Seller values(998, 'Yakov Cohen', 12387);
insert into Seller values(997, 'Yuri Cohen', 12387);
insert into Seller values(996, 'Yisroel Cohen', 12387);
insert into Seller values(995, 'Yael Cohen', 12387);
insert into Seller values(994, 'Yirmi Cohen', 12387);
insert into Seller values(993, 'Yechiel Cohen', 12387);
insert into Seller values(992, 'Yari Cohen', 12387);
insert into Seller values(991, 'Yoel Cohen', 12387);
insert into Seller values(990, 'Yitzchak Cohen', 12387);
insert into Seller values(989, 'Yishmael Cohen', 12387);

insert into City values(919, 'Male', 133);
insert into City values(929, 'Sisero', 234);
insert into City values(939, 'Jamal', 445);
insert into City values(949, 'Impogo', 346);
insert into City values(959, 'New Deli', 236);
insert into City values(969, 'Yemen', 234);
insert into City values(979, 'Sinsera', 236);
insert into City values(989, 'Yamasukro', 127);
insert into City values(921, 'Temen', 123);
insert into City values(922, 'Shunami', 187);

insert into Buyer values(999,'Noa Nos',32452);
insert into Buyer values(789,'Noa Aizrncn',53222);
insert into Buyer values(778,'Ori Yajo',95458);
insert into Buyer values(983,'rachel  mag',54325);                                                            
insert into Buyer values(987,'shora mag',35452);
insert into Buyer values(678,'noa rnxd',93848);
insert into Buyer values(982,'rachel  aizen',64224);
insert into Buyer values(984,'ori yayay',12345);
insert into Buyer values(964,'ori yemen',12435);
insert into Buyer values(954,'ori yoni',12235);

insert into Apartment values(954,50,2,3,150000000, 999, 919);
insert into Apartment values(953,54,0,3,150000000, 998, 929);
insert into Apartment values(952,30,7,1,150000000, 997, 939);
insert into Apartment values(951,20,1,1,100000000, 996, 949);
insert into Apartment values(950,65,1,2,300000000, 995, 959);
insert into Apartment values(949,36,1,1,150000000, 994, 969);
insert into Apartment values(948,90,2,3,350000000, 993, 979);
insert into Apartment values(947,62,0,3,200000000, 992, 989);
insert into Apartment values(946,48,3,2,250000000, 991, 921);
insert into Apartment values(945,63,1,3,350000000, 990, 922);

insert into Agent_Person values(999, 'Shimmy Brown', 12347);
insert into Agent_Person values(998, 'Vicky Gee', 12347);
insert into Agent_Person values(997, 'Dudi Cohen', 11287);
insert into Agent_Person values(996, 'Rikki Gold', 12387);
insert into Agent_Person values(995, 'Bonnie Field', 12287);
insert into Agent_Person values(994, 'Sam Smith', 23387);
insert into Agent_Person values(993, 'Mike Wazowski', 12187);
insert into Agent_Person values(992, 'Molly Weasley', 12237);
insert into Agent_Person values(991, 'Ronald McDonald', 12323);
insert into Agent_Person values(990, 'Sam McSam', 43387);

insert into Visit values(980, TO_DATE('2014-05-03', 'YYYY-MM-DD'), 12, 954, 999, 999);
insert into Visit values(981, TO_DATE('2012-04-12', 'YYYY-MM-DD'), 10, 953, 789, 998);
insert into Visit values(982, TO_DATE('2013-02-11', 'YYYY-MM-DD'), 15, 952, 778, 997);
insert into Visit values(983, TO_DATE('2007-01-10', 'YYYY-MM-DD'), 11, 951, 983, 996);
insert into Visit values(984, TO_DATE('2004-02-23', 'YYYY-MM-DD'), 11, 950, 987, 995);
insert into Visit values(985, TO_DATE('2003-03-21', 'YYYY-MM-DD'), 10, 949, 678, 994);
insert into Visit values(986, TO_DATE('2002-04-22', 'YYYY-MM-DD'), 14, 948, 983, 993);
insert into Visit values(987, TO_DATE('2012-05-21', 'YYYY-MM-DD'), 12, 947, 984, 992);
insert into Visit values(988, TO_DATE('2014-04-12', 'YYYY-MM-DD'), 14, 946, 964, 991);
insert into Visit values(989, TO_DATE('2013-05-12', 'YYYY-MM-DD'), 12, 945, 954, 990);

insert into Apartment_Sale values(924,150000000, 19919, TO_DATE('2025-02-12', 'YYYY-MM-DD'), 980);
insert into Apartment_Sale values(923,150000000, 19929, TO_DATE('2024-01-11', 'YYYY-MM-DD'), 981);
insert into Apartment_Sale values(922,150000000, 19939, TO_DATE('2026-06-22', 'YYYY-MM-DD'), 982);
insert into Apartment_Sale values(921,100000000, 19949, TO_DATE('2027-09-24', 'YYYY-MM-DD'), 983);
insert into Apartment_Sale values(930,300000000, 10159, TO_DATE('2026-10-25', 'YYYY-MM-DD'), 984);
insert into Apartment_Sale values(939,150000000, 19969, TO_DATE('2025-11-07', 'YYYY-MM-DD'), 985);
insert into Apartment_Sale values(938,350000000, 20979, TO_DATE('2025-05-09', 'YYYY-MM-DD'), 986);
insert into Apartment_Sale values(937,200000000, 29989, TO_DATE('2026-04-07', 'YYYY-MM-DD'), 987);
insert into Apartment_Sale values(936,250000000, 29921, TO_DATE('2027-01-02', 'YYYY-MM-DD'), 988);
insert into Apartment_Sale values(935,6350000000, 29922, TO_DATE('2028-06-01', 'YYYY-MM-DD'), 989);

Commit; 
