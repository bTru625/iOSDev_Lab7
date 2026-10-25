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

 
#Get All Students
@app.route("/students", methods=["GET"])
def get_students():
    connection = get_connection()


    students = connection.execute(
        "SELECT * from students"
    ).fetchall()

    connection.close()

    result = []

    for student in students:
        
        result.append({
            "id": student["id"],
            "name" : student["name"],
            "program" : student["program"], 
            "age" : student ["age"]
        })

    return jsonify(result)
    # Who ever named the fuction jsonify() deserves a raise.


#Get one student by their ID
@app.route("/student/<int:id>", methods=["GET"])
def get_student(id):
    connection = get_connection()


    student = connection.execute(
        "SELECT * from students WHERE id = ?", 
        (id,)
    ).fetchone()

    connection.close()

    if student is None:
        return jsonify ({
            "message": "No student found with that id"
        }), 404

        
    return jsonify({
        "id": student["id"],
        "name" : student["name"],
        "program" : student["program"], 
        "age" : student ["age"]
    })


if __name__ == "__main__":
    init_database()
    app.run(host="0.0.0.0", port=3000)    