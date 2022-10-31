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