<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Connexion - Miniature</title>
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
      --success:   #2d7a5f;
      --success-bg:#edf7f3;
    }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: 'Inter', sans-serif;
      min-height: 100vh;
      display: grid;
      grid-template-columns: 1fr 1fr;
    }

    /* Left panel - branding */
    .panel-brand {
      background: var(--accent);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 3rem;
      position: relative;
      overflow: hidden;
    }

    .panel-brand::before {
      content: '';
      position: absolute;
      width: 500px; height: 500px;
      border-radius: 50%;
      border: 1px solid rgba(255,255,255,0.06);
      top: -100px; left: -100px;
    }

    .panel-brand::after {
      content: '';
      position: absolute;
      width: 300px; height: 300px;
      border-radius: 50%;
      border: 1px solid rgba(255,255,255,0.06);
      bottom: 80px; right: -80px;
    }

    .brand-logo {
      font-family: 'Syne', sans-serif;
      font-size: 1.6rem;
      font-weight: 800;
      color: #fff;
      letter-spacing: -0.02em;
      text-decoration: none;
      position: relative;
      z-index: 1;
    }

    .brand-logo span { color: var(--pop); }

    .brand-tagline {
      position: relative;
      z-index: 1;
    }

    .brand-tagline h2 {
      font-family: 'Syne', sans-serif;
      font-size: clamp(2rem, 3.5vw, 3rem);
      font-weight: 700;
      color: #fff;
      line-height: 1.15;
      margin-bottom: 1rem;
    }

    .brand-tagline p {
      font-size: 0.9rem;
      color: rgba(255,255,255,0.45);
      line-height: 1.6;
      max-width: 320px;
    }

    .brand-stats {
      display: flex;
      gap: 2rem;
      position: relative;
      z-index: 1;
    }

    .stat {
      display: flex;
      flex-direction: column;
      gap: 0.2rem;
    }

    .stat-number {
      font-family: 'Syne', sans-serif;
      font-size: 1.5rem;
      font-weight: 700;
      color: #fff;
    }

    .stat-label {
      font-size: 0.72rem;
      color: rgba(255,255,255,0.35);
      letter-spacing: 0.05em;
      text-transform: uppercase;
    }

    /* Right panel - form */
    .panel-form {
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 3rem 2rem;
      background: var(--surface);
    }

    .form-wrapper {
      width: 100%;
      max-width: 380px;
      animation: slideIn 0.5s ease both;
    }

    @keyframes slideIn {
      from { opacity: 0; transform: translateX(20px); }
      to   { opacity: 1; transform: translateX(0); }
    }

    .form-header {
      margin-bottom: 2.5rem;
    }

    .form-header h1 {
      font-family: 'Syne', sans-serif;
      font-size: 1.9rem;
      font-weight: 700;
      letter-spacing: -0.02em;
      margin-bottom: 0.4rem;
    }

    .form-header p {
      font-size: 0.87rem;
      color: var(--muted);
    }

    /* Alerts */
    .alert {
      border-radius: 10px;
      padding: 0.75rem 1rem;
      font-size: 0.82rem;
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      gap: 0.6rem;
      font-weight: 500;
    }

    .alert-success {
      background: var(--success-bg);
      border: 1px solid rgba(45,122,95,0.2);
      color: var(--success);
    }

    .alert-error {
      background: var(--pop-light);
      border: 1px solid rgba(232,93,58,0.2);
      color: var(--pop);
    }

    /* Form fields */
    .form-group { margin-bottom: 1.1rem; }

    label {
      display: block;
      font-size: 0.78rem;
      font-weight: 500;
      color: var(--accent2);
      margin-bottom: 0.45rem;
    }

    input {
      width: 100%;
      background: var(--bg);
      border: 1.5px solid var(--border);
      border-radius: 10px;
      padding: 0.8rem 1rem;
      color: var(--text);
      font-family: 'Inter', sans-serif;
      font-size: 0.9rem;
      transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
      outline: none;
    }

    input::placeholder { color: var(--muted); }

    input:focus {
      border-color: var(--accent);
      background: #fff;
      box-shadow: 0 0 0 3px rgba(26,26,26,0.06);
    }

    .btn-submit {
      width: 100%;
      margin-top: 0.75rem;
      padding: 0.9rem;
      background: var(--pop);
      color: #fff;
      font-family: 'Syne', sans-serif;
      font-size: 0.9rem;
      font-weight: 700;
      letter-spacing: 0.02em;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      transition: background 0.2s, transform 0.1s, box-shadow 0.2s;
    }

    .btn-submit:hover {
      background: #d44f2e;
      box-shadow: 0 4px 16px rgba(232,93,58,0.3);
    }

    .btn-submit:active { transform: scale(0.98); }

    .form-footer {
      text-align: center;
      margin-top: 1.75rem;
      font-size: 0.82rem;
      color: var(--muted);
    }

    .form-footer a {
      color: var(--accent);
      text-decoration: none;
      font-weight: 600;
      border-bottom: 1px solid transparent;
      transition: border-color 0.2s;
    }

    .form-footer a:hover { border-color: var(--accent); }

    @media (max-width: 768px) {
      body { grid-template-columns: 1fr; }
      .panel-brand { display: none; }
      .panel-form { padding: 2rem 1.5rem; }
    }
  </style>
</head>
<body>

  <aside class="panel-brand" aria-hidden="true">
    <a class="brand-logo" href="${pageContext.request.contextPath}/feeds">Mini<span>ature</span></a>

    <div class="brand-tagline">
      <h2>Partagez ce qui vous inspire.</h2>
      <p>Rejoignez une communauté de créateurs et suivez les personnes qui vous ressemblent.</p>
    </div>

    <div class="brand-stats">
      <div class="stat">
        <span class="stat-number">12k</span>
        <span class="stat-label">Membres</span>
      </div>
      <div class="stat">
        <span class="stat-number">48k</span>
        <span class="stat-label">Posts</span>
      </div>
      <div class="stat">
        <span class="stat-number">130k</span>
        <span class="stat-label">Likes</span>
      </div>
    </div>
  </aside>

  <main class="panel-form">
    <div class="form-wrapper">

      <header class="form-header">
        <h1>Bon retour 👋</h1>
        <p>Connectez-vous pour rejoindre la conversation.</p>
      </header>

      <% if ("true".equals(request.getParameter("registered"))) { %>
        <div class="alert alert-success" role="alert">
          ✓ Inscription réussie ! Connectez-vous.
        </div>
      <% } %>

      <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error" role="alert">
          ✕ ${error}
        </div>
      <% } %>

      <form method="post" action="${pageContext.request.contextPath}/login" novalidate>
        <div class="form-group">
          <label for="username">Nom d'utilisateur</label>
          <input type="text" id="username" name="username"
                 placeholder="username" autocomplete="username" required />
        </div>
        <div class="form-group">
          <label for="password">Mot de passe</label>
          <input type="password" id="password" name="password"
                 placeholder="••••••••" autocomplete="current-password" required />
        </div>
        <button type="submit" class="btn-submit">Se connecter →</button>
      </form>

      <footer class="form-footer">
        Pas encore de compte ?
        <a href="${pageContext.request.contextPath}/register">S'inscrire gratuitement</a>
      </footer>

    </div>
  </main>

</body>
</html>
