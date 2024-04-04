-- Creating or replacing a procedure to update student's first and last name
CREATE OR REPLACE PROCEDURE update_student_name(
    p_student_id IN NUMBER,           -- Input parameter: Student ID
    p_new_name IN VARCHAR2            -- Input parameter: New full name
) AS
BEGIN
    -- Extracting first and last names from the full name
    UPDATE student
    SET first_name = SUBSTR(p_new_name, 1, INSTR(p_new_name, ' ') - 1),
        last_name = SUBSTR(p_new_name, INSTR(p_new_name, ' ') + 1)
    WHERE student_id = p_student_id;
    
    -- Displaying a success message if the update is successful
    DBMS_OUTPUT.PUT_LINE('Student name updated successfully.');
EXCEPTION
    -- Handling any exceptions and displaying an error message
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating student name: ' || SQLERRM);
END;
/

-- Testing the procedure
SET SERVEROUTPUT ON;

-- Selecting the student's first and last name before the update
SELECT first_name, last_name FROM student WHERE student_id = 6;

-- Declaring variables for the test
DECLARE
    v_student_name VARCHAR2(100) := 'Menna Amr'; 
BEGIN
    -- Calling the update_student_name procedure
    update_student_name(6, v_student_name);
    
    -- Displaying the new student name after the update
    DBMS_OUTPUT.PUT_LINE('Student new name: ' || v_student_name);
END;

-- Selecting the student's first and last name after the update
SELECT first_name, last_name FROM student WHERE student_id = 6;








-------create procedure to update course name 
CREATE OR REPLACE PROCEDURE UpdateCourseName (
    p_course_id NUMBER,
    p_new_course_name VARCHAR2
)
AS 
    v_course_count NUMBER;
