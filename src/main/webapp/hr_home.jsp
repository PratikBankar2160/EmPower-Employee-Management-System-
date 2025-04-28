<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HR Home</title>

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

        /* Leave Section */
        .leave-section {
            padding: 20px;
            border-radius: 8px;
            background: white;
            box-shadow:1px 10px 80px rgba(18, 47, 209, 0.537), -20px -0px 30px rgba(208, 6, 235, 0.203);

        }

        /* Filter Buttons */
        .filter-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .filter-buttons .btn {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 10px 20px;
            transition: all 0.3s ease;
            border-radius: 8px;
        }

        .filter-buttons .btn i {
            margin-right: 8px;
        }

        .filter-buttons .btn:hover {
            transform: scale(1.05);
            opacity: 0.9;
        }
        h2{
        margin-top:10px;
        	padding-bottom:-90px;
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

    <!-- Main Content -->
    <div class="main-content">
        <h2 id="leave"><i class="material-icons">event_note</i> Leave Requests</h2>

        <div class="leave-section">
            <!-- Filter Buttons -->
            <div class="filter-buttons">
                <button class="btn blue waves-effect" onclick="setFilter('')">
                    <i class="material-icons">filter_list</i> All
                </button>
                <button class="btn orange waves-effect" onclick="setFilter('Pending')">
                    <i class="material-icons">hourglass_empty</i> Pending
                </button>
                <button class="btn green waves-effect" onclick="setFilter('Approved')">
                    <i class="material-icons">check_circle</i> Approved
                </button>
                <button class="btn red waves-effect" onclick="setFilter('Rejected')">
                    <i class="material-icons">cancel</i> Rejected
                </button>
            </div>

            <div id="leaveData" class="center-align">
                <!-- Leave Data Will Load Here -->
            </div>
        </div>
    </div>

    <script>
    let selectedStatus = '';

    function setFilter(status) {
        selectedStatus = status;
        loadLeaves(status);
    }

    function loadLeaves(status) {
        console.log("Loading leaves for status:", status); // Debugging log
        $.ajax({
            url: "ViewPendingLeaves",
            type: "GET",
            data: { status: status },
            success: function (data) {
                $("#leaveData").html(data);
            },
            error: function (xhr, status, error) {
                console.error("Error loading leaves:", error);
            }
        });
    }
    
    //logout functionality
    
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
    
  //Update Leave Status
  
    function updateStatus(leaveId, newStatus) {
    console.log("Updating Leave ID:", leaveId, "to", newStatus);

    // Show toast for confirmation
    M.toast({
        html: `<span>Are you sure you want to ${newStatus} this leave request?</span> 
               <button class="btn-flat yellow-text" onclick="proceedUpdate(${leaveId}, '${newStatus}')">Yes</button>`,
        displayLength: 3000 // Toast duration
    });
}

// Function to proceed with the update
function updateStatus(leaveId, newStatus) {
    console.log("Updating Leave ID:", leaveId, "to", newStatus);

    // Show blue toast notification before making the request
    M.toast({
        html: "Updating leave status to <b>" + newStatus + "</b>...",
        classes: 'blue',
        displayLength: 4000
    });

    fetch('UpdateLeaveStatus', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'leave_id=' + leaveId + '&status=' + newStatus
    })
    .then(response => response.text())
    .then(result => {
        console.log("Server Response:", result);

        if (result.trim() === "success") {
            // Update status text dynamically
            document.getElementById("status_" + leaveId).innerHTML = "<b>" + newStatus + "</b>";

            // Update action buttons dynamically
            let actionsCell = document.getElementById("actions_" + leaveId);
            if (newStatus === "Approved") {
                actionsCell.innerHTML = `<button onclick="updateStatus(${leaveId}, 'Rejected')" class="btn red waves-effect">Reject</button>`;
            } else if (newStatus === "Rejected") {
                actionsCell.innerHTML = `<button onclick="updateStatus(${leaveId}, 'Approved')" class="btn green waves-effect">Approve</button>`;
            } else {
                actionsCell.innerHTML = "";
            }
        }
    })
    .catch(error => console.error("Error:", error)); // Only log errors, no extra toasts
}







 // Load all leaves 
    $(document).ready(function () {
        loadLeaves(''); 
    });
</script>



    <!-- Materialize JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

</body>
</html>
