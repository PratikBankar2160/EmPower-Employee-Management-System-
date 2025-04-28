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

@WebServlet("/Remove")
public class Delete extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        PrintWriter out = res.getWriter();
        res.setContentType("text/html");

        int id = Integer.parseInt(req.getParameter("id"));

        Connection con = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;

        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

            // Start transaction
            con.setAutoCommit(false);

            // Delete from user_info first to maintain referential integrity
            ps1 = con.prepareStatement("DELETE FROM user_info WHERE id=?");
            ps1.setInt(1, id);
            int userDeleted = ps1.executeUpdate();

            // Delete from Emp_Add table
            ps2 = con.prepareStatement("DELETE FROM Emp_Add WHERE id=?");
            ps2.setInt(1, id);
            int empDeleted = ps2.executeUpdate();

            if (empDeleted > 0) {
                con.commit(); // Commit transaction if both deletions are successful
                res.setStatus(HttpServletResponse.SC_OK);
                out.print("Employee Deleted Successfully from both tables.");
            } else {
                con.rollback(); // Rollback transaction if employee deletion fails
                res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("Employee not found or deletion failed.");
            }
        } catch (Exception e) {
            try {
                if (con != null) {
                    con.rollback(); // Rollback transaction in case of an error
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("Error: " + e.getMessage());
        } finally {
            try {
                if (ps1 != null) ps1.close();
                if (ps2 != null) ps2.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
