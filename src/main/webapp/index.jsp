<%@ page import="org.example.student.model.Student" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Students</title>
    <script src="https://unpkg.com/@tailwindcss/browser@4"></script>
    <script src="${pageContext.request.contextPath}/modalFunction.js"></script>
    <link rel="stylesheet" href="https://cdn-uicons.flaticon.com/2.1.0/uicons-regular-rounded/css/uicons-regular-rounded.css">
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
                        <a href="#" class="text-orange-600 hover:text-orange-900 px-3 py-1 rounded-3xl hover:bg-orange-200 flex items-center" onclick="openEditStudentModal(<%= student.getId() %>)">
                            <i class="fi fi-rr-pencil mr-2"></i>
                            Edit
                        </a>
                        <form action="<%= request.getContextPath() %>/students/delete" method="post" class="inline">
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

<%--//Popup Modal--%>
<div id="Modal" class="hidden fixed inset-0 flex items-center justify-center bg-opacity-50 h-full w-full
                               bg-gray-200/32 border border-gray-50/48 rounded-2xl
                               shadow-lg backdrop-blur-[9px]">
    <div class="modal-animation relative p-5 border w-1/3 shadow-lg rounded-2xl bg-white">
        <!-- Modal Header -->
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-lg font-semibold text-gray-700">Add New Student</h3>
            <button onclick="closeModal()" class="text-gray-400 hover:text-gray-600">
                <i class="fi fi-rr-cross-small text-xl"></i>
            </button>
        </div>

        <!-- Add Student Form -->
        <form action="${pageContext.request.contextPath}/students/add" method="post">
            <div class="space-y-4">
                <!-- Student Name -->
                <div class="relative">
                    <label class="block text-sm font-medium text-gray-700">Full Name</label>
                    <input type="text" name="name" required
                           class="mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                </div>

                <div class="relative">
                    <label class="block text-sm font-medium text-gray-700">Age</label>
                    <input type="number" name="age" required
                           class="mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                </div>

                <!-- Address -->
                <div class="relative">
                    <label class="block text-sm font-medium text-gray-700">Address</label>
                    <input type="text" name="address" required
                           class="mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                </div>

                <!-- Phone -->
                <div class="relative">
                    <label class="block text-sm font-medium text-gray-700">Phone</label>
                            <i class="fi fi-rr-phone-call absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                            <input type="tel" name="phone" placeholder="Enter phone number"
                                   class="block w-full px-3 py-2 pl-10 rounded-r-lg focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                </div>

                <div class="relative">
                    <label class="block text-sm font-medium text-gray-700">Gender</label>
                    <select type="email" name="gender" required
                           class="mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                        <option value="Male" name="male">Male</option>
                        <option value="Female" name="male">Female</option>
                    </select>
                </div>

                <!-- Submit Button -->
                <div class="pt-4">
                    <button type="submit"
                            class="w-full bg-orange-500 hover:bg-orange-600 text-white font-medium py-2 px-4 rounded-lg transition-colors duration-200">
                        Add Customer
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Edit Student Modal -->
<div id="EditStudentModal" class="hidden fixed inset-0 flex items-center justify-center bg-opacity-50 h-full w-full
                               bg-gray-200/32 border border-gray-50/48 rounded-2xl
                               shadow-lg backdrop-blur-[9px]">
    <div class="modal-animation relative p-5 border w-1/3 shadow-lg rounded-2xl bg-white">
        <!-- Modal Header -->
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-lg font-semibold text-gray-700">Edit Student</h3>
            <button onclick="closeModal()" class="text-gray-400 hover:text-gray-600">
                <i class="fi fi-rr-cross-small text-xl"></i>
            </button>
        </div>

        <!-- Edit Student Form -->
        <form action="${pageContext.request.contextPath}/students/update" method="post">
            <div class="space-y-4">
                <input type="hidden" name="id">

                <!-- Student Name -->
                <div class="relative">
                    <label class="block text-sm font-medium text-gray-700">Full Name</label>
                    <input type="text" name="name" required
                           class="mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                </div>

                <div class="relative">
                    <label class="block text-sm font-medium text-gray-700">Age</label>
                    <input type="number" name="age" required
                           class="mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                </div>

                <!-- Address -->
                <div class="relative">
                    <label class="block text-sm font-medium text-gray-700">Address</label>
                    <input type="text" name="address" required
                           class="mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                </div>

                <!-- Phone -->
                <div class="relative">
                    <label class="block text-sm font-medium text-gray-700">Phone</label>
                    <input type="tel" name="phone" required
                           class="block w-full px-3 py-2 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                </div>

                <!-- Gender -->
                <div class="relative">
                    <label class="block text-sm font-medium text-gray-700">Gender</label>
                    <select name="gender" required
                            class="mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2 focus:ring-2 focus:ring-orange-500 focus:border-orange-500">
                        <option value="Male" name="Male">Male</option>
                        <option value="Female" name="Female">Female</option>
                    </select>
                </div>

                <!-- Submit Button -->
                <div class="pt-4">
                    <button type="submit"
                            class="w-full bg-orange-500 hover:bg-orange-600 text-white font-medium py-2 px-4 rounded-lg transition-colors duration-200">
                        Update Student
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>


</body>
</html>