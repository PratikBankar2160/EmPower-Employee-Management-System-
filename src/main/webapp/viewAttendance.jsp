<%@ page import="java.sql.*" %>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    Object userIdObj = session.getAttribute("u_id");

    if (userIdObj == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    int u_id = Integer.parseInt(userIdObj.toString());

    try {
    	Class.forName("org.postgresql.Driver");
    	con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023");

        String query = "SELECT attendance_date, status, check_in, check_out FROM attendance WHERE u_id = ?";
        ps = con.prepareStatement(query);
        ps.setInt(1, u_id);
        rs = ps.executeQuery();
%>

<h3>Your Attendance Records</h3>

<% if (!rs.isBeforeFirst()) { %>
    <p style="color: red;">No attendance records found.</p>
<% } else { %>

<table border="1">
    <tr>
        <th>Date</th>
        <th>Status</th>
        <th>Check-in</th>
        <th>Check-out</th>
    </tr>

<%
    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getDate("attendance_date") %></td>
        <td><%= rs.getString("status") %></td>
        <td><%= rs.getTime("check_in") != null ? rs.getTime("check_in") : "N/A" %></td>
        <td><%= rs.getTime("check_out") != null ? rs.getTime("check_out") : "N/A" %></td>
    </tr>
<%
    }
%>
</table>

<% } %>

<%
    } catch (Exception e) {
%>
    <p style="color: red;">Error fetching attendance records.</p>
<%
    }
%>
