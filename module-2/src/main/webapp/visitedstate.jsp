<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Maine Adventure Highlights</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

    <h1>Places I Loved in Maine</h1>
    <p>This table highlights five of my favorite places to visit in Maine. Each entry includes the name of the place, the type of activity it offers, and a brief description.</p>

    <table>
        <tr>
            <th>Place</th>
            <th>Activity Type</th>
            <th>Description</th>
        </tr>

        <%
            // Define a 2D array to store data records
            String[][] maineSpots = {
                {"Acadia National Park", "Hiking", "Beautiful coastal park with rocky beaches and scenic trails."},
                {"Portland Head Light", "Sightseeing", "Historic lighthouse with dramatic ocean views."},
                {"Bar Harbor", "Relaxation", "Charming coastal town known for seafood and whale watching."},
                {"Kennebunkport", "Shopping", "Quaint town with boutiques, galleries, and oceanfront views."},
                {"Camden Hills State Park", "Nature", "Great for hiking with panoramic views of the harbor."}
            };

            // Loop to print table rows dynamically
            for (int i = 0; i < maineSpots.length; i++) {
        %>
        <tr>
            <td><%= maineSpots[i][0] %></td>
            <td><%= maineSpots[i][1] %></td>
            <td><%= maineSpots[i][2] %></td>
        </tr>
        <%
            }
        %>
    </table>

    <footer>
        <p>All information is based on personal travel experiences in Maine.</p>
    </footer>

</body>
</html>
