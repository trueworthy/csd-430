<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
    Lea Trueworthy
    CSD 430 Module 5 & 6 Assignment: Working with CRUD-READ, JDBC, & JavaBeans
    June 21, 2025
-->
<!DOCTYPE html>
<html>
<head>
<title>CRUD Read</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

	<h1>Read Books by ID</h1>

	<jsp:useBean id="myDB" class="database.DbBean" scope="page" />
	<a href="index_02.jsp">back to index02</a>
	<br />

	<!-- Always show the selection form -->
	<form method="post">
		<label>Select Book ID:</label> <select name="book_id" required>
			<%
			try {
				String sql = "SELECT DISTINCT book_id FROM lea_library_data ORDER BY book_id ASC";
				java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/CSD430", "student1",
				"pass");
				java.sql.Statement stmt = conn.createStatement();
				java.sql.ResultSet rs = stmt.executeQuery(sql);
				while (rs.next()) {
					int id = rs.getInt("book_id");
			%>
			<option value="<%=id%>"><%=id%></option>
			<%
			}
			rs.close();
			stmt.close();
			conn.close();
			} catch (Exception e) {
			out.println("<option>Error loading IDs</option>");
			}
			%>
		</select> <input type="submit" value="Search" />
	</form>

	<%
	// Show details only if POST + ID selected
	if (request.getMethod().equals("POST")) {
		String idStr = request.getParameter("book_id");
		if (idStr != null && !idStr.isEmpty()) {
			int id = Integer.parseInt(idStr);
			String bookDetails = myDB.getBookById(id);
			out.println("<h2>Book Details:</h2>");
			out.println(bookDetails);
			out.println("<h2>Whole Library:</h2>");
			out.print(myDB.readAll()); // Show full library after selecting
		} else {
			out.println("<p>No book ID selected.</p>");
		}
	}
	%>

</body>
</html>
