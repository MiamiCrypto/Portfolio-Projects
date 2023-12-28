-- *************************************************************
-- CREATE video_game_store DATABASE
-- *************************************************************

-- create database
DROP DATABASE IF EXISTS video_game_store;
CREATE DATABASE video_game_store;

USE video_game_store;

-- create tables
CREATE TABLE IF NOT EXISTS customers
(
  customer_number INT NOT NULL AUTO_INCREMENT,
  full_name VARCHAR(255),
  address   VARCHAR(255),
  city VARCHAR(255),
  state VARCHAR(2),
  phone VARCHAR(15),
  PRIMARY KEY (customer_number)
);
select * from customers;

INSERT INTO customers VALUES
(100, "Randolf Castro", "100 Miracle Mile", "Coral Gables", "FL", "3054081122"),
(200, "Debo Samuels", "15907 SW 82 st", "Miami", "FL", "3053868600"),
(300, "Sheri Reynolds", "13250 SW 128 st", "Kendall", "FL", "3056002144"),
(400, "Maria Taylor", "252 East 7 st", "Atlanta", "GA", "9541238877"),
(500, "Michael Jackson", "100 Moonwalker rd", "Hollywood", "CA", "6873006050");

-- create tables
CREATE TABLE IF NOT EXISTS orders
(
  order_number INT NOT NULL AUTO_INCREMENT,
  customer_number INT, 
  barcode VARCHAR(255),
  price DECIMAL(5,2),
  quantity INT, 
  PRIMARY KEY(order_number),
  FOREIGN KEY (customer_number) REFERENCES customers (customer_number),
  FOREIGN KEY (barcode) REFERENCES video_games (barcode)
  );

INSERT INTO orders (customer_number, barcode, price, quantity) VALUES 
("100", "0102030405", "59.99", "12"),
("200", "7080904050", "49.99", "20"),
("300", "9895949162", "99.00", "10"),
("400", "1210101045", "59.99", "15"),
("500", "7707070707", "59.99", "10");

-- create tables
CREATE TABLE IF NOT EXISTS purchase_details
(
  game_title VARCHAR(255),
  order_number INT,
  barcode VARCHAR(255),
  quantity INT, 
  total_purchase DECIMAL(5,2),
  PRIMARY KEY (game_title),
  FOREIGN KEY (order_number) REFERENCES orders (order_number),
  FOREIGN KEY (barcode) REFERENCES video_games (barcode)
);

INSERT INTO purchase_details VALUES
("Halo Infinite", "6", "0102030405", 12, 719.88),
("Mass Effect", "7", "7080904050", 20, 999.80),
("Max Payne", "8", "9895949162", 10, 990.00),
("Madden 23", "9", "1210101045", 15, 899.85),
("NBA 2k23", "10", "7707070707", 10, 591.00);

-- create tables
CREATE TABLE IF NOT EXISTS video_games
(
  barcode VARCHAR(255),
  game_title VARCHAR(255),
  number_of_disc INT, 
  game_studio VARCHAR(60),
  DLC_price DECIMAL(5,2),
  PRIMARY KEY (barcode)
);

INSERT INTO video_games VALUES
("0102030405", "Halo Infinite","1", "343 Studios", "10.00"),
("7080904050", "Mass Effect", "2", "Bethesda", "10.00"),
("9895949162", "Max Payne", "2", "Rockstar", "20.00"),
("1210101045", "Madden 23", "1", "EA Sports", "10.00"),
("7707070707", "NBA 2k23", "1", "2K Studios", "15.00");

-- create tables
CREATE TABLE IF NOT EXISTS game_studio
(
game_studio_ID INT, 
barcode VARCHAR(255), 
headquarters VARCHAR(255), 
key_person VARCHAR(255),
PRIMARY KEY (game_studio_ID),
FOREIGN KEY (barcode) REFERENCES video_games (barcode)
);
    
INSERT INTO game_studio VALUES
(3001, "0102030405", "Miami", "Lance Stevens"),
(3002, "7080904050", "Virginia", "Jamal Williams"),
(3003, "9895949162", "Los Angeles", "Stacey Adams"),
(4004, "1210101045", "Las Vegas", "Leon Wright"),
(5005, "7707070707", "Miami", "Benny Blanco");

-- QUERY 1:
select sum(price) as total_sales from orders;
-- QUERY 2:
select * from customers where state = "FL";
-- Query 3
select order_number, quantity, price, 
case 
	when price < 59.99 then "The price is less than $59.99"
    when price > 59.99 then "The price is greater than $59.99"
    else "The price is equal to $59.99"
    end as Price_Query from orders; 
-- QUERY 4: 
select * from video_games left join orders on video_games.barcode = orders.barcode where game_title = "Halo Infinite";
-- QUERY 5:
select count(quantity) as Games_with_5_or_more_sales from orders where quantity > 4;





-- select * from order_items;
-- select 
-- Students.City, Students.FirstName, Students.Major, Students.ScholarShip 
-- from Students
-- join HighSchool on (Students.City = HighSchool.City) 
-- where Students.Major in (select Major from Students where Major is 'Business') order by Major desc; 

-- select author.authorID, author.ISBN, author.author_of_last from author left join order_items on (author.ISBN = order_items.ISBN) where author.authorID in (select authorID from author where authorID = '110') order by authorID;
-- select order_items.quantity, order_items.ISBN from order_items inner join author on (order_items.ISBN = author.ISBN) where author.authorID in (select authorID from author where authorID = '110') order by authorID;
-- select * from author left join orders on author.ISBN = orders.ISBN where authorID = '110';
select authorID, quantity, author_of_last as lastName from author left join orders on author.ISBN = orders.ISBN where authorID = '110';
-- select count(City), StudentID from Students Group by StudentID order by count(City) asc; 
-- select quantity as Manly_Hall_Books from orders where ISBN like "999999";
select count(pages) as Books_Over_200pgs from books where pages > 200; 
-- select quantity as Manly_Hall_Books from orders where ISBN like "999999";
select * from customers where city = "Miami";
