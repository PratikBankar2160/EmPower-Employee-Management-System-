<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Remove Employee</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script> 
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
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

    .form-container {
        margin-left: 600px;
        margin-top: 100px;
        padding: 20px;
        max-width: 600px;
        background: white;
        border-radius: 10px;
        box-shadow:1px 10px 80px rgba(18, 47, 209, 0.537), -20px -0px 30px rgba(208, 6, 235, 0.203);
    }

    .form-content {
        text-align: center;
    }

    .input-field input {
        border-bottom: 2px solid #2c3e50;
    }
    .project-name { 
         	font-size: 24px; 
         	font-weight: bold; 
         	letter-spacing: 1px; 
         	text-transform: uppercase; 
         }
         .top-navbar h5 {
           /*  margin: 0; */
            font-weight: bold;
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
    
    <div class="top-navbar">
       <div class="project-name">Employee Management System</div>
        <h5>Welcome <%= session.getAttribute("name") %>.!</h5>

        <div class="nav-buttons">
            
           <button class="btn blue waves-effect" onclick="window.location.href='report.jsp'">Attendance Report</button>
            <button class="btn red waves-effect" id="logout">
                <i class="material-icons left">exit_to_app</i> Logout
            </button>
        </div>
    </div>

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

    <div class="form-container">
        <div class="form-content">
            <form method="post" action="Remove" id="RemoveEmployee">
                <h2>Remove Employee</h2>
                <div class="input-field">
                    <input type="number" id="id" name="id" required>
                    <label for="id">Enter Employee ID</label>
                </div>
                <button type="submit" class="btn waves-effect waves-light red">Remove</button>
                <button type="button" class="btn waves-effect waves-light grey" onclick="window.location.href = 'hr_home.jsp'">Back</button>
            </form>
        </div>
    </div>

    <script>
        $(document).ready(function(){
            $("#RemoveEmployee").on("submit", function(event){
                event.preventDefault();
                var formData = $(this).serialize();
                $.ajax({
                    url : "Remove",
                    data : formData,
                    type : "POST",
                    success : function(data){
                        M.toast({html: 'Employee removed successfully!', classes: 'green'});
                        setTimeout(() => window.location.assign("Delete.jsp"), 1500);
                    },
                    error : function(jqXHR){
                        M.toast({html: 'Error: ' + jqXHR.responseText, classes: 'red'});
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
