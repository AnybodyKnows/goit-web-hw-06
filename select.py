from connect import create_connection

with open("Select.sql", "r", encoding="UTF-8") as f:
    sql = f.read()
    sqls = sql.split(";")
    sqls = sqls[:10]

with create_connection() as con:
    if con is not None:
        cur = con.cursor()
        for sql in sqls:
            print(sql)
            cur.execute(sql)
            rows = cur.fetchall()
            for row in rows:
                print(row)
    else:
        pass
