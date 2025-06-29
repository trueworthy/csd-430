//    Lea Trueworthy
//    CSD 430 Module 7 Assignment: Working with CRUD-READ, JDBC, & JavaBeans
//    June 28, 2025

package configBean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ConfigProject implements java.io.Serializable {

    // Connection and Statement objects
    private Connection connection;
    private Statement statement;

    // Serial version UID
    private static final long serialVersionUID = 111222333444L;

    // Database credentials
    private final String url = "jdbc:mysql://localhost:3306/CSD430";
    private final String username = "student1";
    private final String password = "pass";

    // ***************************************************************
    // ------------------------ Constructor --------------------------
    // ***************************************************************
    
    public ConfigProject() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load the driver
            connection = DriverManager.getConnection(url, username, password);  // Establish connection
            statement = connection.createStatement();  // Create a statement object
        } catch (ClassNotFoundException e) {
            System.out.println("Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage());
        }
    }

    // ***************************************************************
    // ------------------------ Populate Table ----------------------
    // ***************************************************************
    
    public String populateTable() {
        StringBuilder result = new StringBuilder();
        
        // SQL queries to insert data into the table
        String sql = """
                INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES
                ('Murder Your Employer', 'Rupert Holmes', 2022, 'Mystery'),
                ('The Instructor', 'TR Hendricks', 2021, 'Thriller'),
                ('From Below', 'Darcy Coates', 2021, 'Horror'),
                ('Grave Reservations', 'Cherie Priest', 2021, 'Mystery'),
                ('The Lost Village', 'Camilla Sten and Alexandra Fleming', 2021, 'Thriller'),
                ('The New Neighbor', 'Carter Wilson', 2021, 'Thriller'),
                ('The Cartographers', 'Peng Shepherd', 2022, 'Fantasy'),
                ('Girl in Ice', 'Erica Ferencik', 2022, 'Thriller'),
                ('The Fields', 'Erin Young', 2021, 'Crime'),
                ('Mickey7', 'Edward Ashton', 2022, 'Science Fiction');
        """;

        try {
            // Execute the SQL query to populate the table
            statement.executeUpdate(sql);
            result.append("The library has been populated.");
        } catch (SQLException e) {
            result.append("Error populating table: ").append(e.getMessage());
        }
        
        return result.toString();  // Return result message
    }

    // ***************************************************************
    // ------------------------ Read Table --------------------------
    // ***************************************************************
    
    public String read() {
        StringBuilder result = new StringBuilder();
        
        try {
            // Execute a query to retrieve data from the table
            var rs = statement.executeQuery("SELECT * FROM lea_library_data");

            // Prepare the result to display in an HTML table
            result.append("<table border='1'><tr><th>ID</th><th>Title</th><th>Author</th><th>Year</th><th>Genre</th></tr>");
            
            while (rs.next()) {
                result.append("<tr>")
                      .append("<td>").append(rs.getInt("id")).append("</td>")
                      .append("<td>").append(rs.getString("title")).append("</td>")
                      .append("<td>").append(rs.getString("author")).append("</td>")
                      .append("<td>").append(rs.getInt("publish_year")).append("</td>")
                      .append("<td>").append(rs.getString("genre")).append("</td>")
                      .append("</tr>");
            }
            result.append("</table>");
            rs.close();
        } catch (SQLException e) {
            result.append("Error reading from table: ").append(e.getMessage());
        }
        
        return result.toString();  // Return the table HTML or error message
    }

    // ***************************************************************
    // ------------------------ Close Connection ---------------------
    // ***************************************************************
    
    public void closeConnection() {
        try {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            System.out.println("Error closing resources: " + e.getMessage());
        }
    }
}
