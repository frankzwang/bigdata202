--*********************************************************************************************************************************************
--Table with the following structure: gradeID, createdAt, studentID, courseID, score, maxScore.
--Get the Average grade per student and course.

--Get the Average grade per course
SELECT * from tblGrade
SELECT courseID, AVG(score) AS avgScorePerCourse 
FROM tblGrade
GROUP BY courseID

--Get the Average grade per student
SELECT * from tblGrade
SELECT studentID, AVG(score) AS AavgScorePerStudent
FROM tblGrade
GROUP BY studentID

--Extract (full row with gradeID) the lowest grade ever received from a student in any given course
SELECT * FROM tblGrade
WHERE score = (SELECT MIN(score) FROM tblGrade)

--Get the maximum grade per course (full row with gradeID).
SELECT * FROM tblGrade
SELECT courseID, MAX(score) AS maxScorePerCourse 
FROM tblGrade
GROUP BY courseID