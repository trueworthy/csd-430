<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="dbBean" class="database.DbBean" scope="page" />

<!--
    Lea Trueworthy
    CSD 430 Module 8 Assignment: Working with CRUD-READ, JDBC, & JavaBeans
    July 1, 2025
-->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CRUD Update</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
	<h1>Update Book</h1>
	<a href="index_02.jsp">back to index02</a>

	<%
	String result = "";
	String selectedBookID = request.getParameter("bookID");
	String action = request.getParameter("action");
	boolean showForm = false;
	Map<String, String> bookData = new HashMap<>();

	if ("showForm".equals(action) && selectedBookID != null) {
		try {
			int bookID = Integer.parseInt(selectedBookID);
			bookData = dbBean.getRecordById(bookID);
			if (!bookData.isEmpty()) {
		showForm = true;
			}
		} catch (NumberFormatException e) {
			result = "Invalid book ID.";
		}
	} else if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("update") != null) {
		// Handle form submission
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String genre = request.getParameter("genre");
		String publish_yearStr = request.getParameter("publish_year");
		String bookFormat = request.getParameter("bookFormat");
		String ISBN = request.getParameter("ISBN");
		String bookIDStr = request.getParameter("bookID");

		try {
			int publish_year = Integer.parseInt(publish_yearStr);
			int bookID = Integer.parseInt(bookIDStr);
			result = dbBean.updateRecord(title, author, genre, publish_year, bookFormat, ISBN, bookID);
			selectedBookID = bookIDStr;
		} catch (NumberFormatException e) {
			result = "Invalid input format.";
		}
	}
	%>

	<h3>Select a book to update:</h3>
	<form method="get" action="CRUD_Update.jsp">
		<label for="bookID">Select Book:</label><br>
		<%=dbBean.formGetPK("")%>
		<input type="hidden" name="action" value="showForm" /> <input
			type="submit" value="Load Book" />
	</form>

	<br />

	<%
	if (showForm) {
	%>
	<form method="post" action="CRUD_Update.jsp">
		<label for="bookID">Book ID:</label><br> <input type="text" id="bookID" name="bookID" readonly value="<%=bookData.get("bookID")%>"><br>
		<br> <label for="title">Title:</label><br> <input type="text" id="title" name="title" required value="<%=bookData.get("title")%>"><br>
		<br> <label for="author">Author:</label><br> <input type="text" id="author" name="author" required value="<%=bookData.get("author")%>"><br>
		<br> <label for="genre">Genre:</label><br> <input type="text" id="genre" name="genre" value="<%=bookData.get("genre")%>"><br>
		<br> <label for="publish_year">Publication Year:</label><br> <input type="number" id="publish_year" name="publish_year" value="<%=bookData.get("publish_year")%>"><br>
		<br> <label for="bookFormat">Format:</label><br> <input type="text" id="bookFormat" name="bookFormat" value="<%=bookData.get("bookFormat")%>"><br> 		
				
		<!--This is for a dropdown menu for the book format. I'm not sure which one the professor wants -->
		<!--<br> <label for="bookFormat">Format:</label><br>
		<select id="bookFormat" name="bookFormat">
    			<option value="HC" <%= "HC".equals(bookData.get("bookFormat")) ? "selected" : "" %>>HC</option>
    			<option value="PB" <%= "PB".equals(bookData.get("bookFormat")) ? "selected" : "" %>>PB</option>
    			<option value="MM" <%= "MM".equals(bookData.get("bookFormat")) ? "selected" : "" %>>MM</option>
    			<option value="OOP" <%= "OOP".equals(bookData.get("bookFormat")) ? "selected" : "" %>>OOP</option>
    			<option value="AUDIO" <%= "AUDIO".equals(bookData.get("bookFormat")) ? "selected" : "" %>>AUDIO</option>
		</select>-->
		
		<br> <label for="ISBN">ISBN:</label><br> <input type="text" id="ISBN" name="ISBN" value="<%=bookData.get("ISBN")%>"><br>
		<br> <input type="submit" name="update" value="Update Record">
	</form>
	<%
	}
	%>

	<br />
	<div style="color: green;"><%=result%></div>

	<%
	if (result.contains("successfully") && selectedBookID != null) {
	%>
	<h2>Updated Record:</h2>
	<%=dbBean.read(selectedBookID)%>
	<br />
	<h3>Full Book List:</h3>
	<%=dbBean.readAll()%>
	<%
	}
	%>
</body>

</html>
