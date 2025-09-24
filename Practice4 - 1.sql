DROP TABLE IF EXISTS StudentEnrollments;

CREATE TABLE StudentEnrollments (
    enrollment_id INT,
    student_name VARCHAR(100) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    enrollment_date DATE NOT NULL
);

-- Part A: Insert Multiple Enrollments
START TRANSACTION;
INSERT INTO StudentEnrollments (enrollment_id, student_name, course_id, enrollment_date)
VALUES (1, 'Ashish', 'CSE101', '2024-07-01'),
       (2, 'Smaran', 'CSE102', '2024-07-01'),
       (3, 'Vaibhav', 'CSE101', '2024-07-01');
COMMIT;

-- Part B: Lock a Student Record using SELECT FOR UPDATE
START TRANSACTION;
SELECT * FROM StudentEnrollments
WHERE student_name = 'Ashish' AND course_id = 'CSE101'
FOR UPDATE;
-- Other sessions trying to update this row will be blocked until this transaction commits
COMMIT;

-- Part C: Demonstrate Consistent Updates
START TRANSACTION;
UPDATE StudentEnrollments
SET enrollment_date = '2024-07-10'
WHERE enrollment_id = 1;
COMMIT;

START TRANSACTION;
UPDATE StudentEnrollments
SET enrollment_date = '2024-07-12'
WHERE enrollment_id = 2;
COMMIT;

SELECT * FROM StudentEnrollments;
