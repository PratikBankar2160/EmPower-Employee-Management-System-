<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Home</title>
     <!-- Materialize CSS & Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<!-- Materialize CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
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
        
        /* Main Content - Scrollable */
        .main-content {
            margin-left: 270px;
            margin-top: px;
            padding: 20px;
            height: calc(100vh - 96px);
            overflow-y: auto;
        }
        .content { flex: 1; padding: 30px; }

        .card {
            background: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow:1px 10px 80px rgba(18, 47, 209, 0.537), -20px -0px 30px rgba(208, 6, 235, 0.203);
            text-align: center;
        }
        
        
        
        .navbar .brand-title { font-weight: bold; font-size: 22px; }
        .navbar .user-info { display: flex; align-items: center; gap: 15px; }
    </style>
</head>
<body>
    <!-- Navbar -->
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
        <!-- Sidebar -->
        <div class="sidebar">
            <ul>
                <li><a href="RequestLeave.jsp"><i class="material-icons">event_note</i> Request Leave</a></li>
                <li><a href="ViewLeaveStatus.jsp"><i class="material-icons">assignment_turned_in</i> View Leave Status</a></li>
                <li><a href="Attendance.jsp"><i class="material-icons">access_time</i> Mark Attendance</a></li>
                <li>
			    <a href="EmpChangePassword.jsp">
			        <i class="material-icons">lock</i> Change Password
			    </a>
			</li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="content">
            <div class="card">
                <h1>Welcome to Your Dashboard</h1>
                <p>Manage your tasks efficiently using the navigation options provided.</p>
            </div>
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
