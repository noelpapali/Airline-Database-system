DROP DATABASE IF EXISTS AirlinesSystemdb;
CREATE DATABASE IF NOT EXISTS AirlinesSystemdb;
USE AirlinesSystemdb;

/*
DROP TABLE IF EXISTS Flight_T;
DROP TABLE IF EXISTS Airplane_T;
DROP TABLE IF EXISTS Route_T;
DROP TABLE IF EXISTS Flight_T;
DROP TABLE IF EXISTS Discount_T;
Drop table if exists Baggage_T;
Drop table if exists Customer_T;
Drop table if exists Airport_T;
Drop table if exists FoodChoice_T;
DROP TABLE IF EXISTS BookingSource_T;
DROP TABLE IF EXISTS Booking_T;
drop table if exists Payment_T;
DROP TABLE IF EXISTS Cargo_T;
DROP TABLE IF EXISTS Lounges_T;
DROP TABLE IF EXISTS Position_T;
DROP TABLE IF EXISTS FlightCrew_T;
DROP TABLE IF EXISTS Employees_T;
DROP TABLE IF EXISTS Class_T;
Drop table if exists RepairType_T;
Drop table if exists Maintenance_T;
*/


CREATE TABLE IF NOT EXISTS Airplane_T ( 
    AirplaneID_pk INT AUTO_INCREMENT PRIMARY KEY,
    CapacityPassenger INT,
    CapacityCargo INT,
    Manufacturer VARCHAR(255),
    PriceOfPlane INT,
    YearOfManufacturing INT
);


CREATE TABLE IF NOT EXISTS airportcity_T  (
    Abbreviation VARCHAR(3) NOT NULL,
    CityName VARCHAR(255) NOT NULL,
    PRIMARY KEY (Abbreviation)
);

CREATE TABLE IF NOT EXISTS Route_T (
    RouteID_pk VARCHAR(6),
    SourceID VARCHAR(25),
    DestinationID VARCHAR(25),
    Distance INT,
    PRIMARY KEY(RouteID_pk),
    foreign key (SourceID) references AirportCity_T(Abbreviation),
    foreign key (DestinationID) references AirportCity_T(Abbreviation)
    );

CREATE TABLE IF NOT EXISTS  Flight_T (
	FlightNo_pk INT,
    AirplaneID INT,
    RouteID VARCHAR(6),
    Depart_time TIME,
    Arrival_time TIME,
    PRIMARY KEY(FlightNo_pk),
    FOREIGN KEY(AirplaneID) REFERENCES Airplane_T(AirplaneID_pk),
    FOREIGN KEY(RouteID) REFERENCES Route_T(RouteID_pk)
    );


CREATE TABLE IF NOT EXISTS Discount_T (
    Code_pk VARCHAR(10),
    Percent INT,
    About VARCHAR(50),
    PRIMARY KEY(Code_pk)
    );


CREATE TABLE IF NOT EXISTS Customer_T(
CustomerID_pk int primary key auto_increment,
Cust_First_Name varchar(50),
Cust_Last_Name varchar(50),
Cust_EmailID varchar(50 )unique,
Cust_Phone bigint unique,
Cust_age int,
PassportNo varchar(10) unique,
Membership_Stat varchar(20),
Cust_Address varchar(50)
);


CREATE TABLE IF NOT EXISTS Baggage_T(
BaggageID_pk int primary key auto_increment,
Number_Bags int,
Weight_Bags int,
CustomerID int,
foreign key (CustomerID) references Customer_T(CustomerID_pk)
);


CREATE TABLE IF NOT EXISTS Lounges_T (
LoungeId int  primary key,
LoungeName varchar(100) not null);

CREATE TABLE IF NOT EXISTS Airport_T (
AirportId_pk int primary key not null auto_increment,
AirportName varchar(100) not null,
AirportCity varchar(100) not null,
AirportState varchar(100) not null,
AirportCountry varchar(100) not null,
AirportStripsNo int not null,
LoungeID INT,
foreign key (AirportCity) references AirportCity_T(Abbreviation),
foreign key (LoungeId) references Lounges_T (LoungeId));


CREATE TABLE IF NOT EXISTS FoodChoice_T (
FoodId_pk int primary key not null auto_increment,
Cuisine varchar(50) not null,
FoodChoice varchar(50) not null,
Drinks varchar(50) not null
);


CREATE TABLE IF NOT EXISTS BookingSource_T (
    BookingSourceID_pk INT PRIMARY KEY NOT NULL,
	BookingSourceName VARCHAR(255) NOT NULL
	);
    
CREATE TABLE IF NOT EXISTS  Class_T(
    ClassId_pk Varchar(30) primary key not null,
    ClassDesc Varchar(90) not null,
    AminityDesc Varchar(90) not null);

CREATE TABLE IF NOT EXISTS RepairType_T(
RepairTypeID_pk int primary key auto_increment,
RepairDesc varchar(100));

CREATE TABLE IF NOT EXISTS Maintenance_T(
    MainID_pk int PRIMARY KEY AUTO_INCREMENT,
    StartTime datetime,
    EndTime datetime,
    RepairTypeID int,
    RepairCost int,
    AirplaneID_fk int,
    FOREIGN KEY (RepairTypeID) REFERENCES RepairType_T(RepairTypeID_pk),
    FOREIGN KEY (AirplaneID_fk) REFERENCES Airplane_T(AirplaneID_pk)
);


