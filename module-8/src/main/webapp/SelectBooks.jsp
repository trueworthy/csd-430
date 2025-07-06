<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id='dbBean' class='configBean.ConfigProject' />

<!--
    Lea Trueworthy
    CSD 430 Module 8 Assignment: Working with CRUD-READ, JDBC, & JavaBeans
    July 1, 2025
-->

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>All Books in Library</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h1>All the Books in the Library</h1>

	<br />
	<a href="index.jsp">back to index</a>
	<br />
	<br />

	<%
	try {
		out.print(dbBean.read());
	} catch (Exception e) {
		out.print("Error selecting title");
	}
	%>
</body>
</html>