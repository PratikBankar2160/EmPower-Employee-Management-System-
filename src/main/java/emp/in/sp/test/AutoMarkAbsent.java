package emp.in.sp.test;

import java.sql.*;
import java.time.*;

public class AutoMarkAbsent {
    public static void main(String[] args) {
        try (Connection con = DriverManager.getConnection("jdbc:postgresql:emp_project","postgres","pratik4023")) {
            String query = """
                INSERT INTO attendance (u_id, attendance_date, status)
                SELECT u_id, ? , 'Absent'
                FROM user_info
                WHERE u_id NOT IN (
                    SELECT u_id FROM attendance WHERE attendance_date = ?
                )
            """;

            try (PreparedStatement ps = con.prepareStatement(query)) {
                LocalDate today = LocalDate.now();
                ps.setDate(1, Date.valueOf(today));
                ps.setDate(2, Date.valueOf(today));

                int rowsAffected = ps.executeUpdate();
                System.out.println(rowsAffected + " employees marked as Absent.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
