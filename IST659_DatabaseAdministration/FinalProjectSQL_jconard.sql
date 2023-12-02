/* 
Author: Jake Conard 
Course: IST659 M407 
Term: April 2021 
*/ 
  
-- Creating the Final Project Customer Table. 
CREATE TABLE customer ( 
       -- Columns for the Customer table 
       customer_id int identity, 
       customer_first_name varchar(30) not null, 
       customer_middle_initial char(1), 
       customer_last_name varchar(200) not null, 
       customer_email varchar(50), 
       customer_phone_number varchar(20) not null,
       customer_street_number varchar(30) not null, 
	   customer_city varchar(25), 
       customer_state char(2) not null, 
	   customer_zip varchar(10) not null, 
       --Constraints on the Customer
       CONSTRAINT PK_customer_id PRIMARY KEY (customer_id),  
) 
  
-- Creating the Payment_Info Table 
  
CREATE TABLE payment_info( 
       --Columns for the Payment_Info Table 
       payment_info_id int identity, 
       creditcard_number varchar(16) not null, 
	   creditcard_expdate datetime not null,
       creditcard_cvv char(3) not null, 
       billing_street_number varchar(30) not null, 
	   billing_city varchar(25) not null, 
	   billing_state char(2) not null, 
	   billing_zip varchar(10) not null, 
       --Constraints on Payment_Info Table 
       CONSTRAINT PK_payment_info_id PRIMARY KEY (payment_info_id) 
) 

-- Creating the Customer_to_Payment_Info Table 
  
CREATE TABLE customer_to_payment_info( 
       --Columns for the Customer_to_Payment_Info Table 
       customer_to_payment_info_id int identity, 
       customer_id int not null, 
	   payment_info_id int not null,
       --Constraints on Customer_to_Payment_Info Table 
       CONSTRAINT PK_customer_to_payment_info_id PRIMARY KEY (customer_to_payment_info_id) ,
	   CONSTRAINT FK1_customer_to_payment_info_id FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	   CONSTRAINT FK2_customer_to_payment_info_id FOREIGN KEY (payment_info_id) REFERENCES payment_info(payment_info_id) 
) 

-- Creating the Products Table 
  
CREATE TABLE products( 
       --Columns for the Products Table 
       product_id int identity, 
       product_number varchar(25) not null, 
	   product_description varchar(255) not null,
       --Constraints on Products Table 
       CONSTRAINT PK_product_id PRIMARY KEY (product_id),  
) 

-- Creating the SalesPerson Table 
  
CREATE TABLE salesperson( 
       --Columns for the SalesPerson Table 
       salesperson_id int identity, 
       salesperson_first_name varchar(30) not null,
	   salesperson_middle_initial char(1), 
	   salesperson_last_name varchar(30) not null, 
	   salesperson_email varchar(50) not null, 
	   salesperson_phone_number varchar(20) not null, 
	   salesperson_street_number varchar(30) not null, 
	   salesperson_city varchar(25) not null,
	   salesperson_state char(2) not null,
	   salesperson_zip varchar(10) not null,
       --Constraints on SalesPerson Table 
       CONSTRAINT PK_salesperson_id PRIMARY KEY (salesperson_id) 
) 

-- Creating the Purchase_Order Table 
  
CREATE TABLE purchase_order( 
       --Columns for the Purchase_Order Table 
       purchase_order_id int identity,
	   purchase_order_date datetime not null, 
	   purchase_order_amount money not null, 
	   customer_id int not null, 
	   salesperson_id int not null, 
       --Constraints on Purchase_Order Table 
       CONSTRAINT PK_purchase_order PRIMARY KEY (purchase_order_id) ,
	   CONSTRAINT FK1_purchase_order FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	   CONSTRAINT FK2_purchase_order FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id) 
) 

-- Creating the Purchase_Order_To_Product Table 
  
CREATE TABLE purchase_order_to_product( 
       --Columns for the Purchase_Order_To_Product Table 
       purchase_order_to_product_id int identity,
	   purchase_order_id int not null, 
	   product_id int not null, 
       --Constraints on Purchase_Order_To_Product Table 
       CONSTRAINT PK_purchase_order_to_product PRIMARY KEY (purchase_order_to_product_id) ,
	   CONSTRAINT FK1_purchase_order_to_product FOREIGN KEY (purchase_order_id) REFERENCES purchase_order(purchase_order_id),
	   CONSTRAINT FK2_purchase_order_to_product FOREIGN KEY (product_id) REFERENCES products(product_id) 
) 

/*
Adding data to the Final Project Tables
*/

  
--Adding Data to the Customer Table
  
