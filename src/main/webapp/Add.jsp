<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Form</title>

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
        
        .main-content { margin-left: 260px; padding: 20px; }
        .form-container { padding: 20px; border-radius: 8px; background: white; }
    </style>
</head>
<body>

    <!-- Authentication Check -->
    <% String user = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("Email".equals(cookie.getName()) && cookie.getValue() != null) {
                user = cookie.getValue();
                break;
            }
        }
    }
    if (user == null) { %>
    <script> window.location.href = "Login.jsp"; </script>
    <% } %>

    <!-- Top Navbar -->
    <div class="top-navbar">
    <div class="project-name">Employee Management System</div>
        <h5>Welcome <%= session.getAttribute("name") %>.!</h5>
        <div class="nav-buttons">
        
            <button class="btn blue waves-effect" onclick="window.location.href='report.jsp'">Attendance Report</button>
            <button class="btn red waves-effect" id="logout"><i class="material-icons left">exit_to_app</i> Logout</button>
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
            <li>
			    <a href="ChangePassword.jsp">
			        <i class="material-icons">lock</i> Change Password
			    </a>
			</li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="form-container">
            <h2><i class="material-icons">person_add</i> New Employee Details</h2>
            <form action="Add" method="post" id="AddForm">
                <div class="row">
                    <div class="col s12 m6">
                        <div class="input-field"><input type="text" name="name" id="name" required><label for="name">Employee Name</label></div>
                        <div class="input-field"><input type="number" name="age" id="age" required><label for="age">Employee Age</label></div>
                        <div class="input-field"><input type="date" name="dob" id="dob" required><label for="dob">Date of Birth</label></div>
                        <label>Gender :</label>
                        <p>
                            <label><input type="radio" name="gender" value="Male" required><span>Male</span></label>
                            <label><input type="radio" name="gender" value="Female" required><span>Female</span></label>
                            <label><input type="radio" name="gender" value="Other" required><span>Other</span></label>
                        </p>
                        <div class="input-field"><input type="text" name="address" id="address" required><label for="address">Employee Address</label></div>
                        <div class="input-field"><input type="number" name="adhar" id="adhar" required><label for="adhar">Aadhar Number</label></div>
                    </div>

                    <div class="col s12 m6">
                        <div class="input-field"><input type="text" name="phone" id="phone" required><label for="phone">Employee Phone</label></div>
                        <div class="input-field"><input type="email" name="email" id="email" required><label for="email">Employee Email</label></div>
                        <div class="input-field">
                            <select id="city" name="city" class="browser-default" required>
                                <option value="" disabled selected>Select City</option>
                                <option value="Delhi">Delhi</option>
                                <option value="Mumbai">Mumbai</option>
                                <option value="Pune">Pune</option>
                                <option value="Bangalore">Bangalore</option>
                                <option value="Chennai">Chennai</option>
                            </select>
                        </div>
                        <div class="input-field"><input type="text" name="education" id="education" required><label for="education">Education</label></div>
                        
                    </div>
                </div>

                <button type="submit" class="btn waves-effect waves-light">Submit</button>
                <button type="reset" class="btn waves-effect waves-light">Reset</button>
                <button type="button" class="btn waves-effect waves-light" onclick="window.location.href = 'hr_home.jsp'">Back</button>
            </form>
        </div>
    </div>

    <script>
        $(document).ready(function(){
            $("#AddForm").on("submit", function(event){
                event.preventDefault();
                var f = $(this).serialize();
                $.ajax({
                    url : "Add",
                    data : f,
                    type : "POST",
                    success : function(response){
                        alert(response);
                        window.location.assign("Add.jsp");
                    },
                    error : function(jqXHR){
                        alert("Error: " + jqXHR.responseText);
                    }
                });
            });

            $("#logout").on("click", function(){
                document.cookie = "Email=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/";
                window.location.href = "Login.jsp";
            });
        });
    </script>
</body>
</html>
