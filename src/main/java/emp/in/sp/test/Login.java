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
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/plain"); // Set content type to plain text

        String email = req.getParameter("email1");
        String pass = req.getParameter("pass1");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Load JDBC Driver
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

            // Check user credentials
            //String query = "SELECT * FROM user_info WHERE email=? AND password=?";
            String query = "SELECT id, name, role FROM user_info WHERE email=? AND password=?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, pass);

            rs = ps.executeQuery();
            if (rs.next()) {
            	String name = rs.getString("name");
                // Get role and user ID
                String role = rs.getString("role").trim(); // Trim to avoid extra spaces
                int userId = rs.getInt("id");

                // Set a cookie for email
                Cookie c = new Cookie("Email", email);
                c.setMaxAge(30 * 60);
                
                resp.addCookie(c);

                // Create and set session attributes
                HttpSession session = req.getSession();
                session.setAttribute("name", name);  // Store email in session
                session.setAttribute("email", email);  // Store email in session

                session.setAttribute("u_id", userId);
                session.setAttribute("loggedIn", true);
                session.setAttribute("role", role);
                session.setMaxInactiveInterval(60	 * 60); // Session timeout set to 30 minutes

                // Debugging info (remove in production)
                System.out.println("Login Success: Email=" + email + ", Role=" + role);

                // Send role as response
                out.print(role);
            } else {
                out.print("Invalid");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
