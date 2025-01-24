CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) NOT NULL,
    address TEXT
);

CREATE TABLE Services (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    service_name VARCHAR(100) NOT NULL,
    service_description TEXT,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Technicians (
    technician_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    expertise VARCHAR(100),
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE ServiceRequests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    service_id INT,
    technician_id INT,
    request_date DATE NOT NULL,
    status ENUM('Pending', 'In Progress', 'Completed') NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id),
    FOREIGN KEY (technician_id) REFERENCES Technicians(technician_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_status ENUM('Paid', 'Pending') NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Customers (name, email, phone, address) VALUES
('John Doe', 'john@example.com', '9876543210', '123 Street, City'),
('Alice Smith', 'alice@example.com', '9876543211', '456 Avenue, City');

INSERT INTO Services (service_name, service_description, price) VALUES
('Laptop Repair', 'Fixing hardware and software issues', 500.00),
('Virus Removal', 'Removing malware and optimizing performance', 300.00),
('Data Recovery', 'Recover lost files and data', 700.00);

INSERT INTO Technicians (name, expertise, phone, email) VALUES
('Mike Johnson', 'Hardware & Software Repair', '9876543222', 'mike@example.com'),
('Sarah Lee', 'Data Recovery Specialist', '9876543223', 'sarah@example.com');

INSERT INTO ServiceRequests (customer_id, service_id, technician_id, request_date, status) VALUES
(1, 1, 1, '2025-01-20', 'Pending'),
(2, 2, 2, '2025-01-19', 'In Progress');

INSERT INTO Payments (customer_id, amount, payment_date, payment_status) VALUES
(1, 500.00, '2025-01-21', 'Paid'),
(2, 300.00, '2025-01-20', 'Pending');

SELECT * FROM ServiceRequests WHERE status = 'Pending';

SELECT Customers.name, Customers.email, Payments.amount, Payments.payment_status
FROM Customers
JOIN Payments ON Customers.customer_id = Payments.customer_id
WHERE Payments.payment_status = 'Pending';

SELECT SUM(Payments.amount) AS total_revenue FROM Payments WHERE payment_status = 'Paid';

SELECT Services.service_name, COUNT(ServiceRequests.service_id) AS request_count
FROM ServiceRequests
JOIN Services ON ServiceRequests.service_id = Services.service_id
GROUP BY Services.service_name
ORDER BY request_count DESC
LIMIT 1;
