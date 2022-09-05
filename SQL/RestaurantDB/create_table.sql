-- Restuarant Database

CREATE TABLE menu (
  menu_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  food_names TEXT,
  price INTEGER
);

INSERT INTO menu VALUES 
  (1, 'Ramen', 179),
  (2, 'Miso soup', 169),
  (3, 'Sukiyaki', 249),
  (4, 'Teriyaki', 159),
  (5, 'Sushi', 129),
  (6, 'Sashimi', 149),
  (7, 'Onigiri', 139),
  (8, 'Tempura', 99),
  (9, 'Groza', 99),
  (10, 'Green tea', 39);

CREATE TABLE staffs (
  staff_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  staff_name TEXT,
  position TEXT
);

INSERT INTO staffs VALUES
  (1, 'James', 'General Manager'),
  (2, 'Michael', 'Executive Chef'),
  (3, 'David', 'Chef'),
  (4, 'Mary', 'Kitchen Manager'),
  (5, 'Sarah', 'Food & Beverage Manager'),
  (6, 'Lisa', 'Cashier'),
  (7, 'Emily', 'Cashier'),
  (8, 'Mark', 'Server'),
  (9, 'Ann', 'Server'),
  (10, 'Amy', 'Dishwasher');

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  name TEXT,
  gender TEXT,
  age INTEGER
);

INSERT INTO customers VALUES
  (1, 'Maria', 'F', 25),
  (2, 'Janet', 'F', 26),
  (3, 'Tyler', 'M', 30),
  (4, 'Emma', 'F', 32),
  (5, 'Justin', 'M', 21),
  (6, 'Scott', 'M', 22),
  (7, 'Helen', 'F', 21),
  (8, 'Susan', 'F', 28),
  (9, 'John', 'M', 40),
  (10, 'Linda', 'F', 35),
  (11, 'Thomas', 'M', 39),
  (12, 'Richard', 'M', 25);

CREATE TABLE food_order (
  order_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  invoice_id INT,
  menu_id INT,
  quantity INT,
  FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
  FOREIGN KEY (menu_id) REFERENCES menu(menu_id)
);

INSERT INTO food_order VALUES
  (1, 1, 1, 1),
  (2, 1, 2, 1),
  (3, 1, 10, 1),
  (4, 2, 1, 1),
  (5, 2, 4, 1),
  (6, 2, 10, 1),
  (7, 2, 10, 1),
  (8, 3, 5, 1),
  (9, 3, 6, 1),
  (10, 4, 3, 1),
  (11, 4, 5, 1),
  (12, 5, 5, 1),
  (13, 5, 7, 1),
  (14, 5, 10, 1),
  (15, 6, 8, 1),
  (16, 6, 8, 1),
  (17, 6, 3, 1),
  (18, 6, 10, 1),
  (19, 6, 10, 1),
  (20, 7, 3, 1),
  (21, 7, 4, 1),
  (22, 8, 6, 1),
  (23, 8, 10, 1),
  (24, 9, 9, 1),
  (25, 9, 4, 1),
  (26, 9, 10, 1),
  (27, 10, 8, 1),
  (28, 10, 6, 1);

CREATE TABLE invoice (
  invoice_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  staff_id int,
  customer_id INT,
  invoice_date DATETIME,
  total INTEGER,
  FOREIGN KEY (staff_id) REFERENCES staffs(staff_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO invoice VALUES
  (1, 6, 2, '2022-09-01', 387),
  (2, 6, 4, '2022-09-02', 416),
  (3, 7, 1, '2022-09-03', 278),
  (4, 6, 5, '2022-09-03', 378),
  (5, 7, 7, '2022-09-04', 268),
  (6, 7, 9, '2022-09-06', 525),
  (7, 7, 12, '2022-09-08', 408),
  (8, 6, 3, '2022-09-09', 188),
  (9, 6, 11, '2022-09-09', 297),
  (10, 6, 8, '2022-09-10', 248);


 
