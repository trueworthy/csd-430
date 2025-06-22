<!--
    Lea Trueworthy
    CSD 430 Module 4 Assignment: JavaBeans
    June 14, 2025
-->

<%@ page import="packingMaine.MaineLocation"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<jsp:useBean id="sampleLocation" class="packingMaine.MaineLocation"
	scope="page" />
<%
    // Populate sampleLocation (demonstrating useBean)
    sampleLocation.setPlace("Sample Place");
    sampleLocation.setActivityType("Photography");
    sampleLocation.setDescription("Scenic viewpoint with wildlife.");
    sampleLocation.setSeason("Spring");
    sampleLocation.setRegion("Northern");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Maine Adventure Highlights</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f2f2f2;
	padding: 20px;
}

h1 {
	color: #004d66;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
	background-color: #fff;
}

th, td {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: left;
}

th {
	background-color: #cce6ff;
	color: #00334d;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

footer {
	margin-top: 30px;
	font-size: 0.9em;
	color: #666;
}
</style>
</head>

<body>

	<h1>Places I Loved in Maine</h1>
	<p>This table highlights five of my favorite places to visit in
		Maine. Each entry includes the name of the place, the type of activity
		it offers, and a brief description, including the best season to visit
		and the region.</p>

	<h2>Featured Location (from useBean):</h2>
	<p>
		<strong>Place:</strong>
		<%= sampleLocation.getPlace() %><br> <strong>Activity:</strong>
		<%= sampleLocation.getActivityType() %><br> <strong>Best Season:</strong>
		<%= sampleLocation.getSeason() %><br> <strong>Region:</strong>
		<%= sampleLocation.getRegion() %><br> <strong>Description:</strong>
		<%= sampleLocation.getDescription() %><br>
	</p>

	<table>
		<tr>
			<th>Place</th>
			<th>Activity Type</th>
			<th>Best Season</th>
			<th>Region</th>
			<th>Description</th>
		</tr>

		<%
            // Create and populate the list of MaineLocation beans
            List<MaineLocation> spots = new ArrayList<MaineLocation>();
            spots.add(new MaineLocation("Acadia National Park", "Hiking", "Summer", "Downeast", "Beautiful coastal park with rocky beaches and scenic trails."));
            spots.add(new MaineLocation("Portland Head Light", "Sightseeing", "Fall", "Southern", "Historic lighthouse with dramatic ocean views."));
            spots.add(new MaineLocation("Bar Harbor", "Relaxation", "Spring", "Downeast", "Charming coastal town known for seafood and whale watching."));
            spots.add(new MaineLocation("Kennebunkport", "Shopping", "Summer", "Southern", "Quaint town with boutiques, galleries, and oceanfront views."));
            spots.add(new MaineLocation("Camden Hills State Park", "Nature", "Fall", "Midcoast", "Great for hiking with panoramic views of the harbor."));

            for (MaineLocation location : spots) {
        %>
		<tr>
			<td><%= location.getPlace() %></td>
			<td><%= location.getActivityType() %></td>
			<td><%= location.getDescription() %></td>
			<td><%= location.getSeason() %></td>
			<td><%= location.getRegion() %></td>
		</tr>
		<%
            }
        %>
	</table>

</body>
</html>
