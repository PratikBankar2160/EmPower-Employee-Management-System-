<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    // Session validation
    if (session == null || session.getAttribute("u_id") == null || session.getAttribute("loggedIn") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("Employee")) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<%
    String toastMessage = null;
    String toastType = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = (String) session.getAttribute("email");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (email == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            toastMessage = " New password and confirm password do not match!";
            toastType = "error";
        } else {
            try (Connection con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023")) {
                try (PreparedStatement ps = con.prepareStatement("SELECT * FROM user_info WHERE email = ? AND password = ?")) {
                    ps.setString(1, email);
                    ps.setString(2, oldPassword);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        try (PreparedStatement psUpdate = con.prepareStatement("UPDATE user_info SET password = ? WHERE email = ?")) {
                            psUpdate.setString(1, newPassword);
                            psUpdate.setString(2, email);

                            if (psUpdate.executeUpdate() > 0) {
                                toastMessage = " Password changed successfully!";
                                toastType = "success";
                            } else {
                                toastMessage = " Failed to change password. Try again!";
                                toastType = "error";
                            }
                        }
                    } else {
                        toastMessage = " Old password is incorrect!";
                        toastType = "error";
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                toastMessage = " Error occurred! Please try again later.";
                toastType = "error";
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <!-- Materialize CSS & Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body {
            background-color: #eef1f7;
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #2c3e50;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px 20px;
        }

        .sidebar {
            background-color: #2c3e50;
            width: 250px;
            height: 100vh;
            color: #fff;
            padding: 20px;
            box-sizing: border-box;
        }

        .sidebar ul li a {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #fff;
            padding: 12px 15px;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .sidebar ul li:hover a {
            background-color: #1abc9c;
        }

        .main-content {
            margin-left: 270px;
            padding: 30px;
            height: calc(100vh - 96px);
            overflow-y: auto;
        }

        .animated-heading {
            font-size: 28px;
            color: #2c3e50;
            text-align: center;
            margin-bottom: 20px;
            animation: fadeIn 1s ease-in-out;
        }

        .password-form {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 1px 10px 80px rgba(18, 47, 209, 0.537), -20px -0px 30px rgba(208, 6, 235, 0.203);
            animation: slideIn 0.5s ease-in-out;
        }

        .input-field .material-icons {
            color: #1abc9c;
            transition: transform 0.3s ease-in-out;
        }

        .input-field input:focus + label,
        .input-field input:focus ~ .material-icons {
            color: #3498db;
            transform: scale(1.3);
        }

        .btn-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 20px;
        }

        .btn {
            border-radius: 8px;
            transition: background 0.3s, transform 0.2s;
        }

        .btn:hover {
            background: #1abc9c;
            transform: scale(1.05);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-10px); }
            to { opacity: 1; transform: translateX(0); }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <div class="brand-title"><h5>Employee Management System</h5></div>
        <h5><span>Welcome, <%= (String) session.getAttribute("name") %>!</span></h5>
        <div class="user-info">
            <button class="btn red waves-effect" id="logout">
                <i class="material-icons left">exit_to_app</i> Logout
            </button>
        </div>
    </div>

    <div style="display: flex;">
        <!-- Sidebar -->
        <div class="sidebar">
            <ul>
                <li><a href="RequestLeave.jsp"><i class="material-icons">event_note</i> Request Leave</a></li>
                <li><a href="ViewLeaveStatus.jsp"><i class="material-icons">assignment_turned_in</i> View Leave Status</a></li>
                <li><a href="Attendance.jsp"><i class="material-icons">access_time</i> Mark Attendance</a></li>
                <li><a href="EmpChangePassword.jsp"><i class="material-icons">lock</i> Change Password</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="container">
                <h2 class="animated-heading">&#x1F512; Change Password</h2>

                <!-- Toast Notification -->
                <% if (toastMessage != null) { %>
                    <script>
                        document.addEventListener('DOMContentLoaded', function() {
                            M.toast({
                                html: `<i class="material-icons left"><%= "success".equals(toastType) ? "check_circle" : "error" %></i> 
                                        <%= toastMessage %>`,
                                classes: '<%= "success".equals(toastType) ? "green" : "red" %> rounded'
                            });
                        });
                    </script>
                <% } %>

                <form action="EmpChangePassword.jsp" method="post" class="password-form">
                    <div class="input-field">
                        <i class="material-icons prefix">lock_outline</i>
                        <input type="password" name="oldPassword" id="oldPassword" required>
                        <label for="oldPassword">Old Password</label>
                    </div>

                    <div class="input-field">
                        <i class="material-icons prefix">vpn_key</i>
                        <input type="password" name="newPassword" id="newPassword" required>
                        <label for="newPassword">New Password</label>
                    </div>

                    <div class="input-field">
                        <i class="material-icons prefix">check_circle</i>
                        <input type="password" name="confirmPassword" id="confirmPassword" required>
                        <label for="confirmPassword">Confirm New Password</label>
                    </div>

                    <div class="btn-group">
                        <button type="submit" class="btn waves-effect waves-light green">
                            &#x1F510; Change Password
                        </button>
                        <button type="button" class="btn waves-effect waves-light blue" 
                                onclick="window.location.href='employee_home.jsp'">
                            &#x2B05; Back
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $("#logout").on("click", function() {
                // Clear the Email cookie
                document.cookie = "Email=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/";

                // Show logout message
                M.toast({html: "Logging out...", classes: "red"});

                // Redirect after 1 second
                setTimeout(function() {
                    window.location.href = "Login.jsp";
                }, 1000);
            });
        });
    </script>
</body>
</html>