import logging
from random import randint
from faker import Faker
from psycopg2 import DatabaseError
from connect import create_connection

fake = Faker("uk-Ua")
cnt_student = 20
cnt_group = 3
cnt_subject = 7
cnt_prof = 6
cnt_grade = 20


with open("Del&Create.sql", "r", encoding="UTF-8") as f:
    sql_create_tbl = f.read()


def overwrite_tbl(con):
    c = con.cursor()
    try:
        c.execute(sql_create_tbl)
        con.commit()
    except DatabaseError as e:
        logging.error(e)
        con.rollback()
    finally:
        c.close()


def insert_data(con):
    c = con.cursor()
    try:
        for _ in range(cnt_group):
            c.execute("INSERT INTO Groups (GroupName) VALUES (%s)", (fake.word(),))

        for _ in range(cnt_prof):
            c.execute("INSERT INTO Professors (FullName) VALUES (%s)", (fake.name(),))

        for _ in range(cnt_subject):
            c.execute("INSERT INTO Subjects (SubjectName, ProfessorID) VALUES (%s, %s)",
                      (fake.word(), randint(1, cnt_prof)))

        for student in range(1, cnt_student + 1):
            c.execute("INSERT INTO Students (FullName, GroupId) VALUES (%s, %s)", (fake.name(), randint(1, cnt_group)))

        for Student in range(1, cnt_student + 1):
            for grade in range(1, cnt_grade+1):
                c.execute("INSERT INTO Grades (StudentId, SubjectId, Grade, DateReceived) VALUES (%s, %s, %s, %s)",
                          (Student, randint(1, cnt_subject), randint(1, 100), fake.date_this_decade()))

        con.commit()
    except DatabaseError as e:
        logging.error(e)
        con.rollback()
    finally:
        c.close()


if __name__ == '__main__':
    try:
        with create_connection() as con:
            if con is not None:
                overwrite_tbl(con)
                insert_data(con)
            else:
                pass
    except RuntimeError as err:
        print(err)
