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
<title>CRUD Create</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

	<h1>Create a New Book</h1>

	<jsp:useBean id="myDB" class="database.DbBean" scope="page" />
	<a href="index_02.jsp">back to index02</a>
	<br />
	<%
	// Handling GET: show the form
	if (request.getMethod().equals("GET")) {
		out.println("<form method='POST'>");
		out.println("Title: <input type='text' name='title'><br>");
		out.println("Author: <input type='text' name='author'><br>");
		out.println("Publish Year: <input type='text' name='publish_year'><br>");
		out.println("Genre: <input type='text' name='genre'><br>");
		out.println("<input type='submit' value='Add Book'>");
		out.println("</form>");
	}

	// Handling POST: add new book
	if (request.getMethod().equals("POST")) {
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
		// Add the book to the database
		message = myDB.createBook(title, author, publishYear != null ? publishYear : 0, genre = "---");
			} catch (NumberFormatException e) {
		message = "Publish year must be a number.";
			}
		}
		out.println("<p>" + message + "</p>");
	}
	%>
</body>
</html>
