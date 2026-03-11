<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Connexion</title>
</head>
<body>
    <h1>Connexion</h1>

    <% if ("true".equals(request.getParameter("registered"))) { %>
        <p style="color: green;">Inscription réussie ! Connectez-vous.</p>
    <% } %>

    <% if (request.getAttribute("error") != null) { %>
        <p style="color: red;">${error}</p>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/login">
        <input type="text" name="username" placeholder="Nom d'utilisateur" required />
        <input type="password" name="password" placeholder="Mot de passe" required />
        <button type="submit">Se connecter</button>
    </form>

    <a href="${pageContext.request.contextPath}/register">Pas encore de compte ?</a>
</body>
</html>