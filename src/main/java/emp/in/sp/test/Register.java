package emp.in.sp.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/regForm")
public class Register extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        String myname = req.getParameter("name1");
        String myemail = req.getParameter("email1");
        String mypass = req.getParameter("pass1");
        String mygender = req.getParameter("gender1");
        String mycity = req.getParameter("city1");

        try {       	
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

            // Check if email already exists
            PreparedStatement checkEmail = con.prepareStatement("SELECT * FROM user_info WHERE email = ?");
            checkEmail.setString(1, myemail);
            ResultSet rs = checkEmail.executeQuery();

            if (rs.next()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Set status code for error
                out.print("Email already exists.");
            } else {
                // Insert new user
                PreparedStatement ps = con.prepareStatement("INSERT INTO user_info (name, email, password, gender, city,role) VALUES (?,?,?,?,?,'Manager')");
                ps.setString(1, myname);
                ps.setString(2, myemail);
                ps.setString(3, mypass);
                ps.setString(4, mygender);
                ps.setString(5, mycity);

                int count = ps.executeUpdate();
                if (count > 0) {
                    resp.setStatus(HttpServletResponse.SC_OK); // Set status code for success
                    out.print("User Registered Successfully..!");
                } else {
                    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Set status code for error
                    out.print("User not Registered due to some Error.!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Set status code for server error
            out.print("Server error: " + e.getMessage());
        } finally {
            out.close(); // Close the PrintWriter
        }
    }
}
