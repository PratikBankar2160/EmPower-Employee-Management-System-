package emp.in.sp.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/users")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        HttpSession session = request.getSession(false);
        Integer u_id = (Integer) session.getAttribute("u_id");

        try {
            // Database connection
        	Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");
            String sql = "SELECT * FROM Emp_Add WHERE u_id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, u_id);
            rs = stmt.executeQuery();

            // HTML structure
            out.println("<!DOCTYPE html>");
            out.println("<html><head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<title>View Employees</title>");

            // Include Materialize CSS & Icons
            out.println("<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css'>");
            out.println("<link href='https://fonts.googleapis.com/icon?family=Material+Icons' rel='stylesheet'>");
            out.println("<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>");

            // Custom CSS
            out.println("<style>");
            out.println("body { background-color: #eef1f7; font-family: 'Arial', sans-serif; margin: 0; padding: 0; }");
            out.println(".top-navbar { background: #2c3e50; padding: 30px 20px; display: flex; justify-content: space-between; align-items: center; color: white; }");
            out.println(".top-navbar h5 { margin: 0; font-weight: bold; }");
            out.println(".top-navbar .nav-buttons .btn { margin-left: 10px; transition: 0.3s; border-radius: 8px; }");
            out.println(".top-navbar .btn:hover { background: #1abc9c; transform: scale(1.05); }");

            out.println(".sidebar { position: fixed; left: 0; top: 96px; width: 250px; height: calc(100vh - 60px); background: #2c3e50; padding-top: 20px; }");
            out.println(".sidebar ul { list-style: none; padding: 0; }");
            out.println(".sidebar ul li { padding: 15px; border-bottom: 1px solid rgba(255, 255, 255, 0.1); transition: 0.3s; }");
            out.println(".sidebar ul li a { text-decoration: none; color: white; display: flex; align-items: center; font-size: 16px; transition: 0.3s; }");
            out.println(".sidebar ul li a i { margin-right: 10px; }");
            out.println(".sidebar ul li:hover { background: #1abc9c; padding-left: 20px; transform: scale(1.05); border-radius: 0 10px 10px 0; }");

            out.println(".project-name { font-size: 24px; font-weight: bold; letter-spacing: 1px; text-transform: uppercase; color: gold; }");

            out.println(".main-content { margin-left: 270px; padding: 20px; }");
            out.println(".project-name { font-size: 24px; font-weight: bold; letter-spacing: 1px; text-transform: uppercase; color: gold; }");
            out.println(".table-container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }");
            out.println("</style>");

            // JavaScript for deleting users
            out.println("<script>");
            out.println("function deleteUser(id) {"
                    + "  if (confirm('Are you sure you want to delete this employee?')) {"
                    + "    $.ajax({"
                    + "      url: 'users',"
                    + "      type: 'POST',"
                    + "      data: { id: id },"
                    + "      success: function(response) {"
                    + "        if (response.trim() === 'success') {"
                    + "          $('#user-' + id).remove();"
                    + "          M.toast({html: 'Employee deleted successfully!', classes: 'green'});"
                    + "        } else {"
                    + "          M.toast({html: 'Failed to delete employee.', classes: 'red'});"
                    + "        }"
                    + "      },"
                    + "      error: function() {"
                    + "        M.toast({html: 'Error in request.', classes: 'red'});"
                    + "      }"
                    + "    });"
                    + "  }"
                    + "}");
            out.println("</script>");

            out.println("</head><body>");

            // Top Navbar
            out.println("<div class='top-navbar'>");
            out.println("<div class='project-name'>Employee Management System</div>");
            out.println("<h5>Welcome " + session.getAttribute("name") + ".!</h5>");
            out.println("<button class='btn red waves-effect' onclick=\"window.location.href='Login.jsp'\">Logout</button>");
            out.println("</div>");

            // Sidebar
            out.println("<div class='sidebar'>");
            out.println("<ul>");
            out.println("<li><a href='Add.jsp'><i class='material-icons'>person_add</i> Add Employee</a></li>");
            out.println("<li><a href='users'><i class='material-icons'>visibility</i> View Employees</a></li>");
            out.println("<li><a href='Search.jsp'><i class='material-icons'>search</i> Search Employee</a></li>");
            out.println("<li><a href='Update.jsp'><i class='material-icons'>edit</i> Modify Employee</a></li>");
            out.println("<li><a href='Delete.jsp'><i class='material-icons'>delete</i> Delete Employee</a></li>");
            out.println("<li><a href='ChangePassword.jsp'><i class='material-icons' >lock</i> Change Password</a></li>");
            out.println("</ul>");
            out.println("</div>");

            // Main Content
            out.println("<div class='main-content'>");
            out.println("<h4><i class='material-icons'>group</i> Employee List</h4>");
            out.println("<div class='table-container'>");

            out.println("<table class='striped responsive-table'>"
                    + "<thead><tr>"
                    + "<th>ID</th><th>Name</th><th>Age</th><th>DOB</th><th>Address</th>"
                    + "<th>Mobile</th><th>Email</th><th>Education</th><th>Aadhar</th><th>Action</th>"
                    + "</tr></thead><tbody>");

            while (rs.next()) {
                out.println("<tr id='user-" + rs.getInt("id") + "'>"
                        + "<td>" + rs.getInt("id") + "</td>"
                        + "<td>" + rs.getString("name") + "</td>"
                        + "<td>" + rs.getInt("age") + "</td>"
                        + "<td>" + rs.getDate("date_of_birth") + "</td>"
                        + "<td>" + rs.getString("address") + "</td>"
                        + "<td>" + rs.getString("Mobile_no") + "</td>"
                        + "<td>" + rs.getString("email") + "</td>"
                        + "<td>" + rs.getString("education") + "</td>"
                        + "<td>" + rs.getString("adhar_no") + "</td>"
                        + "<td><button class='btn red' onclick='deleteUser(" + rs.getInt("id") + ")'>Delete</button></td>"
                        + "</tr>");
            }

            out.println("</tbody></table>");
            out.println("</div>");
            out.println("</div>");

            // Materialize JS
            out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js'></script>");

            out.println("</body></html>");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Connection conn = null;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            conn = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

            // Start Transaction
            conn.setAutoCommit(false);

            // Delete from Emp_Add
            PreparedStatement stmt1 = conn.prepareStatement("DELETE FROM Emp_Add WHERE id=?");
            stmt1.setInt(1, id);
            int empRows = stmt1.executeUpdate();

            // Delete from user_info
            PreparedStatement stmt2 = conn.prepareStatement("DELETE FROM user_info WHERE id=?");
            stmt2.setInt(1, id);
            int userRows = stmt2.executeUpdate();

            // Commit Transaction if both deletions succeed
            if (empRows > 0 && userRows > 0) {
                conn.commit();
                out.print("success");
            } else {
                conn.rollback();
                out.print("error");
            }

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback in case of error
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            out.print("error");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException closeEx) {
                    closeEx.printStackTrace();
                }
            }
        }
    }

}
