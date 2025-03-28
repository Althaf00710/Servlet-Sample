package org.example.student.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
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
                case "/get":
                    getStudent(request, response);
                    break;
                case "/search":
                    searchStudents(request, response);
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

    private void searchStudents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private void viewStudents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Student> students = studentDAO.getStudent();
        request.setAttribute("students", students);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }

    private void getStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.getStudent(id);

        Gson gson = new Gson();
        JsonObject jsonResponse = new JsonObject();

        if (student != null) {
            String studentJson = gson.toJson(student);
            response.getWriter().write(studentJson);
        } else {
            jsonResponse.addProperty("error", "Student not found");
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write(gson.toJson(jsonResponse));
        }
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");

        Student student = new Student();
        student.setName(name);
        student.setAge(age);
        student.setAddress(address);
        student.setPhone(phone);
        student.setGender(gender);

        studentDAO.addStudent(student);
        response.sendRedirect(request.getContextPath() + "/students/view");
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");


        Student student = new Student();
        student.setId(id);
        student.setName(name);
        student.setAge(age);
        student.setAddress(address);
        student.setPhone(phone);
        student.setGender(gender);

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
