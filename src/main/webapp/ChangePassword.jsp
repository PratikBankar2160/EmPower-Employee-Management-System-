<%@ page import="java.sql.*" %>
<%@ page session="true" %>



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
    <title>Change Password</title>
     <!-- Materialize CSS & Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<!-- Materialize CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
	
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        .project-name {
        font-size: 24px;
        font-weight: bold;
        letter-spacing: 1px;
        text-transform: uppercase;
        color: gold;
    }

    body {
        background-color: #eef1f7;
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
    }

    .top-navbar {
        background: #2c3e50;
        padding: 30px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: white;
    }

    .top-navbar h5 {
        margin: 0;
        font-weight: bold;
    }

    .top-navbar .nav-buttons .btn {
        margin-left: 10px;
        transition: 0.3s;
        border-radius: 8px;
    }

    .top-navbar .btn:hover {
        background: #1abc9c;
        transform: scale(1.05);
    }

    .sidebar {
        position: fixed;
        left: 0;
        top: 96px;
        width: 250px;
        height: calc(100vh - 60px);
        background: #2c3e50;
        padding-top: 20px;
    }

    .sidebar ul {
        list-style: none;
        padding: 0;
    }

    .sidebar ul li {
        padding: 15px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        transition: 0.3s;
    }

    .sidebar ul li a {
        text-decoration: none;
        color: white;
        display: flex;
        align-items: center;
        font-size: 16px;
        transition: 0.3s;
    }

    .sidebar ul li a i {
        margin-right: 10px;
    }

    .sidebar ul li:hover {
        background: #1abc9c;
        padding-left: 20px;
        transform: scale(1.05);
        border-radius: 0 10px 10px 0;
    }
    /* Main Content - Scrollable */
        .main-content {
            margin-left: 270px;
            margin-top: px;
            padding: 20px;
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
        box-shadow:1px 10px 80px rgba(18, 47, 209, 0.537), -20px -0px 30px rgba(208, 6, 235, 0.203);
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
	<!-- Top Navbar -->
    <div class="top-navbar">
        <div class="project-name">Employee Management System</div>
        <h5>Welcome <%= session.getAttribute("name") %>.!</h5>
        <div class="nav-buttons">
            <!-- <button class="btn blue waves-effect" onclick="window.location.href='Attendance.jsp'">
                <i class="material-icons left">check_circle</i> Mark Attendance
            </button> -->
            <button class="btn blue waves-effect" onclick="window.location.href='report.jsp'">Attendance Report</button>

            <button class="btn red waves-effect" id="logout">
                <i class="material-icons left">exit_to_app</i> Logout
            </button>
        </div>
    </div>

    <!-- Left Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="Add.jsp"><i class="material-icons">person_add</i> Add Employee</a></li>
            <li><a href="users" onclick="document.getElementById('fetchForm').submit(); return false;"><i class="material-icons">visibility</i> View Employees</a></li>
            <li><a href="Search.jsp"><i class="material-icons">search</i> Search Employee</a></li>
            <li><a href="Update.jsp"><i class="material-icons">edit</i> Modify Employee</a></li>
            <li><a href="Delete.jsp"><i class="material-icons">delete</i> Delete Employee</a></li>
            <li>
			    <a href="ChangePassword.jsp">
			        <i class="material-icons">lock</i> Change Password
			    </a>
			</li>
        </ul>
    </div>
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

        <form action="ChangePassword.jsp" method="post" class="password-form">
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
				        onclick="window.location.href='hr_home.jsp'">
				    &#x2B05; Back
				</button>

            </div>
        </form>
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
