package org.example.student.DAO;

import org.example.student.model.Student;

import java.util.List;

public interface StudentDAO {
    public Student getStudent(int id);
    public List<Student> getStudent();
    public void addStudent(Student student);
    public void updateStudent(Student student);
    public void deleteStudent(int id);
    public List<Student> getStudentByName(String name);
}
