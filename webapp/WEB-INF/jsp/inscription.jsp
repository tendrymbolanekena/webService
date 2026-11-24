<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Inscription patient</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f4f4f9;
        }
        .container {
            max-width: 500px;
            margin: auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .champ {
            margin: 15px 0;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input, select, button {
            width: 100%;
            box-sizing: border-box;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            margin-top: 15px;
            border: none;
            background: #0066cc;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        .message {
            color: #cc0000;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Inscription patient</h1>

    <% if (request.getAttribute("erreur") != null) { %>
        <p class="message">${erreur}</p>
    <% } %>

    <form action="${pageContext.request.contextPath}/inscription/patient" method="post" 
          data-object="Patient">
        <div class="champ">
            <label for="nom">Nom</label>
            <input id="nom" name="nom" type="text" required>
        </div>

        <div class="champ">
            <label for="prenom">Prenom</label>
            <input id="prenom" name="prenom" type="text" required>
        </div>

        <div class="champ">
            <label for="sexeId">Sexe</label>
            <select id="sexeId" name="sexeId" required>
                <option value="">Choisissez un sexe</option>
                <option value="1">Masculin</option>
                <option value="2">Feminin</option>
            </select>
        </div>

        <div class="champ">
            <label for="numeroTelephone">Numero de telephone</label>
            <input id="numeroTelephone"
                   name="numeroTelephone"
                   type="tel"
                   maxlength="20"
                   required>
        </div>

        <div class="champ">
            <label for="dateNaissance">Date de naissance</label>
            <input id="dateNaissance" name="dateNaissance" type="date" required>
        </div>

        <div class="champ">
            <label for="adresse">Adresse</label>
            <input id="adresse" name="adresse" type="text" required>
        </div>

        <div class="champ">
            <label for="email">Email</label>
            <input id="email" name="email" type="email" required>
        </div>

        <div class="champ">
            <label for="mdp">Mot de passe</label>
            <input id="mdp" name="mdp" type="password" required>
        </div>

        <button type="submit">Creer mon compte</button>
    </form>


    <script src="${pageContext.request.contextPath}/FrameWork.js"></script>

    <p><a href="${pageContext.request.contextPath}/">Retour a la connexion</a></p>
</div>
</body>
</html>