<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Connexion</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f4f4f9;
        }

        .container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            max-width: 400px;
            margin: auto;
        }

        h1 { 
            color: #333; 
            text-align: center;
        }

        .erreur {
            font-weight: bold;
            color: #cc0000;
            background: #ffe6e6;
            padding: 8px 10px;
            border-radius: 4px;
            margin-bottom: 15px;
        }

        input, button {
            width: 100%;
            box-sizing: border-box;
            margin-top: 5px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #0066cc;
            color: white;
            border: none;
            font-weight: bold;
            cursor: pointer;
            margin-top: 15px;
        }

        button:hover {
            background-color: #0052a3;
        }

        .champ {
            margin: 15px 0;
        }

        label {
            display: block;
            font-weight: bold;
            color: #555;
        }
    </style>
</head>
<body>
    <div class="container">

        <h1>Connexion</h1>

        <%-- Affichage optionnel d'un message d'erreur renvoyé par le contrôleur --%>
        <% if (request.getAttribute("erreur") != null) { %>
            <div class="erreur">${erreur}</div>
        <% } %>

        <form action="login"
              method="post">

            <div class="champ">
                <label for="email">Email :</label>
                <input type="email"
                       id="email"
                       name="email"
                       placeholder="Entrez votre email"
                       required>
            </div>

            <div class="champ">
                <label for="mdp">Mot de passe :</label>
                <input type="password"
                       id="mdp"
                       name="mdp"
                       placeholder="Entrez votre mot de passe"
                       required>
            </div>

            <button type="submit">Se connecter</button>
        </form>

        <a href="${pageContext.request.contextPath}/inscription">Pas encore inscrit ? Créez un compte</a>

    </div>

    <script src="${pageContext.request.contextPath}/FrameWork.js"></script>
</body>
</html>