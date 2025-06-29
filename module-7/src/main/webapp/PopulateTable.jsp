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
<title>Populate Library</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h1>Populate Library</h1>

	<jsp:useBean id="myDB" class="database.DbBean" scope="page" />
	<a href="index.jsp">back to index</a>
	<br />

	<%
	String result = "";
	try {
		// Call the populateLibrary method from DbBean
		result = myDB.populateTable(); // Make sure this method is defined in DbBean
	} catch (Exception e) {
		result = "An error occurred: " + e.getMessage();
	}
	%>
	<%=result%>

</body>
</html>
