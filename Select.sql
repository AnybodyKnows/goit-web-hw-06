--1Find the top 5 students with the highest average grade across all subjects:
SELECT s.StudentID, s.FullName, AVG(g.Grade) AS AverageGrade
FROM Students s
JOIN Grades g ON s.StudentID = g.StudentID
GROUP BY s.StudentID, s.FullName
ORDER BY AverageGrade DESC
LIMIT 5;

--2Find the student with the highest average grade in a specific subject:
SELECT s.StudentID, s.FullName, AVG(g.Grade) AS AverageGrade
FROM Students s
JOIN Grades g ON s.StudentID = g.StudentID
JOIN Subjects subj ON g.SubjectID = subj.SubjectID
WHERE subj.SubjectName = 'груди'
GROUP BY s.StudentID, s.FullName
ORDER BY AverageGrade DESC
LIMIT 1;

--3Find the average grade in groups for a specific subject:
SELECT s.GroupID, subj.SubjectName, AVG(g.Grade) AS AverageGrade
FROM Students s
JOIN Grades g ON s.StudentID = g.StudentID
JOIN Subjects subj ON g.SubjectID = subj.SubjectID
WHERE subj.SubjectName = 'груди'
GROUP BY s.GroupID, subj.SubjectName;

--4Find the average grade across all grades:
SELECT AVG(Grade) AS AverageGrade
FROM Grades;

--5Find the courses taught by a specific professor:
SELECT subj.SubjectName
FROM Subjects subj
JOIN Professors prof ON subj.ProfessorID = prof.ProfessorID
WHERE prof.FullName = 'пан Орхип Терещенко';

--6Find the list of students in a specific group:
SELECT *
FROM Students
WHERE GroupID = 3;

--7Find the grades of students in a specific group for a certain subject:
SELECT s.GroupID, subj.SubjectName, s.FullName, g.Grade
FROM Students s
JOIN Grades g ON s.StudentID = g.StudentID
JOIN Subjects subj ON g.SubjectID = subj.SubjectID
WHERE s.GroupID = 3
AND subj.SubjectName = 'груди'
order by grade desc ;

--8Find the average grade given by a specific professor for their subjects:
SELECT prof.FullName, subj.subjectname, AVG(g.Grade) AS AverageGrade
FROM Professors prof
JOIN Subjects subj ON prof.ProfessorID = subj.ProfessorID
JOIN Grades g ON subj.SubjectID = g.SubjectID
GROUP BY prof.FullName, subj.subjectname;

--9Find the list of courses attended by a specific student::
SELECT s.FullName, subj.SubjectName
FROM Subjects subj
JOIN Grades g ON subj.SubjectID = g.SubjectID
JOIN Students s ON g.StudentID = s.StudentID
WHERE s.FullName = 'Віолетта Кибкало'
group by s.FullName, subj.SubjectName;

--10List the courses taught by a specific professor to a specific student:
SELECT s.FullName AS student, prof.FullName AS Professor, subj.SubjectName
FROM Subjects subj
JOIN Professors prof ON subj.ProfessorID = prof.ProfessorID
JOIN Grades g ON subj.SubjectID = g.SubjectID
JOIN Students s ON g.StudentID = s.StudentID
WHERE s.FullName = 'Віолетта Кибкало'
AND prof.FullName = 'пан Орхип Терещенко'
group by s.FullName, prof.FullName, subj.SubjectName;
