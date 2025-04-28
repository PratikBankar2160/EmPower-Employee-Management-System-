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
import jakarta.servlet.http.HttpSession;

@WebServlet("/ViewPendingLeaves")
public class ViewPendingLeaves extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("u_id") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int managerId = (Integer) session.getAttribute("u_id");
        String statusFilter = req.getParameter("status"); // Get the status parameter from request

        String url = "jdbc:postgresql:emp_project?useSSL=false&allowPublicKeyRetrieval=true";
        String user = "postgres";
        String password = "pratik4023";

        String query = "SELECT l.leave_id, e.id AS emp_id, e.name AS emp_name, l.leave_type, "
                     + "l.start_date, l.end_date, l.reason, l.status "
                     + "FROM leave_management l "
                     + "JOIN Emp_Add e ON l.e_id = e.id "
                     + "WHERE e.u_id = ? ";
        
        // Apply status filter if provided
        if (statusFilter != null && !statusFilter.isEmpty()) {
            query += "AND l.status = ? ";
        }

        query += "ORDER BY CASE "
               + "WHEN l.status = 'Pending' THEN 1 "
               + "WHEN l.status = 'Approved' THEN 2 "
               + "WHEN l.status = 'Rejected' THEN 3 ELSE 4 END, "
               + "l.start_date DESC;";

        try (Connection con = DriverManager.getConnection(url, user, password);
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, managerId);
            
            if (statusFilter != null && !statusFilter.isEmpty()) {
                ps.setString(2, statusFilter); // Bind status if filter is applied
            }

            try (ResultSet rs = ps.executeQuery()) {
                out.println("<table class='striped centered highlight'>");
                out.println("<thead><tr><th>Leave ID</th><th>Employee ID</th><th>Employee Name</th><th>Leave Type</th>"
                          + "<th>Start Date</th><th>End Date</th><th>Reason</th><th>Status</th><th>Actions</th></tr></thead>");
                out.println("<tbody>");

                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
                    int leaveId = rs.getInt("leave_id");
                    String currentStatus = rs.getString("status");

                    String actionButton = "";
                    if ("Pending".equals(currentStatus)) {
                        actionButton = "<button onclick=\"updateStatus(" + leaveId + ", 'Approved')\" class='btn green waves-effect'>Approve</button> "
                                     + "<button onclick=\"updateStatus(" + leaveId + ", 'Rejected')\" class='btn red waves-effect'>Reject</button>";
                    } else if ("Approved".equals(currentStatus)) {
                        actionButton = "<button onclick=\"updateStatus(" + leaveId + ", 'Rejected')\" class='btn red waves-effect'>Reject</button>";
                    } else if ("Rejected".equals(currentStatus)) {
                        actionButton = "<button onclick=\"updateStatus(" + leaveId + ", 'Approved')\" class='btn green waves-effect'>Approve</button>";
                    }

                    out.println("<tr id='row_" + leaveId + "'>");
                    out.println("<td>" + leaveId + "</td>");
                    out.println("<td>" + rs.getInt("emp_id") + "</td>");
                    out.println("<td>" + rs.getString("emp_name") + "</td>");
                    out.println("<td>" + rs.getString("leave_type") + "</td>");
                    out.println("<td>" + rs.getDate("start_date") + "</td>");
                    out.println("<td>" + rs.getDate("end_date") + "</td>");
                    out.println("<td>" + rs.getString("reason") + "</td>");
                    out.println("<td id='status_" + leaveId + "'><b>" + currentStatus + "</b></td>");
                    out.println("<td id='actions_" + leaveId + "'>" + actionButton + "</td>");
                    out.println("</tr>");
                }

                if (!hasData) {
                    out.println("<tr><td colspan='9'>No leave requests found</td></tr>");
                }

                out.println("</tbody></table>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error fetching leave requests: " + e.getMessage() + "</p>");
        }
    }
}
