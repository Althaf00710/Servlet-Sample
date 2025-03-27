package org.example.student.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.student.DAO.StudentDAO;
import org.example.student.DAOImpl.StudentDAOImpl;
import org.example.student.model.Student;

import java.io.IOException;
import java.util.List;

@WebServlet("/students/*")
public class StudentController extends HttpServlet {
    private final StudentDAO studentDAO = new StudentDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/view";

        try {
            switch (action) {
                case "/view":
                    viewStudents(request, response);
                    break;
                case "/search":
                    //searchStudent(request, response);
                    break;
                default:
                    show404(request, response);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/add";
        try {
            switch (action) {
                case "/add":
                    addStudent(request, response);
                    break;
                case "/update":
                    updateStudent(request, response);
                    break;
                case "/delete":
                    deleteStudent(request, response);
                    break;
                default:
                    show404(request, response);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void viewStudents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Student> students = studentDAO.getStudents();
        request.setAttribute("students", students);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }

    private void searchStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        Student student = studentDAO.getStudent(id);
//
//        if (student != null) {
//            request.setAttribute("student", student);
//            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
//            dispatcher.forward(request, response);
//        } else {
//            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Student not found.");
//        }
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));

        Student student = new Student();
        student.setName(name);
        student.setAge(age);

        studentDAO.addStudent(student);
        response.sendRedirect(request.getContextPath() + "/students/view");
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));

        Student student = new Student();
        student.setId(id);
        student.setName(name);
        student.setAge(age);

        studentDAO.updateStudent(student);
        response.sendRedirect(request.getContextPath() + "/students/view");
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        studentDAO.deleteStudent(id);
        response.sendRedirect(request.getContextPath() + "/students/view");
    }

    private void show404(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Page not found.");
    }

}
