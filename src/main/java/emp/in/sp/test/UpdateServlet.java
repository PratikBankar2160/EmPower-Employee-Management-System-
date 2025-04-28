package emp.in.sp.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String education = request.getParameter("education");
        String adhar = request.getParameter("adhar");
        String gender = request.getParameter("gender");
        String city = request.getParameter("city");
        PreparedStatement pstmt = null;
        PreparedStatement ps2 = null;
        
        try {
        	Class.forName("org.postgresql.Driver");
        	Connection conn = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");


            // Update the employee record in Emp_Add table
            String updateQuery = "UPDATE Emp_Add SET name=?, age=?, date_of_birth=?, address=?, Mobile_No=?, email=?, education=?,  adhar_no=? WHERE id=?";
            pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, name);
            pstmt.setInt(2, age);
            pstmt.setDate(3, Date.valueOf(dob));
            pstmt.setString(4, address);
            pstmt.setString(5, phone);
            pstmt.setString(6, email);
            pstmt.setString(7, education);
            pstmt.setString(8, adhar);
            pstmt.setInt(9, id);

            int rowsUpdated = pstmt.executeUpdate();

            // Also update user_info table
            String userUpdateQuery = "UPDATE user_info SET name=?, email=?, gender=?, city=? WHERE id=?";
            ps2 = conn.prepareStatement(userUpdateQuery);
            ps2.setString(1, name);
            ps2.setString(2, email);
            ps2.setString(3, gender);
            ps2.setString(4, city);
            ps2.setInt(5, id);

            int userRowsUpdated = ps2.executeUpdate();

            // Send response to the client
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");
            if (rowsUpdated > 0 && userRowsUpdated > 0) {
                out.println("<h3>Record updated successfully in both tables!</h3>");
            } else {
                out.println("<h3>Update failed. Please check if the record exists.</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (ps2 != null) ps2.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
