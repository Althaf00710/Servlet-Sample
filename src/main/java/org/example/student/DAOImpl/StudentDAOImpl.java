package org.example.student.DAOImpl;

import org.example.student.DAO.StudentDAO;
import org.example.student.model.Student;
import org.example.student.util.DbConfig;

import java.util.List;

public class StudentDAOImpl implements StudentDAO {
    private final DbConfig dbConfig = DbConfig.getInstance();

    @Override
    public Student getStudent(int id) {
        return null;
    }

    @Override
    public List<Student> getStudents() {
        return List.of();
    }

    @Override
    public void addStudent(Student student) {

    }

    @Override
    public void updateStudent(Student student) {

    }

    @Override
    public void deleteStudent(int id) {

    }
}
