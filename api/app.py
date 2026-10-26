from dbm import error

from flask import Flask, jsonify, request
import sqlite3


app = Flask(__name__)


def init_database():
    connection = sqlite3.connect("api/students.db")
    cursor = connection.cursor()

    cursor.execute(
        """
        CREATE TABLE IF NOT EXISTS students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            program TEXT NOT NULL,
            age INTEGER NOT NULL
        )
        """
    )

    cursor.execute("SELECT COUNT(*) FROM students")
    count = cursor.fetchone()[0]

    if count == 0:
        students = [
            ("Alice", "Computer Science", 21),
            ("Bob", "Business", 23),
            ("Charlie", "Computer Science", 20),
        ]
        cursor.executemany(
            """
            INSERT INTO students(name, program, age)
            VALUES (?, ?, ?)
            """,
            students,
        )

    connection.commit()
    connection.close()


def get_connection():
    connection = sqlite3.connect("api/students.db")
    connection.row_factory = sqlite3.Row
    return connection


@app.route("/students/program/<program>", methods=["GET"])
def get_students_by_program(program):
    result = []

    connection = get_connection()
    cursor = connection.cursor()

    students = cursor.execute(
        """
        SELECT * FROM students
        WHERE students.program = ?
        """,
        (program,),
    ).fetchall()

    for student in students:
        result.append({
            "id": student["id"],
            "name": student["name"],
            "program": student["program"],
            "age": student["age"],
        })

    connection.close()

    return jsonify(result)


@app.route("/students/statistics/average-age", methods=["GET"])
def get_average_age():
    connection = get_connection()
    cursor = connection.cursor()

    result = cursor.execute(
        """
        SELECT AVG(age) from students
        """
    ).fetchone()

    connection.close()

    return jsonify({"average_age": result[0]})


if __name__ == "__main__":
    init_database()
    app.run(host="0.0.0.0", port=3000)