
<%@ page import="java.util.List" %>
<%@ page import="model.Patient" %>

<%
    List<Patient> patients =
        (List<Patient>) request.getAttribute("patient");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des patients</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 35px;
            color: #333;
        }

        .container {
            max-width: 1100px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.06);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        h2 {
            margin: 0;
            color: #26354a;
        }

        .count {
            color: #64748b;
            margin-top: 8px;
            font-size: 14px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 14px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background: #f8fafc;
            color: #64748b;
            font-size: 13px;
        }

        tr:hover {
            background: #f8fafc;
        }

        .empty {
            text-align: center;
            padding: 35px;
            color: #94a3b8;
        }

        .id {
            color: #64748b;
        }
        
        @media(max-width: 650px) {
            body {
                padding: 12px;
            }

            .container {
                padding: 12px;
                overflow-x: auto;
            }

            table {
                min-width: 600px;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header">
        <div>
            <h2>Liste des patients</h2>
            <div class="count">
                Gestion des patients enregistrés
            </div>
        </div>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Date de naissance</th>
                <th>Actions</th>
            </tr>
        </thead>

        <tbody>
            <% if (patients != null && !patients.isEmpty()) {
                for (Patient p : patients) { %>

                <tr>
                    <td class="id"><%= p.getId() %></td>
                    <td><%= p.getNom() %></td>
                    <td><%= p.getPrenom() %></td>
                    <td><%= p.getDateNaissance() %></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/patient/delete?id=<%= p.getId() %>">Supprimer</a>
                        <a href="${pageContext.request.contextPath}/patient/edit?id=<%= p.getId() %>">Modifier</a>
                    </td>
                </tr>

            <%  }
               } else { %>

                <tr>
                    <td colspan="4" class="empty">
                        Aucun patient enregistré.
                    </td>
                </tr>

            <% } %>
        </tbody>
    </table>

</div>

</body>
</html>
