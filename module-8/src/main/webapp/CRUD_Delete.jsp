<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id='dbBean' class='database.DbBean' />

<!--
    Lea Trueworthy
    CSD 430 Module 8 Assignment: Working with CRUD-CREATE, JDBC, & JavaBeans
    July 1, 2025
-->

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CRUD Delete</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
	<h1>Delete Book</h1>

	<a href="index_02.jsp">back to index02</a>
	<br>
	<br>
	<%
	String result = "";
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String bookIDStr = request.getParameter("bookID");

		if (bookIDStr != null) {
			try {
		int bookID = Integer.parseInt(bookIDStr);
		result = dbBean.delete(bookIDStr);
			} catch (NumberFormatException e) {
		result = "Error: Invalid Book ID format";
			}
		}
	}
	%>

	<%=result%>

	<form method="post">
		<label for="bookID">Book ID to Delete:</label><br> <input
			type="number" id="bookID" name="bookID" required><br> <br>
		<input type="submit" value="Delete Record">
	</form>

</body>
</html>