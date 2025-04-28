package emp.in.sp.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MarkAttendance")
public class MarkAttendance extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("u_id") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        int u_id = (int) session.getAttribute("u_id");
        String role = (String) session.getAttribute("role");

        String status = req.getParameter("status");
        int employee_id = role.equals("Manager") || role.equals("HR") ? Integer.parseInt(req.getParameter("employee_id")) : u_id;

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

            String query = "INSERT INTO attendance (u_id, date, status) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, employee_id);
            ps.setDate(2, java.sql.Date.valueOf(LocalDate.now()));
            ps.setString(3, status);

            int result = ps.executeUpdate();
            PrintWriter out = resp.getWriter();
            if (result > 0) {
                out.println("Attendance Marked Successfully!");
            } else {
                out.println("Failed to mark attendance.");
            }

            ps.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
