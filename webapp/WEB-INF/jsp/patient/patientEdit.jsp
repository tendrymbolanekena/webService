<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Patient" %>

<%
    Patient patient = (Patient) request.getAttribute("patient");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier un patient</title>

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
            max-width: 600px;
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

        .message {
            font-weight: bold;
            color: #cc0000;
            background: #ffe6e6;
            padding: 10px 12px;
            border-radius: 8px;
            margin-bottom: 18px;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            color: #64748b;
            font-size: 13px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="tel"],
        input[type="date"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            color: #333;
            background: #f8fafc;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: #26354a;
            background: white;
        }

        .actions {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        button {
            padding: 12px 20px;
            background: #26354a;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #1e293b;
        }

        .btn-cancel {
            padding: 12px 20px;
            background: #f8fafc;
            color: #64748b;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
        }

        .btn-cancel:hover {
            background: #f1f5f9;
            color: #333;
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
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header">
        <div>
            <h2>Modifier le patient</h2>
            <div class="subtitle">
                Mise à jour des informations du patient
            </div>
        </div>
    </div>

    <% if (request.getAttribute("erreur") != null) { %>
        <p class="message">${erreur}</p>
    <% } %>

    <% if (patient != null) { %>

        <form action="${pageContext.request.contextPath}/patient/update"
              method="post"
              data-object="Patient">

            <input type="hidden" name="id" value="<%= patient.getId() %>">

            <div class="form-group">
                <label for="nom">Nom</label>
                <input type="text"
                       id="nom"
                       name="nom"
                       value="<%= patient.getNom() != null ? patient.getNom() : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label for="prenom">Prénom</label>
                <input type="text"
                       id="prenom"
                       name="prenom"
                       value="<%= patient.getPrenom() != null ? patient.getPrenom() : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label for="sexeId">Sexe</label>
                <select id="sexeId" name="sexeId" required>
                    <option value="">Choisissez un sexe</option>
                    <option value="1" <%= patient.getSexeId() == 1 ? "selected" : "" %>>Masculin</option>
                    <option value="2" <%= patient.getSexeId() == 2 ? "selected" : "" %>>Féminin</option>
                </select>
            </div>

            <div class="form-group">
                <label for="numeroTelephone">Numéro de téléphone</label>
                <input type="tel"
                       id="numeroTelephone"
                       name="numeroTelephone"
                       maxlength="20"
                       value="<%= patient.getNumeroTelephone() != null ? patient.getNumeroTelephone() : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label for="dateNaissance">Date de naissance</label>
                <input type="date"
                       id="dateNaissance"
                       name="dateNaissance"
                       value="<%= patient.getDateNaissance() != null ? patient.getDateNaissance() : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label for="adresse">Adresse</label>
                <input type="text"
                       id="adresse"
                       name="adresse"
                       value="<%= patient.getAdresse() != null ? patient.getAdresse() : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email"
                       id="email"
                       name="email"
                       value="<%= patient.getEmail() != null ? patient.getEmail() : "" %>"
                       required>
            </div>

            <div class="form-group">
                <label for="mdp">Mot de passe</label>
                <input type="password"
                       id="mdp"
                       name="mdp"
                       value="<%= patient.getMdp() != null ? patient.getMdp() : "" %>"
                       required>
            </div>

            <div class="actions">
                <button type="submit">Enregistrer</button>
                <a href="${pageContext.request.contextPath}/patient/fiche" class="btn-cancel">Annuler</a>
            </div>
        </form>

    <% } else { %>

        <div class="empty">
            Patient introuvable.
        </div>

    <% } %>

</div>

<script src="${pageContext.request.contextPath}/FrameWork.js"></script>
</body>
</html>