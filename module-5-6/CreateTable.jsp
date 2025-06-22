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
<title>JSP Create Table</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h1>JSP Create Table</h1>

	<!-- Use the jsp:useBean tag to instantiate DbBean -->
	<jsp:useBean id="myDB" class="database.DbBean" scope="page" />
	<a href="index.jsp">back to index</a>
	<br />

	<%
	try {
		// Call the createTable method and display the result
		out.print(myDB.createTable());
	} catch (Exception e) {
		out.print("Error creating table: " + e.getMessage());
	}
	%>
</body>
</html>
