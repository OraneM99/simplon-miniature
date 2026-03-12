<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Inscription - Miniature</title>
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
      --danger:    #e85d3a;
      --danger-bg: #fdf0ed;
    }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: 'Inter', sans-serif;
      min-height: 100vh;
      display: grid;
      grid-template-columns: 1fr 1fr;
    }

    /* ── Panneau gauche branding ── */
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

    /* Étapes d'inscription */
    .brand-steps {
      position: relative;
      z-index: 1;
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }

    .step {
      display: flex;
      align-items: center;
      gap: 1rem;
    }

    .step-number {
      width: 32px; height: 32px;
      border-radius: 50%;
      background: var(--pop);
      color: #fff;
      font-family: 'Syne', sans-serif;
      font-size: 0.85rem;
      font-weight: 700;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
    }

    .step-text {
      font-size: 0.85rem;
      color: rgba(255,255,255,0.6);
      line-height: 1.4;
    }

    .step-text strong {
      color: #fff;
      display: block;
      font-size: 0.9rem;
    }

    /* ── Panneau droit formulaire ── */
    .panel-form {
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 3rem 2rem;
      background: var(--surface);
      overflow-y: auto;
    }

    .form-wrapper {
      width: 100%;
      max-width: 400px;
      animation: slideIn 0.5s ease both;
    }

    @keyframes slideIn {
      from { opacity: 0; transform: translateX(20px); }
      to   { opacity: 1; transform: translateX(0); }
    }

    .form-header {
      margin-bottom: 2rem;
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

    /* Alert */
    .alert-error {
      border-radius: 10px;
      padding: 0.75rem 1rem;
      font-size: 0.82rem;
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      gap: 0.6rem;
      font-weight: 500;
      background: var(--danger-bg);
      border: 1px solid rgba(232,93,58,0.2);
      color: var(--danger);
    }

    /* Fieldset / section */
    fieldset {
      border: none;
      margin-bottom: 0.5rem;
    }

    legend {
      font-family: 'Syne', sans-serif;
      font-size: 0.72rem;
      font-weight: 700;
      letter-spacing: 0.12em;
      text-transform: uppercase;
      color: var(--muted);
      margin-bottom: 1rem;
      width: 100%;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    legend::after {
      content: '';
      flex: 1;
      height: 1px;
      background: var(--border);
    }

    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1rem;
    }

    .form-group { margin-bottom: 1rem; }

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
      margin-top: 1rem;
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
      margin-top: 1.5rem;
      font-size: 0.82rem;
      color: var(--muted);
      display: flex;
      justify-content: center;
      gap: 1.5rem;
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
      .form-row { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>

  <!-- Panneau gauche : branding -->
  <aside class="panel-brand" aria-hidden="true">
    <a class="brand-logo" href="#">Mini<span>ature</span></a>

    <div class="brand-tagline">
      <h2>Rejoignez la communauté.</h2>
      <p>Créez votre profil en quelques secondes et commencez à partager avec le monde.</p>
    </div>

    <div class="brand-steps" aria-label="Étapes d'inscription">
      <div class="step">
        <span class="step-number">1</span>
        <div class="step-text">
          <strong>Créez votre profil</strong>
          Choisissez un pseudo unique
        </div>
      </div>
      <div class="step">
        <span class="step-number">2</span>
        <div class="step-text">
          <strong>Suivez des membres</strong>
          Abonnez-vous aux profils qui vous inspirent
        </div>
      </div>
      <div class="step">
        <span class="step-number">3</span>
        <div class="step-text">
          <strong>Publiez et likez</strong>
          Partagez vos idées et réagissez aux posts
        </div>
      </div>
    </div>
  </aside>

  <!-- Formulaire principal -->
  <main class="panel-form">
    <div class="form-wrapper">

      <header class="form-header">
        <h1>Créer un compte</h1>
        <p>Gratuit et sans engagement.</p>
      </header>

      <% if (request.getAttribute("error") != null) { %>
        <div class="alert-error" role="alert">✕ ${error}</div>
      <% } %>

      <form method="post" action="${pageContext.request.contextPath}/register" novalidate>

        <fieldset>
          <legend>Identité</legend>
          <div class="form-row">
            <div class="form-group">
              <label for="username">Nom d'utilisateur</label>
              <input type="text" id="username" name="username"
                     placeholder="username" autocomplete="username" required />
            </div>
            <div class="form-group">
              <label for="email">Email</label>
              <input type="email" id="email" name="email"
                     placeholder="you@mail.com" autocomplete="email" required />
            </div>
          </div>
        </fieldset>

        <fieldset>
          <legend>Sécurité</legend>
          <div class="form-group">
            <label for="password">Mot de passe</label>
            <input type="password" id="password" name="password"
                   placeholder="••••••••" autocomplete="new-password" required />
          </div>
          <div class="form-group">
            <label for="confirmPassword">Confirmation</label>
            <input type="password" id="confirmPassword" name="confirmPassword"
                   placeholder="••••••••" autocomplete="new-password" required />
          </div>
        </fieldset>

        <button type="submit" class="btn-submit">Créer mon compte →</button>
      </form>

      <footer class="form-footer">
        <a href="${pageContext.request.contextPath}/login">Déjà un compte ?</a>
        <a href="${pageContext.request.contextPath}/home">Retour à l'accueil</a>
      </footer>

    </div>
  </main>

</body>
</html>
