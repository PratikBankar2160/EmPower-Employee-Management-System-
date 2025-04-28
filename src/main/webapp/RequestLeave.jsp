<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Request Leave</title>
    <!-- Materialize CSS & Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
    

    <style>
        body {
            background-color: #f0f4f8;
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
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            margin-left:375px;
            max-width: 500px;
            transform: scale(0.8);
            opacity: 0;
            animation: fadeIn 0.5s forwards ease-out;
        }
        @keyframes fadeIn {
            to {
                transform: scale(1);
                opacity: 1;
            }
        }
        .main-content h4 {
            text-align: center;
            margin-bottom: 25px;
            color: #00796b;
        }
        .btn {
            width: 100%;
            margin-top: 10px;
        }
        .btn.grey {
            background-color: #b0bec5;
        }
        .material-icons {
            transition: transform 0.3s ease-in-out;
        }
        .btn:hover .material-icons,
        .input-field:hover .material-icons {
            transform: scale(1.2);
            color: #00796b;
        }
        
    </style>
</head>
<body>
    <div class="navbar">
        <div class="brand-title"> <h5>Employee Management System</h5></div>
        <h5><span> Welcome, <%= (String) session.getAttribute("name") %>!</span></h5>
        <div class="user-info">
            
            <button class="btn red waves-effect" id="logout">
                <i class="material-icons left">exit_to_app</i> Logout
            </button>
        </div>
    </div>

    <div style="display: flex;">
        <div class="sidebar">
            <ul>
                <li><a href="RequestLeave.jsp"><i class="material-icons">event_note</i> Request Leave</a></li>
                <li><a href="ViewLeaveStatus.jsp"><i class="material-icons">assignment_turned_in</i> View Leave Status</a></li>
                <li><a href="Attendance.jsp"><i class="material-icons">access_time</i> Mark Attendance</a></li>
                <li><a href="EmpChangePassword.jsp"><i class="material-icons">lock</i> Change Password</a></li>
            </ul>
        </div>

        <div class="main-content">
        <h4>Request Leave</h4>
        <form action="RequestLeave" method="post">
            <div class="input-field">
                <select name="leave_type" required>
                    <option value="" disabled selected>Choose Leave Type</option>
                    <option value="Sick Leave">Sick Leave</option>
                    <option value="Casual Leave">Casual Leave</option>
                    <option value="Paid Leave">Paid Leave</option>
                </select>
                <label>Leave Type</label>
            </div>
            <div class="input-field">
                <input type="date" name="start_date" required>
                <label>Start Date</label>
            </div>
            <div class="input-field">
                <input type="date" name="end_date" required>
                <label>End Date</label>
            </div>
            <div class="input-field">
                <textarea name="reason" class="materialize-textarea" required></textarea>
                <label>Reason for Leave</label>
            </div>
            <button type="submit" class="btn waves-effect waves-light teal">
                <i class="material-icons left">send</i> Submit
            </button>
            <button type="button" class="btn grey" onclick="window.location.href='employee_home.jsp'">
                <i class="material-icons left">arrow_back</i> Cancel
            </button>
        </form>
    </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            M.FormSelect.init(document.querySelectorAll('select'));
        });
    </script>

    <script>
        $(document).ready(function(){
            $('select').formSelect();
        });
        
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
