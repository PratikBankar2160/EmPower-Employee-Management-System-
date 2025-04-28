<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Updation</title>
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
        
        /* Main Content - Scrollable */
        .main-content {
            margin-left: 270px;
            margin-top: px;
            padding: 20px;
            height: calc(100vh - 96px);
            overflow-y: auto;
        }
    </style>
</head>
<body>
    <% String user = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("Email".equals(cookie.getName())) {
                if (cookie.getValue() != null) {
                    user = cookie.getValue();
                    break;
                }
            }
        }
    }

    if (user == null) {
    %>
    <script>
        window.location.href = "Login.jsp";
    </script>
    <% } %>
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

    <!-- Main Content -->
    <div class="main-content">
    <div class="form-container">
        <div class="form-content">
            <form action="UpdateServlet" method="post" id="UpdateEmployee">
            <h1>Employee Updation..!</h1>
                <div class="row">
                    <div class="col s12 m6">
                        <div class="input-field">
                            <label for="id">ID:</label>
                            <input type="number" name="id" id="id" required>
                        </div>
                        <div class="input-field">
                            <label for="name">Employee Name</label>
                            <input type="text" name="name" id="name">
                        </div>
                        <div class="input-field">
                            <label for="Age">Employee Age</label>
                            <input type="number" name="age" id="Age">
                        </div>
                        <div class="input-field">
                            <label for="dob">Date Of Birth</label>
                            <input type="date" name="dob" id="dob">
                        </div>
                        <div class="input-field">
                            <label for="address">Employee Address</label>
                            <input type="text" name="address" id="address">
                        </div>
                        <div class="gender-section">
		                    <label>Gender :</label>
		                    <p>
		                        <label>
		                            <input type="radio" id="male" name="gender" value="Male" required>
		                            <span>Male</span>
		                        </label>
		                    </p>
		                    <p>
		                        <label>
		                            <input type="radio" id="female" name="gender" value="Female" required>
		                            <span>Female</span>
		                        </label>
		                    </p>
		                </div>
                    </div>
                    <div class="col s12 m6">
                        <div class="input-field">
                            <label for="phone">Employee Phone</label>
                            <input type="text" name="phone" id="phone">
                        </div>
                        <div class="input-field">
                            <label for="email">Employee Email</label>
                            <input type="email" name="email" id="email">
                        </div>
                        <div class="input-field">
                            <label for="education">Employee Education</label>
                            <input type="text" name="education" id="education">
                        </div>
                        
                        <div class="input-field">
                            <label for="adhar">Employee Adhar No.</label>
                            <input type="number" name="adhar" id="adhar">
                        </div>
                        <div class="input-field" >
		                    	<label for="city"></label>
		                    	<select id="city" name="city" class="browser-default" required>
		                        <option value="" disabled selected>Select City</option>
		                        <option value="Delhi">Delhi</option>
		                        <option value="Mumbai">Mumbai</option>
		                        <option value="Pune">Pune</option>
		                        <option value="Bangalore">Bangalore</option>
		                        <option value="Chennai">Chennai</option>
		                    </select>
		                </div>
                    </div>
                </div>
                <button type="submit" class="btn waves-effect waves-light">Submit</button>
                <button type="button" class="btn waves-effect waves-light" onclick="window.location.href = 'hr_home.jsp'">Back</button>
            </form>
        </div>
    </div>
    </div>
    <script>
        $(document).ready(function(){
            $("#UpdateEmployee").on("submit", function(event){
                event.preventDefault();

                var f = $(this).serialize();
                console.log(f);

                $.ajax({
                    url : "UpdateServlet",
                    data : f,
                    type : "POST",
                    success : function(data, textStatus, jqXHR){
                        alert("Employee Updated Successfully..!");
                        window.location.assign("Update.jsp");
                    },
                    error : function(jqXHR, textStatus, errorThrown){
                        alert("Something Went Wrong..!");
                    }
                });
            });
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
