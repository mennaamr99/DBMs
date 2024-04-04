-- Create department table
CREATE TABLE department (
    dep_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(255) NOT NULL
);

-- Create student table
CREATE TABLE student (
    student_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(255) NOT NULL,
    last_name VARCHAR2(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR2(1) NOT NULL,
    faculty VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) UNIQUE NOT NULL,
    hours_completed NUMBER NOT NULL,
    dep_id NUMBER,
    FOREIGN KEY (dep_id) REFERENCES department(dep_id)
);

-- Create courses table
CREATE TABLE courses (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(255) NOT NULL,
    course_hours NUMBER NOT NULL
);

-- Create enrollment table
CREATE TABLE enrollment (
    student_id NUMBER,
    course_id NUMBER,
    grade VARCHAR2(2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Create dept_course table
CREATE TABLE dept_course (
    dep_id NUMBER,
    course_id NUMBER,
    PRIMARY KEY (dep_id, course_id),
    FOREIGN KEY (dep_id) REFERENCES department(dep_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
-    Populate the database with sample data.

--Insert data into department table
INSERT INTO department (dep_id, dept_name) VALUES (1, 'Computer Science');
INSERT INTO department (dep_id, dept_name) VALUES (2, 'Physics');
INSERT INTO department (dep_id, dept_name) VALUES (3, 'Business Administration');
INSERT INTO department (dep_id, dept_name) VALUES (4, 'Mathematics');
INSERT INTO department (dep_id, dept_name) VALUES (5, 'English Literature');
INSERT INTO department (dep_id, dept_name) VALUES (6, 'Microbiology/Chemistry');
INSERT INTO department (dep_id, dept_name) VALUES (7, 'History literature');

-- Insert data into student table
INSERT INTO student (student_id, first_name, last_name, date_of_birth, gender, faculty, email, hours_completed, dep_id)
VALUES (1, 'John', 'Doe', TO_DATE('2007-02-05', 'YYYY-MM-DD'), 'M', 'Engineering', 'john.doe@email.com', 100, 1);
INSERT INTO student (student_id, first_name, last_name, date_of_birth, gender, faculty, email, hours_completed, dep_id)
VALUES (2, 'Jane', 'Smith', TO_DATE('2006-02-05', 'YYYY-MM-DD'), 'F', 'Science', 'jane.smith@email.com', 120, 2);
INSERT INTO student (student_id, first_name, last_name, date_of_birth, gender, faculty, email, hours_completed, dep_id)
VALUES (3, 'Bob', 'Johnson', TO_DATE('2005-02-05', 'YYYY-MM-DD'), 'M', 'Business', 'bob.johnson@email.com', 80, 3);
INSERT INTO student (student_id, first_name, last_name, date_of_birth, gender, faculty, email, hours_completed, dep_id)
VALUES (4, 'Alice', 'Johnson', TO_DATE('2004-02-05', 'YYYY-MM-DD'), 'F', 'Science', 'alice.johnson@email.com', 90, 4);
INSERT INTO student (student_id, first_name, last_name, date_of_birth, gender, faculty, email, hours_completed, dep_id)
VALUES (5, 'Charlie', 'Brown', TO_DATE('2003-02-05', 'YYYY-MM-DD'), 'M', 'Arts', 'charlie.brown@email.com', 110, 5);
INSERT INTO student (student_id, first_name, last_name, date_of_birth, gender, faculty, email, hours_completed, dep_id)
VALUES (6, 'Menna', 'Gabr', TO_DATE('2003-05-15', 'YYYY-MM-DD'), 'F', 'Science', 'menna.gabr@email.com', 60, 6);

-- Insert data into courses table
INSERT INTO courses (course_id, course_name, course_hours) VALUES (101, 'Introduction to Programming', 3);
INSERT INTO courses (course_id, course_name, course_hours) VALUES (102, 'Physics I', 4)
INSERT INTO courses (course_id, course_name, course_hours) VALUES (103, 'Marketing Principles', 3);
INSERT INTO courses (course_id, course_name, course_hours) VALUES (104, 'Calculus I', 4);
INSERT INTO courses (course_id, course_name, course_hours) VALUES (105, 'Shakespearean Literature', 3);
INSERT INTO courses (course_id, course_name, course_hours) VALUES (106, 'Principle of Applied Chemistry', 3); 
INSERT INTO courses (course_id, course_name, course_hours) VALUES (107, 'Bacteria and Chronic Infections', 4);
INSERT INTO courses (course_id, course_name, course_hours) VALUES (108, 'History', 3);

-- Insert data into enrollment table
-- Enroll John Doe in Introduction to Programming
INSERT INTO enrollment (student_id, course_id, grade) VALUES (1, 101, 'A');
-- Enroll Jane Smith in Physics I
INSERT INTO enrollment (student_id, course_id, grade) VALUES (2, 102, 'B');
-- Enroll Bob Johnson in Marketing Principles
INSERT INTO enrollment (student_id, course_id, grade) VALUES (3, 103, 'C');
-- Enroll Alice Johnson in Calculus I
INSERT INTO enrollment (student_id, course_id, grade) VALUES (4, 104, 'B+');
-- Enroll Charlie Brown in Shakespearean Literature
INSERT INTO enrollment (student_id, course_id, grade) VALUES (5, 105, 'A-');
-- Insert Menna's enrollment for the Principle of Applied Chemistry (at Microbiology/Chemistry department)
INSERT INTO enrollment (student_id, course_id, grade)
VALUES (6, 106, 'A');
-- Insert Menna's enrollment for bacteria and chronic infections (at Microbiology/Chemistry department)
INSERT INTO enrollment (student_id, course_id, grade)
VALUES (6, (SELECT course_id FROM courses WHERE course_name = 'Bacteria and Chronic Infections'), 'B');
-- Insert Menna's enrollment for history course (at Literature department)
INSERT INTO enrollment (student_id, course_id, grade)
VALUES (6, (SELECT course_id FROM courses WHERE course_name = 'History'), 'A');

-- Insert data into dept_course table
-- Associate Computer Science department with Introduction to Programming
INSERT INTO dept_course (dep_id, course_id) VALUES (1, 101);
-- Associate Physics department with Physics I
INSERT INTO dept_course (dep_id, course_id) VALUES (2, 102);
-- Associate Business Administration department with Marketing Principles
INSERT INTO dept_course (dep_id, course_id) VALUES (3, 103);
-- Associate Mathematics department with Calculus I
INSERT INTO dept_course (dep_id, course_id) VALUES (4, 104);
-- Associate English Literature department with Shakespearean Literature
INSERT INTO dept_course (dep_id, course_id) VALUES (5, 105);
-- Associate Microbiology/Chemistry department with Principle of Applied Chemistry
INSERT INTO dept_course (dep_id, course_id) VALUES (6, 106);
-- Associate Microbiology/Chemistry department with Bacteria and Chronic Infections
INSERT INTO dept_course (dep_id, course_id) VALUES (6, 107);
-- Associate History Literature department with History
INSERT INTO dept_course (dep_id, course_id) VALUES (7, 108);



-- testing the constriaints
--Check the contents of the department table:
SELECT * FROM department;
--Check the contents of the student table:
SELECT * FROM student;
--Check the contents of the courses table:
SELECT * FROM courses;
--Check the contents of the enrollment table:
SELECT * FROM enrollment;
--Check the contents of the dept_course table:
SELECT * FROM dept_course;
--Check the total hours completed by each student:
SELECT student_id, SUM(course_hours) AS total_hours_completed
FROM  enrollment
JOIN courses ON enrollment.course_id = courses.course_id
GROUP BY student_id;

--Check for students who have enrolled in courses from their respective departments:
SELECT s.student_id, s.first_name, s.last_name, s.dep_id, d.dept_name,
       e.course_id, c.course_name, e.grade
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN dept_course dc ON s.dep_id = dc.dep_id AND e.course_id = dc.course_id
JOIN department d ON s.dep_id = d.dep_id
JOIN courses c ON e.course_id = c.course_id;

--Try to insert a student with a non-existing department:
INSERT INTO student (student_id, first_name, last_name, date_of_birth, gender, faculty, email, hours_completed, dep_id)
VALUES (7, 'New', 'Student', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'M', 'Science', 'new.student@email.com', 80, 8);
--Try to insert a department-course association with a non-existing department or course:
INSERT INTO dept_course (dep_id, course_id) VALUES (8, 109);

-- Try to insert a new student with an existing email
INSERT INTO student (student_id, first_name, last_name, date_of_birth, gender, faculty, email, hours_completed, dep_id)
VALUES (7, 'New', 'Student', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'M', 'Science', 'john.doe@email.com', 80, 1);

ALTER TABLE enrollment
ADD CONSTRAINT check_grade CHECK (regexp_like(grade, '^[^0-9]+$'));
ALTER TABLE student
ADD CONSTRAINT unique_student_name UNIQUE (first_name, last_name);
ALTER TABLE student
ADD CONSTRAINT check_hours_completed CHECK (regexp_like(hours_completed, '^[0-9]+$'));
-- use regexp_like function for pattern matching. 

-- Attempt to violate the constraint on grade by inserting a number
-- This will fail because '2' contains a number
INSERT INTO enrollment (student_id, course_id, grade) VALUES
(1, 102, '2');

-- Attempt to violate the unique constraint on student name
-- This will fail because 'John Doe' already exists in the table
INSERT INTO student (student_id, first_name, last_name, date_of_birth, gender, faculty, email, hours_completed, dep_id) VALUES
(3, 'John', 'Doe', '2002-03-03', 'M', 'Physics', 'john.doe2@example.com', 60, 1);







