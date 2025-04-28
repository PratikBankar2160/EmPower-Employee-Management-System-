<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | EmpowerHR</title>

    <!-- Materialize CSS & Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- jQuery & Materialize JS -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script> 
    

    <style>
body {
    background: linear-gradient(135deg, #4A148C, #7B1FA2);
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0 5%;
    animation: fadeIn 1.2s ease-in-out;
}

.project-info {
    color: #fff;
    text-align: left;
    max-width: 40%;
    animation: fadeIn 1.2s ease-in-out;
}

.project-info h1 {
    font-size: 3rem;
    font-weight: bold;
}

.project-info p {
	padding-right:10px;
    font-size: 1.2rem;
}

.form-container {
    backdrop-filter: blur(12px);
    background: rgba(0, 0, 0, 0.4);
    border-radius: 15px;
    padding: 40px;
    width: 400px;
    color: #fff;
    box-shadow: 0 10px 25px rgba(255, 255, 255, 0.779);
    text-align: center;
    animation: slideIn 1s ease-out forwards;
    opacity: 0; /* Initial hidden state */
}

.form-container h4 {
    margin-bottom: 20px;
    font-weight: bold;
}

.input-field input {
    color: #fff;
}

.input-field label {
    color: #ddd;
}

.input-field i {
    color: #4CAF50;
}

/* Button Animation */
.btn {
    width: 100%;
    margin-top: 15px;
    background-color: #43A047;
    border-radius: 8px;
    transition: background 0.3s ease, transform 0.2s ease;
}

.btn:hover {
    background-color: #2E7D32;
    transform: scale(1.05); /* Button hover animation */
}

.btn.grey {
    background-color: #616161;
}

.btn.grey:hover {
    background-color: #424242;
    transform: scale(1.05);
}

/* Animations */
 @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideIn {
            from {
                transform: translateX(50px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

    </style>
</head>
<body>

    <div class="project-info">
        <h1>EmpowerHR</h1>
        <p>Your trusted employee management solution — simplifying HR tasks and enhancing productivity.</p>
    </div>

    <div class="form-container">
        <h4>&#128272; Log-in</h4>
        <form id="loginForm">
            <div class="input-field">
                <i class="material-icons prefix">email</i>
                <input type="email" id="email1" name="email1" required>
                <label for="email1">Email</label>
            </div>

            <div class="input-field">
                <i class="material-icons prefix">lock</i>
                <input type="password" id="pass1" name="pass1" required>
                <label for="pass1">Password</label>
            </div>

            <button type="submit" class="btn waves-effect waves-light"><i class="material-icons">login</i> Login</button>
            <button type="button" class="btn grey" onclick="window.location.href='Landing.jsp'">Back</button>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            $("#loginForm").on("submit", function(event) {
                event.preventDefault();
                var formData = $(this).serialize();

                $.ajax({
                    url: "Login",
                    data: formData,
                    type: "POST",
                    success: function(response) {
                        var role = response.trim();
                        if (role === "Manager") {
                            M.toast({html: "Login Successful as Manager!", classes: "green"});
                            setTimeout(() => window.location.assign("hr_home.jsp"), 1500);
                        } else if (role === "Employee") {
                            M.toast({html: "Login Successful as Employee!", classes: "green"});
                            setTimeout(() => window.location.assign("employee_home.jsp"), 1500);
                        } else {
                            M.toast({html: "Invalid email or password!", classes: "red"});
                        }
                    },
                    error: function() {
                        M.toast({html: "Failed to connect!", classes: "red"});
                    }
                });
            });
        });
    </script>

</body>
</html>
