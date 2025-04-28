<%@ page import="java.sql.*, java.time.*" %>
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
    <title>Mark Attendance</title>
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

        .btn {
            margin: 10px;
            padding: 0 20px;
            border-radius: 25px;
            font-weight: 600;
            text-transform: uppercase;
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .btn i {
            vertical-align: middle;
            margin-right: 8px;
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
            <h3>&#x1F552;Attendance Actions</h3>
            <form method="post">
                <button type="submit" name="markAttendance" class="btn waves-effect waves-light blue darken-2">
                    <i class="material-icons left">check</i> Mark Attendance
                </button>
                <button type="submit" name="markCheckOut" class="btn waves-effect waves-light green darken-2">
                    <i class="material-icons left">exit_to_app</i> Mark Check-Out
                </button>
            </form>

            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                Object userIdObj = session.getAttribute("u_id");
                int u_id = Integer.parseInt(userIdObj.toString());
                LocalDate today = LocalDate.now();

                try {
                    // Load PostgreSQL driver
                    Class.forName("org.postgresql.Driver");

                    // Establish database connection
                    con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/emp_project", "postgres", "pratik4023");

                    // Check if attendance is already marked for today
                    String checkQuery = "SELECT * FROM attendance WHERE u_id = ? AND attendance_date = ?";
                    ps = con.prepareStatement(checkQuery);
                    ps.setInt(1, u_id);
                    ps.setDate(2, Date.valueOf(today));
                    rs = ps.executeQuery();

                    if (request.getParameter("markAttendance") != null) {
                        if (!rs.next()) {
                            // Insert attendance if not already marked
                            String insertQuery = "INSERT INTO attendance (u_id, attendance_date, status, check_in) VALUES (?, ?, 'Present', CURRENT_TIME)";
                            ps = con.prepareStatement(insertQuery);
                            ps.setInt(1, u_id);
                            ps.setDate(2, Date.valueOf(today));
                            ps.executeUpdate();
            %>
                            <script>
                                M.toast({html: "Attendance Marked Successfully!", classes: "green"});
                            </script>
            <%
                        } else {
            %>
                            <script>
                                M.toast({html: "Attendance already marked for today.", classes: "red"});
                            </script>
            <%
                        }
                    } else if (request.getParameter("markCheckOut") != null) {
                        if (rs.next() && rs.getTime("check_out") == null) {
                            // Update check-out time if attendance is marked and check-out is not already marked
                            String updateQuery = "UPDATE attendance SET check_out = CURRENT_TIME WHERE u_id = ? AND attendance_date = ?";
                            ps = con.prepareStatement(updateQuery);
                            ps.setInt(1, u_id);
                            ps.setDate(2, Date.valueOf(today));
                            ps.executeUpdate();
            %>
                            <script>
                                M.toast({html: "Check-Out Marked Successfully!", classes: "green"});
                            </script>
            <%
                        } else {
            %>
                            <script>
                                M.toast({html: "Check-Out Already Marked or Attendance Not Found.", classes: "red"});
                            </script>
            <%
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace(); // Log the exception for debugging
            %>
                    <script>
                        M.toast({html: "Error: <%= e.getMessage() %>", classes: "red"});
                    </script>
            <%
                } finally {
                    // Close resources in reverse order of their creation
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                }
            %>
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