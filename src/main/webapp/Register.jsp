<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up | EmpowerHR</title>

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
            margin: 0;
        }

        .container {
            display: flex;
            width: 80%;
            max-width: 900px;
            gap: 30px;
        }

        .project-info {
            flex: 1;
            color: #fff;
            text-align: left;
            padding: 20px;
            animation: fadeIn 1.5s ease-in-out;
        }

        .project-name {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .project-description {
            font-size: 16px;
            color: #ddd;
            line-height: 1.6;
        }

        .form-container {
        	background: rgba(0, 0, 0, 0.4);
            flex: 1;
            backdrop-filter: blur(12px);
            border-radius: 15px;
            padding: 40px;
            color: #fff;
            box-shadow: 0 10px 25px rgba(255, 255, 255, 0.779);
            animation: slideIn 1.2s ease-out;
        }

        .form-container h4 {
            margin-bottom: 20px;
            font-weight: bold;
        }

        .input-field input, .input-field select {
            border-bottom: 2px solid #4CAF50;
            color: #fff;
        }

        .input-field input::placeholder {
            color: #ddd;
        }

        .input-field label {
            color: #ddd;
        }

        .input-field i {
            color: #4CAF50;
        }

        .btn {
            width: 100%;
            margin-top: 15px;
            background-color: #43A047;
            border-radius: 8px;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background-color: #2E7D32;
        }

        .btn.grey {
            background-color: #616161;
        }

        .btn.grey:hover {
            background-color: #424242;
        }

        .gender-options {
            text-align: left;
            margin-top: 10px;
        }

        .gender-options label {
            margin-right: 20px;
        }

        .select-wrapper input.select-dropdown {
            color: #fff;
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

    <div class="container">
        <!-- Project Info Section -->
        <div class="project-info">
            <div class="project-name">EmpowerHR</div>
            <div class="project-description">
                EmpowerHR is a comprehensive Employee Management System designed to streamline HR tasks, manage employee records, and simplify attendance tracking. With intuitive navigation and robust features, EmpowerHR enhances productivity for both employees and managers.
            </div>
        </div>

        <!-- Registration Form -->
        <div class="form-container">
            <h4><i class="material-icons">person_add</i> Sign Up</h4>
            <form action="regForm" method="post" id="myForm">

                <div class="input-field">
                    <i class="material-icons prefix">account_circle</i>
                    <input type="text" id="name1" name="name1" required placeholder="Enter your name">
                    <label for="name1">Name</label>
                </div>

                <div class="input-field">
                    <i class="material-icons prefix">email</i>
                    <input type="email" id="email1" name="email1" required placeholder="Enter your email">
                    <label for="email1">Email</label>
                </div>

                <div class="input-field">
                    <i class="material-icons prefix">lock</i>
                    <input type="password" id="pass1" name="pass1" required placeholder="Create a password">
                    <label for="pass1">Password</label>
                </div>

                <div class="gender-options">
                    <label>Gender</label>
                    <p>
                        <label>
                            <input type="radio" name="gender1" value="Male" required />
                            <span>Male</span>
                        </label>
                        <label>
                            <input type="radio" name="gender1" value="Female" required />
                            <span>Female</span>
                        </label>
                    </p>
                </div>

                <div class="input-field">
                    <select id="city1" name="city1" required>
                        <option value="" disabled selected>Select City</option>
                        <option value="Delhi">Delhi</option>
                        <option value="Mumbai">Mumbai</option>
                        <option value="Pune">Pune</option>
                        <option value="Bangalore">Bangalore</option>
                        <option value="Chennai">Chennai</option>
                    </select>
                </div>

                <button class="btn waves-effect waves-light" type="submit">
                    Register <i class="material-icons right">send</i>
                </button>

                <button type="button" class="btn grey waves-effect" onclick="window.location.href='Landing.jsp'">
                    Back <i class="material-icons right">arrow_back</i>
                </button>
            </form>
        </div>
    </div>

    <script>
        $(document).ready(function(){
            $('select').formSelect();
            $("#myForm").on("submit", function(event){
                event.preventDefault();
                var f = $(this).serialize();
                $.ajax({
                    url : "regForm",
                    data : f,
                    type : "POST",
                    success : function(data){
                        M.toast({html: "Registration Successful!", classes: "green"});
                        setTimeout(() => window.location.assign("Login.jsp"), 1500);
                    },
                    error : function(jqXHR){
                        M.toast({html: jqXHR.responseText, classes: "red"});
                    }
                });
            });
        });
    </script>

</body>
</html>
