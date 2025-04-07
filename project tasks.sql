

------------   PROJECT TASK  -------


   -----BASIC QUERY ---
--- List all reservations with their guest names, room numbers, check-in dates, and check-out dates.
SELECT
    g.first_Name,
    r.room_number,
    res.check_In_Date,
    res.check_Out_Date,
	res.reservation_ID,
	res.number_Of_guests
FROM  reservation res
JOIN  guests g ON res.guest_id = g.guest_id  
JOIN  room r ON res.room_id = r.room_id;   
 
 
 
 --- Find all reservations for a specific guest (e.g., guest with guest_id = 9

 SELECT
    res.*,
    g.first_Name, 
    r.room_number 
FROM reservation res
JOIN  guests g ON res.guest_id = g.guest_id
JOIN room r ON res.room_id = r.room_id
WHERE res.guest_id = 9; 

/* List all rooms that are currently occupied (check-in date is before or equal to today, 
and check-out date is after today).*/

SELECT
    r.room_number,
    res.check_In_Date,
    res.check_Out_Date
FROM
    room r
JOIN reservation res ON r.room_id = res.room_id
WHERE res.check_In_Date <= GETDATE() AND res.check_Out_Date > GETDATE();




--Show all reservations for a specific date range.


	SELECT
    res.*, -- Select all columns from the reservation table
    g.first_Name, -- Include the guest's name for clarity
    r.room_number -- Include the room number for clarity
FROm  reservation res
JOIN  guests g ON res.guest_id = g.guest_id
JOIN  room r ON res.room_id = r.room_id
WHERE  res.check_In_Date >= '2024-10-26' AND res.check_Out_Date <= '2024-10-30';


---Calculate the average total amount of all reservations

select AVG(total_amount) AS average_total_amount
From reservation;



--Find the highest and lowest total amount for a reservation.

select MAX(total_amount) as highest_total_amount
from reservation
-- for lowest_total_amount
select Min(total_amount) as lowest_total_amount
from reservation


-- Count the number of reservations for each payment method.

SELECT
    payment_method,
    COUNT(reservation_id) AS number_of_reservations
FROM payment
GROUP By payment_method;



--List all reservations and their corresponding payment details.
Select
    r.reservation_id,
    r.guest_id,
    r.room_id,
    r.check_In_Date,
    r.check_Out_Date,
    p.payment_id,
    p.payment_date,
    p.payment_amount,
    p.payment_method
From  reservation r
right JOIN payment p ON r.reservation_id = p.reservation_id;



--Find the total amount of payments for each reservation.
	Select 
    r.reservation_id,
    SUM(p.payment_amount) AS total_payment_amount
From  reservation r
right Join 
payment p ON r.reservation_id = p.reservation_id
Group by r.


-- Update the payment status of a reservation (e.g., change 'Pending' to 'Paid')
   
  Update reservation
  set payment_status='Paid'
  where reservation_ID='103';
-- to check
  select * from reservation
   where reservation_ID='103';

-- Change the check-out date for a reservation.  '2024-01-10' to '2024-01-15' where reservation_id ='102'

update reservation
set check_Out_Date='2024-01-15'
where reservation_ID='102';

-- to check 
select * from reservation
where reservation_ID='102';


-- Add a new payment record for a reservation.

INSERT INTO payment (payment_id, reservation_id, payment_date, payment_amount, payment_method) VALUES
('E169', 103, '2025-01-15', 510.00, 'Cash');

 select * from payment
 where payment_id='E169'

 -- for delete 
  delete from payment
 where payment_id ='E169';


 --Update the number of guests for a reservation. change 1 to 2 where reservation_id ='103'
 update reservation
 set number_Of_guests='2'
 where reservation_ID='103'


 -- to check
 select * from reservation
  where reservation_ID='103'


--Add a new room to the room table.
INSERT INTO room( room_number, room_type, price, availability) VALUES
    ('1703', 'Suite', 560.00, 1);

-- to check
	 select * from room
	 where room_number='1703';

--Change the price of a room. (price is change 560 to 580 where room_number ='1703'

   update room
   set price='580'
   where room_number='1703';

-- to check 
    select * from room
	 where room_number='1703';

--Change the availability of a room.   (0 to 1) where room_id='51'
  update room 
  set availability =1
 where room_id='51';

  
-- to check 
    select * from room
	 where room_id='51';


--Add a new guest to the guest table.
 INSERT INTO guests( first_Name, 
 last_Name,
 contact_Number,
 email,
 address) 
 VALUES
  ('shiv', 'Sahay', '91-9000000000', 'shiv.sahay@email.com', '010 MG Road, mangalore, jarnataka');

  select * from guests
  where first_Name='shiv'



  ----------------  ADVANCED QUERY  -----------------

---Find the rooms with the most frequent reservations.

Select  r.room_number,
COUNT(res.room_id) AS reservation_count
From  room r
Join  reservation res ON r.room_id = res.room_id
Group by r.room_number


--Calculate the total revenue generated within a specific month.
	Select
    Sum(total_amount) AS total_revenue
From
    reservation
Where
    -- Specify the year and month you're interested in
    Year(check_In_Date) = 2025 AND Month(check_In_Date) = 1 ; -- 1  For January 2025

--Find guests who have made atleast one reservations.
	Select 	g.last_name,
  COUNT(res.guest_id) AS number_of_reservations
From guests g
Join  reservation res ON g.guest_id = res.guest_id
group by g.guest_id, g.last_Name
Having COUNT(res.guest_id) > 0;




-- Calculate the number of days each room was occupied.
Select r.room_number,
    SUM( DATEDIFF ( day, res.check_In_Date, res.check_Out_Date)) AS total_occupied_days
From room r
Join reservation res ON r.room_id = res.room_id
Group by r.room_number
Order BY total_occupied_days DESC;


--Find the reservations that checked in on a weekend.

select res.*,
g.first_name ,
r.room_id
from  reservation res
join guests g on res.guest_id=g.guest_id

join room r on res.room_id=r.room_id
where DATENAME(dw, res.check_In_Date) in ('saturday' , 'sunday')



--Find the reservations that checked out on a weekend.


select res.*,
g.first_name ,
r.room_id
from  reservation res
join guests g on res.guest_id=g.guest_id

join room r on res.room_id=r.room_id
where DATENAME(dw, res.check_Out_Date ) in ('saturday' , 'sunday')


---Find the reservations that have a payment method of credit card, and have a payment amount greater than 500.

  select 
   g.first_name ,
  res.reservation_ID,
  p.payment_id,
  p.payment_amount,
  p.payment_method
  from reservation res
  join guests g on res.guest_id=g.guest_id
  join payment p on res.reservation_ID=p.reservation_id
  where payment_amount>=500 and payment_method='credit card'


  --Find the reservations that have a payment status of paid, and have a  reservation date within the last 30 days.

    select 
	res.reservation_id,
	res.payment_status,
	g.first_name
	

	from reservation res
	join guests g on res.guest_id=g.guest_id
	  join payment p on res.reservation_ID=p.reservation_id
	where payment_status='paid'
	and payment_date >dATEAdd(day, -30, Getdate());
    
	

--Find the reservations that have a number of guests greater than 2, and have a room type of suite.
 
 select 
   g.first_name ,
  res.reservation_ID,
  r.room_type,
  res.number_Of_guests
  from reservation res
  join guests g on res.guest_id=g.guest_id
  join room r on res.room_id=r.room_id
  where number_Of_guests>2 and room_type='suite'


-- Find the reservations that overlapped with each other.
 SELECT
    r1.reservation_id AS ReservationID1,
    g1.last_Name AS GuestName1,
    r1.check_In_Date AS CheckInDate1,
    r1.check_Out_Date AS CheckOutDate1,
    r2.reservation_id AS ReservationID2,
    g2.last_Name AS GuestName2,
    r2.check_In_Date AS CheckInDate2,
    r2.check_Out_Date AS CheckOutDate2,
    rm.room_number
FROM
    reservation r1
JOIn reservation r2 ON r1.room_id = r2.room_id AND r1.reservation_id <> r2.reservation_id
JOIn guests g1 ON r1.guest_id = g1.guest_id
JOIn guests g2 ON r2.guest_id = g2.guest_id
JOIn room rm ON r1.room_id = rm.room_id
WHERE (r1.check_In_Date < r2.check_Out_Date) AND (r1.check_Out_Date > r2.check_In_Date)
ORDER By  rm.room_number, r1.check_In_Date;

--write a query  displaying the most popular payment methods
Select
    payment_method,
    Count(payment_id) AS number_of_payments,
    Sum(payment_amount) AS total_amount_paid
From payment
Group by  payment_method
Order by number_of_payments DESC;

-- write a query  displaying the total revenue generated by each room type.

   SELECT r.room_type,
    SUM(res.total_amount) AS total_revenue
From room r
Join  reservation res ON r.room_id = res.room_id
Group by  r.room_type
Order by total_revenue DESC;


--Generate a query of all reservations for a specific month
(-- Specify the desired month (6for May))
(-- Specify the desired year)

SELECT
    res.reservation_id,
    g.first_Name,
    r.room_number,
    r.room_type,
    res.check_In_Date,
    res.check_Out_Date,
    res.number_Of_guests,
    res.total_amount,
    res.payment_status
FROM
    reservation res
join  guests g ON res.guest_id = g.guest_id
Join room r ON res.room_id = r.room_id
Where YEAR(res.check_In_Date) = 2024
    AND MONTH(res.check_In_Date) =  6
	Order by res.check_In_Date, r.room_number;


--: Generate a query of all payments made within a specific month .
 
 Select
    p.payment_id,
    res.reservation_id,
    g.first_Name,
    r.room_number,
    p.payment_date,
    p.payment_amount,
    p.payment_method,
    res.payment_status
From payment p
Join  reservation res ON p.reservation_id = res.reservation_id
Join guests g ON res.guest_id = g.guest_id
Join room r ON res.room_id = r.room_id
Where   month(p.payment_date) = 1-- Specify the desired year
Order by  p.payment_date;

-----     stored procedure    ----------

---Create a Stored Procedure to Add a New Guest

Create Procedure SP_AddNewGuest (
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @ContactNumber VARCHAR(20),
    @Email VARCHAR(255),
    @Address VARCHAR(255),
    @NewGuestID INT output
)
AS
begin
     IF EXISTS (SELECT 1 FROM guests WHERE contact_Number = @ContactNumber OR email = @Email)
    begin
        return 1;
    end
    insert into guests (first_Name, last_Name, contact_Number, email, address)
    values (@FirstName, @LastName, @ContactNumber, @Email, @Address);
    set @NewGuestID = SCOPE_IDENTITY();
    return 0;
end;
go

-- Declare a variable to store the output guest ID
DECLARE @NewID INT;
DECLARE @Result INT;

-- Execute the stored procedure
EXEC @Result = sp_AddNewGuest
    @FirstName = 'Ammy',
    @LastName = 'Singh',
    @ContactNumber = '9638637722',
    @Email = 'ammy.singh@example.com',
    @Address = '143 Main, delhi',
    @NewGuestID = @NewID OUTPUT;

 ---to check   
	select*from guests
	where first_Name='Ammy'



--Create a Stored Procedure to Check Room Availability (More Detailed):


create procedure sp_CheckRoomAvailability (
    @RoomID INT,
    @CheckInDate DATE,
    @CheckOutDate DATE
)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM room WHERE room_id = @RoomID)
    BEGIN
        RETURN 'error';
    END

    IF NOT EXISTS (
        SELECT 1
        FROM reservation
        WHERE room_id = @RoomID
          AND check_In_Date < @CheckOutDate
          AND check_Out_Date > @CheckInDate
    )
    BEGIN
        RETURN 'room is valid';
    END
    ELSE
    BEGIN
        RETURN 'room is invalid';
    END
END;
GO



--Create a Stored Procedure to Find Guest Details by ID

	CREATE PROCEDURE sp_GetGuestDetails (
    @GuestID INT
)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM guests WHERE guest_id = @GuestID)
    BEGIN
        RETURN 1; -- Guest not found
    END
        SELECT
        guest_id,
        first_Name,
        last_Name,
        contact_Number,
        email,
        address
    FROM  guests
    WHERE guest_id = @GuestID;
    RETURN 0; -- Success
END;
GO


-- Declare variables
DECLARE @Result INT;
DECLARE @GuestToCheck INT = 10;

-- Execute the stored procedure
EXEC @Result = sp_GetGuestDetails @GuestID = @GuestToCheck;




























 










