<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<jsp:useBean id="dbBean" class="database.DbBean" scope="page" />

 <!--
 Lea Trueworthy
 CSD 430 Module 9 Assignment: Working with CRUD-DELETE, JDBC, & JavaBeans
 July 7, 2025
 -->

 <!DOCTYPE html>
 <html>
  <head>
   <meta charset="UTF-8">
    <title>CRUD Read</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    </head>

    <body>
     <h1>Read Books</h1>
     <a href="index_02.jsp">back to index02</a>
     <br />

      <h3>Select a book to view:</h3>
      <form method="get" action="CRUD_Read.jsp">
       <label for="bookID"></label><br>
       <%=dbBean.formGetPK("")%>
        <input type="hidden" name="action" value="showForm" />
        <input type="submit" value="View Book" />
       </form>
       <br />

        <%
        String bookID = request.getParameter("bookID");

        if (bookID != null && !bookID.trim().isEmpty()) {
        %>
        <h2>Search Result:</h2>
        <%=dbBean.read(bookID)%>
         <br />
          <br />

           <h2>All Books:</h2>
           <%=dbBean.readAll()%>
            <%
            }
            %>

           </body>

          </html>
