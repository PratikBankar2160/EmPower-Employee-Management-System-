package emp.in.sp.test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;

@WebServlet("/RequestLeave")
public class RequestLeave extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Session validation
        HttpSession session = req.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("u_id") : null;
        Boolean loggedIn = (session != null) ? (Boolean) session.getAttribute("loggedIn") : null;
        
        if (userId == null || loggedIn == null || !loggedIn) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        String leaveType = req.getParameter("leave_type");
        String startDate = req.getParameter("start_date");
        String endDate = req.getParameter("end_date");
        String reason = req.getParameter("reason");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

            String query = "INSERT INTO leave_management (e_id, leave_type, start_date, end_date, reason, status) VALUES (?, ?, ?, ?, ?, 'Pending')";
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setString(2, leaveType);
            ps.setDate(3, Date.valueOf(startDate));
            ps.setDate(4, Date.valueOf(endDate));
            ps.setString(5, reason);

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                resp.sendRedirect("ViewLeaveStatus.jsp");
            } else {
                resp.getWriter().print("Failed to request leave.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            resp.getWriter().print("Error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