CREATE TABLE IF NOT EXISTS  Payment_T(
	PaymentId_pk int not null,
    Amount int not null,
    Type_Of_Payment varchar(30) not null,
    DiscountId_fk VARCHAR(10),
    primary key(PaymentId_pk),
    FOREIGN KEY (DiscountId_fk) REFERENCES Discount_t(Code_pk)
    );


CREATE TABLE IF NOT EXISTS Booking_T(
	BookingId_pk INT NOT NULL,
    FlightNo_fk INT NOT NULL,
    Date_Of_Travel VARCHAR(30) NOT NULL,
    CustomerId_fk INT NOT NULL,
    Seat_No VARCHAR(30) NOT NULL,
    BookingSourceId_fk INT NOT NULL,
    ClassId_fk VARCHAR(30) NOT NULL,
    FoodId_fk INT NOT NULL,
    PaymentId_fk INT NOT NULL,
    PRIMARY KEY(BookingId_pk),
    Foreign Key (FlightNo_fk) references Flight_T(FlightNo_pk),
    FOREIGN KEY (BookingSourceId_fk) REFERENCES BookingSource_T(BookingSourceID_pk),
    FOREIGN KEY (FoodId_fk) REFERENCES foodchoice_t(FoodId_pk),
    FOREIGN KEY (CustomerId_fk) REFERENCES Customer_T(CustomerId_pk),
    FOREIGN KEY (ClassId_fk) REFERENCES Class_T(ClassId_pk),
    foreign key (PaymentID_fk) references Payment_T(PaymentId_pk)
    );

    

CREATE TABLE IF NOT EXISTS  Cargo_T(
    CargoID_pk INT,
    FlightNo INT,
    Weight DECIMAL(10, 2),
    PaymentID INT,
    CustomerID INT,
    PRIMARY KEY(CargoID_pk),
    FOREIGN KEY(PaymentID) REFERENCES Payment_T(PaymentID_pk),
    FOREIGN KEY(FlightNo) REFERENCES Flight_T(FlightNo_pk)
);



