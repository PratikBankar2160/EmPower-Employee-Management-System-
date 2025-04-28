<%@ page import="java.sql.*" %>
<%
    // Session validation
    if (session == null || session.getAttribute("u_id") == null || session.getAttribute("loggedIn") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("Employee")) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
    	Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

        String query = "SELECT u.name, a.attendance_date, a.status, a.check_in, a.check_out FROM attendance a JOIN user_info u ON a.u_id = u.id";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
%>

<h3>Attendance Dashboard</h3>
<table border="1">
    <tr>
        <th>Employee Name</th>
        <th>Date</th>
        <th>Status</th>
        <th>Check-in</th>
        <th>Check-out</th>
    </tr>

<%
    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getDate("attendance_date") %></td>
        <td><%= rs.getString("status") %></td>
        <td><%= rs.getTime("check_in") %></td>
        <td><%= rs.getTime("check_out") %></td>
    </tr>
<%
    }
%>
</table>

<%
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
