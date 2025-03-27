<%@ page import="org.example.student.model.Student" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Students</title>
    <script src="https://unpkg.com/@tailwindcss/browser@4"></script>
</head>
<body>
<div class="mouse-circle"></div>
<div class="flex-1 p-8 pt-4">
    <!-- Header Section -->
    <div class="flex justify-between items-center mb-6 gap-4">
        <h1 class="text-2xl font-medium text-gray-600 whitespace-nowrap">Students</h1>

        <!-- Search Bar -->
        <div class="flex-1 max-w-md relative">
            <div class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-400 z-3">
                <i class="fi fi-rr-search text-lg"></i>
            </div>
            <form action="${pageContext.request.contextPath}/students/search" method="GET" class="relative">
                <input type="text"
                       id="searchInput"
                       name="searchTerm"
                       placeholder="Search Students..."
                       class="w-full px-4 py-2 rounded-3xl border border-gray-300 focus:outline-none focus:ring-2 focus:ring-orange-500 pl-10 pr-16 transition-colors duration-200 hover:border-gray-400 bg-white">
                <button type="submit"
                        class="absolute right-2 top-1/2 transform -translate-y-1/2 px-8 py-1 rounded-3xl bg-gray-100 text-orange-600 font-semibold hover:bg-gray-200 hover:text-orange-400 transition-colors duration-350 z-3 cursor-pointer">
                    GO
                </button>
            </form>
        </div>

        <!-- Add Customer Button -->
        <button onclick="openModal()" class="bg-orange-500 hover:bg-orange-600 text-white px-4 py-2 rounded-3xl flex items-center transition-colors duration-200 whitespace-nowrap">
            <i class="fi fi-rr-plus mr-2"></i>
            Add Student
        </button>
    </div>

    <!-- Customers Table -->
    <div class="bg-white rounded-lg shadow overflow-hidden relative">
        <table class="min-w-full divide-y divide-gray-200" id="customersTable">
            <thead class="bg-gray-200">
            <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Id</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student Name</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Age</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Gender</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Phone</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Address</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
            <%
                List<Student> students = (List<Student>) request.getAttribute("students");
                if (students != null) {
                    for (Student student : students) {
            %>
            <tr>
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="flex items-center">
                        <div class="ml-4">
                            <div class="text-sm font-medium text-gray-900">
                                <%= student.getId() %>
                            </div>
                        </div>
                    </div>
                </td>

                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    <%= student.getName() %>
                </td>

                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    <%= student.getAge() %>
                </td>

                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    <%= student.getGender() %>
                </td>

                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    <%= student.getPhone() %>
                </td>

                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                    <%= student.getAddress() %>
                </td>

                <!-- Actions -->
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                    <div class="flex items-center space-x-3">
                        <a href="#" class="text-orange-600 hover:text-orange-900 px-3 py-1 rounded-3xl hover:bg-orange-200 flex items-center" onclick="openEditDriverModal(<%= student.getId() %>)">
                            <i class="fi fi-rr-pencil mr-2"></i>
                            Edit
                        </a>
                        <form action="<%= request.getContextPath() %>/customers/delete" method="post" class="inline">
                            <input type="hidden" name="id" value="<%= student.getId() %>">
                            <button type="submit" class="text-red-600 hover:text-red-900 px-3 py-1 rounded-3xl hover:bg-red-200 flex items-center">
                                <i class="fi fi-rr-trash mr-2"></i>
                                Delete
                            </button>
                        </form>
                    </div>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>