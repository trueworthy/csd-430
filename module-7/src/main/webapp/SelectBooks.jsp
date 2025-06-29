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
<title>All Books in Library</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h1>All the Books in the Library</h1>

	<jsp:useBean id="myDB" class="database.DbBean" scope="page" />
	<a href="index.jsp">back to index</a>
	<br />

	<%
	String result = "";
	try {
		// Call the readAll() method from DbBean
		result = myDB.readAll(); // Assuming this method returns a table with all book entries
	} catch (Exception e) {
		result = "Error: " + e.getMessage(); // Handle any errors
	}
	%>
	<table>
		<%=result%>
		<!-- Print the result (which should be the HTML table of all books) -->
	</table>
</body>
</html>
