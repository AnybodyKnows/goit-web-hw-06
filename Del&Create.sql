
-- Удаление таблицы, если она существует, перед созданием
DROP TABLE IF EXISTS Students CASCADE;
DROP TABLE IF EXISTS Groups CASCADE;
DROP TABLE IF EXISTS Professors CASCADE;
DROP TABLE IF EXISTS Subjects CASCADE;
DROP TABLE IF EXISTS Grades CASCADE;

-- Создание таблицы групп
CREATE TABLE Groups (
    GroupID SERIAL PRIMARY KEY,
    GroupName VARCHAR(50)
);

-- Создание таблицы студентов
CREATE TABLE Students (
    StudentID SERIAL PRIMARY KEY,
    FullName VARCHAR(50),
    GroupID INT,
    FOREIGN KEY (GroupID) REFERENCES Groups(GroupID)
);


-- Создание таблицы преподавателей
CREATE TABLE Professors (
    ProfessorID SERIAL PRIMARY KEY,
    FullName VARCHAR(50)
);

-- Создание таблицы предметов
CREATE TABLE Subjects (
    SubjectID SERIAL PRIMARY KEY,
    SubjectName VARCHAR(100),
    ProfessorID INT,
    FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID)
);

-- Создание таблицы оценок
CREATE TABLE Grades (
    GradeID SERIAL PRIMARY KEY,
    StudentID INT,
    SubjectID INT,
    Grade INT,
    DateReceived DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);