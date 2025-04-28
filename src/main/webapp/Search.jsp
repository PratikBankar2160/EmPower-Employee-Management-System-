<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Search</title>
    
    <!-- Materialize CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
    <!-- jQuery & Materialize JS -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    
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

        .container {
            margin-left: 270px;
            margin-top: 30px;
        }

        .card {
            padding: 20px;
            border-radius: 12px;
            box-shadow: 2px 4px 10px rgba(0, 0, 0, 0.2);
        }

        table.striped th {
            background: #2c3e50;
            color: white;
        }

        table.striped tr:hover {
            background: rgba(44, 62, 80, 0.2);
        }
          /* Table Styling */
    .employee-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 2px 4px 10px rgba(0, 0, 0, 0.15);
    }

    .employee-table th, .employee-table td {
        padding: 14px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    .employee-table th {
        background: #1a252f;
        color: white;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .employee-table tbody tr:nth-child(even) {
        background: #f8f9fa;
    }

    .employee-table tbody tr:hover {
        background: rgba(26, 37, 47, 0.2);
        transition: 0.3s ease-in-out;
    }

    .employee-table td {
        color: #333;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .employee-table th, .employee-table td {
            padding: 10px;
            font-size: 14px;
        }
    }
</style>

    </style>
</head>
<body>
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

    <div class="container">
        <div class="row">
            <div class="col s12 m8 offset-m2">
                <div class="card">
                    <h4 class="center-align">Search Employee</h4>
                    <form id="searchForm" action="Search" method="GET">
                        <div class="input-field">
                            <i class="material-icons prefix">badge</i>
                            <input type="number" id="id" name="id" required>
                            <label for="id">Enter Employee ID</label>
                        </div>
                        <div class="center-align">
                            <button type="submit" class="btn waves-effect waves-light">Search</button>
                            <a href="hr_home.jsp" class="btn red waves-effect waves-light">Back</a>
                        </div>
                    </form>
                </div>

                <%-- Display error message if no record is found --%>
                <% if (request.getAttribute("error") != null) { %>
                    <h5 class="center-align red-text"><%= request.getAttribute("error") %></h5>
                <% } %>

                <%-- Display employee details if available --%>
                <% if (request.getAttribute("id") != null) { %>
                    <h4 class="center-align">Employee Details</h4>
                    <!-- Updated Table -->
					<table class="employee-table">
					    <thead>
					        <tr>
					            <th>ID</th><th>Name</th><th>Age</th><th>Date of Birth</th>
					            <th>Address</th><th>Mobile No</th><th>Email</th>
					            <th>Education</th><th>Adhar No</th>
					        </tr>
					    </thead>
					    <tbody>
					        <tr>
					            <td><%= request.getAttribute("id") %></td>
					            <td><%= request.getAttribute("name") %></td>
					            <td><%= request.getAttribute("age") %></td>
					            <td><%= request.getAttribute("dob") %></td>
					            <td><%= request.getAttribute("address") %></td>
					            <td><%= request.getAttribute("mobile") %></td>
					            <td><%= request.getAttribute("email") %></td>
					            <td><%= request.getAttribute("education") %></td>
					            <td><%= request.getAttribute("adhar") %></td>
					        </tr>
					    </tbody>
					</table>
                <% } %>
            </div>
        </div>
    </div>


    <script>
        $(document).ready(function(){
            M.AutoInit();

            // Logout Confirmation
            $("#logout").click(function() {
                if (confirm("Are you sure you want to logout?")) {
                    window.location.href = "Login.jsp";
                }
            });

            // Prevent empty Employee ID search
            $("#searchForm").submit(function(e) {
                let id = $("#id").val().trim();
                if (id === "") {
                    e.preventDefault();
                    M.toast({html: "Please enter an Employee ID!", classes: "red"});
                }
            });
        });
    </script>
</body>
</html>
