<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Inscription</title>
  </head>
  <body>

    <h1>Inscription</h1>

    <% if (request.getAttribute("error") != null) { %>
        <p style="color: red;">${error}</p>
      <% } %>

    <form method="post" action="${pageContext.request.contextPath}/register">
        <input type="text" name="username" placeholder="Nom d'utilisateur" required />
        <input type="email" name="email" placeholder="Email" required />
        <input type="password" name="password" placeholder="Mot de passe" required />
        <input type="password" name="confirmPassword" placeholder="Confirmation mot de passe" required />
        <button type="submit">S'inscrire</button>
    </form>

    <a href="${pageContext.request.contextPath}/login">Deja un compte ?</a>
    <br>
    <a href="index.jsp">Retour a l'accueil</a>
</body>
</html>
