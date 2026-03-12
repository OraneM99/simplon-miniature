<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="fr.simplon.models.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
  List<Post> postList = (List<Post>) request.getAttribute("postList");
  String feedType = (String) request.getAttribute("feedType");
  if (feedType == null) feedType = "recommendations";
  DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd MMM yyyy · HH:mm");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Fil — Miniature</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --bg:      #0d0d0f;
      --surface: #16161a;
      --border:  #2a2a32;
      --accent:  #c8a96e;
      --accent2: #e8c98e;
      --text:    #e8e6e0;
      --muted:   #6b6870;
      --danger:  #c0675a;
    }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: 'DM Sans', sans-serif;
      min-height: 100vh;
    }

    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
      pointer-events: none;
      z-index: 0;
    }

    .orb {
      position: fixed;
      width: 600px; height: 600px;
      border-radius: 50%;
      background: radial-gradient(circle, rgba(200,169,110,0.06) 0%, transparent 70%);
      top: 30%; left: 50%;
      transform: translate(-50%, -50%);
      pointer-events: none;
      z-index: 0;
    }

    /* Nav */
    nav {
      position: fixed;
      top: 0; left: 0; right: 0;
      z-index: 100;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 1.25rem 3rem;
      border-bottom: 1px solid var(--border);
      background: rgba(13,13,15,0.85);
      backdrop-filter: blur(12px);
    }

    .nav-logo {
      font-family: 'Playfair Display', serif;
      font-size: 1.4rem;
      color: var(--accent);
      letter-spacing: 0.05em;
      text-decoration: none;
    }

    .nav-links {
      display: flex;
      gap: 0.5rem;
      align-items: center;
    }

    .nav-links a {
      font-size: 0.8rem;
      font-weight: 500;
      letter-spacing: 0.08em;
      text-transform: uppercase;
      text-decoration: none;
      color: var(--muted);
      padding: 0.5rem 1rem;
      border-radius: 6px;
      transition: color 0.2s, background 0.2s;
    }

    .nav-links a:hover { color: var(--text); background: var(--border); }
    .nav-links a.logout { color: var(--danger); }
    .nav-links a.logout:hover {
      background: rgba(192,103,90,0.1);
      color: var(--danger);
    }

    /* Layout */
    .layout {
      max-width: 680px;
      margin: 0 auto;
      padding: 7rem 1.5rem 4rem;
      position: relative;
      z-index: 1;
    }

    /* Compose box */
    .compose {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 14px;
      padding: 1.5rem;
      margin-bottom: 2rem;
      animation: fadeUp 0.6s ease both;
    }

    .compose-label {
      font-size: 0.7rem;
      font-weight: 500;
      letter-spacing: 0.15em;
      text-transform: uppercase;
      color: var(--accent);
      margin-bottom: 0.75rem;
    }

    textarea {
      width: 100%;
      background: var(--bg);
      border: 1px solid var(--border);
      border-radius: 8px;
      padding: 0.85rem 1rem;
      color: var(--text);
      font-family: 'DM Sans', sans-serif;
      font-size: 0.9rem;
      resize: vertical;
      min-height: 90px;
      outline: none;
      transition: border-color 0.2s, box-shadow 0.2s;
    }

    textarea::placeholder { color: var(--muted); }
    textarea:focus {
      border-color: var(--accent);
      box-shadow: 0 0 0 3px rgba(200,169,110,0.1);
    }

    .compose-footer {
      display: flex;
      justify-content: flex-end;
      margin-top: 0.75rem;
    }

    .btn-primary {
      padding: 0.6rem 1.5rem;
      background: var(--accent);
      color: #0d0d0f;
      font-family: 'DM Sans', sans-serif;
      font-size: 0.8rem;
      font-weight: 600;
      letter-spacing: 0.08em;
      text-transform: uppercase;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background 0.2s, transform 0.1s;
    }

    .btn-primary:hover { background: var(--accent2); }
    .btn-primary:active { transform: scale(0.97); }

    .btn-like {
      background: none;
      border: 1px solid var(--border);
      border-radius: 999px;
      color: var(--muted);
      font-size: 0.9rem;
      padding: 0.3rem 0.85rem;
      cursor: pointer;
      transition: color 0.2s, border-color 0.2s, background 0.2s, transform 0.1s;
      margin-right: 0.5rem;
    }

    .btn-like:hover {
      color: var(--danger);
      border-color: var(--danger);
      background: rgba(192,103,90,0.08);
    }

    .btn-like.liked {
      color: var(--danger);
      border-color: var(--danger);
      background: rgba(192,103,90,0.15);
    }

    .btn-like.liked:hover {
      background: rgba(192,103,90,0.25);
      transform: scale(1.05);
    }

    .feed-tabs {
      display: flex;
      gap: 0;
      margin-bottom: 1.5rem;
      border: 1px solid var(--border);
      border-radius: 10px;
      overflow: hidden;
      animation: fadeUp 0.6s ease 0.1s both;
    }

    .feed-tabs a {
      flex: 1;
      text-align: center;
      padding: 0.7rem;
      font-size: 0.78rem;
      font-weight: 500;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      text-decoration: none;
      color: var(--muted);
      background: var(--surface);
      transition: color 0.2s, background 0.2s;
    }

    .feed-tabs a:first-child { border-right: 1px solid var(--border); }
    .feed-tabs a:hover { color: var(--text); background: var(--border); }
    .feed-tabs a.active {
      color: var(--accent);
      background: rgba(200,169,110,0.08);
    }

    /* Posts */
    .post-list {
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }

    .post-card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 14px;
      padding: 1.5rem;
      animation: fadeUp 0.5s ease both;
      transition: border-color 0.2s;
    }

    .post-card:hover { border-color: rgba(200,169,110,0.3); }

    /* Post Header */
    .post-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 1rem;
      padding-bottom: 1rem;
      border-bottom: 1px solid var(--border);
    }

    .post-owner {
      font-size: 0.78rem;
      font-weight: 500;
      letter-spacing: 0.05em;
      color: var(--accent);
    }

    .post-date {
      font-size: 0.72rem;
      color: var(--muted);
    }

    /* Post Content */
    .post-content {
      font-size: 0.92rem;
      line-height: 1.65;
      color: var(--text);
      margin-bottom: 1.25rem;
    }

    .post-draft {
      display: inline-block;
      font-size: 0.68rem;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--muted);
      border: 1px solid var(--border);
      border-radius: 999px;
      padding: 0.2rem 0.6rem;
      margin-right: 0.5rem;
    }

    /* Post Actions */
    .post-actions {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      margin-bottom: 1.5rem;
      padding-bottom: 1.5rem;
      border-bottom: 1px solid var(--border);
    }

    .btn-comment {
      padding: 0.5rem 1rem;
      background: var(--accent);
      color: #0d0d0f;
      font-family: 'DM Sans', sans-serif;
      font-size: 0.75rem;
      font-weight: 600;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background 0.2s;
      white-space: nowrap;
    }

    .btn-comment:hover { background: var(--accent2); }

    /* Comments Section - Intégré au post */
    .comments-section {
      display: flex;
      flex-direction: column;
      gap: 0.75rem;
    }

    .comments-header {
      font-size: 0.75rem;
      font-weight: 600;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--muted);
      margin-bottom: 0.5rem;
    }

    .comments-list {
      display: flex;
      flex-direction: column;
      gap: 0.75rem;
      margin-bottom: 1rem;
      padding: 0.75rem;
      background: rgba(255, 255, 255, 0.02);
      border-left: 2px solid var(--accent);
      border-radius: 4px;
    }

    .comment-item {
      display: flex;
      flex-direction: column;
      gap: 0.25rem;
    }

    .comment-meta {
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .comment-author {
      font-weight: 600;
      font-size: 0.8rem;
      color: var(--accent);
    }

    .comment-time {
      font-size: 0.7rem;
      color: var(--muted);
    }

    .comment-text {
      color: var(--text);
      font-size: 0.85rem;
      line-height: 1.4;
      margin-left: 0.25rem;
    }

    /* Comment Form */
    .comment-form {
      display: flex;
      gap: 0.5rem;
      flex-wrap: wrap;
    }

    .comment-input {
      flex: 1;
      min-width: 200px;
      background: var(--bg);
      border: 1px solid var(--border);
      border-radius: 8px;
      padding: 0.5rem 0.75rem;
      color: var(--text);
      font-family: 'DM Sans', sans-serif;
      font-size: 0.85rem;
      outline: none;
      transition: border-color 0.2s;
    }

    .comment-input::placeholder { color: var(--muted); }
    .comment-input:focus {
      border-color: var(--accent);
      box-shadow: 0 0 0 2px rgba(200,169,110,0.1);
    }

    /* Empty state */
    .empty {
      text-align: center;
      padding: 4rem 2rem;
      color: var(--muted);
      font-size: 0.9rem;
    }

    .empty-icon {
      font-size: 2.5rem;
      margin-bottom: 1rem;
      opacity: 0.4;
    }

    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(16px); }
      to   { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>

<div class="orb"></div>

<nav>
  <a class="nav-logo" href="${pageContext.request.contextPath}/feeds">Miniature</a>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/home">Accueil</a>
    <a href="${pageContext.request.contextPath}/logout" class="logout">Se déconnecter</a>
  </div>
</nav>

<div class="layout">

  <div class="compose">
    <div class="compose-label">Nouveau post</div>
    <form method="post" action="${pageContext.request.contextPath}/feeds">
      <textarea name="newPost" placeholder="Quoi de neuf ?"></textarea>
      <div class="compose-footer">
        <button type="submit" class="btn-primary">Publier</button>
      </div>
    </form>
  </div>

  <div class="feed-tabs">
    <a href="${pageContext.request.contextPath}/feeds?type=recommendations"
       class="<%= "recommendations".equals(feedType) ? "active" : "" %>">
      Recommandations
    </a>
    <a href="${pageContext.request.contextPath}/feeds?type=subscriptions"
       class="<%= "subscriptions".equals(feedType) ? "active" : "" %>">
      Abonnements
    </a>
  </div>

  <div class="post-list">
    <% if (postList == null || postList.isEmpty()) { %>
    <div class="empty">
      <div class="empty-icon">✦</div>
      <p>Aucun post pour le moment.<br>Soyez le premier à publier !</p>
    </div>
    <% } else { %>
    <% for (Post post : postList) { %>
    <div class="post-card">

      <!-- POST HEADER -->
      <div class="post-header">
        <span class="post-owner">@ <%= post.getOwnerUsername() %></span>
        <span class="post-date"><%= post.getCreatedAt().format(fmt) %></span>
      </div>

      <!-- POST CONTENT -->
      <div class="post-content"><%= post.getContent() %></div>

      <!-- DRAFT BADGE -->
      <div style="margin-bottom: 1rem;">
        <% if (post.isDraft()) { %>
        <span class="post-draft">Brouillon</span>
        <% } %>
      </div>

      <!-- POST ACTIONS (Like) -->
      <div class="post-actions">
        <%
          boolean liked = post.isLiked();
          String likeClass = liked ? "btn-like liked" : "btn-like";
        %>
        <form method="post" action="${pageContext.request.contextPath}/feeds" style="margin: 0; display: flex;">
          <input type="hidden" name="buttonLike" value="<%= post.getId() %>">
          <button type="submit" class="<%= likeClass %>">♥ J'aime</button>
        </form>
      </div>

      <!-- COMMENTS SECTION (Intégré au post) -->
      <div class="comments-section">

        <!-- Comments List (si des commentaires existent) -->
        <% List<Map<String, Object>> comments = post.getComments(); %>
        <% if (comments != null && !comments.isEmpty()) { %>
        <div class="comments-list">
          <% for (Map<String, Object> comment : comments) { %>
          <div class="comment-item">
            <div class="comment-meta">
              <span class="comment-author">@ <%= comment.get("username") %></span>
              <span class="comment-time"><%= ((LocalDateTime)comment.get("createdAt")).format(fmt) %></span>
            </div>
            <div class="comment-text"><%= comment.get("content") %></div>
          </div>
          <% } %>
        </div>
        <% } %>

        <!-- Comment Form -->
        <form method="post" action="${pageContext.request.contextPath}/feeds" class="comment-form">
          <input type="hidden" name="postId" value="<%= post.getId() %>">
          <input type="text" name="newComment" placeholder="Ajouter un commentaire..." class="comment-input">
          <button type="submit" class="btn-comment">Envoyer</button>
        </form>

      </div>

    </div>
    <% } %>
    <% } %>
  </div>

</div>

</body>
</html>
