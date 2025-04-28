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

@WebServlet("/ViewAttendance")
public class ViewAttendance extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("u_id") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        int u_id = (int) session.getAttribute("u_id");
        String role = (String) session.getAttribute("role");

        PrintWriter out = resp.getWriter();
        resp.setContentType("text/html");

        try {
        	Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

            String query = "SELECT u_id, date, status FROM attendance WHERE u_id=? ORDER BY date DESC";
            if ("Manager".equals(role) || "HR".equals(role)) {
                query = "SELECT u_id, date, status FROM attendance ORDER BY date DESC"; // For managers/HR, show all
            }

            PreparedStatement ps = con.prepareStatement(query);
            if ("Employee".equals(role)) {
                ps.setInt(1, u_id);
            }

            ResultSet rs = ps.executeQuery();

            out.println("<table border='1' class='striped centered'>");
            out.println("<tr><th>Employee ID</th><th>Date</th><th>Status</th></tr>");
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("u_id") + "</td>");
                out.println("<td>" + rs.getDate("date") + "</td>");
                out.println("<td>" + rs.getString("status") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");

            rs.close();
            ps.close();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<h3 style='color:red'>" + e.getMessage() + "</h3>");
        }
    }
}
