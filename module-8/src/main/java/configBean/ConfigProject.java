package configBean;

//Lea Trueworthy
//CSD 430 Module 8 Assignment: Working with CRUD-READ, JDBC, & JavaBeans
//July 1, 2025

public class ConfigProject implements java.io.Serializable {

	private static final long serialVersionUID = 1111222233334444L;

	// Database connection settings
	private static final String DB_URL = System.getProperty("db.url", "jdbc:mysql://localhost:3306/CSD430");
	private static final String DB_USER = System.getProperty("db.user", "student1");
	private static final String DB_PASSWORD = System.getProperty("db.password", "pass");

	// Name of the database
	private static final String TABLE_NAME = "trueworthy_library_data";

	// ***************************************************************
	// ------------------------ Constructor --------------------------
	// ***************************************************************

	public ConfigProject() {
		// No action needed in constructor
	}

	// Drops the existing table and creates a new one
	public String createTable() {
		StringBuilder dataStringBuilder = new StringBuilder();

		// Drop table if exists
		try (java.sql.Connection conn = getConnection(); java.sql.Statement stmt = conn.createStatement()) {
			stmt.executeUpdate("DROP TABLE IF EXISTS " + TABLE_NAME);
			dataStringBuilder.append("Table ").append(TABLE_NAME).append(" dropped (if it existed).<br />");
		} catch (java.sql.SQLException e) {
			dataStringBuilder.append("<b>Error during drop operation: ").append(e.getMessage()).append("</b><br />");
		}

		// ***************************************************************
		// ------------------------ Create Table ----------------------
		// ***************************************************************
		
		try (java.sql.Connection conn = getConnection(); java.sql.Statement stmt = conn.createStatement()) {
			String createTableSQL = "CREATE TABLE " + TABLE_NAME + " (" + 
					"BookID int NOT NULL AUTO_INCREMENT PRIMARY KEY, " + 
					"Title varchar(255) NOT NULL, " + 
					"Author varchar(255) NOT NULL, " + 
					"Genre varchar(255) NOT NULL, " + 
					"publish_year int NOT NULL, " + 
					"bookFormat varchar(255) NOT NULL, " + 
					"ISBN varchar(13) NOT NULL" + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";
			stmt.executeUpdate(createTableSQL);
			dataStringBuilder.append("Table ").append(TABLE_NAME).append(" created successfully.<br />");
		} catch (java.sql.SQLException e) {
			dataStringBuilder.append("<b>Table creation failed: ").append(e.getMessage()).append("</b><br />");
		}

		return dataStringBuilder.toString();
	}

	// ***************************************************************
	// ------------------------ Populate Table ----------------------
	// ***************************************************************

