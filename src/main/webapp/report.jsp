<%@ page import="java.sql.*" %>
<% int u_id=(Integer)session.getAttribute("u_id");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
    	Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

        String query = "SELECT a.id AS attendance_id, emp.id AS emp_id, emp.name AS name, a.attendance_date, a.check_in, a.check_out, a.status FROM attendance a JOIN Emp_Add emp ON a.u_id = emp.id WHERE emp.u_id = ?";

        ps = con.prepareStatement(query);
        ps.setInt(1,u_id);
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Attendance Report</title>
    <!-- Materialize CSS & Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<!-- Materialize CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
	
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

    /* Main content area */
    .main-content {
        margin-left: 270px;
        padding: 20px;
    }

    /* Table adjustments */
    .report-table {
        width: 100%;
        max-width: 1100px;
        margin-top: 30px;
        margin-left: auto;
        margin-right: auto;
        border: 1px solid #ddd;
        border-radius: 10px;
        overflow: hidden;
        background-color: #ffffff;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }

    .report-table th, .report-table td {
        text-align: center;
        padding: 12px;
    }

    .report-table th {
        background-color: #2c3e50;
        color: #fff;
    }

    .report-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    .report-table tbody tr:hover {
        background-color: #e3f2fd;
        transform: scale(1.02);
        transition: 0.2s;
    }

    .report-title {
        text-align: center;
        margin-top: 30px;
    }
    </style>
</head>
<body>
<div class="top-navbar">
    <div class="project-name">Employee Management System</div>
    <h5>Welcome <%= session.getAttribute("name") %>.!</h5>
    <div class="nav-buttons">
        <button class="btn blue waves-effect" onclick="window.location.href='report.jsp'"><i class="material-icons left">assessment</i> Attendance Report</button>
        <button class="btn red waves-effect" id="logout">
              <i class="material-icons left">exit_to_app</i> Logout
        </button>
    </div>
</div>

<!-- Left Sidebar -->
<div class="sidebar">
    <ul>
        <li><a href="Add.jsp"><i class="material-icons">person_add</i> Add Employee</a></li>
        <li><a href="users"><i class="material-icons">visibility</i> View Employees</a></li>
        <li><a href="Search.jsp"><i class="material-icons">search</i> Search Employee</a></li>
        <li><a href="Update.jsp"><i class="material-icons">edit</i> Modify Employee</a></li>
        <li><a href="Delete.jsp"><i class="material-icons">delete</i> Delete Employee</a></li>
    </ul>
</div>

<div class="main-content">
    <h3 class="report-title">Attendance Report</h3>
    <table class="highlight centered report-table">
        <thead>
            <tr>
                <th>Employee Name</th>
                <th>Date</th>
                <th>Check-In</th>
                <th>Check-Out</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getDate("attendance_date") %></td>
                <td><%= rs.getTime("check_in") != null ? rs.getTime("check_in") : "N/A" %></td>
                <td><%= rs.getTime("check_out") != null ? rs.getTime("check_out") : "N/A" %></td>
                <td><%= rs.getString("status") %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

<%
    } catch (Exception e) {
%>
    <p style="color: red; text-align: center;">Error: <%= e.getMessage() %></p>
<%
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

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
