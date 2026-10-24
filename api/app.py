from dbm import error

from flask import Flask, jsonify, request
import sqlite3


app = Flask(__name__)


def init_database():
    connection = sqlite3.connect("students.db")
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
    connection = sqlite3.connect("students.db")
    connection.row_factory = sqlite3.Row
    return connection
