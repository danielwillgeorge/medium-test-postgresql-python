#!/usr/bin/env python
import subprocess
import psycopg2


def main():
    output = subprocess.check_output("pg_tmp -t", shell=True)
    print(output)

    conn = psycopg2.connect(output)
    cur = conn.cursor()

    cur.execute("CREATE TABLE trees (id VARCHAR (13), common_name VARCHAR (50), scientific_name VARCHAR (50));")
    cur.execute("INSERT INTO trees (id, common_name, scientific_name) VALUES (1, 'California Redwood', 'Sequoia sempervirens')")
    cur.execute("SELECT * FROM trees;")

    print(cur.fetchone())

    cur.close()
    conn.close()

if __name__ == "__main__":
    main()
