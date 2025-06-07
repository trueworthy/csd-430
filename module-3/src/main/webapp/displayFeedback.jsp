<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="style.css">

<title>Feedback Results</title>
</head>
<body>
	<div class="container">
		<h1>Submitted Job Application Data</h1>
		<p class="description">Here is a summary of the information you
			submitted. Please review it carefully.</p>

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
				String workAuthorization = request.getParameter("workAuthorization");
				String coverLetter = request.getParameter("coverLetter");
				%>

				<tr>
					<td class="field-label">Full Name:</td>
					<td class="field-value"><%=fullName != null ? fullName : "N/A"%></td>
				</tr>
				<tr>
					<td class="field-label">Email Address:</td>
					<td class="field-value"><%=email != null ? email : "N/A"%></td>
				</tr>
				<tr>
					<td class="field-label">Phone Number:</td>
					<td class="field-value"><%=phone != null ? phone : "N/A"%></td>
				</tr>
				<tr>
					<td class="field-label">Position Applying For:</td>
					<td class="field-value"><%=position != null ? position : "N/A"%></td>
				</tr>
				<tr>
					<td class="field-label">Work Authorization:</td>
					<td class="field-value"><%=workAuthorization%></td>
				</tr>
				<tr>
					<td class="field-label">Cover Letter:</td>
					<td class="field-value">
						<%
						if (coverLetter != null && !coverLetter.trim().isEmpty()) {
						%> <pre><%=coverLetter%></pre> <%
						} else {
						%> No cover letter provided. <%
						}
						%>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>
