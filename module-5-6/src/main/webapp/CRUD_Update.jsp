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
<title>CRUD Update</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h1>Update Book</h1>

	<jsp:useBean id="myDB" class="database.DbBean" scope="page" />
	<a href="index_02.jsp">back to index02</a>
	<br />

	<%
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		// Show the form with existing book data
		String bookId = request.getParameter("book_id");
		if (bookId != null) {
			// Fetch existing data to populate the form
			String bookData = myDB.getBookDetails(bookId);
			out.print(bookData);
		} else {
			out.print("Please select a book to update.");
		}
	} else if ("POST".equalsIgnoreCase(request.getMethod())) {
		// Handle the form submission
		String bookId = request.getParameter("book_id");
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String year = request.getParameter("publish_year");
		String genre = request.getParameter("genre");

		String message = "";
		if (title == null || title.trim().isEmpty()) {
			message = "Title is required.";
		} else {
			Integer publishYear = null;
			try {
		if (year != null && !year.trim().isEmpty()) {
			publishYear = Integer.parseInt(year);
		}
		message = myDB.updateBook(bookId, title, author, publishYear != null ? publishYear : 0, genre);
			} catch (NumberFormatException e) {
		message = "Year must be a valid number if provided.";
			}
		}

		// Print the result message after updating
		out.println("<br />");
		out.print(message);

		// Optionally, show the updated record
		if ("Book updated successfully".equals(message)) {
			out.println("<br />");
			out.print(myDB.getBookDetails(bookId)); // Show updated details
		}
	}
	%>

	<form method="GET" action="CRUD_Update.jsp">
		Book ID: <select name="book_id">
			<%=myDB.getBookIdOptions()%>
			<!-- Assuming this method fetches the book IDs -->
		</select> <input type="submit" value="Select Book" />
	</form>


</body>
</html>
