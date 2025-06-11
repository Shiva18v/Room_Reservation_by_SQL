
----- HOTEL RESERVATION SYSTEM---

-- create database
create database Hotel_Reservation;



 ---------------------------creating tables-------------------------


-- Creating the Guests table

--guest table
drop table if exists guests;
Create Table guests(
    guest_id INT identity(1,1) Primary Key,
    first_Name Varchar(255)not null,
    last_Name Varchar(255) not null,
    contact_Number varchar(20) unique,
    email Varchar(255) CONSTRAINT CK_EmailAtSymbol CHECK (Email LIKE '%@%'),
    address varchar(255)
);

-- reservation table
drop table if exists reservation;
create table reservation(
reservation_ID INT identity(1,1) PRIMARY KEY,
guest_id INT not null,
room_id INT not null,
check_In_Date DATE not null,
check_Out_Date DATE not null,
number_Of_guests INT not null,
reservation_date DATE not null,
total_amount DECIMAL(10,2),
payment_status VARCHAR(75),
CONSTRAINT CK_PaymentStatus CHECK (payment_status IN ('Paid', 'Pending', 'Cancelled')),
CONSTRAINT CK_CheckInOutDates CHECK (check_Out_Date > check_In_Date), 
CONSTRAINT CK_no_Guests CHECK (number_Of_guests > 0),
CONSTRAINT CK_Amount CHECK (total_amount >= 0), 
);


ALTER TABLE payment
ALTER COLUMN payment_date date; 


-- payment table
drop table if exists payment;
create table payment (
payment_id varchar(75) PRIMARY KEY,
reservation_id INT not null,
payment_date DATE not null,
payment_amount DECIMAl(10,2) not null,
payment_method VARCHAR(75) not null,
CONSTRAINT CK_PaymentAmount CHECK (payment_amount >= 0),
CONSTRAINT CK_PaymentMethod CHECK (payment_method IN ('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Cash'))
);


---room table 
drop table if exists room;
create table room(
room_id INT identity(1,1) PRIMARY KEY,
room_number VARCHAR(75) not null unique,
room_type VARCHAR(75) not null,
price DECIMAL(10,2) not null,
availability bit not null,
CONSTRAINT CK_Price CHECK (price >= 0), 
CONSTRAINT CK_RoomType CHECK (room_type IN ('Single', 'Double', 'Suite'))
);

--room facilities table
drop table if exists room_facilities;
create table room_facilities(
room_id INT not null,
facilities_id INT not null, 
PRIMARY KEY (room_id, facilities_id)
);

--facilities table

