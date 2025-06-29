<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--
    Lea Trueworthy
    CSD 430 Module 7 Assignment: Working with CRUD-READ, JDBC, & JavaBeans
    June 28, 2025
-->
<!DOCTYPE html>
<html>
<head>
<title>CRUD Delete</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

	<h1>Delete Book</h1>

	<jsp:useBean id="myDB" class="database.DbBean" scope="page" />
	<a href="index_02.jsp">back to index02</a>
	<br />
	<%
	if (request.getMethod().equals("GET")) {
		// Print the dropdown form options to delete a book
		String value = myDB.formGetPK("DeleteBook.jsp");
	}
	%>

	<%
	if (request.getMethod().equals("POST")) {
		// Get the selected book ID as integer, parse from string param
		int bookId = Integer.parseInt(request.getParameter("book_id"));

		// Call delete method on bean
		out.print(myDB.delete(bookId));

		out.println("<br />");

	}
	%>

	<!-- Form for selecting book_id and submitting POST -->
	<form method="post">
		Book ID: <select name="book_id">
			<%=myDB.getBookIdOptions()%>
		</select> <input type="submit" value="Delete Book" />
	</form>
	<!--  display updated table -->
	<%=myDB.readAll()%>
</body>
</html>
