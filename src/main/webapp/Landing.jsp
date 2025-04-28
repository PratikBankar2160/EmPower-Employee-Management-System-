<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome | EmpowerHR</title>

    <!-- Materialize CSS & Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    

    <style>
        body {
            height: 100vh;
            background: linear-gradient(135deg, #4A148C, #7B1FA2); 
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
            color: #fff;
            overflow: hidden;
        }

        .container {
            text-align: center;
            background: rgba(0, 0, 0, 0.7);
            padding: 40px 50px;
            box-shadow: 0 10px 25px rgba(255, 255, 255, 0.779);
            animation: fadeIn 0.8s ease-out, float 4s ease-in-out infinite;
        }

        /* @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        } */

        .button-container {
            display: flex;
            gap: 20px;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .btn {
            width: 150px;
            border-radius: 25px;
            font-weight: bold;
            letter-spacing: 1px;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .btn:hover {
            background: #43A047;
            transform: scale(1.05);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        .footer {
            background: rgba(0, 0, 0, 0.8);
            color: #bbb;
            padding: 20px 0;
            width: 100%;
            text-align: center;
            font-size: 0.9rem;
            animation: slideUp 1s ease-out;
        }

        @keyframes slideUp {
            from { transform: translateY(100%); }
            to { transform: translateY(0); }
        }

        .footer a {
            color: #4CAF50;
            text-decoration: none;
            margin: 0 10px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: #FFD700;
        }

        .footer .social-icons i {
            color: #bbb;
            margin: 0 5px;
            font-size: 1.5rem;
            cursor: pointer;
            transition: color 0.3s ease, transform 0.3s ease;
        }

        .footer .social-icons i:hover {
            color: #4CAF50;
            transform: scale(1.2);
        }

        .modal {
            background: rgba(0, 0, 0, 0.9);
            color: #fff;
            padding: 20px;
            border-radius: 10px;
            animation: zoomIn 0.5s ease-out;
            box-shadow: 0 10px 25px rgba(255, 255, 255, 0.779);
        }

        @keyframes zoomIn {
            from { transform: scale(0.8); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        .modal-footer {
            background: rgba(0, 0, 0, 0.7);
        }

        .project-info p {
            margin: 15px 0;
            display: flex;
            align-items: center;
        }

        .project-info i {
            margin-right: 10px;
            color: #4CAF50;
            font-size: 2rem;
        }

        .btn .material-icons {
            margin-right: 4px;
            vertical-align: middle;
            font-size: 20px;
        }

        h3 {
            animation: glow 2s infinite alternate;
        }
        
        
        body {
            height: 100vh;
            color: #fff;
            overflow: hidden;
        }

        #particles-js {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: -1;
            background: linear-gradient(135deg, #4A148C, #7B1FA2);
        }

    </style>
</head>
<body>
    <div class="container">
        <h3>Welcome to <span style="color:#FFD700;">EmpowerHR</span></h3>
        <p>Empowering your workforce with streamlined management solutions.</p>

        <div class="button-container" style="display: flex; justify-content: space-between; width: 100%;">
            <!-- Left Side Button -->
            <button type="button" 
                    class="btn waves-effect waves-light green darken-2"
                    style="white-space: nowrap; padding: 0 24px; width: auto;"
                    onclick="M.Modal.getInstance(document.querySelector('#project-info-modal'))?.open()">
                <i class="material-icons left">info</i>Read Document
            </button>

            <!-- Right Side Buttons -->
            <div style="display: flex; gap: 20px;">
                <button type="submit" class="btn waves-effect waves-light purple darken-3"
                        onclick="window.location.href = 'Register.jsp'">
                    <i class="material-icons left">person_add</i>Register
                </button>

                <button type="submit" class="btn waves-effect waves-light deep-purple darken-2"
                        onclick="window.location.href = 'Login.jsp'">
                    <i class="material-icons left">login</i>Login
                </button>
            </div>
        </div>
    </div>

<div id="particles-js"></div>


    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 EmpowerHR | All Rights Reserved</p>
        <p>
            <a href="#privacy-modal" class="modal-trigger">Privacy Policy</a> | 
            <a href="#terms-modal" class="modal-trigger">Terms of Service</a> | 
            <a href="#contact-modal" class="modal-trigger">Contact Us</a>
        </p>
        <div class="social-icons">
            <i class="material-icons">facebook</i>
            <i class="material-icons">twitter</i>
            <i class="material-icons">linkedin</i>
        </div>
    </div>

    <!-- Project Info Modal -->
    <div id="project-info-modal" class="modal">
        <div class="project-info">
            <h4>About EmpowerHR</h4>
            <p>
                🌟 <b>EmpowerHR &nbsp</b> is an intuitive platform designed for seamless employee management. Key features include:
            </p>
            <p><i class="material-icons">dashboard</i> Admin Dashboard for managing employees, leaves, and attendance.</p>
            <p><i class="material-icons">group</i> Employee Management with role-based access control.</p>
            <p><i class="material-icons">event</i> Attendance Tracking with detailed reporting and summaries.</p>
            <p><i class="material-icons">check_circle</i> Leave Management System for easy leave requests and approvals.</p>
            <p><i class="material-icons">trending_up</i> Analytics Dashboard with insights into employee performance and trends.</p>
            <p><i class="material-icons">verified_user</i> Secure Authentication with session handling and role-based access.</p>
            <p><i class="material-icons">search</i> Advanced Search and Filter options for employee data management.</p>
            <p><i class="material-icons">notifications_active</i> Future Integration for Email Alerts and Payroll Management.</p>
            <p>Explore the platform and unlock productivity like never before!</p>
        </div>
    </div>

    <!-- Privacy Policy Modal -->
    <div id="privacy-modal" class="modal">
        <div class="modal-content">
            <h4>Privacy Policy</h4>
            <p>We are committed to protecting your privacy. Your data is securely stored and never shared with third parties without consent.</p>
        </div>
    </div>

    <!-- Terms of Service Modal -->
    <div id="terms-modal" class="modal">
        <div class="modal-content">
            <h4>Terms of Service</h4>
            <p>By using EmpowerHR, you agree to our terms, which include fair usage policies, data protection measures, and security guidelines.</p>
        </div>
    </div>

    <!-- Contact Us Modal -->
    <div id="contact-modal" class="modal">
        <div class="modal-content">
            <h4>Contact Us</h4>
            <p>
                📞 Phone: +91 9322245152<br>
                📧 Email: support@empowerhr.com<br>
                🏢 Address: 123 HR Avenue, Business Park, NY, USA
            </p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const modals = document.querySelectorAll('.modal');
            M.Modal.init(modals);
        });
        
        document.addEventListener('DOMContentLoaded', function () {
            particlesJS('particles-js', {
                particles: {
                    number: { value: 80 },
                    color: { value: '#ffffff' },
                    shape: { type: 'circle' },
                    opacity: { value: 0.5 },
                    size: { value: 3 },
                    line_linked: { enable: true, distance: 150, color: '#ffffff', opacity: 0.4, width: 1 },
                    move: { enable: true, speed: 2, direction: 'none', out_mode: 'bounce' }
                },
                interactivity: {
                    detect_on: 'canvas',
                    events: {
                        onhover: { enable: true, mode: 'repulse' },
                        onclick: { enable: true, mode: 'push' },
                        resize: true
                    }
                },
                retina_detect: true
            });
        });
    </script>
</body>
</html>