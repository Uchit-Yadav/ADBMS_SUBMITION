DROP TABLE IF EXISTS FeePayments;

CREATE TABLE FeePayments (
    payment_id INT,
    student_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) CHECK (amount > 0),
    payment_date DATE NOT NULL
);

-- Part A: Insert Multiple Fee Payments
START TRANSACTION;
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (1, 'Ashish', 5000.00, '2024-06-01'),
       (2, 'Smaran', 4500.00, '2024-06-02'),
       (3, 'Vaibhav', 5500.00, '2024-06-03');
COMMIT;
SELECT * FROM FeePayments;

-- Part B: Demonstrate ROLLBACK
START TRANSACTION;
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (1, 'Kiran', 6000.00, '2024-06-04');
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (1, 'Duplicate', 3000.00, '2024-06-05'); 
ROLLBACK;
SELECT * FROM FeePayments;

-- Part C: Partial Failure
START TRANSACTION;
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (5, 'Mehul', 7000.00, '2024-06-06');
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (6, NULL, 6500.00, '2024-06-07'); 
ROLLBACK;
SELECT * FROM FeePayments;

-- Part D: ACID Compliance
START TRANSACTION;
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (7, 'Rohan', 8000.00, '2024-06-08');
COMMIT;

START TRANSACTION;
INSERT INTO FeePayments (payment_id, student_name, amount, payment_date)
VALUES (2, 'Duplicate2', 9000.00, '2024-06-09'); 
ROLLBACK;
SELECT * FROM FeePayments;
