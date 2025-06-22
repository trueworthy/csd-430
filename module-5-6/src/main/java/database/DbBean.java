//    Lea Trueworthy
//    CSD 430 Module 5 & 6 Assignment: Working with CRUD-READ, JDBC, & JavaBeans
//    June 21, 2025

package database;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DbBean implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private Connection connection;
	private Statement statement;

	private final String url = "jdbc:mysql://localhost:3306/CSD430";
	private final String username = "student1";
	private final String password = "pass";

	// Constructor opens connection and creates statement
	public DbBean() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(url, username, password);
			statement = connection.createStatement();
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("Error initializing DB connection: " + e.getMessage());
		}
	}

	// Close connection and statement
	public void closeConnection() {
		try {
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		} catch (SQLException e) {
			System.out.println("Error closing DB connection: " + e.getMessage());
		}
	}

	// Create table
	public String createTable() {
		StringBuilder result = new StringBuilder();
		try {
			statement.executeUpdate("DROP TABLE IF EXISTS lea_library_data");
			result.append("Dropped existing table if it existed.<br>");

			String createSQL = """
					    CREATE TABLE lea_library_data (
					        book_id INT AUTO_INCREMENT PRIMARY KEY,
					        title VARCHAR(255),
					        author VARCHAR(255),
					        publish_year INT,
					        genre VARCHAR(100)
					    )
					""";
			statement.executeUpdate(createSQL);
			result.append("Created table lea_library_data.<br>");
		} catch (SQLException e) {
			return "Error creating table: " + e.getMessage();
		}
		return result.toString();
	}

	// Populate table with sample data
	public String populateTable() {
		String[] inserts = {
				"INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES('Murder Your Employer', 'Rupert Holmes', 2022, 'Mystery')",
				"INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES('The Instructor', 'TR Hendricks', 2021, 'Thriller')",
				"INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES('From Below', 'Darcy Coates', 2021, 'Horror')",
				"INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES('Grave Reservations', 'Cherie Priest', 2021, 'Mystery')",
				"INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES('The Lost Village', 'Camilla Sten and Alexandra Fleming', 2021, 'Thriller')",
				"INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES('The New Neighbor', 'Carter Wilson', 2021, 'Thriller')",
				"INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES('The Cartographers', 'Peng Shepherd', 2022, 'Fantasy')",
				"INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES('Girl in Ice', 'Erica Ferencik', 2022, 'Thriller')",
				"INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES('The Fields', 'Erin Young', 2021, 'Crime')",
				"INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES('Mickey7', 'Edward Ashton', 2022, 'Science Fiction')" };

		try {
			for (String sql : inserts) {
				statement.executeUpdate(sql);
			}
			return "Library populated with 10 books.<br>";
		} catch (SQLException e) {
			return "Error populating table: " + e.getMessage();
		}
	}

	// Read all books (returns HTML table)
	public String readAll() {
		StringBuilder sb = new StringBuilder();
		try {
			ResultSet rs = statement.executeQuery("SELECT * FROM lea_library_data ORDER BY book_id ASC");
			sb.append("<table border='1'><tr><th>ID</th><th>Title</th><th>Author</th><th>Year</th><th>Genre</th></tr>");
			while (rs.next()) {
				sb.append("<tr>").append("<td>").append(rs.getInt("book_id")).append("</td>").append("<td>")
						.append(rs.getString("title")).append("</td>").append("<td>").append(rs.getString("author"))
						.append("</td>").append("<td>").append(rs.getInt("publish_year")).append("</td>").append("<td>")
						.append(rs.getString("genre")).append("</td>").append("</tr>");
			}
			sb.append("</table>");
		} catch (SQLException e) {
			return "Error reading data: " + e.getMessage();
		}
		return sb.toString();
	}

	// Create book
	public String createBook(String title, String author, int year, String genre) {
		String sql = "INSERT INTO lea_library_data (title, author, publish_year, genre) VALUES (?, ?, ?, ?)";
		try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
			pstmt.setString(1, title);
			pstmt.setString(2, author);
			pstmt.setInt(3, year);
			pstmt.setString(4, genre);
			pstmt.executeUpdate();
			return "Book added successfully.<br>";
		} catch (SQLException e) {
			return "Error adding book: " + e.getMessage();
		}
	}

	// Delete book by ID
	public String delete(int bookId) {
		String sql = "DELETE FROM lea_library_data WHERE book_id = ?";
		try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
			pstmt.setInt(1, bookId);
			int rows = pstmt.executeUpdate();
			return rows > 0 ? "Book deleted successfully.<br>" : "No book found with that ID.<br>";
		} catch (SQLException e) {
			return "Error deleting book: " + e.getMessage();
		}
	}

	// Update book by ID
	public String updateBook(String idStr, String title, String author, int year, String genre) {
		String sql = "UPDATE lea_library_data SET title = ?, author = ?, publish_year = ?, genre = ? WHERE book_id = ?";
		try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
			pstmt.setString(1, title);
			pstmt.setString(2, author);
			pstmt.setInt(3, year);
			pstmt.setString(4, genre);
			pstmt.setInt(5, Integer.parseInt(idStr));
			int rows = pstmt.executeUpdate();
			return rows > 0 ? "Book updated successfully.<br>" : "No book found for that ID.<br>";
		} catch (SQLException e) {
			return "Error updating book: " + e.getMessage();
		}
	}

	// Get book details by ID (to pre-fill update form)
	public String getBookDetails(String idStr) {
		StringBuilder sb = new StringBuilder();
		String sql = "SELECT * FROM lea_library_data WHERE book_id = ?";
		try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
			pstmt.setInt(1, Integer.parseInt(idStr));
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				sb.append("<form method='post'>");
				sb.append("ID: <input type='text' name='book_id' value='").append(rs.getInt("book_id"))
						.append("' readonly><br>");
				sb.append("Title: <input type='text' name='title' value='").append(rs.getString("title"))
						.append("'><br>");
				sb.append("Author: <input type='text' name='author' value='").append(rs.getString("author"))
						.append("'><br>");
				sb.append("Year: <input type='number' name='publish_year' value='").append(rs.getInt("publish_year"))
						.append("'><br>");
				sb.append("Genre: <input type='text' name='genre' value='").append(rs.getString("genre"))
						.append("'><br>");
				sb.append("<input type='submit' value='Update Book'>");
				sb.append("</form>");
			} else {
				sb.append("<p>No book found with ID ").append(idStr).append(".</p>");
			}
		} catch (Exception e) {
			sb.append("<p>Error: ").append(e.getMessage()).append("</p>");
		}
		return sb.toString();
	}

	// Generate <option> list for book IDs (for dropdowns)
	public String getBookIdOptions() {
		StringBuilder sb = new StringBuilder();
		try {
			ResultSet rs = statement.executeQuery("SELECT book_id FROM lea_library_data ORDER BY book_id ASC");
			while (rs.next()) {
				int id = rs.getInt("book_id");
				sb.append("<option value='").append(id).append("'>").append(id).append("</option>");
			}
		} catch (SQLException e) {
			sb.append("<option>Error loading IDs</option>");
		}
		return sb.toString();
	}

	// Provide the PK form for GET requests (like professor's formGetPK)
	public String formGetPK(String jspName) {
		StringBuilder sb = new StringBuilder();
		sb.append("<form action='").append(jspName).append("' method='post'>");
		sb.append("Select Book ID: <select name='book_id'>");
		sb.append(getBookIdOptions());
		sb.append("</select>");
		sb.append("<input type='submit' value='Submit'>");
		sb.append("</form>");
		return sb.toString();
	}

	// Get one book by ID (readonly, single row table)
	public String getBookById(int bookId) {
		StringBuilder sb = new StringBuilder();
		String sql = "SELECT * FROM lea_library_data WHERE book_id = ?";
		try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
			pstmt.setInt(1, bookId);
			ResultSet rs = pstmt.executeQuery();

			sb.append("<table border='1'><tr><th>ID</th><th>Title</th><th>Author</th><th>Year</th><th>Genre</th></tr>");
			if (rs.next()) {
				sb.append("<tr>").append("<td>").append(rs.getInt("book_id")).append("</td>").append("<td>")
						.append(rs.getString("title")).append("</td>").append("<td>").append(rs.getString("author"))
						.append("</td>").append("<td>").append(rs.getInt("publish_year")).append("</td>").append("<td>")
						.append(rs.getString("genre")).append("</td>").append("</tr>");
			} else {
				sb.append("<tr><td colspan='5'>No book found with ID ").append(bookId).append(".</td></tr>");
			}
			sb.append("</table>");
		} catch (SQLException e) {
			return "Error fetching book by ID: " + e.getMessage();
		}
		return sb.toString();
	}

	// --- OPTIONAL: Get distinct publish years for dropdown ---
	public List<Integer> getDistinctPublishYears() {
		List<Integer> years = new ArrayList<>();
		String sql = "SELECT DISTINCT publish_year FROM lea_library_data ORDER BY publish_year ASC";
		try (Statement stmt = connection.createStatement()) {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				years.add(rs.getInt("publish_year"));
			}
		} catch (SQLException e) {
			// Return empty list on error
		}
		return years;
	}
}