CREATE TABLE IF NOT EXISTS Position_T (
    PositionID_pk INT PRIMARY KEY,
    PositionDescription VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS FlightCrew_T (
    FlightCrewID_pk INT PRIMARY KEY,
    FlightNumber INT
);

CREATE TABLE IF NOT EXISTS Employees_T (
    EmployeeID_pk INT PRIMARY KEY,
    EmailID VARCHAR(255),
    PositionID_fk INT,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Contact VARCHAR(255),
    FlightCrewID_fk INT,
    FOREIGN KEY (PositionID_fk) REFERENCES Position_T(PositionID_pk),
    FOREIGN KEY (FlightCrewID_fk) REFERENCES FlightCrew_T(FlightCrewID_pk)
);


#Script to Add Data in Tables from here
USE AirlinesSystemdb;

        
INSERT INTO Airplane_T (AirplaneID_pk, CapacityPassenger, CapacityCargo, Manufacturer, PriceOfPlane, YearOfManufacturing) 
VALUES (1001, 200, 1000, 'Boeing', 100000000, 2015),
(1002, 150, 800, 'Airbus', 95000000, 2018),
(1003, 220, 1100, 'Embraer', 85000000, 2017),
(1004, 250, 1200, 'Cessna', 70000000, 2019),
(1005, 190, 950, 'Dassault', 90000000, 2014),
(1006, 280, 1300, 'Gulfstream', 110000000, 2013),
(1007, 240, 1150, 'Pilatus', 95000000, 2016),
(1008, 260, 1250, 'ATR', 80000000, 2017),
(1009, 200, 1000, 'Boeing', 100000000, 2020),
(1010, 150, 800, 'Airbus', 95000000, 2021),
(1011, 220, 1100, 'Embraer', 85000000, 2019),
(1012, 250, 1200, 'Cessna', 70000000, 2022);
    
    
INSERT INTO airportCity_T (Abbreviation, CityName) VALUES
    ('BOM', 'Mumbai'),
    ('DEL', 'Delhi'),
    ('HYD', 'Hyderabad'),
    ('DXB', 'Dubai'),
    ('SIN', 'Singapore'),
    ('JFK', 'New York City'),
    ('LAX', 'Los Angeles'),
    ('SFO', 'San Francisco'),
    ('ORD', 'Chicago'),
    ('MIA', 'Miami'),
    ('DFW', 'Dallas-Fort Worth'),
    ('LAS', 'Las Vegas'),
    ('DEN', 'Denver'),
    ('ATL', 'Atlanta'),
    ('BOS', 'Boston'),
    ('SEA', 'Seattle'),
    ('PHX', 'Phoenix'),
    ('DCA', 'Washington, D.C.'),
    ('IAH', 'Houston'),
    ('MCO', 'Orlando'),
    ('MSY', 'New Orleans'),
    ('SAN', 'San Diego'),
    ('MSP', 'Minneapolis'),
    ('SJC', 'San Jose'),
    ('PDX', 'Portland'),
    ('STL', 'St. Louis');
    
INSERT INTO Route_T VALUES ('JL583', 'JFK', 'LAX', 2500),
    ('OM267', 'ORD', 'MIA', 1200),
    ('BS492', 'BOS', 'SFO', 2750),
    ('DS741', 'DEN', 'SEA', 1050),
    ('AL359', 'ATL', 'LAS', 1800),
    ('DJ672', 'DFW', 'JFK', 1400),
    ('IO428', 'IAH', 'ORD', 950),
    ('LS196', 'LAX', 'SFO', 350),
    ('ML873', 'MCO', 'LAX', 2200),
    ('JM725', 'JFK', 'MIA', 1100),
    ('SP164', 'SEA', 'PHX', 1100),
    ('OD937', 'ORD', 'DFW', 800),
    ('LJ825', 'LAS', 'JFK', 2200),
    ('SO481', 'SFO', 'ORD', 1850),
    ('MD369', 'MIA', 'DCA', 950),
    ('BA539', 'BOS', 'ATL', 1000),
    ('DI247', 'DEN', 'IAH', 900),
    ('LL365', 'LAX', 'LAS', 250),
    ('SS839', 'SAN', 'SFO', 500),
    ('MJ713', 'MSY', 'JFK', 1200);


INSERT INTO Flight_T VALUES (111, 1008, 'JL583', '12:00', '17:30'),
    (121, 1001, 'OM267', '06:00', '10:00'),
    (131, 1002, 'BS492', '11:00', '17:00'),
    (141, 1003, 'DS741', '19:00', '22:00'),
    (151, 1004, 'AL359', '13:00', '17:00'),
    (161, 1005, 'DJ672', '22:00', '01:00'),
    (171, 1006, 'IO428', '17:00', '20:00'),
    (181, 1007, 'LS196', '07:00', '09:00'),
    (191, 1008, 'ML873', '08:00', '14:00'),
    (221, 1001, 'JM725', '12:00', '15:00'),
    (222, 1002, 'SP164', '09:00', '11:00'),
    (223, 1003, 'OD937', '05:00', '08:00'),
    (224, 1004, 'LJ825', '23:00', '05:00'),
    (225, 1005, 'SO481', '21:00', '01:30'),
    (226, 1006, 'MD369', '23:00', '02:00'),
    (227, 1007, 'BA539', '10:30', '15:00'),
    (228, 1008, 'DI247', '12:30', '15:30'),
    (229, 1001, 'LL365', '09:30', '11:30'),
    (100, 1002, 'SS839', '07:30', '09:30'),
    (200, 1003, 'MJ713', '11:30', '14:30');
        

    
INSERT INTO Discount_T VALUES ('FFO', 20, 'First time flying offer'),
    ('TD391', 5, 'Thanksgiving discount'),
    ('AIR500', 5, 'Flying to locations like Alaska, Delaware, Vermont'),
    ('FS100', 0, 'Free snack on tickets above $100'),
    ('MX562', 15, 'Christmas holiday discount'),
    ('GD15', 10, 'Family discount if more than 10 adults'),
    ('STUD555', 7, 'Student discount'),
    ('ARMY555', 5, 'Veteran discount'),
    ('EARLYB6', 6, 'If booking before 6 months'),
    ('SZ65', 4, 'If above 65 years of age'),
    ('10OFF', 10, '10 percent OFF for select routes'),
    ('DEC5', 5, '5% OFF for early bird booking');
    
    

    
INSERT INTO BookingSource_T  VALUES (1001, 'Booking.com'),
(1002, 'Expedia'),
(1003, 'Hotels.com'),
(1004, 'Agoda'),
(1005, 'TripAdvisor'),
(1006, 'Airbnb'),
(1007, 'Kayak'),
(1008, 'Priceline'),
(1009, 'Orbitz'),
(1010, 'Travelocity');


insert into Customer_T(CustomerID_pk,Cust_First_Name,Cust_Last_Name,Cust_EmailID,Cust_Phone,Cust_age,PassportNo,Membership_Stat,Cust_Address)
values(201,'Keanu','Reeves','realjohnwick@kr.com',9452740001,59,'V1463096','Platinum','Los Angeles, California'),
(202,'Leonardo','DiCaprio','wolfofthewallstreet@ld.com',9452740018,48,'C1474096','Gold','Los Angeles, California'),
(203,'Robert','Downey','ironman@avengers.com',9452740045,58,'R1466696','Silver','Malibu, California'),
(204,'Johnny','Depp','willywonka@choc.com',9452740007,60,'J1538096','Gold','Nashville, Tennessee'),
(205,'Tom','Cruise','ethanhunt@mi.com',9452740010,61,'T1536386','Platinum','Louisville, Kentucky'),
(206,'John', 'Smith', 'john.smith@email.com', 5551234567, 30, 'A4123456', 'Gold', 'Dallas, Texas'),
(207,'Sarah', 'Johnson', 'sarah.johnson@email.com', 5559876543, 25, 'X7789012', 'Silver', 'San Diego, California'),
(208,'Michael', 'Davis', 'michael.davis@email.com', 5555555555, 35, 'D9456789', 'Platinum', 'Tucson, Arizona'),
(209,'Emily', 'Wilson', 'emily.wilson@email.com', 5552345678, 28, 'G9123789', 'Silver', 'Boston, Massachusetts'),
(210, 'David', 'Anderson', 'david.anderson@email.com', 5558765432, 40, 'J5789012', 'Gold', 'New York City, New York'),
(211,'Jennifer','Lawrence','j.lawrence@email.com',5551112233,32,'L2345678','Platinum','Los Angeles, California'),
(212,'Chris','Hemsworth','thor@avengers.com',5559998888,38,'H3456789','Gold','Malibu, California'),
(213,'Emma','Watson','emma.watson@email.com',5553334444,31,'W4567890','Silver','Boston, Massachusetts'),
(214,'Ryan','Gosling','ryan.gosling@email.com',5557776666,41,'G5678901','Gold','New York City, New York'),
(215,'Margot','Robbie','margot.robbie@email.com',5554445555,31,'R6789012','Platinum','San Diego, California'),
(216, 'Alicia', 'Johnson', 'alicia.j@email.com', 5552223333, 29, 'J7890123', 'Silver', 'Chicago, Illinois');


INSERT INTO Baggage_T (BaggageID_pk,Number_Bags, Weight_Bags, CustomerID) VALUES
(1,2, 30, 201),
(2,1, 15, 202),
(3,3, 40, 203),
(4,2, 35, 204),
(5,1, 20, 205),
(6,4, 60, 206),
(7,2, 25, 207),
(8,1, 10, 208),
(9,3, 45, 209),
(10,2, 35, 210);


insert into Lounges_T values(1, 'Adani Lounge'),
(2, 'Reliance Lounge'),
(3, 'Tata Lounge'),
(4, 'Airport Lounge');

insert into foodchoice_t values (1, 'Pasta', 'Veg', 'Soft Drinks'),
(null, 'Paneer Masala', 'Veg', 'Juice'),
(null, 'Chicken Masala', 'Non-Veg', 'Tea'),
(null, 'Noodles', 'Non-Veg', 'Beer'),
(null, 'Sandwitch', 'Veg', 'Juice');

INSERT INTO Payment_T values('1111',70,'card','STUD555'),
('5555',64,'card',null),
('2221',81,'Paypal', null),
('2222',69,'card','STUD555'),
('3331',77,'Paypal','10OFF'),
('3332',80,'card',null),
('3333',61,'Apple Pay',null),
('4441',64,'card','DEC5'),
('4442',70,'Paypal',null),
('4443',64,'Apple Pay',null),
(4444,540,'card','10OFF'),
(5551,140,'card','DEC5'),
(5552,180,'Paypal', NULL),
(5553,900,'card',NULL),
(5554,1990,'Paypal','DEC5'),
(5556, 500, 'card', NULL);


#class_T
insert into Class_T values('ECO','ECONOMY','TELEVISION'),
('BUS','BUSINESS','TELEVISION,Wi-Fi'),
('FST','FIRST','TELEVISION,Wi-Fi,Videogame');


INSERT INTO Booking_T (BookingId_pk, FlightNo_fk, Date_Of_Travel, CustomerId_fk, ClassID_fk, Seat_No, BookingSourceId_fk, FoodId_fk, PaymentId_fk) VALUES
(1, 121, '2023-11-01', 201, 'ECO', 'A1',1003,2,1111),
(2, 200, '2023-11-02', 202, 'BUS', 'B2',1002,4,2221),
(3, 221, '2023-11-03', 203, 'FST', 'C3',1007,5,2222),
(4, 227, '2023-11-04', 204, 'ECO', 'D4',1003,1,3331),
(5, 171, '2023-11-05', 205, 'BUS', 'E5',1006,2,3332),
(6, 191, '2023-11-06', 206, 'FST', 'F6',1002,3,3333),
(7, 222, '2023-11-07', 207, 'ECO', 'G7',1005,5,4441),
(8, 141, '2023-11-08', 208, 'BUS', 'H8',1004,2,4442),
(9, 200, '2023-11-09', 209, 'FST', 'I9',1003,1,4443),
(10, 100, '2023-11-10', 210, 'ECO', 'J10',1006,4,4444);

#RepairT
insert into RepairType_T(RepairDesc) values 
('Routine Maintenance'),
('Scheduled Maintenance'),
('Unscheduled Maintenance'),
('Line Maintenance'),
('Heavy Maintenance'),
('Avionics Repairs'),
('Structural Repairs'),
('Engine Repairs and Overhauls'),
('Paint and Interior Refurbishment'),
('Corrosion Control'),
('Welding and Composite Repairs'),
('Upgrades and Modifications');

#MaintainanceT
insert into Maintenance_T(StartTime,EndTime,RepairTypeID,RepairCost,AirplaneID_fk) values 
('2023-04-10 08:15:00', '2023-04-20 08:15:00', 6, 10000,1009),
('2023-04-15 14:20:00', '2023-04-23 14:20:00', 8,17000,1010),
('2023-04-20 10:45:00', '2023-05-03 10:45:00', 12,50000,1011),
('2023-04-25 13:30:00', '2023-04-26 13:30:00', 1,5000,1012),
('2023-05-01 09:30:00', '2023-05-12 09:30:00', 6,12000,1009),
('2023-05-06 11:20:00', '2023-05-20 11:20:00', 7,25000,1010),
('2023-05-11 15:45:00', '2023-05-30 15:45:00', 5,100000,1011),
('2023-05-16 16:00:00', '2023-05-24 16:00:00', 3,14000,1012),
('2023-06-03 18:30:00', '2023-06-18 18:30:00', 5, 75000,1009),
('2023-06-08 22:15:00', '2023-06-17 22:15:00', 11,8000,1010),
('2023-06-15 09:40:00', '2023-06-16 09:40:00', 1,6500,1011);


INSERT INTO Cargo_T (CargoID_pk, FlightNo, Weight, PaymentID, CustomerID) VALUES
(21, 121, 10.2, 5551, 211), -- weights are in tonnes
(33, 131, 20, 5552, 212),
(38, 141, 35.25, 5553, 213),
(45, 151, 15, 5554, 214),
(55, 161, 37.5, 5555, 215);


INSERT INTO Position_T (PositionID_pk, PositionDescription) VALUES
(1, 'Pilot'),
(2, 'Co-Pilot'),
(3, 'Flight Attendant'),
(4, 'Flight Engineer'),
(5, 'Air Traffic Controller');

-- Data for FlightCrew_T table
INSERT INTO FlightCrew_T (FlightCrewID_pk, FlightNumber) VALUES
(101, 121),
(102, 131),
(103, 141),
(104, 151),
(105, 161);

-- Data for Employees_T table
INSERT INTO Employees_T (EmployeeID_pk, EmailID, PositionID_fk, FirstName, LastName, Contact, FlightCrewID_fk) VALUES
(1001, 'john@example.com', 1, 'John', 'Doe', '123-456-7890', 101),
(1002, 'jane@example.com', 3, 'Jane', 'Smith', '234-567-8901', 103),
(1003, 'mike@example.com', 2, 'Mike', 'Johnson', '345-678-9012', 102),
(1004, 'sara@example.com', 4, 'Sara', 'Williams', '456-789-0123', 104),
(1005, 'chris@example.com', 5, 'Chris', 'Brown', '567-890-1234', 105),
(1006, 'emily@example.com', 1, 'Emily', 'Taylor', '678-901-2345', 101),
(1007, 'alex@example.com', 2, 'Alex', 'Anderson', '789-012-3456', 102),
(1008, 'laura@example.com', 3, 'Laura', 'Martin', '890-123-4567', 103),
(1009, 'peter@example.com', 4, 'Peter', 'White', '901-234-5678', 104),
(1010, 'olivia@example.com', 5, 'Olivia', 'Lee', '012-345-6789', 105);


INSERT INTO airport_t VALUES 
    (1, 'Los Angeles International Airport', 'LAX', 'California', 'USA', '4', '2'),
    (2, "O'Hare International Airport", 'ORD', 'Illinois', 'USA', '7', '4'),
    (3, 'Miami International Airport', 'MIA', 'Florida', 'USA', '4', '3'),
    (4, 'Boston Logan International Airpor', 'BOS', 'Massachusetts', 'USA', '6', '1'),
    (5, 'San Francisco International Airport', 'SFO', 'California', 'USA', '4', '4'),
    (6, 'Denver International Airport', 'DEN', 'Colorado', 'USA', '6', '1'),
    (7, 'Seattle-Tacoma International Airport', 'SEA', 'Washington', 'USA', '3', '2'),
    (8, 'Hartsfield-Jackson Atlanta International Airport', 'ATL', 'Georgia', 'USA', '5', '4'),
    (9, 'McCarran International Airport', 'LAS', 'Nevada', 'USA', '3', '3'),
    (10, 'Ronald Reagan Washington National Airport', 'DCA', 'District of Columbia (D.C.)', 'USA', '6', '2'),
    (11, 'George Bush Intercontinental Airport', 'IAH', 'Texas', 'USA', '5', '1'),
    (12, 'Orlando International Airport', 'MCO', 'Florida', 'USA', '4', '4'),
    (13, 'Phoenix Sky Harbor International Airport', 'PHX', 'Arizona', 'USA', '5', '4'),
    (14, 'Louis Armstrong New Orleans International Airport', 'MSY', 'Louisiana', 'USA', '4', '3'),
    (15, 'San Diego International Airport', 'SAN', 'California', 'USA', '5', '4'),
    (16, 'CST international airport', 'BOM', 'Maharashtra', 'India', '2', '1'),
    (17, 'IG international airport', 'DEL', 'Delhi', 'India', '2', '2'),
    (18, 'RG international airport', 'HYD', 'Telangana', 'India', '1', '3'),
    (19, 'JFK international airport', 'JFK', 'New York', 'USA', '2', '4'),
    (20, 'DFW international airport', 'DFW', 'Texas', 'USA', '2', '1'),
    (21, 'Dubai international airport', 'DXB', 'Dubai', 'UAE', '2', '2'),
    (22, 'Changi international airport', 'SIN', 'Singapore', 'Singapore', '2', '3');


-- --------------------------------------------------------------------------------------------------------------------------------------------------
-- Complex Queries:

-- Complex Query 1: Using Inner Join
-- give the flight details and passanger details of all the passangers trabelling on flight num 200
select flightNo_fk, depart_time, arrival_time, customerid_fk, Cust_First_Name, Cust_Last_Name
from booking_t b inner join flight_t f on b.FlightNo_fk = f.FlightNo_pk inner join customer_t c
on b.CustomerId_fk = c.CustomerID_pk
where FlightNo_fk = 200;

-- Complex Query 2 
-- select booking detail of customers whose membership status is platinum
select Date_Of_Travel,CustomerId_fk,Seat_No,ClassId_fk from booking_t
where CustomerId_fk in (select CustomerID_pk from Customer_T
where Membership_Stat = 'Platinum');

-- Complex Query 3
-- Display the cargo and payment details of those cargos that received a discount and show the type of discount
SELECT C.CargoID_pk, C.FlightNo, C.Weight, C.PaymentID,
	   (SELECT P.Amount FROM Payment_T P WHERE P.PaymentId_pk = C.PaymentID) AS PaymentAmount, 
       (SELECT D.About FROM Discount_T D WHERE D.Code_pk = (SELECT P.DiscountId_fk FROM Payment_T P WHERE P.PaymentId_pk = C.PaymentID)) AS DiscountType
FROM cargo_t C 
WHERE C.PaymentID IN (SELECT PaymentID_pk FROM Payment_T WHERE DiscountID_fk IS NOT NULL);

-- Complex Query 4 Using Outer Join
-- It retrieves all records from both tables Class_T and Booking_T, ensuring there are no duplicates.
SELECT *
FROM Class_T
LEFT OUTER JOIN Booking_T ON Class_T.ClassId_pk = Booking_T.ClassId_fk
UNION
SELECT *
FROM Class_T
RIGHT OUTER JOIN Booking_T ON Class_T.ClassId_pk = Booking_T.ClassId_fk;

-- Complex Query 5: 
-- This subquery retrieves the booking information along with ClassDesc and AminityDesc for a specific date of travel from the Booking_T and Class_T tables.
SELECT
    BookingId_pk,
    FlightNo_fk,
    Date_Of_Travel,
    ClassId_fk,
    (SELECT ClassDesc FROM Class_T WHERE Class_T.ClassId_pk = Booking_T.ClassId_fk) AS ClassDesc,
    (SELECT AminityDesc FROM Class_T WHERE Class_T.ClassId_pk = Booking_T.ClassId_fk) AS AminityDesc
FROM
    Booking_T
WHERE
    Date_Of_Travel = '2023-11-01'; -- Replace '8-22-2023' with the desired date
SELECT * FROM Booking_T;

-- Complex Query 6 
-- It retrieves the city name (entire name, not abbreviation) of the airports present in the specified state from another table using Left Join: 
select CityName from Airport_t left join airportcity_t on Airport_t.AirportCity = airportcity_t.Abbreviation 
where Airport_t.AirportState = 'California';

-- Complex Query 7:
-- It retrieves airport city(abbreviation), city name, lounge id and lounge name of that designated airport for the specified state and country.
select AirportCity, (select CityName from airportcity_T where airportcity_T.Abbreviation = airport_t.AirportCity) as cityname,
LoungeId, (select LoungeName from lounges_t where lounges_t.LoungeId = airport_t.LoungeId)
as lounge_name from airport_t where AirportCountry = 'USA' and AirportState = 'Texas';

-- Complex Query 8 
-- Display the flight details (including source and destination) of a particular make of flight.
 SELECT F.FlightNo_pk, A.Manufacturer, R.sourceID,R.DestinationID, F.depart_time
FROM flight_T F JOIN Route_T R ON F.routeID = R.routeID_pk
           JOIN airplane_T A ON F.airplaneID=A.airplaneID_pk
WHERE A.manufacturer = 'Boeing';

-- Complex Query 9 
-- Shows a scenario where you want to find pairs of employees who are part of the same flight crew (This query made use of self-join).
SELECT DISTINCT e1.EmployeeID_pk AS Employee1, e1.FirstName AS FirstName1, e1.LastName AS LastName1,
                e2.EmployeeID_pk AS Employee2, e2.FirstName AS FirstName2, e2.LastName AS LastName2,
                e1.FlightCrewID_fk AS FlightCrewID
FROM Employees_T e1
JOIN Employees_T e2 ON e1.FlightCrewID_fk = e2.FlightCrewID_fk AND e1.EmployeeID_pk < e2.EmployeeID_pk
WHERE e1.FlightCrewID_fk IS NOT NULL
ORDER BY e1.FlightCrewID_fk, e1.EmployeeID_pk;

-- Complex Query 10 
-- To retrieve all records from the Class_T table and the matching records from the Booking_T table based on the common ClassId using a left outer join.
SELECT *
FROM Class_T
LEFT OUTER JOIN Booking_T ON Class_T.ClassId_pk = Booking_T.ClassId_fk
WHERE Booking_T.ClassId_fk IS NULL
UNION
SELECT *
FROM Class_T
LEFT OUTER JOIN Booking_T ON Class_T.ClassId_pk = Booking_T.ClassId_fk
WHERE Class_T.ClassId_pk IS NULL
UNION
SELECT *
FROM Class_T
LEFT OUTER JOIN Booking_T ON Class_T.ClassId_pk = Booking_T.ClassId_fk
WHERE Booking_T.ClassId_fk IS NOT NULL AND Class_T.ClassId_pk IS NOT NULL;

-- Complex Query 11:
-- A subquery to retrieve the ClassDesc and AminityDesc for each booking in the Booking_T table.
SELECT
    BookingId_pk,
    ClassId_fk,
    (SELECT ClassDesc FROM Class_T WHERE Class_T.ClassId_pk = Booking_T.ClassId_fk) AS ClassDesc,
    (SELECT AminityDesc FROM Class_T WHERE Class_T.ClassId_pk = Booking_T.ClassId_fk) AS AminityDesc
FROM
    Booking_T;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Stored Procedures 
-- Procedure 1: 
-- It gives the number of runways of the desired airport city.
delimiter //
  create procedure GetAirportStrip(in City varchar(3) )
  begin
  select AirportStripsNo from airport_t where AirportCity = City;
  end //
delimiter ;

 #calling procedure
 select * FROM airport_t;
 call GetAirportStrip('PHX');

 -- Procedure 2:
 -- stored procedure that gives baggage details of a customer based on the booking id
DROP PROCEDURE IF EXISTS getbaggagedet;
DELIMITER //
CREATE PROCEDURE Getbaggagedet(bookingID_param INT)
BEGIN
	SELECT BA.baggageID_pk AS baggageID, BA.Number_bags AS No_of_bags, BA.Weight_bags AS weight, BA.customerID AS customerID
    FROM Baggage_T BA JOIN booking_T B ON BA.customerID = B.customerID_fk
    WHERE B.bookingID_pk = bookingID_param;
END//
DELIMITER ;

 #calling procedure
CALL Getbaggagedet(5);

-- Procedure 3: 
-- To get the booking details like BookingId_pk, FlightNo, Date_Of_Travel, CustomerId, ClassId, Seat_No, BookingSourceId, BaggageId, FoodId, PaymentId, ClassDesc, AminityDesc based on the booking ID.
DELIMITER //
CREATE PROCEDURE GetBookingDetails(
    IN p_BookingId INT
)
BEGIN
	DECLARE classDesc VARCHAR(90);
    DECLARE amenityDesc VARCHAR(90);


    -- Get booking details along with ClassDesc and AminityDesc
    SELECT
        b.BookingId_pk,
        b.FlightNo_fk,
        b.Date_Of_Travel,
        b.CustomerId_fk,
        b.ClassId_fk,
        b.Seat_No,
        b.BookingSourceId_fk,
        b.FoodId_fk,
        b.PaymentId_fk,
        c.ClassDesc,
        c.AminityDesc
    INTO
        @BookingId_pk,
        @FlightNo,
        @Date_Of_Travel,
        @CustomerId,
        @ClassId,
        @Seat_No,
        @BookingSourceId,
        @FoodId,
        @PaymentId,
        @ClassDesc,
        @AminityDesc
    FROM
        Booking_T b
    JOIN
        Class_T c ON b.ClassId_fk = c.ClassId_pk
    WHERE
        b.BookingId_pk = p_BookingId;

    -- Display the retrieved information
    SELECT CONCAT(
        'Booking ID: ', @BookingId_pk, ', ',
        'Flight No: ', @FlightNo, ', ',
        'Date of Travel: ', @Date_Of_Travel, ', ',
        'Customer ID: ', @CustomerId, ', ',
        'Class ID: ', @ClassId, ', ',
        'Seat No: ', @Seat_No, ', ',
        'Booking Source ID: ', @BookingSourceId, ', ',
        'Food ID: ', @FoodId, ', ',
        'Payment ID: ', @PaymentId, ', ',
        'Class Description: ', @ClassDesc, ', ',
        'Amenity Description: ', @AminityDesc
    ) AS BookingDetails;
END //
DELIMITER ;

Select * FROM Booking_T;
 #calling procedure
CALL GetBookingDetails(2);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Functions 
-- Function 1:
-- fn to give the number of flights flown by a particular make of airplane when the manufacturer is given
DROP FUNCTION IF EXISTS GetFlightcount;
DELIMITER //
CREATE FUNCTION GetFlightcount(airplanemake VARCHAR(20))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE flightcount INT;
    
    SELECT COUNT(*) INTO flightcount
    FROM Flight_T F INNER JOIN Airplane_T A ON F.airplaneID = A.airplaneID_pk
    WHERE A.manufacturer = airplanemake;

	RETURN flightcount;
END //
DELIMITER ;

SELECT GetFlightcount('pilatus');

-- Function 2:
-- Function to get the total revenue generated for a specific flight:

DELIMITER //
CREATE FUNCTION GetTotalRevenue(flight_no INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_revenue DECIMAL(10, 2);
 
    SELECT SUM(p.Amount) INTO total_revenue
    FROM Booking_T b
    JOIN Payment_T p ON b.PaymentId_fk = p.PaymentId_pk
    WHERE b.FlightNo_fk = flight_no;
 
    RETURN total_revenue;
END //
DELIMITER ;

SELECT GetTotalRevenue(121) AS TotalRevenue;

-- Function 3: 
-- Function calculates the number of booked seats for the specified flight.
DELIMITER //
CREATE FUNCTION GetBookedSeatsCount(
    flightNoParam INT
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE bookedSeatsCount INT;

    -- Calculate the count of booked seats for the specified flight
    SELECT COUNT(*) INTO bookedSeatsCount
    FROM Booking_T
    WHERE FlightNo_fk = flightNoParam;

    RETURN bookedSeatsCount;
END//
DELIMITER ;

SELECT GetBookedSeatsCount(221);

-- Function 4
-- Function to get the travel time based on the flight number and the route ID.
DELIMITER //
CREATE FUNCTION GetTravelTime(
    flightNoParam INT, route varchar(10)
) RETURNS TIME
DETERMINISTIC
BEGIN
    DECLARE Starttime TIME;
    DECLARE Endtime TIME;
    DECLARE traveltime TIME;
 
    -- Calculate the Travel time for a particular flight
    SELECT Depart_time, Arrival_time INTO StartTime, EndTime
    FROM Flight_T
    WHERE FlightNo_pk = flightNoParam AND routeID=route;
 
    IF Starttime>Endtime THEN
     SET Endtime = ADDTIME(Endtime, "24:00");
	END IF;
     SET traveltime = TIMEDIFF(Endtime, Starttime);
	RETURN traveltime;
END//
DELIMITER ;

SELECT GetTravelTime(121, 'OM267');

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------
#Views
#View 1 - DIsplays the important customer details, booking details, payment details of all the passengers
CREATE VIEW CustomerBookingDetails_View AS
SELECT 
    Booking_T.BookingId_pk,
    Customer_T.Cust_First_Name,
    Customer_T.Cust_Last_Name,
    Customer_T.Cust_EmailID,
    BookingSource_T.BookingSourceName,
    Class_T.ClassDesc,
    Payment_T.Amount,
    Payment_T.Type_Of_Payment
FROM Booking_T
JOIN Customer_T ON Booking_T.CustomerId_fk = Customer_T.CustomerID_pk
JOIN BookingSource_T ON Booking_T.BookingSourceId_fk = BookingSource_T.BookingSourceID_pk
JOIN Class_T ON Booking_T.ClassId_fk = Class_T.ClassId_pk
JOIN Payment_T ON Booking_T.PaymentId_fk = Payment_T.PaymentId_pk;

SELECT * FROM CustomerBookingDetails_View;

#View 2 - Displays the maintenence details along with the repair description for all the maintenance works
CREATE VIEW MaintenanceDetails_View AS
SELECT 
    Maintenance_T.MainID_pk,
    RepairType_T.RepairDesc,
    Maintenance_T.StartTime,
    Maintenance_T.EndTime,
    Maintenance_T.AirplaneID_fk,
    Maintenance_T.RepairCost
FROM Maintenance_T
JOIN RepairType_T ON Maintenance_T.RepairTypeID = RepairType_T.RepairTypeID_pk;

SELECT * FROM MaintenanceDetails_View;

#View3 - Display the particulars of all the flights taken by all airplanes
CREATE VIEW AirplaneFlightDetails_View AS
SELECT A.airplaneID_pk, A.manufacturer, F.FlightNo_pk, R.sourceID, R.destinationID, GetTravelTime(F.FlightNo_pk, F.routeID) AS Time_of_Travel, R.Distance
FROM Flight_T F JOIN Airplane_T A ON A.airplaneID_pk = F.airplaneID 
				JOIN Route_T R ON R.routeID_pk = F.RouteID;
 
SELECT * FROM AirplaneFlightDetails_View;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Triggers -- 

-- Trigger 1:
#After Update Trigger
-- make a trigger for every update in the flight's departure time and log it in a different flightlog_T table
CREATE TABLE IF NOT EXISTS FlightLogs_T (
log_id INT AUTO_INCREMENT PRIMARY KEY,
flightNo INT,
old_departure_time DATETIME,
new_departure_time DATETIME,
log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER UpdateDepartureTimeTrigger
AFTER UPDATE ON Flight_T
FOR EACH ROW
BEGIN
IF OLD.Depart_time <> NEW.Depart_time THEN
INSERT INTO FlightLogs_T (flightNo, old_departure_time, new_departure_time)
VALUES (NEW.flightNo_pk, OLD.Depart_Time, NEW.Depart_Time);
END IF;
END;
//
DELIMITER ;

-- example for trigger
UPDATE Flight_T
SET Depart_time = '06:30'
WHERE FlightNo_pk = 100;

SELECT * FROM FlightLogs_T;


 -- Trigger 2:
 -- A before delete trigger that helps to maintain a cargo deletion log (by inserting necessary data into that table) whenever a deletion is made in the cargo table.
DROP TABLE IF EXISTS cargoDeletionLog;
CREATE TABLE IF NOT EXISTS cargoDeletionLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    cargoID INT,
    DeletedAt DATETIME
);
DROP TRIGGER IF EXISTS BeforecargoDelete;
-- Create the delete trigger
DELIMITER //
CREATE TRIGGER BeforecargoDelete
BEFORE DELETE ON Cargo_T
FOR EACH ROW
BEGIN
    -- Log the deleted passenger information
    INSERT INTO cargoDeletionLog (cargoID, DeletedAt)
    VALUES (OLD.cargoID_pk, NOW());
END//
DELIMITER ;

-- example for trigger
DELETE FROM cargo_T
WHERE cargoID_pk=21;
select * from cargodeletionlog;

-- Trigger 3: 
-- trigger check that cargo weight inserted is between 2 and 40 during every insertion into cargo table
DROP TRIGGER IF EXISTS CheckCargoWeight;
DELIMITER //
CREATE TRIGGER CheckCargoWeight
BEFORE INSERT ON Cargo_T
FOR EACH ROW
BEGIN
    DECLARE error_message VARCHAR(255);

    IF NEW.Weight > 40 THEN
        SET error_message = 'Cargo weight must not exceed 40.';
        SIGNAL SQLSTATE '22003'
        SET MESSAGE_TEXT = error_message;
	ELSEIF NEW.Weight < 2 THEN
		SET error_message = 'Cargo weight must not be below 2.';
        SIGNAL SQLSTATE '22003'
        SET MESSAGE_TEXT = error_message;
    END IF;
END//

-- example for trigger
INSERT INTO Cargo_T VALUES
(41, 121, 35, 5556, 216); 
INSERT INTO Cargo_T VALUES
(41, 121, 50, 5557, 217);  # this will return an error in the action output section as cargo weight is above 40