	public String populateTable() {
		StringBuilder dataStringBuilder = new StringBuilder();
		
// I decided to add more books to the list just to see what it would look like
		String[][] books = { 
				{ "Murder Your Employer", "Rupert Holmes", "Mystery", "2022", "HC", "9781451648218" },
				{ "The Instructor", "TR Hendricks", "Thriller", "2021", "MM", "9781250832962" },
				{ "From Below", "Darcy Coates", "Horror", "2021", "PB", "9781728220239" },
				{ "Grave Reservations", "Cherie Priest", "Mystery", "2021", "HC", "9781982168896" },
				{ "The New Neighbor", "Carter Wilson", "Thriller", "2021", "PB", "9781728247526" },
				{ "Girl in Ice", "Erica Ferencik", "Thriller", "2022", "HC", "9781982143022" },
				{ "The Fields", "Erin Young", "Crime", "2021", "HC", "9781250799395" },
				{ "Mickey7", "Edward Ashton", "Science Fiction", "2022", "PB", "9781250875280" },
			    { "The Silent Patient", "Alex Michaelides", "Thriller", "2019", "HC", "9781250301697" },
			    { "Moon USA National Parks Hiking", "Jason Frye", "Travel", "2025", "PB", "9798886470826" },
			    { "Where the Forest Meets the Stars", "Glendy Vanderah", "Fantasy", "2019", "PB", "9781503904910" },
			    { "Mexican Gothic", "Silvia Moreno-Garcia", "Horror", "2020", "HC", "9780525620785" },
			    { "Dessert Person: Recipes and Guidance for Baking with Confidence: A Baking Book", "Claire Saffitz", "Cooking", "2020", "HC", "9781984826961" },
			    { "The Lorax", "Dr. Seuss", "Kids", "1971", "HC", "9780394823379" },
			    { "Zen and the Art of Motorcycle Maintenance", "Robert M Pirsig", "Philosophy", "2006", "MM", "9780060589462" },
			    { "The Secret of Secrets", "Dan Brown", "Thriller", "2025", "HC", "9780385546898" },
			    { "Denver Dossier: Themed Adventures for Every Traveler", "Kimberly Burk Cordova", "Travel", "2024", "LP", "9798348571825" },
			    { "The Midnight Library", "Matt Haig", "Fantasy", "2020", "HC", "9780525559474" },
			    { "I Know Why the Caged Bird Sings", "Maya Angelou", "Biographies", "2009", "PB", "9780812980028" },
			    { "Project Hail Mary", "Andy Weir", "Science Fiction", "2021", "HC", "9780593135204" },
			    { "The Guest List", "Lucy Fokley", "Mystery", "2020", "HC", "9780062868930" },
			    { "The Cruel Prince", "Holly Black", "Teen & Young Adult", "2018", "HC", "9780316310314" },
			    { "One Piece, Vol. 1: Romance Dawn", "Eiichiro Oda", "Comic", "2003", "PB", "9781569319017" },
			    { "The Godfather", "Mario Puzo", "Thrillers", "1969", "HC", "9780399103421" },
				{ "The Cartographers", "Peng Shepherd", "Fantasy", "2022", "HC", "9780062910691" },
			    { "The Forgotten 500", "Gregory A. Freeman", "History", "2008", "PB", "9780451224958" },
			    { "It Ends With Us", "Colleen Hoover", "Romance", "2016", "PB", "9781501110368" },
			    { "Gerald's Game", "Stephen King", "Horror", "1994", "HC", "9780831727529" },
			    { "100 Plants to Feed the Bees", "The Xerces Society", "Nature", "2016", "HC", "9781612128863" },
			    { "The Maid", "Nita Prose", "Mystery", "2022", "HC", "9780593356159" },
			    { "A Brief History of Time", "Stephen Hawking", "Science", "1998", "PB", "9780553380163" },
			    { "The Last Thing He Told Me", "Laura Dave", "Thriller", "2021", "HC", "9781501171345" },
			    { "Expiration Dates", "Rebecca Serle", "Romance", "2024", "HC", "9781982166823" },
				{ "The Lost Village", "Camilla Sten and Alexandra Fleming", "Thriller", "2021", "HC", "9781250249258" },
			    { "Dr. Seuss's ABC", "Dr. Seuss", "Kids", "1991", "HC", "9780394800301" }
				};

		try (java.sql.Connection conn = getConnection();
				java.sql.PreparedStatement stmt = conn.prepareStatement("INSERT INTO " + TABLE_NAME
						+ "(Title, Author, Genre, publish_year, bookFormat, ISBN) VALUES(?, ?, ?, ?, ?, ?)")) {

			conn.setAutoCommit(false);

			for (String[] book : books) {
				stmt.setString(1, book[0]); // Title
				stmt.setString(2, book[1]); // Author
				stmt.setString(3, book[2]); // Genre
				stmt.setInt(4, Integer.parseInt(book[3])); // publish_year
				stmt.setString(5, book[4]); // bookFormat
				stmt.setString(6, book[5]); // ISBN
				stmt.addBatch();
			}

			stmt.executeBatch();
			conn.commit();
			dataStringBuilder.append("Table populated successfully with ").append(books.length).append(" books.");

		} catch (java.sql.SQLException e) {
			dataStringBuilder.append("<b>Error inserting data: ").append(e.getMessage()).append("</b><br />");
		}

		return dataStringBuilder.toString();
	}

	// ***************************************************************
	// ------------------------ Read Table --------------------------
	// ***************************************************************

	public String read() {
		StringBuilder dataStringBuilder = new StringBuilder();

		String sql = "SELECT * FROM " + TABLE_NAME;

		try (java.sql.Connection conn = getConnection();
				java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
				java.sql.ResultSet resultSet = stmt.executeQuery()) {

			dataStringBuilder.append("<table border='1' class='table'>").append(
					"<thead><tr>"
					+ "<th>Book ID</th>"
					+ "<th>Title</th>"
					+ "<th>Author</th>"
					+ "<th>Genre</th>"
					+ "<th>Publication Year</th>"
					+ "<th>Book Format</th>"
					+ "<th>ISBN</th></tr>"
					+ "</thead>")
					.append("<tbody>");

			while (resultSet.next()) {
				dataStringBuilder.append("<tr>");
				for (int i = 1; i <= resultSet.getMetaData().getColumnCount(); i++) {
					dataStringBuilder.append("<td>").append(resultSet.getString(i).trim()).append("</td>");
				}
				dataStringBuilder.append("</tr>");
			}
			dataStringBuilder.append("</tbody></table>");

		} catch (java.sql.SQLException e) {
			dataStringBuilder.append("<p>Error retrieving data: ").append(e.getMessage()).append("</p>");
		}

		return dataStringBuilder.toString();
	}

	// Establishes and returns a connection to the database
	private java.sql.Connection getConnection() throws java.sql.SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String connectionUrl = DB_URL + "?user=" + DB_USER + "&password=" + DB_PASSWORD
					+ "&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
			return java.sql.DriverManager.getConnection(connectionUrl);
		} catch (ClassNotFoundException e) {
			throw new java.sql.SQLException("Database driver not found: " + e.getMessage(), e);
		}
	}
}