INSERT INTO customer(customer_first_name, customer_middle_initial, customer_last_name, customer_email,
		customer_phone_number, customer_street_number, customer_city, customer_state, customer_zip) 
       VALUES 
              ('Jaxon', 'L', 'Conard', 'jlconard@nodomain.xyz', '303-244-2546', '123 Highland Ave', 'Highlands Ranch', 'CO', '80126'), 
			  ('Jacob', 'N', 'Conard', 'jnconard@nodomain.xyz', '303-232-9978', '456 Grady Cir', 'Castle Rock', 'CO', '80123'), 
			  ('Kari', 'L', 'Conard', 'klconard@nodomain.xyz', '303-212-6784', '999 Trailblazer Ave', 'Denver', 'CO', '80120'), 
			  ('Parker', 'R', 'Conard', 'prconard@nodomain.xyz', '303-987-4316', '867 N. 17th Drive', 'Phoenix', 'AZ', '85021'), 
			  ('Jon', 'C', 'Simon', 'jcsimon@nodomain.xyz', '602-678-0987', '456 N. 6th Ave', 'Tucson', 'AZ', '09876'), 
			  ('Jordan', 'D', 'Conard', 'jdconard@nodomain.xyz', '602-865-0987', '123 Lawernce Ave', 'Phoenix', 'AZ', '85021'), 
			  ('Francis', 'K', 'Conard', 'fkconard@nodomain.xyz', '602-244-2546', '876 W. 12th Street', 'Parker', 'CO', '80129'), 
			  ('Jon', 'L', 'Smith', 'jlsmith@nodomain.xyz', '303-244-6785', '123 W. 4th Street', 'Highlands Ranch', 'CO', '80126'), 
			  ('Manny', 'L', 'Ramirez', 'mlramirez@nodomain.xyz', '303-444-4444', '123 W. 91st Street', 'Denver', 'CO', '80001'), 
			  ('Clayton', 'L', 'Kershaw', 'clkershaw@nodomain.xyz', '909-244-2667', '999 W. Dodgers Ave.', 'Riverside', 'CA', '92504')


--Adding Data to the Payment Info Table
  
INSERT INTO payment_info(creditcard_number,creditcard_expdate, creditcard_cvv, billing_street_number, billing_city, billing_state, billing_zip) 
       VALUES 
              ('375565848789318', '2022-12-01', '111', '123 Highland Ave', 'Highlands Ranch', 'CO', '80126'), 
			  ('4644280119756114', '2024-01-01', '555', '456 Grady Cir', 'Castle Rock', 'CO', '80123'), 
			  ('4539945973832783', '2024-02-01', '444', '999 Trailblazer Ave', 'Denver', 'CO', '80120'), 
			  ('4485458679798310', '2023-06-01', '121', '867 N. 17th Drive', 'Phoenix', 'AZ', '85021'), 
			  ('4929409731063932', '2025-08-01', '999', '456 N. 6th Ave', 'Tucson', 'AZ', '09876'), 
			  ('5388929644126253', '2024-03-01', '789', '123 Lawernce Ave', 'Phoenix', 'AZ', '85021'), 
			  ('5334240451004772', '2021-12-01', '567', '876 W. 12th Street', 'Parker', 'CO', '80129'), 
			  ('5428403704885507', '2021-10-01', '000', '123 W. 4th Street', 'Highlands Ranch', 'CO', '80126'), 
			  ('5242213371251212', '2022-07-01', '098', '123 W. 91st Street', 'Denver', 'CO', '80001'), 
			  ('5354516973428531', '2025-09-01', '909', '999 W. Dodgers Ave.', 'Riverside', 'CA', '92504')

 --Adding Data to the Salesperson Table
  
INSERT INTO salesperson(salesperson_first_name, salesperson_middle_initial, salesperson_last_name,
		salesperson_email, salesperson_phone_number, salesperson_street_number, salesperson_city, salesperson_state, salesperson_zip) 
       VALUES 
              ('Dan', 'L', 'Patrick', 'dlpatrick@nodomain.xyz', '123-456-7890', '123 Stetson Ave', 'Columbus', 'OH', '34576'), 
			  ('Andrew', 'J', 'Perloff', 'ajperloff@nodomain.xyz', '876-908-3654', '876 Brady Ave', 'Manhattan', 'NY', '10243'), 
			  ('Patrick', 'S', 'OConnor', 'psoconnor@nodomain.xyz', '453-976-1432', '9087 W. 43rd Street', 'Dallas', 'TX', '90675'), 
			  ('Paul', 'L', 'Pabast', 'plpabast@nodomain.xyz', '876-4356-9087', '7612 W. *9th Ave.', 'Augusta', 'GA', '39005'), 
			  ('Todd', 'D', 'Fritz', 'tdfritz@nodomain.xyz', '398-435-0987', '907 North 89th Street', 'Nashville', 'TN', '09876')

			  
 --Adding Data to the Products Table
  
