<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="fr.simplon.models.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    List<Post> postList = (List<Post>) request.getAttribute("postList");
    String feedType = (String) request.getAttribute("feedType");
    if (feedType == null) feedType = "recommendations";
    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd MMM yyyy · HH:mm");

    HttpSession currentSession = request.getSession(false);
    boolean isLogged = currentSession != null && currentSession.getAttribute("loggedUser") != null;
    String loggedUser = isLogged ? (String) currentSession.getAttribute("loggedUser") : null;
    String initAvatar = (loggedUser != null && !loggedUser.isEmpty())
        ? String.valueOf(loggedUser.charAt(0)).toUpperCase() : "?";
%>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Fil — Miniature</title>
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=Inter:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --bg:        #f0ede8;
      --surface:   #faf9f7;
      --border:    #e0dbd2;
      --accent:    #1a1a1a;
      --accent2:   #3d3d3d;
      --pop:       #e85d3a;
      --pop-light: #fdf0ed;
      --text:      #1a1a1a;
      --muted:     #9a9590;
    }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: 'Inter', sans-serif;
      min-height: 100vh;
    }

    /* ── Header ── */
    header {
      position: fixed;
      top: 0; left: 0; right: 0;
      z-index: 100;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 1.1rem 3rem;
      background: rgba(250,249,247,0.88);
      backdrop-filter: blur(14px);
      border-bottom: 1px solid var(--border);
    }

    .nav-logo {
      font-family: 'Syne', sans-serif;
      font-size: 1.4rem;
      font-weight: 800;
      letter-spacing: -0.02em;
      text-decoration: none;
      color: var(--accent);
    }

    .nav-logo span { color: var(--pop); }

    .nav-links {
      display: flex;
      gap: 0.4rem;
      align-items: center;
    }

    .nav-links a {
      font-size: 0.78rem;
      font-weight: 500;
      letter-spacing: 0.06em;
      text-transform: uppercase;
      text-decoration: none;
      color: var(--muted);
      padding: 0.45rem 0.9rem;
      border-radius: 8px;
      transition: color 0.2s, background 0.2s;
    }

    .nav-links a:hover { color: var(--accent); background: var(--border); }

    .nav-links a.logout { color: var(--pop); }
    .nav-links a.logout:hover { background: var(--pop-light); }

    .nav-links a.btn-outline {
      border: 1.5px solid var(--border);
      color: var(--accent2);
    }
    .nav-links a.btn-outline:hover { border-color: var(--accent); background: var(--bg); }

    .nav-links a.btn-fill {
      background: var(--pop);
      color: #fff;
    }
    .nav-links a.btn-fill:hover { background: #d44f2e; }

    /* ── Layout centré ── */
    .layout {
      max-width: 680px;
      margin: 0 auto;
      padding: 7rem 1.5rem 4rem;
    }

    /* ── Compose ── */
    .compose {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 16px;
      padding: 1.5rem;
      margin-bottom: 2rem;
      animation: fadeUp 0.5s ease both;
    }

    .compose-label {
      font-family: 'Syne', sans-serif;
      font-size: 0.7rem;
      font-weight: 700;
      letter-spacing: 0.15em;
      text-transform: uppercase;
      color: var(--pop);
      margin-bottom: 0.75rem;
    }

    textarea {
      width: 100%;
      background: var(--bg);
      border: 1.5px solid var(--border);
      border-radius: 10px;
      padding: 0.85rem 1rem;
      color: var(--text);
      font-family: 'Inter', sans-serif;
      font-size: 0.92rem;
      resize: vertical;
      min-height: 90px;
      outline: none;
      transition: border-color 0.2s, box-shadow 0.2s;
    }

    textarea::placeholder { color: var(--muted); }
    textarea:focus {
      border-color: var(--accent);
      box-shadow: 0 0 0 3px rgba(26,26,26,0.06);
      background: #fff;
    }

    .compose-footer {
      display: flex;
      justify-content: flex-end;
      margin-top: 0.75rem;
    }

    .btn-primary {
      padding: 0.6rem 1.5rem;
      background: var(--pop);
      color: #fff;
      font-family: 'Syne', sans-serif;
      font-size: 0.8rem;
      font-weight: 700;
      letter-spacing: 0.06em;
      text-transform: uppercase;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background 0.2s, transform 0.1s, box-shadow 0.2s;
    }

    .btn-primary:hover {
      background: #d44f2e;
      box-shadow: 0 4px 12px rgba(232,93,58,0.3);
    }
    .btn-primary:active { transform: scale(0.97); }

    /* ── Tabs ── */
    .feed-tabs {
      display: flex;
      margin-bottom: 1.5rem;
      border: 1px solid var(--border);
      border-radius: 12px;
      overflow: hidden;
      animation: fadeUp 0.5s ease 0.05s both;
    }

    .feed-tabs a {
      flex: 1;
      text-align: center;
      padding: 0.75rem;
      font-size: 0.78rem;
      font-weight: 600;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      text-decoration: none;
      color: var(--muted);
      background: var(--surface);
      transition: color 0.2s, background 0.2s;
    }

    .feed-tabs a:first-child { border-right: 1px solid var(--border); }
    .feed-tabs a:hover { color: var(--accent); background: var(--bg); }
    .feed-tabs a.active { color: var(--pop); background: var(--pop-light); font-weight: 700; }

    /* ── Posts ── */
    .post-list {
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }

    .post-card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 16px;
      padding: 1.25rem 1.5rem;
      animation: fadeUp 0.5s ease both;
      transition: border-color 0.2s, box-shadow 0.2s;
    }

    .post-card:hover {
      border-color: rgba(232,93,58,0.25);
      box-shadow: 0 2px 16px rgba(232,93,58,0.06);
    }

    .post-meta {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 0.75rem;
    }

    .post-owner {
      font-family: 'Syne', sans-serif;
      font-size: 0.82rem;
      font-weight: 700;
      color: var(--pop);
    }

    .post-date {
      font-size: 0.72rem;
      color: var(--muted);
    }

    .post-content {
      font-size: 0.95rem;
      line-height: 1.7;
      color: var(--accent2);
      margin-bottom: 1rem;
      word-break: break-word;
      white-space: pre-wrap;
    }

    .post-actions {
      display: flex;
      align-items: center;
      gap: 0.75rem;
      padding-top: 0.75rem;
      border-top: 1px solid var(--border);
    }

    .btn-like {
      display: flex;
      align-items: center;
      gap: 0.35rem;
      background: none;
      border: 1.5px solid var(--border);
      border-radius: 999px;
      color: var(--muted);
      font-family: 'Inter', sans-serif;
      font-size: 0.8rem;
      font-weight: 500;
      padding: 0.3rem 0.9rem;
      cursor: pointer;
      transition: color 0.2s, border-color 0.2s, background 0.2s, transform 0.1s;
    }

    .btn-like:hover {
      color: var(--pop);
      border-color: var(--pop);
      background: var(--pop-light);
    }

    .btn-like.liked {
      color: var(--pop);
      border-color: var(--pop);
      background: var(--pop-light);
      font-weight: 600;
    }

    .btn-like.liked:hover { transform: scale(1.04); }

    .post-draft {
      display: inline-block;
      font-size: 0.68rem;
      font-weight: 600;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--muted);
      border: 1px solid var(--border);
      border-radius: 999px;
      padding: 0.2rem 0.65rem;
    }

    /* ── Empty state ── */
    .empty {
      text-align: center;
      padding: 4rem 2rem;
      color: var(--muted);
      font-size: 0.9rem;
      line-height: 1.6;
    }

    .empty-icon {
      font-size: 2.5rem;
      margin-bottom: 1rem;
      opacity: 0.3;
    }

    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(14px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 600px) {
      header { padding: 1rem 1.25rem; }
      .layout { padding: 6rem 1rem 3rem; }
    }
  </style>
