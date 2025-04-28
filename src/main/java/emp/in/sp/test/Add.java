package emp.in.sp.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Add")
public class Add extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        HttpSession session = req.getSession(true);
        Integer u_id = (Integer) session.getAttribute("u_id"); // Manager ID

        String name = req.getParameter("name");
        int age = Integer.parseInt(req.getParameter("age"));
        String dob = req.getParameter("dob");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String education = req.getParameter("education");
        String adhar = req.getParameter("adhar");
        String gender = req.getParameter("gender");
        String city = req.getParameter("city");

        Connection con = null;
        PreparedStatement ps = null, ps2 = null;
        ResultSet rs = null;

        try {
            // Load postgresql Driver
        	Class.forName("org.postgresql.Driver");
        	con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/emp_project", "postgres", "pratik4023");


            // Insert into Emp_Add and retrieve the generated employee ID
            String empInsertQuery = "INSERT INTO Emp_Add (u_id, name, age, date_of_birth, address, Mobile_No, email, education, adhar_no) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(empInsertQuery, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, u_id); // Manager ID
            ps.setString(2, name);
            ps.setInt(3, age);
            ps.setDate(4, java.sql.Date.valueOf(dob));
            ps.setString(5, address);
            ps.setString(6, phone);
            ps.setString(7, email);
            ps.setString(8, education);
            ps.setString(9, adhar);
            
            int count = ps.executeUpdate();

            // Get the generated employee ID
            int empId = -1;
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                empId = rs.getInt(1); // Get the auto-generated ID
            }

            if (empId > 0) {
                // Insert into user_info with default password '1111' and role 'Employee'
                String userInsertQuery = "INSERT INTO user_info (id, name, email, password, gender, city, role) VALUES (?, ?, ?, '1111', ?, ?, 'Employee')";
                ps2 = con.prepareStatement(userInsertQuery);
                ps2.setInt(1, empId);
                ps2.setString(2, name);
                ps2.setString(3, email);
                ps2.setString(4, gender);
                ps2.setString(5, city);

                int count1 = ps2.executeUpdate();

                if (count1 > 0) {
                    resp.setStatus(HttpServletResponse.SC_OK);
                    out.print("Employee Data Added Successfully!");
                } else {
                    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("Failed to add Employee Data in user_info.");
                }
            } else {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("Failed to retrieve Employee ID.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("Server error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (ps2 != null) ps2.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            out.close();
        }
    }
}