INSERT INTO products( product_number, product_description)
       VALUES 
              ('1234', 'Ohio Bar'),
			  ('1235', 'Echo Bike'), 
			  ('1236', 'Concept 2 Rower'), 
			  ('1237', 'Rogue Wood Rings'), 
			  ('1238', '45 lb Bumper Plates'), 
			  ('1239', '35 lb Bumper Plates'), 
			  ('1240', '25 lb Bumper Plates'), 
			  ('1241', '55 Kg KettleBell'), 
			  ('1242', 'Squat Rack'), 
			  ('1243', 'Deadlift Platform'), 
			  ('1244', '55 lb Dumbell'), 
			  ('1245', '45 lb Dumbell'), 
			  ('1246', '20 lb Medicine Ball'), 
			  ('1247', 'GHD Rig'), 
			  ('1248', 'Speed Rope'), 
			  ('1249', 'Garage Pull-up System'), 
			  ('1250', 'Foam Plyo Box'), 
			  ('1251', 'Resistance Bands'), 
			  ('1252', 'Echo Slam Balls')

--Adding Data to the Customer to Payment Info
  
INSERT INTO customer_to_payment_info(customer_id, payment_info_id) 
       VALUES 
              ('1', '4'),
			  ('2', '5'),
			  ('3', '6'),
			  ('4', '7'),
			  ('5', '8'),
			  ('6', '9'),
			  ('7', '10'),
			  ('8', '11'),
			  ('9', '12'),
			  ('10', '13')


--Adding a Purchase Order Number to the Purchase Order Table
ALTER TABLE purchase_order
ADD purchase_order_number varchar(25) not null;

--Adding Data to the Purchase Order
  
INSERT INTO purchase_order(purchase_order_number, purchase_order_date, purchase_order_amount, customer_id, salesperson_id)
       VALUES 
              ('1', '2021-06-01', '15000.00', '1', '5'), 
			  ('2', '2021-01-14', '5000.00', '2', '4'),
			  ('3', '2021-05-21', '4900.40', '3', '3'),
			  ('4', '2021-01-23', '6966.50', '4', '2'),
			  ('5', '2021-03-21', '3261.89', '5', '1'),
			  ('6', '2021-02-23', '14356.78', '6', '5'),
			  ('7', '2021-01-01', '275.76', '7', '4'),
			  ('8', '2021-05-31', '5522.38', '8', '3'),
			  ('9', '2021-04-20', '13570.94', '9', '2'),
			  ('10', '2021-05-01', '14848.55', '10', '1'),
			  ('11', '2021-03-01', '13258.23', '1', '5'),
			  ('12', '2021-02-14', '4555.26', '2', '4'),
			  ('13', '2021-01-31', '13981.30', '3', '3'),
			  ('14', '2021-02-28', '1681.98', '4', '2'),
			  ('15', '2021-03-31', '3137.08', '5', '1'),
			  ('16', '2021-04-01', '6406.24', '6', '5'),
			  ('17', '2021-05-20', '11265.61', '7', '4'),
			  ('18', '2021-02-11', '223.37', '8', '3'),
			  ('19', '2021-03-31', '13203.51', '9', '2'),
			  ('20', '2021-02-21', '3534.07', '10', '1'),
			  ('21', '2021-06-02', '8609.97', '1', '5'),
			  ('22', '2021-05-20', '1318.33', '2', '4'),
			  ('23', '2021-01-05', '7835.66', '3', '3'),
			  ('24', '2021-06-21', '10708.64', '4', '2'),
			  ('25', '2021-06-20', '8132.17', '5', '1'),
			  ('26', '2021-05-05', '4118.04', '6', '5'),
			  ('27', '2021-03-11', '14232.54', '7', '4'),
			  ('28', '2021-02-19', '7119.67', '8', '3')

--Adding Data to the purchase_order_to_product
  
