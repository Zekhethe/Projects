import tkinter as tk
from tkinter import messagebox
import sqlite3

class StudentLecturerManagementSystem:
    def __init__(self, root):
        self.root = root
        self.root.title("Student and Lecturer Management System")

        # Connect to SQLite database
        self.conn = sqlite3.connect("sms_database.db")
        self.cur = self.conn.cursor()

        # Create tables if they don't exist
        self.create_tables()

        # GUI elements
        self.student_label = tk.Label(root, text="Student Name:")
        self.student_label.grid(row=0, column=0, padx=10, pady=5)
        self.student_entry = tk.Entry(root)
        self.student_entry.grid(row=0, column=1, padx=10, pady=5)

        self.add_student_button = tk.Button(root, text="Add Student", command=self.add_student)
        self.add_student_button.grid(row=0, column=2, padx=10, pady=5)

        self.lecturer_label = tk.Label(root, text="Lecturer Name:")
        self.lecturer_label.grid(row=1, column=0, padx=10, pady=5)
        self.lecturer_entry = tk.Entry(root)
        self.lecturer_entry.grid(row=1, column=1, padx=10, pady=5)

        self.add_lecturer_button = tk.Button(root, text="Add Lecturer", command=self.add_lecturer)
        self.add_lecturer_button.grid(row=1, column=2, padx=10, pady=5)

        self.view_records_button = tk.Button(root, text="View Records", command=self.view_records)
        self.view_records_button.grid(row=2, columnspan=3, padx=10, pady=5)

    def create_tables(self):
        self.cur.execute('''CREATE TABLE IF NOT EXISTS students (
                            id INTEGER PRIMARY KEY,
                            name TEXT NOT NULL)''')

        self.cur.execute('''CREATE TABLE IF NOT EXISTS lecturers (
                            id INTEGER PRIMARY KEY,
                            name TEXT NOT NULL)''')

        self.conn.commit()

    def add_student(self):
        name = self.student_entry.get().strip()
        if name:
            self.cur.execute("INSERT INTO students (name) VALUES (?)", (name,))
            self.conn.commit()
            messagebox.showinfo("Success", "Student added successfully.")
            self.student_entry.delete(0, tk.END)
        else:
            messagebox.showerror("Error", "Please enter a student name.")

    def add_lecturer(self):
        name = self.lecturer_entry.get().strip()
        if name:
            self.cur.execute("INSERT INTO lecturers (name) VALUES (?)", (name,))
            self.conn.commit()
            messagebox.showinfo("Success", "Lecturer added successfully.")
            self.lecturer_entry.delete(0, tk.END)
        else:
            messagebox.showerror("Error", "Please enter a lecturer name.")

    def view_records(self):
        students = self.cur.execute("SELECT * FROM students").fetchall()
        lecturers = self.cur.execute("SELECT * FROM lecturers").fetchall()

        if students or lecturers:
            record_window = tk.Toplevel(self.root)
            record_window.title("View Records")

            if students:
                student_label = tk.Label(record_window, text="Students:")
                student_label.grid(row=0, column=0, padx=10, pady=5)
                student_listbox = tk.Listbox(record_window)
                student_listbox.grid(row=1, column=0, padx=10, pady=5)
                for student in students:
                    student_listbox.insert(tk.END, student[1])

            if lecturers:
                lecturer_label = tk.Label(record_window, text="Lecturers:")
                lecturer_label.grid(row=0, column=1, padx=10, pady=5)
                lecturer_listbox = tk.Listbox(record_window)
                lecturer_listbox.grid(row=1, column=1, padx=10, pady=5)
                for lecturer in lecturers:
                    lecturer_listbox.insert(tk.END, lecturer[1])
        else:
            messagebox.showinfo("Info", "No records found.")

    def __del__(self):
        self.conn.close()

if __name__ == "__main__":
    root = tk.Tk()
    app = StudentLecturerManagementSystem(root)
    root.mainloop()

import tkinter as tk
import sqlite3


class StudentLecturerManagementSystem:
    def __init__(self, root):
        self.root = root
        self.root.title("Student and Lecturer Management System")

        # Connect to SQLite database
        self.conn = sqlite3.connect("sms_database.db")
        self.cur = self.conn.cursor()

        # Create student and lecturer tables if they don't exist
        self.cur.execute('''CREATE TABLE IF NOT EXISTS students (
                            id INTEGER PRIMARY KEY,
                            name TEXT NOT NULL,
                            age INTEGER)''')
        self.cur.execute('''CREATE TABLE IF NOT EXISTS lecturers (
                            id INTEGER PRIMARY KEY,
                            name TEXT NOT NULL,
                            department TEXT)''')
        self.conn.commit()

        # GUI elements
        self.student_label = tk.Label(root, text="Student Name:")
        self.student_label.pack()
        self.student_entry = tk.Entry(root)
        self.student_entry.pack()

        self.add_student_button = tk.Button(root, text="Add Student", command=self.add_student)
        self.add_student_button.pack()

        self.lecturer_label = tk.Label(root, text="Lecturer Name:")
        self.lecturer_label.pack()
        self.lecturer_entry = tk.Entry(root)
        self.lecturer_entry.pack()

        self.add_lecturer_button = tk.Button(root, text="Add Lecturer", command=self.add_lecturer)
        self.add_lecturer_button.pack()

        # Display student and lecturer records
        self.student_listbox = tk.Listbox(root)
        self.student_listbox.pack()

        self.lecturer_listbox = tk.Listbox(root)
        self.lecturer_listbox.pack()

        self.display_records()

    def add_student(self):
        name = self.student_entry.get()
        if name:
            self.cur.execute("INSERT INTO students (name) VALUES (?)", (name,))
            self.conn.commit()
            self.display_records()

    def add_lecturer(self):
        name = self.lecturer_entry.get()
        if name:
            self.cur.execute("INSERT INTO lecturers (name) VALUES (?)", (name,))
            self.conn.commit()
            self.display_records()

    def display_records(self):
        # Clear existing records
        self.student_listbox.delete(0, tk.END)
        self.lecturer_listbox.delete(0, tk.END)

        # Fetch and display student records
        self.cur.execute("SELECT * FROM students")
        students = self.cur.fetchall()
        for student in students:
            self.student_listbox.insert(tk.END, student[1])  # Display student names

        # Fetch and display lecturer records
        self.cur.execute("SELECT * FROM lecturers")
        lecturers = self.cur.fetchall()
        for lecturer in lecturers:
            self.lecturer_listbox.insert(tk.END, lecturer[1])  # Display lecturer names

    def __del__(self):
        self.conn.close()


if __name__ == "__main__":
    root = tk.Tk()
    app = StudentLecturerManagementSystem(root)
    root.mainloop()
