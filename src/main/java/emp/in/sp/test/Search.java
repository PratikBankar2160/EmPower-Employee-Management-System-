package emp.in.sp.test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Search")
public class Search extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("u_id") == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        int u_id = (Integer) session.getAttribute("u_id");
        String idParam = req.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            req.setAttribute("error", "Employee ID is required!");
            RequestDispatcher rd = req.getRequestDispatcher("Search.jsp");
            rd.forward(req, resp);
            return;
        }

        int empId;
        try {
            empId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid Employee ID format!");
            RequestDispatcher rd = req.getRequestDispatcher("Search.jsp");
            rd.forward(req, resp);
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
        	Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

            String query = "SELECT * FROM Emp_Add WHERE id=? AND u_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, empId);
            ps.setInt(2, u_id);
            rs = ps.executeQuery();

            if (rs.next()) {
                req.setAttribute("id", rs.getInt("id"));
                req.setAttribute("name", rs.getString("name"));
                req.setAttribute("age", rs.getInt("age"));
                req.setAttribute("dob", rs.getDate("date_of_birth"));
                req.setAttribute("address", rs.getString("address"));
                req.setAttribute("mobile", rs.getString("Mobile_no"));
                req.setAttribute("email", rs.getString("email"));
                req.setAttribute("education", rs.getString("education"));
                req.setAttribute("adhar", rs.getString("adhar_no"));
            } else {
                req.setAttribute("error", "No record found for ID: " + empId);
            }

            RequestDispatcher rd = req.getRequestDispatcher("Search.jsp");
            rd.forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            RequestDispatcher rd = req.getRequestDispatcher("Search.jsp");
            rd.forward(req, resp);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
