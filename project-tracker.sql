-- Step 1: The students Table
CREATE TABLE students (
    github VARCHAR(30) PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30)
);

-- Inserting data
INSERT INTO students (github, first_name, last_name)
VALUES ('jhacks', 'Jane', 'Hacker');

INSERT INTO students (github, first_name, last_name)
VALUES ('sdevelops', 'Sarah', 'Developer');

INSERT INTO students (github, first_name, last_name)
VALUES ('joshawott', 'Josh', 'Self-Insert');

INSERT INTO students (github, first_name, last_name)
VALUES ('whacks', 'Warren', 'Hacker');

-- Step 2: Getting Data Out of the database
SELECT last_name FROM students;

SELECT github, first_name FROM students;

SELECT *
FROM students
WHERE first_name = 'Sarah';

SELECT *
FROM students
WHERE github = 'sdevelops';

SELECT first_name, last_name
FROM students
WHERE github = 'jhacks';

-- Step 3: The projects Table
CREATE TABLE projects (
    title VARCHAR(30) PRIMARY KEY,
    description TEXT,
    max_grade INTEGER
);

-- populate projects table
INSERT INTO projects (title, description, max_grade)
VALUES ('Markov', 'Tweets generated from Markov chains', 50);

INSERT INTO projects (title, description, max_grade)
VALUES ('Blockly', 'Programmatic Logic Puzzle Game', 100);

INSERT INTO projects (title, description, max_grade)
VALUES ('Sabersmithy', 'Lightsaber building app', 66);

INSERT INTO projects (title, description, max_grade)
VALUES ('Seeking the Grail', 'Choose your own adventue game', 75);

INSERT INTO projects (title, description, max_grade)
VALUES ('Honeypot 3000', 'Scam call detector', 50);

-- Step 4: Dump/Restore a PostgreSQL Database
-- in terminal: pg_dump project-tracker > project-tracker-dump.sql
-- in terminal: psql project-tracker -f project-tracker-dump.sql

-- Step 5: Advanced Querying
SELECT title, max_grade
FROM projects
WHERE max_grade > 50;

SELECT title, max_grade
FROM projects
WHERE max_grade >= 10 AND max_grade <= 60;

SELECT title, max_grade
FROM projects
WHERE max_grade < 25 OR max_grade > 75;

SELECT *
FROM projects
ORDER BY max_grade;

SELECT title, max_grade, max_grade * 100 AS maxier_grade
FROM projects
WHERE max_grade % 25 = 0
ORDER BY title;

-- Step 6: Linking the Tables Together
CREATE TABLE grades (
    id SERIAL PRIMARY KEY,
    student_github VARCHAR(30) REFERENCES students,
    project_title VARCHAR(30) REFERENCES projects,
    grade INTEGER
);

INSERT INTO grades (student_github, project_title, grade)
VALUES ('jhacks', 'Markov', 10);

INSERT INTO grades (student_github, project_title, grade)
VALUES ('jhacks', 'Blockly', 2);

INSERT INTO grades (student_github, project_title, grade)
VALUES ('sdevelops', 'Markov', 50);

INSERT INTO grades (student_github, project_title, grade)
VALUES ('sdevelops', 'Blockly', 100);

INSERT INTO grades (student_github, project_title, grade)
VALUES ('joshawott', 'Sabersmithy', 66);

INSERT INTO grades (student_github, project_title, grade)
VALUES ('joshawott', 'Seeking the Grail', 70);

INSERT INTO grades (student_github, project_title, grade)
VALUES ('whacks', 'Blockly', 86);

INSERT INTO grades (student_github, project_title, grade)
VALUES ('whacks', 'Sabersmithy', 50);

INSERT INTO grades (student_github, project_title, grade)
VALUES ('lancelot', 'Seeking the Grail', 75);   -- lancelot doesn't exist in students table, insert will not work

-- Step 7: Getting Jane's Project Grades
SELECT first_name, last_name
FROM students
WHERE github = 'jhacks';

SELECT project_title, grade
FROM grades
WHERE student_github = 'jhacks';

SELECT title, max_grade
FROM projects;

SELECT students.first_name, students.last_name, grades.project_title, grades.grade
FROM students
JOIN grades ON (students.github = grades.student_github);

SELECT *
FROM students
  JOIN grades ON (students.github = grades.student_github)
  JOIN projects ON (grades.project_title = projects.title)
WHERE github = 'jhacks';

SELECT first_name, last_name, grades.project_title, grade, projects.max_grade
FROM students
  JOIN grades ON (students.github = grades.student_github)
  JOIN projects ON (grades.project_title = projects.title)
WHERE github = 'jhacks';