</head>
<body>

  <header>
    <a class="nav-logo" href="${pageContext.request.contextPath}/feeds">Mini<span>ature</span></a>
    <nav class="nav-links" aria-label="Navigation principale">
      <% if (isLogged) { %>
        <a href="${pageContext.request.contextPath}/logout" class="logout">Se déconnecter</a>
      <% } else { %>
        <a href="${pageContext.request.contextPath}/login" class="btn-outline">Se connecter</a>
        <a href="${pageContext.request.contextPath}/register" class="btn-fill">S'inscrire</a>
      <% } %>
    </nav>
  </header>

  <div class="layout">

    <% if (isLogged) { %>
    <section class="compose" aria-label="Nouveau post">
      <p class="compose-label">Nouveau post</p>
      <form method="post" action="${pageContext.request.contextPath}/feeds">
        <textarea name="newPost" placeholder="Quoi de neuf ?"></textarea>
        <div class="compose-footer">
          <button type="submit" class="btn-primary">Publier →</button>
        </div>
      </form>
    </section>
    <% } %>

    <div class="feed-tabs" role="tablist">
      <a href="${pageContext.request.contextPath}/feeds?type=recommendations"
         class="<%= "recommendations".equals(feedType) ? "active" : "" %>"
         role="tab">Recommandations</a>
      <a href="${pageContext.request.contextPath}/feeds?type=subscriptions"
         class="<%= "subscriptions".equals(feedType) ? "active" : "" %>"
         role="tab">Abonnements</a>
    </div>

    <% if (postList == null || postList.isEmpty()) { %>
      <div class="empty">
        <div class="empty-icon">✦</div>
        <p>Aucun post pour le moment.<br>Soyez le premier à publier !</p>
      </div>
    <% } else { %>
      <div class="post-list">
        <% for (Post post : postList) {
            boolean liked = post.isLiked();
            String likeClass = liked ? "btn-like liked" : "btn-like";
        %>
          <article class="post-card">
            <div class="post-meta">
              <span class="post-owner">@ <%= post.getOwnerUsername() %></span>
              <time class="post-date" datetime="<%= post.getCreatedAt() %>">
                <%= post.getCreatedAt().format(fmt) %>
              </time>
            </div>

            <p class="post-content"><%= post.getContent() %></p>

            <div class="post-actions">
              <form method="post" action="${pageContext.request.contextPath}/feeds">
                <input type="hidden" name="buttonLike" value="<%= post.getId() %>">
                <button type="submit" class="<%= likeClass %>"
                        aria-label="<%= liked ? "Ne plus aimer" : "Aimer" %>">
                  ♥ <%= liked ? "Aimé" : "J'aime" %>
                </button>
              </form>
              <% if (post.isDraft()) { %>
                <span class="post-draft">Brouillon</span>
              <% } %>
            </div>
          </article>
        <% } %>
      </div>
    <% } %>

  </div>

</body>
</html>
