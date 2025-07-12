<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id='dbBean' class='database.DbBean' />

<!--
    Lea Trueworthy
    CSD 430 Module 9 Assignment: Working with CRUD-DELETE, JDBC, & JavaBeans
    July 7, 2025
-->

<!DOCTYPE html>

<html>
<head>
<title>CRUD Create</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h1>Create a New Book</h1>

	<a href="index_02.jsp">back to index02</a>
	<%
	// Handling GET: show the form
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		String value = dbBean.formGetCreateOrUpdate("CRUD_Create.jsp");
		out.print(value);
	}
	%>
	<%
	// Handling POST: add new book
	String result = "";
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String genre = request.getParameter("genre");
		String publish_yearStr = request.getParameter("publish_year");
		String bookFormatStr = request.getParameter("bookFormat");
		String ISBN = request.getParameter("ISBN");

		if (title != null && author != null && genre != null && publish_yearStr != null && bookFormatStr != null
		&& ISBN != null) {
			try {
		int publish_year = Integer.parseInt(publish_yearStr);
		String bookFormat = request.getParameter("bookFormat");
		result = dbBean.createRecord(title, author, genre, publish_year, bookFormat, ISBN);
			} catch (NumberFormatException e) {
		result = "Error: Invalid";
			}
		} else {
			result = "Error: All fields are required";
		}

		out.print(dbBean.formGetCreateOrUpdate("CRUD_Create.jsp"));

		if (result != null && !result.startsWith("Error") && !result.startsWith("Failed")) {
			try {
		int bookID = Integer.parseInt(result);
		out.println("<h2>New Book Added:</h2>");
		out.print(dbBean.read(result));
			} catch (NumberFormatException e) {
		out.print("<h2>New Book Added:</h2>");
			}
		}

		out.println("<h2>Full Book List:</h2>");
		out.print(dbBean.readAll());
	}
	%>

</body>
</html>