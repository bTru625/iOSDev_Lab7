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
    # Who ever named the function jsonify() deserves a raise.


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


@app.route("/students/program/<program>", methods=["GET"])
def get_students_by_program(program):
    result = []

    connection = get_connection()
    cursor = connection.cursor()

    students = cursor.execute(
        """
        SELECT * FROM students
        WHERE LOWER(students.program) = LOWER(?)
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


@app.route("/students/sort/age", methods=["GET"])
def get_students_sorted_by_age():
    connection = get_connection()

    students = connection.execute(
        "SELECT * FROM students ORDER BY age ASC"
    ).fetchall()

    connection.close()

    result = []

    for student in students:
        result.append({
            "id": student["id"],
            "name": student["name"],
            "program": student["program"],
            "age": student["age"],
        })

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

    return jsonify({"average_age": result[0]})




def validate_student(data):
    if "name" not in data:
        return "Name is required"
    
    if "program" not in data:
        return "Program is required"
    
    if "age" not in data:
        return "Age is required"
    
    if data["name"].strip() == "":
        return "Name cannot be empty"
    
    if data["program"].strip() == "":
        return "Program cannot be empty"
    
    if not isinstance(data["age"], int):
        return "Age must be an integer"
    
    if data["age"] < 16 or data["age"] > 100:
        return "Age must be between 16 and 100"
    
    return None

#add_one_student_to_db
@app.route("/students", methods=["POST"])
def add_student():
    data = request.get_json(force=True)
    error = validate_student(data)
    if error is not None:
        return jsonify({
            "message": error
        }), 400
    connection = get_connection()

    cursor = connection.cursor()
    cursor.execute(
        """
        INSERT INTO students(name, program, age)
        VALUES (?, ?, ?)
        """,
        (
            data["name"],
            data["program"],
            data["age"]
        )
    )
    connection.commit()

    new_id = cursor.lastrowid

    connection.close()

    return jsonify({
        "id": new_id,
        "name": data["name"],
        "program": data["program"],
        "age": data["age"]
    }), 201

#update_student_info
@app.route("/students/<int:id>", methods = ["PUT"])
def update_student(id):
    data = request.get_json()
    
    error = validate_student(data)

    if error is not None: 

        return jsonify({
            "message": error
        }), 400

    connection = get_connection()

    student = connection.execute(
        "SELECT * FROM students WHERE id = ?",
        (id, )
    ).fetchone()

    if student is None:

        connection.close()

        return jsonify({
            "message": "Student not found"
        }), 404

    connection.execute(
        """
        UPDATE students
        SET name = ?, program = ?, age = ?
        WHERE id = ?
        """,
        (
            data["name"],
            data["program"],
            data["age"],
            id
        )
    )

    connection.commit()
    connection.close()

    return jsonify({
        "id": id,
        "name": data["name"],
        "program": data["program"],
        "age": data["age"]
    })

#delete_student_info
@app.route("/students/<int:id>", methods=["DELETE"])
def delete_student(id):

    connection = get_connection()

    student = connection.execute(
        "SELECT * FROM students WHERE id = ?",
        (id,)
    ).fetchone()

    if student is None:
        connection.close()

        return jsonify({
            "message": "Student not found"
        }), 404

    connection.execute(
        "DELETE FROM students WHERE id = ?",
        (id,)
    )

    connection.commit()
    connection.close()

    return jsonify({
        "message": "Student deleted succesfully"
    })

if __name__ == "__main__":
    init_database()
    app.run(host="0.0.0.0", port=3000)
