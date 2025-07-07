<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id='dbBean' class='configBean.ConfigProject' />

<!--
    Lea Trueworthy
    CSD 430 Module 8 Assignment: Working with CRUD-CREATE, JDBC, & JavaBeans
    July 1, 2025
-->

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Create Table</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h1>JSP Create Table</h1>

	<br />
	<a href="index.jsp">back to index</a>
	<br />
	<br />

	<%
	try {
		out.print(dbBean.createTable());
	} catch (Exception e) {
		out.print("Error creating table");
	}
	%>
</body>
</html>