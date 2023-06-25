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

--Get the total count of assignments graded every month.
SELECT Year(createdAt) AS Year, Month(createdAt) AS Month, count(*) as monthlyAsmtGraded 
FROM tblGrade
WHERE year(createdAt) = YEAR(GETDATE())
GROUP BY Year(createdAt), Month(createdAt)

--Extract the list of students with courses that are under the average grade of the class.
WITH avgByCourse AS (
					SELECT courseID, AVG(score) AS avgScorePerCourse 
					FROM tblGrade
					GROUP BY courseID
					) 
SELECT g.studentID, g.courseID, g.score, a.avgScorePerCourse 
FROM tblGrade g
JOIN avgByCourse a ON a.courseID = g.courseID
WHERE score < a.avgScorePerCourse

--*********************************************************************************************************************************************
--Get the student with the largest time gap between 2 activities; only look over their last 4 activities (i.e. 3 gaps to compare)
--use CTE and windows function to get activity partition by studentID
--then compare the time gap between each activity for each student and get the biggest time gap
--sa means student activity
WITH sa AS(
			SELECT 
					studentID,
					activityAt,
 					ROW_NUMBER() OVER (
										PARTITION BY studentID
										ORDER BY activityAt
									 ) rowNum
			FROM tblActivity 
     	)
SELECT top 1
		a.studentID,
		DATEDIFF (MINUTE,a.activityAt, b.activityAt) AS gapMinutes,
		a.activityAt AS lastLoginTime,
		b.activityAt AS nextLoginTime
FROM sa a, sa b
WHERE b.rowNum = a.rowNum + 1
AND a.rowNum < 5
ORDER BY studentID,gapMinutes DESC;

--Get the students with less than 10 activities over the past 30 days. 
SELECT [studentID], COUNT(studentID) AS loginTimes30D
FROM tblActivity
WHERE activityAt >= DateAdd(Day,- 30, GetDate()) 
GROUP BY [studentID]
HAVING (COUNT(activityAt)) < 5

--RECURSIVE CTE case 1: print out Factorial (MySQL dialect) 
WITH RECURSIVE cteFact as 
(
	SELECT 1 n, 1 fact          --anchor
    UNION 	ALL
    SELECT n+1, (n+1)*fact		--recursive query
    FROM cteFact
    WHERE n < 6					--termination
 )
 SELECT n, fact					--result
 FROM cteFact

--RECURSIVE CTE case 2: Corporate Hierarchical 
--print out employee ID and their manager ID (SQL Server dialect) 
WITH cteEmp AS
	(
		SELECT emp_id, emp_name, manager
		FROM employee e
		WHERE manager IS NULL
		UNION all
		SELECT e.emp_id,e.emp_name, e.manager
		FROM cteEmp
		JOIN e on e.manager = cteEmp.emp_id		--employee.manager (id) is cteEmp.emp_id (next level pointing to 1 up level, recursively to null)
	 )
SELECT *
FROM cteEmp
ORDER BY emp_id, manager;