drop table if exists facilities;
create table facilities(
facilities_id INT PRIMARY KEY,
facilities_Name VARCHAR(255) not null

);



 ------relationship between table by foreign key-------


 alter table reservation
 Add constraint fk_guests foreign key (guest_id) references guests(guest_id);
  

  alter table reservation
 Add constraint fk_room foreign key (room_id) references room(room_id);


 alter table payment
 Add constraint fk_reservation foreign key (reservation_id) references reservation(reservation_id);


 alter table room_facilities
 Add constraint fk_room_facilities foreign key (room_id) references room(room_id);



 alter table room_facilities
 Add constraint fk_facilities foreign key (facilities_id) references facilities(facilities_id);




 --------------------data of tables -------------

 INSERT INTO guests( first_Name, last_Name, contact_Number, email, address) VALUES

    ('Aaras', 'Sharma', '91-9876543210', 'aarav.sharma@email.com', '10 MG Road, Bangalore, Karnataka'),
    ('Dida', 'Verma', '91-8765432109', 'diya.verma@email.com', '22 Linking Road, Bangalore, Karnataka'),
    ('Rosan', 'Gupta', '91-7654321098', 'rohan.gupta@email.com', '33 Park Street, Bangalore, Karnataka'),
    ('Sima', 'Singh', '91-6543210987', 'siya.singh@email.com', '44 Residency Road, Bangalore, Karnataka'),
    ('Ajun', 'Reddy', '91-5432109876', 'arjun.reddy@email.com', '55 Koramangala, Bangalore, Karnataka'),
    ('Aarav', 'Varma', '91-9806543210', 'aaav.sharma@email.com', '10 MG Road, Bangalore, Karnataka'),
    ('Diya', 'Verma', '91-8700432109', 'diya.verma@email.com', '22 Linking Road, Bangalore, Karnataka'),
    ('Rohan', 'Gupta', '91-7653321098', 'rohan.gupta@email.com', '33 Park Street, Bangalore, Karnataka'),
    ('Siya', 'Singh', '91-6543210907', 'siya.singh@email.com', '44 Residency Road, Bangalore, Karnataka'),
    ('Arjun', 'Reddy', '91-5402109876', 'arjun.reddy@email.com', '55 Koramangala, Bangalore, Karnataka'),
    ('Anika', 'Joshi', '91-4321098765', 'anika.joshi@email.com', '66 Jayanagar, Bangalore, Karnataka'),
    ('Vivaan', 'Mehta', '91-3210987654', 'vivaan.mehta@email.com', '77 Indiranagar, Bangalore, Karnataka'),
    ('Ishika', 'Nair', '91-2109876543', 'ishika.nair@email.com', '88 Whitefield, Bangalore, Karnataka'),
    ('Aryan', 'Patel', '91-1098765432', 'aryan.patel@email.com', '99 Malleshwaram, Bangalore, Karnataka'),
    ('Myra', 'Kumar', '91-9987654321', 'myra.kumar@email.com', '100 Hebbal, Bangalore, Karnataka'),
    ('Kabir', 'Rao', '91-8876543210', 'kabir.rao@email.com', '101 Bannerghatta Road, Bangalore, Karnataka'),
    ('Shanaya', 'Khan', '91-7765432109', 'shanaya.khan@email.com', '102 Richmond Road, Bangalore, Karnataka'),
    ('Neil', 'Das', '91-6654321098', 'neil.das@email.com', '103 Brigade Road, Bangalore, Karnataka'),
    ('Kaira', 'Roy', '91-5543210987', 'kaira.roy@email.com', '104 Lavelle Road, Bangalore, Karnataka'),
    ('Dhruv', 'Menon', '91-4432109876', 'dhruv.menon@email.com', '105 Cunningham Road, Bangalore, Karnataka'),
    ('Aahana', 'Pillai', '91-3321098765', 'aahana.pillai@email.com', '106 Bellary Road, Bangalore, Karnataka'),
    ('Advait', 'Jain', '91-2210987654', 'advait.jain@email.com', '107 Kasturba Road, Bangalore, Karnataka'),
    ('Ananya', 'Patil', '91-1109876543', 'ananya.patil@email.com', '108 Residency Crescent, Bangalore, Karnataka'),
    ('Vihaan', 'Choudhary', '91-9098765432', 'vihaan.choudhary@email.com', '109 Church Street, Bangalore, Karnataka'),
    ('Saanvi', 'Soni', '91-8087654321', 'saanvi.soni@email.com', '110 St. Marks Road, Bangalore, Karnataka'),
    ('Reyansh', 'Tiwari', '91-7076543210', 'reyansh.tiwari@email.com', '111 MG Road, Bangalore, Karnataka'),
    ('Kiara', 'Pandey', '91-6065432109', 'kiara.pandey@email.com', '112 Commercial Street, Bangalore, Karnataka'),
    ('Agastya', 'Mishra', '91-5054321098', 'agastya.mishra@email.com', '113 Dickenson Road, Bangalore, Karnataka'),
    ('Aadya', 'Tripathi', '91-4043210987', 'aadya.tripathi@email.com', '114 Museum Road, Bangalore, Karnataka'),
    ('Kabir', 'Srivastava', '91-3032109876', 'kabir.srivastava@email.com', '115 Infantry Road, Bangalore, Karnataka'),
    ('Ira', 'Dubey', '91-2021098765', 'ira.dubey@email.com', '116 Palace Road, Bangalore, Karnataka'),
    ('Atharv', 'Yadav', '91-1019876543', 'atharv.yadav@email.com', '117 Race Course Road, Bangalore, Karnataka'),
    ('Aarohi', 'Varma', '91-9198765432', 'aarohi.varma@email.com', '118 High Grounds, Bangalore, Karnataka'),
    ('Parth', 'Kulkarni', '91-8187654321', 'parth.kulkarni@email.com', '119 Benson Town, Bangalore, Karnataka'),
    ('Anvi', 'Desai', '91-7176543210', 'anvi.desai@email.com', '120 Fraser Town, Bangalore, Karnataka'),
    ('Ishaan', 'Rawat', '91-6165432109', 'ishaan.rawat@email.com', '121 Richards Town, Bangalore, Karnataka'),
    ('Samaira', 'Chauhan', '91-5154321098', 'samaira.chauhan@email.com', '122 Cox Town, Bangalore, Karnataka'),
    ('Yuvraj', 'Malik', '91-4143210987', 'yuvraj.malik@email.com', '123 Shivaji Nagar, Bangalore, Karnataka'),
    ('Aaradhya', 'Gill', '91-3132109876', 'aaradhya.gill@email.com', '124 Ulsoor, Bangalore, Karnataka'),
    ('Shaurya', 'Bhatt', '91-2121098765', 'shaurya.bhatt@email.com', '125 Halasuru, Bangalore, Karnataka'),
    ('Aarna', 'Rana', '91-1119876543', 'aarna.rana@email.com', '126 Domlur, Bangalore, Karnataka'),
    ('Kiaan', 'Kapoor', '91-9298765432', 'kiaan.kapoor@email.com', '127 Jeevanbhima Nagar, Bangalore, Karnataka'),
    ('Aanya', 'Seth', '91-8287654321', 'aanya.seth@email.com', '128 BTM Layout, Bangalore, Karnataka'),
    ('Zayan', 'Qureshi', '91-7276543210', 'zayan.qureshi@email.com', '129 HSR Layout, Bangalore, Karnataka'),
    ('Aaditri', 'Bajaj', '91-6265432109', 'aaditri.bajaj@email.com', '130 Marathahalli, Bangalore, Karnataka'),
    ('Divit', 'Khatri', '91-5254321098', 'divit.khatri@email.com', '131 Bellandur, Bangalore, Karnataka'),
    ('Hriday', 'Chakraborty', '91-4243210987', 'hriday.chakraborty@email.com', '132 Sarjapur Road, Bangalore, Karnataka'),
    ('Kyra', 'Narayanan', '91-3232109876', 'kyra.narayanan@email.com', '133 Electronic City, Bangalore, Karnataka'),
    ('Rehaan', 'Kashyap', '91-2221098765', 'rehaan.kashyap@email.com', '134 Yelahanka, Bangalore, Karnataka'),
    ('Miraya', 'Thakur', '91-1219876543', 'miraya.thakur@email.com', '135 Devanahalli, Bangalore, Karnataka'),
    ('Rishaan', 'Mathur', '91-9398765432', 'rishaan.mathur@email.com', '136 RT Nagar, Bangalore, Karnataka'),
    ('Aarush', 'Rathore', '91-8387654321', 'aarush.rathore@email.com', '137 Vidyaranyapura, Bangalore, Karnataka'),
    ('Anika', 'Mishra', '91-7376543210', 'anika.mishra@email.com', '138 Rajarajeshwari Nagar, Bangalore, Karnataka'),
    ('Ishaan', 'Tripathi', '91-6365432109', 'ishaan.tripathi@email.com', '139 Vijayanagar, Bangalore, Karnataka'),
    ('Siya', 'Srivastava', '91-5354321098', 'siya.srivastava@email.com', '140 Basaveshwaranagar, Bangalore, Karnataka'),
    ('Vihaan', 'Dubey', '91-4343210987', 'vihaan.dubey@email.com', '141 Yeshwanthpur, Bangalore, Karnataka'),
    ('Aarav', 'Yadav', '91-3332109876', 'aarav.yadav@email.com', '142 Peenya, Bangalore, Karnataka'),
    ('Diya', 'Varma', '91-2321098765', 'diya.varma@email.com', '143 Jalahalli, Bangalore, Karnataka'),
    ('Rohan', 'Kulkarni', '91-1319876543', 'rohan.kulkarni@email.com', '144 Mathikere, Bangalore, Karnataka'),
    ('Siya', 'Desai', '91-9498765432', 'siya.desai@email.com', '145 Hebbal Kempapura, Bangalore, Karnataka'),
    ('Arjun', 'Rawat', '91-8487654321', 'arjun.rawat@email.com', '146 Kodihalli, Bangalore, Karnataka'),
    ('Anika', 'Chauhan', '91-7476543210', 'anika.chauhan@email.com', '147 Murgesh Pallya, Bangalore, Karnataka'),
    ('Vivaan', 'Malik', '91-6465432109', 'vivaan.malik@email.com', '148 HAL Airport Road, Bangalore, Karnataka'),
    ('Ishika', 'Gill', '91-5454321098', 'ishika.gill@email.com', '149 Vimanapura, Bangalore, Karnataka'),
    ('Aryan', 'Bhatt', '91-4443210987', 'aryan.bhatt@email.com', '150 Hoodi, Bangalore, Karnataka'),
    ('Myra', 'Rana', '91-3432109876', 'myra.rana@email.com', '151 KR Puram, Bangalore, Karnataka'),
    ('Kabir', 'Kapoor', '91-2421098765', 'kabir.kapoor@email.com', '152 Kadugodi, Bangalore, Karnataka'),
    ('Shanaya', 'Seth', '91-1419876543', 'shanaya.seth@email.com', '153 Whitefield Hope Farm, Bangalore, Karnataka'),
    ('Neil', 'Qureshi', '91-9598765432', 'neil.qureshi@email.com', '154 Ramagondanahalli, Bangalore, Karnataka'),
    ('Kaira', 'Bajaj', '91-8587654321', 'kaira.bajaj@email.com', '155 Seegehalli, Bangalore, Karnataka'),
    ('Dhruv', 'Khatri', '91-7576543210', 'dhruv.khatri@email.com', '156 Immadihalli, Bangalore, Karnataka'),
    ('Aahana', 'Chakraborty', '91-6565432109', 'aahana.chakraborty@email.com', '157 Panathur, Bangalore, Karnataka'),
    ('Advait', 'Narayanan', '91-5554321098', 'advait.narayanan@email.com', '158 Gunjur, Bangalore, Karnataka'),
    ('Ananya', 'Kashyap', '91-4543210987', 'ananya.kashyap@email.com', '159 Varthur, Bangalore, Karnataka'),
    ('Vihaan', 'Thakur', '91-3532109876', 'vihaan.thakur@email.com', '160 Balagere, Bangalore, Karnataka'),
    ('Saanvi', 'Mathur', '91-2521098765', 'saanvi.mathur@email.com', '161 Doddakannelli, Bangalore, Karnataka'),
    ('Reyansh', 'Rathore', '91-1519876543', 'reyansh.rathore@email.com', '162 Hosa Road, Bangalore, Karnataka'),
    ('Kiara', 'Mishra', '91-9698765432', 'kiara.mishra@email.com', '163 Chandapura, Bangalore, Karnataka'),
    ('Agastya', 'Tripathi', '91-8687654321', 'agastya.tripathi@email.com', '164 Attibele, Bangalore, Karnataka'),
    ('Aadya', 'Srivastava', '91-7676543210', 'aadya.srivastava@email.com', '165 Jigani, Bangalore, Karnataka'),
    ('Kabir', 'Dubey', '91-6665432109', 'kabir.dubey@email.com', '166 Bommasandra, Bangalore, Karnataka'),
    ('Ira', 'Yadav', '91-5654321098', 'ira.yadav@email.com', '167 Hebbagodi, Bangalore, Karnataka'),
    ('Atharv', 'Varma', '91-4643210987', 'atharv.varma@email.com', '168 Electronic City Phase 2, Bangalore, Karnataka'),
    ('Aarohi', 'Kulkarni', '91-3632109876', 'aarohi.kulkarni@email.com', '169 Kammasandra, Bangalore, Karnataka'),
    ('Parth', 'Desai', '91-2621098765', 'parth.desai@email.com', '170 Anekal, Bangalore, Karnataka'),
    ('Anvi', 'Rawat', '91-1619876543', 'anvi.rawat@email.com', '171 Sarjapura Attibele Road, Bangalore, Karnataka'),
    ('Ishaan', 'Chauhan', '91-9798765432', 'ishaan.chauhan@email.com', '172 Hoskote, Bangalore, Karnataka'),
    ('Samaira', 'Malik', '91-8787654321', 'samaira.malik@email.com', '173 Devanahalli Airport Road, Bangalore, Karnataka'),
    ('Yuvraj', 'Gill', '91-7776543210', 'yuvraj.gill@email.com', '174 Doddaballapur, Bangalore, Karnataka'),
    ('Aaradhya', 'Bhatt', '91-6765432109', 'aaradhya.bhatt@email.com', '175 Nelamangala, Bangalore, Karnataka'),
    ('Shaurya', 'Rana', '91-5754321098', 'shaurya.rana@email.com', '176 Magadi, Bangalore, Karnataka'),
    ('Aarna', 'Kapoor', '91-4743210987', 'aarna.kapoor@email.com', '177 Ramanagara, Bangalore, Karnataka'),
    ('Kiaan', 'Seth', '91-3732109876', 'kiaan.seth@email.com', '178 Channapatna, Bangalore, Karnataka'),
    ('Aanya', 'Qureshi', '91-2721098765', 'aanya.qureshi@email.com', '179 Kanakapura, Bangalore, Karnataka'),
    ('Zayan', 'Bajaj', '91-1719876543', 'zayan.bajaj@email.com', '180 Malur, Bangalore, Karnataka'),
    ('Aaditri', 'Khatri', '91-9898765432', 'aaditri.khatri@email.com', '181 Hosur Road Junction, Bangalore, Karnataka'),
    ('Divit', 'Chakraborty', '91-8887654321', 'divit.chakraborty@email.com', '182 Silk Board Junction, Bangalore, Karnataka'),
    ('Hriday', 'Narayanan', '91-7876543210', 'hriday.narayanan@email.com', '183 Marathahalli Junction, Bangalore, Karnataka'),
    ('Kyra', 'Kashyap', '91-6865432109', 'kyra.kashyap@email.com', '184 KR Puram Railway Station, Bangalore, Karnataka'),
    ('Rehaan', 'Thakur', '91-5854321098', 'rehaan.thakur@email.com', '185 Whitefield Railway Station, Bangalore, Karnataka');
