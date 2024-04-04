-- trigger for updating student course 
CREATE TABLE student_course_history (
          student_id NUMBER,
            old_course_name VARCHAR2(255 CHAR),
            old_grade VARCHAR2(10 CHAR),
            updated_at DATE
       );
       
CREATE OR REPLACE TRIGGER student_update_trigger
after UPDATE ON courses
FOR EACH ROW
DECLARE
    CURSOR enrollment_cursor IS
        SELECT student_id, grade
        FROM enrollment
        WHERE course_id = :old.course_id;
        
    v_enrollment_rec enrollment_cursor%ROWTYPE;
BEGIN
    FOR v_enrollment_rec IN enrollment_cursor
    LOOP
        INSERT INTO student_course_history (STUDENT_ID, OLD_COURSE_NAME, OLD_GRADE, UPDATED_AT)
        VALUES (v_enrollment_rec.student_id, :old.course_name, v_enrollment_rec.grade, SYSDATE);
    END LOOP;
END;
/
--for testing
--update courses set course_name = 'Database manegment' where course_id = 101;
--select* from student_course_history;


-- create trigger to delete student from all tables
CREATE OR REPLACE PROCEDURE delete_student_id(
    v_old_student_id IN student.student_id%TYPE
)
AS
BEGIN
    FOR rec IN (
        SELECT table_name, column_name, object_type
        FROM user_tab_columns c
        JOIN user_objects o ON c.table_name = o.object_name
        WHERE c.column_name = 'STUDENT_ID' AND object_type = 'TABLE' 
    )
    LOOP
        -- Construct dynamic SQL to delete records with the specified student_id
        EXECUTE IMMEDIATE 'DELETE FROM ' || rec.table_name || ' WHERE student_id = ' || v_old_student_id;

        -- Print information
        DBMS_OUTPUT.PUT_LINE('Student ID ' || v_old_student_id || ' records deleted from ' || rec.table_name);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

CREATE OR REPLACE TRIGGER trg_delete_student
AFTER DELETE ON student
FOR EACH ROW
DECLARE
BEGIN
    -- Call the delete_student_id procedure to delete related records
    delete_student_id(1);
END;
/

-- Check existing data before deletion
SELECT* FROM student;
SELECT* from enrollment;  
select* from student_course_history;
BEGIN
    -- Call the delete_student_id procedure
    delete_student_id(6);
END;
-- Check existing data after deletion
SELECT* FROM student;
SELECT* from enrollment;  
select* from student_course_history;
/*<TOAD_FILE_CHUNK>*/

-- DROP TRIGGER student_update_trigger;
   --for testing
--update courses set course_name = 'Database manegment' where course_id = 101;
--select* from student_course_history;

SELECT trigger_name, status
FROM user_triggers
WHERE table_name = 'COURSES';

SELECT * FROM enrollment WHERE course_id = 105;
INSERT INTO enrollment (student_id, course_id, grade)
VALUES (1, 105, 'A');
