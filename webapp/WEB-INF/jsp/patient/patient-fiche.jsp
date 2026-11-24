<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Patient" %>

<%
    Patient patient = (Patient) request.getAttribute("patient");
    String sexeLabel = "Non renseigné";
    if (patient != null) {
        if (patient.getSexeId() == 1) {
            sexeLabel = "Masculin";
        } else if (patient.getSexeId() == 2) {
            sexeLabel = "Féminin";
        }
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fiche du patient</title>

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
            max-width: 650px;
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
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }

        h2 {
            margin: 0;
            color: #26354a;
        }

        .subtitle {
            color: #64748b;
            margin-top: 6px;
            font-size: 14px;
        }

        .fiche-list {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .fiche-item {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 14px;
        }

        .fiche-item.full {
            grid-column: 1 / -1;
        }

        .fiche-label {
            display: block;
            font-size: 12px;
            font-weight: bold;
            color: #64748b;
            text-transform: uppercase;
            margin-bottom: 6px;
        }

        .fiche-value {
            font-size: 15px;
            color: #26354a;
            font-weight: bold;
            word-break: break-word;
        }

        .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .btn {
            padding: 12px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            display: inline-flex;
            align-items: center;
        }

        .btn-primary {
            background: #26354a;
            color: white;
        }

        .btn-primary:hover {
            background: #1e293b;
        }

        .btn-secondary {
            background: #f8fafc;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #f1f5f9;
            color: #333;
        }

        .btn-danger {
            background: #fff5f5;
            color: #cc0000;
            border: 1px solid #fecaca;
        }

        .btn-danger:hover {
            background: #ffe6e6;
        }

        .empty {
            text-align: center;
            padding: 35px;
            color: #94a3b8;
        }

        @media(max-width: 650px) {
            body {
                padding: 12px;
            }

            .container {
                padding: 16px;
            }

            .fiche-list {
                grid-template-columns: 1fr;
            }
        }
        #sary{
            margin: auto;
            width: 50%;
            height: 50% ;            
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header">
        <div>
            <h2>Fiche du patient</h2>
            <div class="subtitle">
                Informations détaillées du dossier patient
            </div>
            <img id="sary" src="http://192.168.42.216:8101/patient/<%= patient.getId() %>/qrcode/<%= patient.getId() %>-patient.jpg" alt="aaaaa">
        </div>
    </div>

    <% if (patient != null) { %>
        <div class="fiche-list">
            
            <div class="fiche-item">
                <span class="fiche-label">ID</span>
                <span class="fiche-value"><%= patient.getId() %></span>
            </div>

            <div class="fiche-item">
                <span class="fiche-label">Sexe</span>
                <span class="fiche-value"><%= sexeLabel %></span>
            </div>

            <div class="fiche-item">
                <span class="fiche-label">Nom</span>
                <span class="fiche-value"><%= patient.getNom() != null ? patient.getNom() : "-" %></span>
            </div>

            <div class="fiche-item">
                <span class="fiche-label">Prénom</span>
                <span class="fiche-value"><%= patient.getPrenom() != null ? patient.getPrenom() : "-" %></span>
            </div>

            <div class="fiche-item">
                <span class="fiche-label">Date de naissance</span>
                <span class="fiche-value"><%= patient.getDateNaissance() != null ? patient.getDateNaissance() : "-" %></span>
            </div>

            <div class="fiche-item">
                <span class="fiche-label">Numéro de téléphone</span>
                <span class="fiche-value"><%= patient.getNumeroTelephone() != null ? patient.getNumeroTelephone() : "-" %></span>
            </div>

            <div class="fiche-item full">
                <span class="fiche-label">Adresse</span>
                <span class="fiche-value"><%= patient.getAdresse() != null ? patient.getAdresse() : "-" %></span>
            </div>

            <div class="fiche-item full">
                <span class="fiche-label">Email</span>
                <span class="fiche-value"><%= patient.getEmail() != null ? patient.getEmail() : "-" %></span>
            </div>
        </div>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/patient/edit?id=<%= patient.getId() %>" class="btn btn-primary">Modifier</a>
            <a href="${pageContext.request.contextPath}/patient/delete?id=<%= patient.getId() %>" class="btn btn-danger">Supprimer</a>
            <a href="${pageContext.request.contextPath}/patient" class="btn btn-secondary">Retour à la liste</a>
        </div>

    <% } else { %>

        <div class="empty">
            Patient introuvable.
        </div>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/patient/list" class="btn btn-secondary">Retour à la liste</a>
        </div>

    <% } %>

</div>

</body>
</html>