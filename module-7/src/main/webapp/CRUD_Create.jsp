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
<title>CRUD Create</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

    <h1>Create a New Book</h1>

    <jsp:useBean id="myDB" class="database.DbBean" scope="page" />
    <a href="index_02.jsp">back to index02</a>
    <br />

    <%
    // Handling GET: show the form
    if (request.getMethod().equals("GET")) {
        out.println("<form method='POST'>");
        out.println("Title: <input type='text' name='title'><br>");
        out.println("Author: <input type='text' name='author'><br>");
        out.println("Publish Year: <input type='text' name='publish_year'><br>");
        out.println("Genre: <input type='text' name='genre'><br>");
        out.println("<input type='submit' value='Add Book'>");
        out.println("</form>");
    }

    // Handling POST: add new book
    if (request.getMethod().equals("POST")) {

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int publishYear = Integer.parseInt(request.getParameter("publish_year"));
        String genre = request.getParameter("genre");

        myDB.createBook(title, author, publishYear, genre);

        out.println("<h2>New Book Added:</h2>");
        out.println("<table border='1'>");
        out.println("<tr><th>Book ID</th><th>Title</th><th>Author</th><th>Publish Year</th><th>Genre</th></tr>");
        out.println(myDB.readLast()); // Display newly added book
        out.println("</table>");

        out.println("<h2>Updated Full Book List:</h2>");
        out.println(myDB.readAll());
    }
    %>
</body>
</html>