INSERT INTO purchase_order_to_product(purchase_order_id, product_id)
       VALUES 

			  ('4', '1'),
			  ('24', '2'),
			  ('10', '3'),
			  ('19', '4'),
			  ('18', '5'),
			  ('13', '6'),
			  ('23', '7'),
			  ('11', '8'),
			  ('16', '9'),
			  ('27', '10'),
			  ('17', '11'),
			  ('22', '12'),
			  ('5', '13'),
			  ('25', '14'),
			  ('1', '15'),
			  ('9', '16'),
			  ('28', '17'),
			  ('6', '18'),
			  ('14', '19'),
			  ('2', '2'),
			  ('20', '1'),
			  ('7', '3'),
			  ('12', '4'),
			  ('26', '5'),
			  ('15', '6'),
			  ('3', '7'),
			  ('8', '8'),
			  ('21', '9'),
			  ('20', '10'),
			  ('28', '11'),
			  ('21', '12'),
			  ('23', '13'),
			  ('7', '14'),
			  ('8', '15'),
			  ('27', '16'),
			  ('24', '17'),
			  ('19', '18'),
			  ('3', '19'),
			  ('11', '1'),
			  ('5', '2'),
			  ('26', '3'),
			  ('10', '4'),
			  ('22', '5'),
			  ('6', '6'),
			  ('9', '7'),
			  ('1', '8'),
			  ('14', '9'),
			  ('15', '10'),
			  ('4', '11'),
			  ('12', '12'),
			  ('17', '13'),
			  ('16', '14'),
			  ('25', '15'),
			  ('18', '16'),
			  ('13', '17'),
			  ('2', '18')

 -- Testing some SELECT statements for some VIEWS and JOINS
SELECT 
	purchase_order.purchase_order_amount,
	purchase_order.purchase_order_date,
	customer.customer_first_name,
	customer.customer_last_name,
	salesperson.salesperson_first_name,
	salesperson.salesperson_last_name,
	products.product_description
FROM purchase_order
JOIN customer ON customer.customer_id = purchase_order.customer_id
JOIN salesperson ON salesperson.salesperson_id = purchase_order.salesperson_id
JOIN products ON purchase_order.purchase_order_id = products.product_id
ORDER BY purchase_order.purchase_order_amount DESC

-- 1. What is the total number of purchase orders and the max, avg, min sale?
SELECT 
	COUNT(purchase_order.purchase_order_id) AS NumberOfPurchaseOrders,
	MAX(purchase_order.purchase_order_amount) AS MaxPurchaseOrder,
	AVG(purchase_order.purchase_order_amount) AS AvgPurchaseOrder,
	MIN(purchase_order.purchase_order_amount) AS MinPurchaseOrder
FROM purchase_order
ORDER BY MaxPurchaseOrder DESC

--Total Sales
SELECT 
	SUM(purchase_order.purchase_order_amount) AS TotalPurchaseOrders
FROM purchase_order
ORDER BY TotalPurchaseOrders DESC

--2. What is the largest sales month?
SELECT 
	SUM(purchase_order.purchase_order_amount) AS TotalPurchaseOrders,
	MONTH(purchase_order.purchase_order_date) AS PurchaseOrderMonth
FROM purchase_order
GROUP BY MONTH(purchase_order.purchase_order_date)
ORDER BY PurchaseOrderMonth DESC

--3. What is the best selling product?
SELECT 
	COUNT(products.product_id) AS ProductTotal,
	products.product_description AS ProductName
FROM products
GROUP BY products.product_description
ORDER BY ProductTotal DESC

--Top Salesperson VIEW
CREATE VIEW TopSalesPerson AS
SELECT 
	SUM(purchase_order.purchase_order_amount) AS TotalPurchaseOrders,
	salesperson.salesperson_last_name
FROM purchase_order
JOIN salesperson on purchase_order.salesperson_id = salesperson.salesperson_id
GROUP BY salesperson.salesperson_last_name

SELECT * FROM TopSalesPerson ORDER BY TotalPurchaseOrders DESC

--Top Salesperson by Month
SELECT 
	SUM(purchase_order.purchase_order_amount) AS TotalPurchaseOrders,
	MONTH(purchase_order.purchase_order_date) AS PurchaseOrderMonth,
	salesperson.salesperson_last_name
FROM purchase_order
JOIN salesperson on purchase_order.salesperson_id = salesperson.salesperson_id
GROUP BY salesperson.salesperson_last_name, MONTH(purchase_order.purchase_order_date)
ORDER BY TotalPurchaseOrders DESC

--Sales by Week
SELECT 
	SUM(purchase_order.purchase_order_amount) AS TotalPurchaseOrders,
	DATEPART(week, purchase_order.purchase_order_date) AS Week
FROM purchase_order
GROUP BY DATEPART(week, purchase_order.purchase_order_date)
ORDER BY TotalPurchaseOrders DESC

-- What is the best weekday for sales? [VIEW]
CREATE VIEW BestWeekday4Sales AS
SELECT 
	SUM(purchase_order.purchase_order_amount) AS TotalPurchaseOrders,
	DATENAME(weekday,purchase_order.purchase_order_date) AS DayName
FROM purchase_order
GROUP BY DATENAME(weekday,purchase_order.purchase_order_date)

SELECT * FROM BestWeekday4Sales ORDER BY TotalPurchaseOrders DESC