BEGIN
    -- Check if the course_id exists
    SELECT COUNT(*)
    INTO v_course_count
    FROM courses
    WHERE course_id = p_course_id;

    IF v_course_count = 0 THEN
        -- Course ID not found, raise an exception or handle it as needed
        RAISE_APPLICATION_ERROR(-20001, 'Course ID not found.');
    ELSE
        -- Update the course name
        UPDATE courses
        SET course_name = p_new_course_name
        WHERE course_id = p_course_id;

        -- Display success message
        DBMS_OUTPUT.PUT_LINE('Course name updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions
        DBMS_OUTPUT.PUT_LINE('Error updating course name: ' || SQLERRM);
        -- Optionally, rollback the transaction if an error occurs
        ROLLBACK;
END;

-----test for procedure
SET SERVEROUTPUT ON;
SELECT* FROM courses WHERE course_id = 104;

DECLARE
    v_course_name VARCHAR2(100) := 'biology'; 
BEGIN
    UpdateCourseName(104,  v_course_name);
    DBMS_OUTPUT.PUT_LINE('course new name: ' ||  v_course_name);
END;
SELECT* FROM courses WHERE course_id = 104;


CREATE OR REPLACE FUNCTION calculate_gpa(p_student_id IN NUMBER) RETURN NUMBER IS
    v_total_grade_points NUMBER := 0;  -- Total grade points accumulated
    v_total_credit_hours NUMBER := 0;  -- Total credit hours for all courses
    v_course_grade CHAR(1);            -- Grade for each course
    v_course_hours NUMBER;              -- Credit hours for each course

    -- Cursor to retrieve grades and credit hours for enrolled courses
    CURSOR c_enrollments IS
        SELECT e.grade, c.course_hours
        FROM enrollment e
        JOIN courses c ON e.course_id = c.course_id
        WHERE e.student_id = p_student_id;

BEGIN
    -- Loop through each enrolled course
    FOR enrollment_rec IN c_enrollments LOOP
        v_course_grade := enrollment_rec.grade;   -- Retrieve grade for the course
        v_course_hours := enrollment_rec.course_hours;  -- Retrieve credit hours for the course

        -- Assigning grade points based on the grade
        CASE v_course_grade
            WHEN 'A' THEN v_total_grade_points := v_total_grade_points + (4 * v_course_hours);
            WHEN 'B' THEN v_total_grade_points := v_total_grade_points + (3 * v_course_hours);
            WHEN 'C' THEN v_total_grade_points := v_total_grade_points + (2 * v_course_hours);
            WHEN 'D' THEN v_total_grade_points := v_total_grade_points + (1 * v_course_hours);
            WHEN 'F' THEN v_total_grade_points := v_total_grade_points + (0 * v_course_hours);
        END CASE;

        v_total_credit_hours := v_total_credit_hours + v_course_hours;  -- Accumulate total credit hours
    END LOOP;

    -- Avoid division by zero
    IF v_total_credit_hours = 0 THEN
        RETURN NULL;  -- Return NULL if there are no credit hours to avoid division by zero
    END IF;

    -- Calculating GPA by dividing total grade points by total credit hours
    RETURN v_total_grade_points / v_total_credit_hours;
END;
/

    -----test for function
    DECLARE
       v_gpa NUMBER;
    BEGIN
     v_gpa := calculate_gpa(6);  -- add the student_id that you waant calc his gpa
        DBMS_OUTPUT.PUT_LINE('GPA: ' || TO_CHAR(v_gpa, '0.00'));
    END;   


CREATE OR REPLACE PROCEDURE delete_department (
    old_dep_id   IN NUMBER
) AS
    CURSOR CHANGE_DEPT_CURSOR IS
        SELECT TABLE_NAME, COLUMN_NAME, OBJECT_TYPE
        FROM USER_TAB_COLUMNS, USER_OBJECTS
        WHERE USER_TAB_COLUMNS.TABLE_NAME = USER_OBJECTS.OBJECT_NAME
        AND COLUMN_NAME = 'DEP_ID'
        AND OBJECT_TYPE = 'TABLE';
BEGIN
    FOR DEPT_RECORD IN CHANGE_DEPT_CURSOR LOOP
        EXECUTE IMMEDIATE 'DELETE FROM ' || DEPT_RECORD.TABLE_NAME || ' WHERE dep_id = :1'
            USING old_dep_id;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions if needed
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END;
-- test the procedure 
set serveroutput on
select* from department;
select* from student;
select* from dept_course;
DECLARE
BEGIN
    delete_department(6);
END;
select* from department;
select* from student;
select* from dept_course;

/*<TOAD_FILE_CHUNK>*/

----test fot procedure

SET SERVEROUTPUT ON;

-- Select the student name before the update
SELECT student_name FROM student WHERE student_id = 1;

DECLARE
    v_student_name VARCHAR2(100) := 'menna amr'; 
BEGIN
    update_student_name(1, v_student_name);
    DBMS_OUTPUT.PUT_LINE('Student new name: ' || v_student_name);
END;

-- Select the student name after the update
SELECT student_name FROM student WHERE student_id = 1;



-----------------------------------------------------------------------------------

--------create procedure to update course name 
CREATE OR REPLACE PROCEDURE UpdateCourseName (
    p_course_id NUMBER,
    p_new_course_name VARCHAR2
)
AS 
    v_course_count NUMBER;
BEGIN
    -- Check if the course_id exists
    SELECT COUNT(*)
    INTO v_course_count
    FROM courses
    WHERE course_id = p_course_id;

    IF v_course_count = 0 THEN
        -- Course ID not found, raise an exception or handle it as needed
        RAISE_APPLICATION_ERROR(-20001, 'Course ID not found.');
    ELSE
        -- Update the course name
        UPDATE courses
        SET course_name = p_new_course_name
        WHERE course_id = p_course_id;

        -- Display success message
        DBMS_OUTPUT.PUT_LINE('Course name updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions
        DBMS_OUTPUT.PUT_LINE('Error updating course name: ' || SQLERRM);
        -- Optionally, rollback the transaction if an error occurs
        ROLLBACK;
END;

-----test for procedure
DECLARE
    v_course_id NUMBER := 104;
    v_new_course_name VARCHAR2(50) := 'biology';
BEGIN
    UpdateCourseName(v_course_id, v_new_course_name);
END;
/
/*<TOAD_FILE_CHUNK>*/
---------------------------------------------------------------------------------------------------------

--------create procedure to update course name 
CREATE OR REPLACE PROCEDURE UpdateCourseName (
    p_course_id NUMBER,
    p_new_course_name VARCHAR2
)
AS 
    v_course_count NUMBER;
BEGIN
    -- Check if the course_id exists
    SELECT COUNT(*)
    INTO v_course_count
    FROM courses
    WHERE course_id = p_course_id;

    IF v_course_count = 0 THEN
        -- Course ID not found, raise an exception or handle it as needed
        RAISE_APPLICATION_ERROR(-20001, 'Course ID not found.');
    ELSE
        -- Update the course name
        UPDATE courses
        SET course_name = p_new_course_name
        WHERE course_id = p_course_id;

        -- Display success message
        DBMS_OUTPUT.PUT_LINE('Course name updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions
        DBMS_OUTPUT.PUT_LINE('Error updating course name: ' || SQLERRM);
        -- Optionally, rollback the transaction if an error occurs
        ROLLBACK;
END;

-----test for procedure
DECLARE
    v_course_id NUMBER := 104;
    v_new_course_name VARCHAR2(50) := 'biology';
BEGIN
    UpdateCourseName(v_course_id, v_new_course_name);
END;
/
