package emp.in.sp.test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateLeaveStatus")
public class UpdateLeaveStatus extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String leaveId = req.getParameter("leave_id");
        String status = req.getParameter("status");

        String url = "jdbc:postgresql:emp_project?useSSL=false&allowPublicKeyRetrieval=true";
        String user = "postgres";
        String password = "pratik4023";

        String query = "UPDATE leave_management SET status = ? WHERE leave_id = ?";

        try (Connection con = DriverManager.getConnection(url, user, password);
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, status);
            ps.setInt(2, Integer.parseInt(leaveId));

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                resp.getWriter().write("success");
            } else {
                resp.getWriter().write("failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("error");
        }
    }
}