select *from guests;




INSERT INTO room( room_number, room_type, price, availability) VALUES
    ('101', 'Single', 100.00, 1),
    ('102', 'Double', 150.00, 1),
    ('103', 'Suite', 250.00, 1),
    ('201', 'Single', 110.00, 1),
    ('202', 'Double', 160.00, 1),
    ('203', 'Suite', 270.00, 1),
    ('301', 'Single', 120.00, 1),
    ('302', 'Double', 170.00, 1),
    ('303', 'Suite', 290.00, 1),
    ('401', 'Single', 130.00, 1),
    ('402', 'Double', 180.00, 1),
    ('403', 'Suite', 310.00, 1),
    ('501', 'Single', 140.00, 1),
    ('502', 'Double', 190.00, 1),
    ('503', 'Suite', 330.00, 1),
    ('601', 'Single', 150.00, 1),
    ('602', 'Double', 200.00, 1),
    ('603', 'Suite', 350.00, 1),
    ('701', 'Single', 160.00, 1),
    ('702', 'Double', 210.00, 1),
    ('703', 'Suite', 370.00, 1),
    ('801', 'Single', 170.00, 1),
    ('802', 'Double', 220.00, 1),
    ('803', 'Suite', 390.00, 1),
    ('901', 'Single', 180.00, 1),
    ('902', 'Double', 230.00, 1),
    ('903', 'Suite', 410.00, 1),
    ('1001', 'Single', 190.00, 1),
    ('1002', 'Double', 240.00, 1),
    ('1003', 'Suite', 430.00, 1),
    ('1101', 'Single', 200.00, 1),
    ('1102', 'Double', 250.00, 1),
    ('1103', 'Suite', 450.00, 1),
    ('1201', 'Single', 210.00, 1),
    ('1202', 'Double', 260.00, 1),
    ('1203', 'Suite', 470.00, 1),
    ('1301', 'Single', 220.00, 1),
    ('1302', 'Double', 270.00, 1),
    ('1303', 'Suite', 490.00, 1),
    ('1401', 'Single', 230.00, 1),
    ('1402', 'Double', 280.00, 1),
    ('1403', 'Suite', 510.00, 1),
    ('1501', 'Single', 240.00, 1),
    ('1502', 'Double', 290.00, 1),
    ('1503', 'Suite', 530.00, 1),
    ('1601', 'Single', 250.00, 1),
    ('1602', 'Double', 300.00, 1),
    ('1603', 'Suite', 550.00, 1),
    ('1701', 'Single', 260.00, 1),
    ('1702', 'Double', 310.00, 1);
