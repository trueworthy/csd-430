<!--
    Lea Trueworthy
    CSD 430 Module 3 Assignment
    June 7, 2025
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <!DOCTYPE html>
   <html>

   <head>
      <link rel="stylesheet" href="style.css">

      <title>Feedback Results</title>
   </head>

   <body>
      <div class="container">
         <h1>Submitted Job Application Data</h1>
         <p class="description">Thank you for applying! Here is your summary.</p>

         <table>
            <thead>
               <tr>
                  <th>Field</th>
                  <th>Value</th>
               </tr>
            </thead>
            <tbody>
            <%
				// Documentation: Scriptlets for holding Java code.
				// Retrieve parameters submitted from the HTML form.
				String fullName = request.getParameter("fullName");
				String email = request.getParameter("email");
				String phone = request.getParameter("phone");
				String position = request.getParameter("position");
				String startDate = request.getParameter("startDate");
				String whyHire = request.getParameter("whyHire");
				%>

                  <tr>
                     <td class="field-label">Full Name:</td>
                     <td class="field-value">
                        <%=fullName !=null ? fullName : "N/A" %>
                     </td>
                  </tr>
                  <tr>
                     <td class="field-label">Email Address:</td>
                     <td class="field-value">
                        <%=email !=null ? email : "N/A" %>
                     </td>
                  </tr>
                  <tr>
                     <td class="field-label">Phone Number:</td>
                     <td class="field-value">
                        <%=phone !=null ? phone : "N/A" %>
                     </td>
                  </tr>
                  <tr>
                     <td class="field-label">Position Applying For:</td>
                     <td class="field-value">
                        <%=position !=null ? position : "N/A" %>
                     </td>
                  </tr>
                  <tr>
                     <td class="field-label">Start Date:</td>
                     <td class="field-value">
                        <%=startDate%>
                     </td>
                  </tr>
                  <tr>
                     <td class="field-label">Why should we hire you?</td>
                     <td class="field-value">
                        <% if (whyHire !=null && !whyHire.trim().isEmpty()) { %>
                           <pre><%=whyHire%></pre>
                           <% } else { %> ---------<% } %>
                     </td>
                  </tr>
            </tbody>
         </table>
      </div>
   </body>

   </html>