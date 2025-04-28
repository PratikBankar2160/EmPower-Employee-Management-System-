<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
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
    <title>View Leave Status</title>
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

        .input-field i {
            position: absolute;
            left: 0;
            top: 13px;
            color: #2c3e50;
        }

        .input-field input, .input-field textarea {
            padding-left: 30px;
        }

        .btn i {
            margin-right: 5px;
        }

        .card {
            background: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 1px 10px 80px rgba(18, 47, 209, 0.537), -20px -0px 30px rgba(208, 6, 235, 0.203);
            text-align: center;
        }

        table {
		    width: 100%; /* Slightly wider for better spacing */
		    margin: 50px auto;
		    border-collapse: collapse;
		    background-color: #fff;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
		    border-radius: 8px; /* Rounded corners */
		    overflow: hidden; /* Ensures rounded corners are visible */
		}
		
		table th, table td {
		    padding: 15px;
		    text-align: center;
		    border-bottom: 1px solid #ddd; /* Light border between rows */
		}
		
		table th {
		    background-color: #2c3e50; /* Dark header background */
		    color: #fff; /* White text for headers */
		    font-weight: 600; /* Bold headers */
		    text-transform: uppercase; /* Uppercase headers */
		}
		
		table tr {
		    transition: background-color 0.3s ease; /* Smooth hover transition */
		}
		
		table tr:hover {
		    background-color: #f5f5f5; /* Light gray hover effect */
		}
		
		table td {
		    color: #333; /* Dark text for better readability */
		}
		
		/* Add a border to the table */
		table {
		    border: 1px solid #ddd; /* Light border around the table */
		}
		
		/* Add a hover effect to table rows */
		table tr:hover {
		    background-color: #e0f7fa; /* Light blue hover effect */
		    cursor: pointer; /* Change cursor to pointer on hover */
		}
		
		/* Style the first column (Leave Type) */
		table td:first-child {
		    font-weight: 500; /* Slightly bold for emphasis */
		}
		
		/* Style the status column */
		table td:nth-child(5) {
		    font-weight: 600; /* Bold status text */
		    color: #1abc9c; /* Green color for approved status */
		}
		
		/* Add a subtle animation to the table rows */
		@keyframes fadeIn {
		    from { opacity: 0; transform: translateY(10px); }
		    to { opacity: 1; transform: translateY(0); }
		}
		
		table tbody tr {
		    animation: fadeIn 0.5s ease-in-out; /* Fade-in animation for rows */
		}
		.back-btn {
		    background-color: #607D8B;
		    color: #fff;
		    border: none;
		    border-radius: 4px;
		    padding: 8px 20px;
		    font-weight: bold;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		}
		
		.btn:hover {
    background-color: #1565c0; /* Darker blue on hover */
    transform: translateY(-2px); /* Slight lift on hover */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Shadow on hover */
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
            <h4 class="center-align">📋 Your Leave Status</h4>
            <table class="striped centered">
    <thead>
        <tr>
            <th>Leave Type</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Reason</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <%
            Integer userId = (Integer) session.getAttribute("u_id");
            if (userId == null) {
                response.sendRedirect("Login.jsp");
                return;
            }

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
            	Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

                String query = "SELECT * FROM leave_management WHERE e_id=?";
                ps = con.prepareStatement(query);
                ps.setInt(1, userId);
                rs = ps.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("leave_type") %></td>
            <td><%= rs.getDate("start_date") %></td>
            <td><%= rs.getDate("end_date") %></td>
            <td><%= rs.getString("reason") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>
    </tbody>
</table>
           <button class="btn waves-effect waves-light blue darken-2" onclick="window.location.href='employee_home.jsp'">
			    <i class="material-icons left">arrow_back</i> Back
			</button>
        </div>
    </div>

    <script>
        document.getElementById("logout").onclick = function() {
            document.cookie = "Email=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/Employee_Management_System;";
            window.location.href = "Login.jsp";
        };
    </script>
</body>
</html>