select *from room;


INSERT INTO reservation (guest_id, room_id, check_In_Date, check_Out_Date, number_Of_guests, reservation_date, total_amount, payment_status)
VALUES
  
    (1, 1, '2025-01-05', '2025-01-10', 2, '2024-12-20 09:00:00', 550.00, 'Paid'),
    (2, 2, '2025-01-08', '2025-01-12', 1, '2024-12-23 11:00:00', 400.00, 'Pending'),
    (3, 3, '2025-01-12', '2025-01-15', 3, '2024-12-26 13:00:00', 800.00, 'Paid'),
    (4, 4, '2025-01-15', '2025-01-18', 2, '2024-12-29 15:00:00', 450.00, 'Paid'),
    (5, 5, '2025-01-18', '2025-01-22', 1, '2025-01-01 17:00:00', 300.00, 'Pending'),
    (6, 6, '2025-01-22', '2025-01-25', 2, '2025-01-04 19:00:00', 650.00, 'Paid'),
    (7, 7, '2025-01-25', '2025-01-28', 3, '2025-01-07 21:00:00', 900.00, 'Paid'),
    (8, 8, '2025-01-28', '2025-01-31', 1, '2025-01-10 23:00:00', 350.00, 'Pending'),
    (9, 9, '2025-01-31', '2025-02-03', 2, '2025-01-13 01:00:00', 500.00, 'Paid'),
    (10, 10, '2025-02-03', '2025-02-07', 2, '2025-01-16 03:00:00', 700.00, 'Paid'),
    (11, 11, '2025-02-07', '2025-02-10', 1, '2025-01-19 05:00:00', 420.00, 'Pending'),
    (12, 12, '2025-02-10', '2025-02-13', 3, '2025-01-22 07:00:00', 850.00, 'Paid'),
    (13, 13, '2025-02-13', '2025-02-16', 2, '2025-01-25 09:00:00', 580.00, 'Paid'),
    (14, 14, '2025-02-16', '2025-02-19', 1, '2025-01-28 11:00:00', 380.00, 'Pending'),
    (15, 15, '2025-02-19', '2025-02-23', 2, '2025-01-31 13:00:00', 620.00, 'Paid'),
    (16, 16, '2025-02-23', '2025-02-26', 3, '2025-02-03 15:00:00', 920.00, 'Paid'),
    (17, 17, '2025-02-26', '2025-03-01', 1, '2025-02-06 17:00:00', 490.00, 'Pending'),
    (18, 18, '2025-03-01', '2025-03-04', 2, '2025-02-09 19:00:00', 780.00, 'Paid'),
    (19, 19, '2025-03-04', '2025-03-07', 2, '2025-02-12 21:00:00', 680.00, 'Paid'),
    (20, 20, '2025-03-07', '2025-03-11', 1, '2025-02-15 23:00:00', 320.00, 'Pending'),
    (21, 21, '2025-03-11', '2025-03-14', 3, '2025-02-18 01:00:00', 880.00, 'Paid'),
    (22, 22, '2025-03-14', '2025-03-17', 2, '2025-02-21 03:00:00', 720.00, 'Paid'),
    (23, 23, '2025-03-17', '2025-03-20', 1, '2025-02-24 05:00:00', 410.00, 'Pending'),
    (24, 24, '2025-03-20', '2025-03-24', 2, '2025-02-27 07:00:00', 590.00, 'Paid'),
    (25, 25, '2025-03-24', '2025-03-27', 3, '2025-03-02 09:00:00', 950.00, 'Paid'),
    (26, 26, '2025-03-27', '2025-03-30', 1, '2025-03-05 11:00:00', 390.00, 'Pending'),
    (27, 27, '2025-03-30', '2025-04-02', 2, '2025-03-08 13:00:00', 610.00, 'Paid'),
    (28, 28, '2025-04-02', '2025-04-05', 3, '2025-03-11 15:00:00', 890.00, 'Paid'),
    (29, 29, '2025-04-05', '2025-04-09', 2, '2025-03-14 17:00:00', 750.00, 'Pending'),
    (30, 30, '2025-04-09', '2025-04-12', 1, '2025-03-17 19:00:00', 310.00, 'Paid'),
    (31, 31, '2025-04-12', '2025-04-15', 2, '2025-03-20 21:00:00', 570.00, 'Paid'),
    (32, 32, '2025-04-15', '2025-04-18', 3, '2025-03-23 23:00:00', 910.00, 'Pending'),
    (33, 33, '2025-04-18', '2025-04-21', 1, '2025-03-26 01:00:00', 430.00, 'Paid'),
    (34, 34, '2025-04-21', '2025-04-24', 2, '2025-03-29 03:00:00', 790.00, 'Paid'),
    (35, 35, '2025-04-24', '2025-04-28', 2, '2025-04-01 05:00:00', 630.00, 'Pending'),
    (36, 36, '2025-04-28', '2025-05-01', 1, '2025-04-04 07:00:00', 370.00, 'Paid'),
    (37, 37, '2025-05-01', '2025-05-04', 3, '2025-04-07 09:00:00', 870.00, 'Paid'),
    (38, 38, '2025-05-04', '2025-05-07', 2, '2025-04-10 11:00:00', 710.00, 'Pending'),
    (39, 39, '2025-05-07', '2025-05-10', 1, '2025-04-13 13:00:00', 330.00, 'Paid'),
    (40, 40, '2025-05-10', '2025-05-14', 2, '2025-04-16 15:00:00', 690.00, 'Paid'),
    (41, 41, '2025-05-14', '2025-05-17', 3, '2025-04-19 17:00:00', 930.00, 'Pending'),
    (42, 42, '2025-05-17', '2025-05-20', 1, '2025-04-22 19:00:00', 460.00, 'Paid'),
    (43, 43, '2025-05-20', '2025-05-23', 2, '2025-04-25 21:00:00', 810.00, 'Paid'),
    (44, 44, '2025-05-23', '2025-05-26', 2, '2025-04-28 23:00:00', 670.00, 'Pending'),
    (45, 45, '2025-05-26', '2025-05-30', 1, '2025-05-01 01:00:00', 360.00, 'Paid'),
    (46, 46, '2025-05-30', '2025-06-02', 3, '2025-05-04 03:00:00', 900.00, 'Paid'),
    (47, 47, '2025-06-02', '2025-06-05', 2, '2025-05-07 05:00:00', 730.00, 'Pending'),
    (48, 48, '2025-06-05', '2025-06-08', 1, '2025-05-10 07:00:00', 440.00, 'Paid'),
    (49, 49, '2025-06-08', '2025-06-11', 2, '2025-05-13 09:00:00', 770.00, 'Paid'),
    (50, 50, '2025-06-11', '2025-06-15', 2, '2025-05-16 11:00:00', 610.00, 'Pending'),
    (51, 1, '2025-06-15', '2025-06-18', 1, '2025-05-19 13:00:00', 350.00, 'Paid'),
    (52, 2, '2025-06-18', '2025-06-21', 3, '2025-05-22 15:00:00', 890.00, 'Paid'),
    (53, 3, '2025-06-21', '2025-06-24', 2, '2025-05-25 17:00:00', 700.00, 'Pending'),
    (54, 4, '2025-06-24', '2025-06-27', 1, '2025-05-28 19:00:00', 310.00, 'Paid'),
    (55, 5, '2025-06-27', '2025-07-01', 2, '2025-05-31 21:00:00', 650.00, 'Paid'),
    (56, 6, '2025-07-01', '2025-07-04', 3, '2025-06-03 23:00:00', 920.00, 'Pending'),
    (57, 7, '2025-07-04', '2025-07-07', 1, '2025-06-06 01:00:00', 480.00, 'Paid'),
    (58, 8, '2025-07-07', '2025-07-10', 2, '2025-06-09 03:00:00', 800.00, 'Paid'),
    (59, 9, '2025-07-10', '2025-07-14', 2, '2025-06-12 05:00:00', 620.00, 'Pending'),
    (60, 10, '2025-07-14', '2025-07-17', 1, '2025-06-15 07:00:00', 390.00, 'Paid'),
    (61, 11, '2025-07-17', '2025-07-20', 3, '2025-06-18 09:00:00', 910.00, 'Paid'),
    (62, 12, '2025-07-20', '2025-07-23', 2, '2025-06-21 11:00:00', 740.00, 'Pending'),
    (63, 13, '2025-07-23', '2025-07-26', 1, '2025-06-24 13:00:00', 370.00, 'Paid'),
    (64, 14, '2025-07-26', '2025-07-30', 2, '2025-06-27 15:00:00', 760.00, 'Paid'),
    (65, 15, '2025-07-30', '2025-08-02', 3, '2025-06-30 17:00:00', 930.00, 'Pending'),
    (66, 16, '2025-08-02', '2025-08-05', 1, '2025-07-03 19:00:00', 450.00, 'Paid'),
    (67, 17, '2025-08-05', '2025-08-08', 2, '2025-07-06 21:00:00', 820.00, 'Paid'),
    (68, 18, '2025-08-08', '2025-08-11', 2, '2025-07-09 23:00:00', 660.00, 'Pending'),
    (69, 19, '2025-08-11', '2025-08-15', 1, '2025-07-12 01:00:00', 380.00, 'Paid'),
    (70, 20, '2025-08-15', '2025-08-18', 3, '2025-07-15 03:00:00', 880.00, 'Paid'),
    (71, 21, '2025-08-18', '2025-08-21', 2, '2025-07-18 05:00:00', 710.00, 'Pending'),
    (72, 22, '2025-08-21', '2025-08-24', 1, '2025-07-21 07:00:00', 420.00, 'Paid'),
    (73, 23, '2025-08-24', '2025-08-28', 2, '2025-07-24 09:00:00', 780.00, 'Paid'),
    (74, 24, '2025-08-28', '2025-08-31', 3, '2025-07-27 11:00:00', 900.00, 'Pending'),
    (75, 25, '2025-08-31', '2025-09-03', 1, '2025-07-30 13:00:00', 360.00, 'Paid'),
    (76, 26, '2025-09-03', '2025-09-06', 2, '2025-08-02 15:00:00', 630.00, 'Paid'),
    (77, 27, '2025-09-06', '2025-09-09', 2, '2025-08-05 17:00:00', 810.00, 'Pending'),
    (78, 28, '2025-09-09', '2025-09-13', 1, '2025-08-08 19:00:00', 490.00, 'Paid'),
    (79, 29, '2025-09-13', '2025-09-16', 3, '2025-08-11 21:00:00', 870.00, 'Paid'),
    (80, 30, '2025-09-16', '2025-09-19', 2, '2025-08-14 23:00:00', 720.00, 'Pending'),
    (81, 31, '2025-09-19', '2025-09-23', 1, '2025-08-17 01:00:00', 330.00, 'Paid'),
    (82, 32, '2025-09-23', '2025-09-26', 2, '2025-08-20 03:00:00', 690.00, 'Paid'),
    (83, 33, '2025-09-26', '2025-09-30', 3, '2025-08-23 05:00:00', 950.00, 'Pending'),
    (84, 34, '2025-09-30', '2025-10-03', 1, '2025-08-26 07:00:00', 410.00, 'Paid'),
    (85, 35, '2025-10-03', '2025-10-06', 2, '2025-08-29 09:00:00', 790.00, 'Paid'),
    (86, 36, '2025-10-06', '2025-10-10', 2, '2025-09-01 11:00:00', 670.00, 'Pending'),
    (87, 37, '2025-10-10', '2025-10-13', 1, '2025-09-04 13:00:00', 320.00, 'Paid'),
    (88, 38, '2025-10-13', '2025-10-16', 3, '2025-09-07 15:00:00', 890.00, 'Paid'),
    (89, 39, '2025-10-16', '2025-10-20', 2, '2025-09-10 17:00:00', 730.00, 'Pending'),
    (90, 40, '2025-10-20', '2025-10-23', 1, '2025-09-13 19:00:00', 440.00, 'Paid'),
    (91, 41, '2025-10-23', '2025-10-26', 2, '2025-09-16 21:00:00', 770.00, 'Paid'),
    (92, 42, '2025-10-26', '2025-10-30', 3, '2025-09-19 23:00:00', 610.00, 'Pending'),
    (93, 43, '2025-10-30', '2025-11-02', 1, '2025-09-22 01:00:00', 350.00, 'Paid'),
    (94, 44, '2025-11-02', '2025-11-05', 2, '2025-09-25 03:00:00', 890.00, 'Paid'),
    (95, 45, '2025-11-05', '2025-11-09', 2, '2025-09-28 05:00:00', 700.00, 'Pending'),
    (96, 46, '2025-11-09', '2025-11-12', 1, '2025-10-01 07:00:00', 310.00, 'Paid'),
    (97, 47, '2025-11-12', '2025-11-15', 3, '2025-10-04 09:00:00', 650.00, 'Paid'),
    (98, 48, '2025-11-15', '2025-11-19', 2, '2025-10-07 11:00:00', 920.00, 'Pending'),
    (99, 49, '2025-11-19', '2025-11-22', 1, '2025-10-10 13:00:00', 480.00, 'Paid'),
    (100, 50, '2025-11-22', '2025-11-26', 2, '2025-10-13 15:00:00', 800.00, 'Paid');
   
    select * from reservation

	UPDATE reservation
