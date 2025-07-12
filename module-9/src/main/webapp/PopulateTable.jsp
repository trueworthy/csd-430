<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id='dbBean' class='configBean.ConfigProject' />

<!--
    Lea Trueworthy
    CSD 430 Module 9 Assignment: Working with CRUD-DELETE, JDBC, & JavaBeans
    July 7, 2025
-->

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Populate Library</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h1>Populate Library</h1>

	<br />
	<a href="index.jsp">back to index</a>
	<br />
	<br />

	<%
	try {
		out.print(dbBean.populateTable());
	} catch (Exception e) {
		out.print("Error populating table");
	}
	%>
</body>
</html>