package database;

//Lea Trueworthy
//CSD 430 Module 8 Assignment: Working with CRUD-READ, JDBC, & JavaBeans
//July 1, 2025

import java.sql.*;
import java.util.*;

public class DbBean implements java.io.Serializable {

    private static final long serialVersionUID = 1111222233334444L;
    
	// Database connection settings
    private static final String DB_URL = System.getProperty("db.url", "jdbc:mysql://localhost:3306/CSD430");
    private static final String DB_USER = System.getProperty("db.user", "student1");
    private static final String DB_PASSWORD = System.getProperty("db.password", "pass");
    
	// ***************************************************************
	// ------------------------ Constructor --------------------------
	// ***************************************************************
    
    public DbBean() {
        // No action needed
    }

    // ***************************************************************
    // ------------------------ Update Record ------------------------
    // ***************************************************************

    public String updateRecord(String title, String author, String genre, int publish_year, String bookFormat, String ISBN, int bookID) {
        String result = "";
        String sql = "UPDATE trueworthy_library_data SET title=?, author=?, genre=?, publish_year=?, bookFormat=?, ISBN=? WHERE bookID=?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, title);
            stmt.setString(2, author);
            stmt.setString(3, genre);
            stmt.setInt(4, publish_year);
            stmt.setString(5, bookFormat);
            stmt.setString(6, ISBN);
            stmt.setInt(7, bookID);
            int rowsAffected = stmt.executeUpdate();
            result = rowsAffected > 0 ? "Record updated successfully." : "Update failed.";
        } catch (SQLException e) {
            result = "Error: " + e.getMessage();
        }
        return result;
    }

    public Map<String, String> getRecordById(int bookID) {
        Map<String, String> data = new HashMap<>();
        String sql = "SELECT * FROM trueworthy_library_data WHERE bookID = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                data.put("bookID", rs.getString("bookID"));
                data.put("title", rs.getString("title"));
                data.put("author", rs.getString("author"));
                data.put("genre", rs.getString("genre"));
                data.put("publish_year", rs.getString("publish_year"));
                data.put("bookFormat", rs.getString("bookFormat"));
                data.put("ISBN", rs.getString("ISBN"));
            }
        } catch (SQLException e) {
        }
        return data;
    }

    // ***************************************************************
    // ------------------------ Create Record ------------------------
    // ***************************************************************

    public String createRecord(String title, String author, String genre, int publish_year, String bookFormat, String ISBN) throws SQLException {
        String sql = "INSERT INTO trueworthy_library_data(title, author, genre, publish_year, bookFormat, ISBN) VALUES(?, ?, ?, ?, ?, ?)";
        Connection conn = getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setString(1, title);
        stmt.setString(2, author);
        stmt.setString(3, genre);
        stmt.setInt(4, publish_year);
        stmt.setString(5, bookFormat);
        stmt.setString(6, ISBN);
        stmt.executeUpdate();
        ResultSet keys = stmt.getGeneratedKeys();
        keys.next();
        return String.valueOf(keys.getInt(1));
    }
    
    // ***************************************************************
    // ------------------------ FormGetCreate ------------------------
    // ***************************************************************
    
    public String formGetCreateOrUpdate(String requestURL) {
        return "<form method='post' action='" + requestURL + "'>\n" +
                "<br /><br />" +
                "<label for='title'>Title</label>&nbsp;&nbsp;" +
                "<input type='text' name='title' id='title' required maxlength='255'><br />\n" +
                "<label for='author'>Author</label>&nbsp;&nbsp;" +
                "<input type='text' name='author' id='author' required maxlength='255'><br />\n" +
                "<label for='genre'>Genre</label>&nbsp;&nbsp;" +
                "<input type='text' name='genre' id='genre' required maxlength='100'><br />\n" +
                "<label for='publish_year'>Publication Year</label>&nbsp;&nbsp;" +
                "<input type='number' name='publish_year' id='publish_year' required min='1800'><br />\n" +
                "<label for='bookFormat'>Format</label>&nbsp;&nbsp;" +
                "<input type='text' name='bookFormat' id='bookFormat' maxlength='50'><br />\n" +
                "<label for='ISBN'>ISBN</label>&nbsp;&nbsp;" +
                "<input type='text' name='ISBN' id='ISBN'><br /><br />\n" +
                "<input type='submit' value='Create Record'>\n" +
                "</form>\n";
    }

    // ***************************************************************
    // ------------------------ FormGetPK ----------------------------
    // ***************************************************************
    
    public String formGetPK(String unused) {
        StringBuilder dataStringBuilder = new StringBuilder();
        dataStringBuilder.append("<select name=\"bookID\" id=\"bookID\">\n");

        try (java.sql.Connection conn = getConnection();
             java.sql.PreparedStatement stmt = conn.prepareStatement("SELECT bookID, title FROM trueworthy_library_data ORDER BY title ASC");
             java.sql.ResultSet resultSet = stmt.executeQuery()) {

            while (resultSet.next()) {
                dataStringBuilder.append("<option value=\"");
                dataStringBuilder.append(resultSet.getString("bookID"));
                dataStringBuilder.append("\">");
                dataStringBuilder.append(resultSet.getString("title"));
                dataStringBuilder.append("</option>");
            }
        } catch (java.sql.SQLException e) {
            System.err.println("SQL Exception: " + e.getMessage());
        }

        dataStringBuilder.append("</select>");
        return dataStringBuilder.toString();
    }

    // ***************************************************************
    // ------------------------ Read ---------------------------------
    // ***************************************************************
    
    public String read(String bookID) {
        StringBuilder dataStringBuilder = new StringBuilder();
        
        // Check if bookID is null or empty
        if (bookID == null || bookID.trim().isEmpty()) {
            return "<p>No book ID provided for search.</p>";
        }
        
        String sql = "SELECT * FROM trueworthy_library_data WHERE bookID = ?";
        
        try (java.sql.Connection conn = getConnection();
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, bookID);
            
            try (java.sql.ResultSet resultSet = stmt.executeQuery()) {
                dataStringBuilder.append("<table border='1' class='table'>");
                dataStringBuilder.append("<thead><tr><th>Book ID</th><th>Title</th><th>Author</th><th>Genre</th><th>Publication Year</th><th>Book Format</th><th>ISBN</th></tr></thead>");
                dataStringBuilder.append("<tbody>");

                boolean found = false;
                while(resultSet.next()) {
                    found = true;
                    dataStringBuilder.append("<tr>");
                    
                    for(int i = 1; i <= resultSet.getMetaData().getColumnCount(); i++) {
                        dataStringBuilder.append("<td>");
                        String value = resultSet.getString(i);
                        dataStringBuilder.append(value != null ? value.trim() : "");
                        dataStringBuilder.append("</td>");
                    }
                    dataStringBuilder.append("</tr>");
                }
                
                if (!found) {
                    dataStringBuilder.append("<tr><td colspan='7'>No book found with ID: ").append(bookID).append("</td></tr>");
                }
                
                dataStringBuilder.append("</tbody>");
                dataStringBuilder.append("</table>");
            }
            
        } catch(java.sql.SQLException e) {
            System.err.println("SQL Exception: " + e.getMessage());
            dataStringBuilder.append("<p>Error retrieving data: ").append(e.getMessage()).append("</p>");
        }
        
        return dataStringBuilder.toString();
    }

    // ***************************************************************
    // ------------------------ Delete -------------------------------
    // ***************************************************************

    public String delete(String title) {
        String sql = "DELETE FROM trueworthy_library_data WHERE title = ?";
        
        try (java.sql.Connection conn = getConnection();
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, title);
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                return "Record deleted successfully";
            } else {
                return "No record found to delete";
            }
            
        } catch(java.sql.SQLException e) {
            System.err.println("SQL Exception: " + e.getMessage());
            return "Error deleting record: " + e.getMessage();
        }
    }

    // ***************************************************************
    // ------------------------ Read All -----------------------------
    // ***************************************************************

    public String readAll() {
        StringBuilder dataStringBuilder = new StringBuilder();
        
        String sql = "SELECT * FROM trueworthy_library_data";
        
        try (java.sql.Connection conn = getConnection();
            java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
            java.sql.ResultSet resultSet = stmt.executeQuery()) {
            
            dataStringBuilder.append("<table border='1'>");
            dataStringBuilder.append("<thead><tr><th>Book ID</th><th>Title</th><th>Author</th><th>Genre</th><th>Publication Year</th><th>Format</th><th>ISBN</th></tr></thead>");
            dataStringBuilder.append("<tbody>");

            while(resultSet.next()) {
                dataStringBuilder.append("<tr>");
                for(int i = 1; i <= resultSet.getMetaData().getColumnCount(); i++) {
                    dataStringBuilder.append("<td>");
                    dataStringBuilder.append(resultSet.getString(i).trim());
                    dataStringBuilder.append("</td>");
                }
                dataStringBuilder.append("</tr>");
            }
            dataStringBuilder.append("</tbody>");
            dataStringBuilder.append("</table>");
            
        } catch(java.sql.SQLException e) {
            System.err.println("SQL Exception: " + e.getMessage());
            dataStringBuilder.append("<p>Error retrieving data: ").append(e.getMessage()).append("</p>");
        }

        return dataStringBuilder.toString();
    }

    // Database Connection

    private java.sql.Connection getConnection() throws java.sql.SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String connectionUrl = DB_URL + "?user=" + DB_USER + "&password=" + DB_PASSWORD + 
                "&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            return java.sql.DriverManager.getConnection(connectionUrl);
        } catch(ClassNotFoundException e) {
            throw new java.sql.SQLException("Database driver not found: " + e.getMessage(), e);
        }
    }
}