SET check_In_Date = DATEFROMPARTS(2024, MONTH(check_In_Date), DAY(check_In_Date)),
check_Out_Date = DATEFROMPARTS(2024, MONTH(check_Out_Date), DAY(check_Out_Date))
WHERE YEAR(check_In_Date) = 2025 or YEAR(check_Out_Date) = 2025;


	

INSERT INTO payment (payment_id, reservation_id, payment_date, payment_amount, payment_method) VALUES
('E101', 102, '2025-01-05', 550.00, 'Credit Card'),
('E102', 103, '2025-01-12', 800.00, 'PayPal'),
('E103', 104, '2025-01-15', 450.00, 'Debit Card'),
('E104', 106, '2025-01-22', 650.00, 'Bank Transfer'),
('E105', 107, '2025-01-25', 900.00, 'Cash'),
('E106', 109, '2025-01-31', 500.00, 'Credit Card'),
('E107', 110, '2025-02-03', 700.00, 'PayPal'),
('E108', 112, '2025-02-10', 850.00, 'Debit Card'),
('E109', 113, '2025-02-13', 580.00, 'Bank Transfer'),
('E110', 115, '2025-02-19', 620.00, 'Cash'),
('E111', 116, '2025-02-23', 920.00, 'Credit Card'),
('E112', 118, '2025-03-01', 780.00, 'PayPal'),
('E113', 119, '2025-03-04', 680.00, 'Debit Card'),
('E114', 121, '2025-03-11', 880.00, 'Bank Transfer'),
('E115', 122, '2025-03-14', 720.00, 'Cash'),
('E116', 124, '2025-03-20', 590.00, 'Credit Card'),
('E117', 125, '2025-03-24', 950.00, 'PayPal'),
('E118', 127, '2025-03-30', 610.00, 'Debit Card'),
('E119', 128, '2025-04-02', 890.00, 'Bank Transfer'),
('E120', 130, '2025-04-09', 310.00, 'Cash'),
('E135', 151, '2025-06-18', 600.00, 'Cash'),
('E136', 152, '2025-06-21', 750.00, 'Credit Card'),
('E137', 154, '2025-06-27', 480.00, 'PayPal'),
('E138', 155, '2025-06-30', 910.00, 'Debit Card'),
('E139', 157, '2025-07-03', 390.00, 'Bank Transfer'),
('E140', 158, '2025-07-06', 820.00, 'Cash'),
('E141', 160, '2025-07-12', 470.00, 'Credit Card'),
('E142', 161, '2025-07-15', 760.00, 'PayPal'),
('E143', 163, '2025-07-21', 340.00, 'Debit Card'),
('E144', 164, '2025-07-24', 930.00, 'Bank Transfer'),
('E145', 166, '2025-07-30', 420.00, 'Cash'),
('E146', 167, '2025-08-02', 830.00, 'Credit Card'),
('E147', 169, '2025-08-08', 380.00, 'PayPal'),
('E148', 170, '2025-08-11', 740.00, 'Debit Card'),
('E149', 172, '2025-08-17', 490.00, 'Bank Transfer'),
('E150', 173, '2025-08-20', 940.00, 'Cash'),
('E151', 175, '2025-08-26', 320.00, 'Credit Card'),
('E152', 176, '2025-08-29', 800.00, 'PayPal'),
('E153', 178, '2025-09-04', 450.00, 'Debit Card'),
('E154', 179, '2025-09-07', 710.00, 'Bank Transfer'),
('E155', 181, '2025-09-13', 370.00, 'Cash'),
('E156', 182, '2025-09-16', 860.00, 'Credit Card'),
('E157', 184, '2025-09-22', 430.00, 'PayPal'),
('E158', 185, '2025-09-25', 780.00, 'Debit Card'),
('E159', 187, '2025-10-01', 360.00, 'Bank Transfer'),
('E160', 188, '2025-10-04', 880.00, 'Cash'),
('E161', 190, '2025-10-10', 440.00, 'Credit Card'),
('E162', 191, '2025-10-13', 720.00, 'PayPal'),
('E163', 193, '2025-10-19', 390.00, 'Debit Card'),
('E164', 194, '2025-10-22', 950.00, 'Bank Transfer'),
('E165', 196, '2025-10-28', 410.00, 'Cash'),
('E166', 197, '2025-10-31', 890.00, 'Credit Card'),
('E167', 199, '2025-11-06', 350.00, 'PayPal'),
('E168', 200, '2025-11-09', 610.00, 'Debit Card');


