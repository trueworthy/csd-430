<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id='dbBean' class='database.DbBean' />

<!--
    Lea Trueworthy
    CSD 430 Module 9 Assignment: Working with CRUD-DELETE, JDBC, & JavaBeans
    July 7, 2025
-->

<!DOCTYPE html>

<html>
<head>
<title>CRUD Delete</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
	<h1>Delete Book</h1>

	<a href="index_02.jsp">back to index02</a>
	<br />
	<br />

	<!-- used same form as CRUD_Read -->
	<form method="post" action="CRUD_Delete.jsp">
		<label for="bookID">Select a book to delete:</label><br />
		<%=dbBean.formGetPK("")%>
		<input type="hidden" name="action" value="showForm" />
		<input type="submit" value="Delete Book" />
	</form>
	<br />
	<%
	String result = "";
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String bookIDStr = request.getParameter("bookID");

		if (bookIDStr != null) {
			try {
		int bookID = Integer.parseInt(bookIDStr);
		result = dbBean.delete(bookIDStr);
		//	out.println("<h2>Book Deleted</h2>");
			out.print(result);
			} catch (NumberFormatException e) {
		result = "Error: Invalid Book ID format";
			}
		}
		out.println("<h2>Full Book List:</h2>");
		out.print(dbBean.readAll());
	}
	%>

<!--
<div style="color: green;"><%=result%></div>
-->
	<br />

</body>
</html>