<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="fr.simplon.models.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>

<%
    List<Post> postList = (List<Post>) request.getAttribute("postList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Miniature</title>
</head>
<body>
<main>
    <h1>Miniature</h1>
    <form method="post">
        <input type="hidden" name="ownerId" value="1">
        <label for="newPost">Créer un post</label>
        <textarea name="newPost"></textarea>
        <br>
        <button type="submit" name="button">Ajouter</button>
    </form>

    <form method="post">
        <ul>
            <% for(Post post : postList) {%>
            <li value="<%= post.getId() %>">
                <%= post.getContent() %>
            </li>
            <%}%>
        </ul>
    </form>

</main>
</body>
</html>