select * from payment;

truncate table payment;


INSERT INTO facilities (facilities_id, facilities_Name) VALUES
(101, 'Wi-Fi'),
(102, 'Swimming Pool'),
(103, 'Gym'),
(104, 'Restaurant'),
(105, 'Spa'),
(106, 'Conference Room'),
(107, 'Parking'),
(108, 'Room Service'),
(109, 'Laundry'),
(110, 'Breakfast Buffet');

SELECT * FROM facilities



INSERT INTO room_facilities (room_id, facilities_id) VALUES
(1, 101), -- Room 1 has facility 101
(1, 102), -- Room 1 has facility 102
(2, 101), -- Room 2 has facility 101
(2, 103), -- Room 2 has facility 103
(3, 102), -- Room 3 has facility 102
(3, 103), -- Room 3 has facility 103
(4, 104), -- Room 4 has facility 104
(5, 101),
(5, 105),
(6, 102),
(6, 106),
(7, 103),
(7, 107),
(8, 104),
(8, 108),
(9, 105),
(9, 109),
(10, 106),
(10, 110),
(11, 107),
(12, 108),
(13, 109),
(14, 110),
(15, 101),
(15, 102),
(16, 103),
(16, 104),
(17, 105),
(17, 106),
(18, 107),
(18, 108),
(19, 109),
(19, 110),
(20, 101),
(20, 103),
(21, 102),
(21, 104),
(22, 105),
(22, 107),
(23, 106),
(23, 108),
(24, 109),
(24, 110),
(25, 101),
(25, 104),
(26, 102),
(26, 105),
(27, 103),
(27, 106),
(28, 107),
(28, 110),
(29, 108),
(29, 109),
(30, 101),
(30, 105),
(31, 102),
(31, 106),
(32, 103),
(32, 107),
(33, 104),
(33, 108),
(34, 109),
(34, 110),
(35, 101),
(35, 103),
(36, 102),
(36, 104),
(37, 105),
(37, 106),
(38, 107),
(38, 108),
(39, 109),
(39, 110),
(40, 101),
(40, 102),
(41, 103),
(41, 104),
(42, 105),
(42, 106),
(43, 107),
(43, 108),
(44, 109),
(44, 110),
(45, 101),
(45, 102),
(46, 103),
(46, 104),
(47, 105),
(47, 106),
(48, 107),
(48, 108),
(49, 109),
(49, 110),
(50, 101),
(50, 103);



select * from room_facilities