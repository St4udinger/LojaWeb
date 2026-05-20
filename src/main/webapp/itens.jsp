<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="br.com.dao.ItemDAO,br.com.model.Item,br.com.model.Usuario,java.util.List" %>
<%
    // Verifica sessão: se não estiver logado, redireciona para login
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Nome para exibir no cabeçalho
    String nomeUsuario = usuarioLogado.getNome();

    // Lista de itens
    List<Item> lista = new ItemDAO().listarTodos();
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Achei! | Itens</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<!-- NAVBAR -->
<nav class="modern-navbar" id="mainNavbar">
  <div class="container">
    <span class="brand"><i class="fas fa-compass"></i> Achei</span>

    <ul>
      <li><a href="${pageContext.request.contextPath}/index.jsp">Início</a></li>
      <li><a href="${pageContext.request.contextPath}/itens.jsp">Itens</a></li>
      <li><a href="${pageContext.request.contextPath}/index.jsp#sobre">Sobre</a></li>
      <li><a href="${pageContext.request.contextPath}/index.jsp#contato">Contato</a></li>
    </ul>

    <!-- Área do usuário logado -->
    <div class="user-area">
      <span class="user-greeting">
        <i class="fas fa-user-circle" aria-hidden="true"></i>
        <span class="user-name"><%= nomeUsuario %></span>
      </span>
      <a href="${pageContext.request.contextPath}/logout" class="btn-logout" title="Sair">
        <i class="fas fa-sign-out-alt" aria-hidden="true"></i> Sair
      </a>
    </div>

    <!-- Menu mobile -->
    <button class="menu-mobile" id="menuMobile" aria-label="Abrir menu">
      <span></span><span></span><span></span>
    </button>
  </div>
</nav>

<!-- HERO -->
<section class="modern-hero" style="min-height:40vh;">
  <div class="hero-content">
    <h1>Achados e Perdidos</h1>
    <p>Explore todos os achados e perdidos cadastrados.</p>
    <div class="search-box-glass">
      <input type="text" id="searchInput" placeholder="Buscar item..." />
      <i class="fas fa-search"></i>
      <div id="searchResults" class="search-results"></div>
    </div>
  </div>
</section>

<!-- ITENS -->
<section class="modern-itens" style="padding-top:40px;">
  <div class="section-title">
    <h2><i class="fas fa-box-open"></i> Itens Disponíveis</h2>
    <div class="filters">
      <button class="active" data-filter="todos">Todos</button>
      <button data-filter="perdido">Perdidos</button>
      <button data-filter="achado">Achados</button>
    </div>
  </div>

  <div class="modern-cards">
  <% for (Item i : lista) { %>
    <div class="modern-card <%= i.getTipo() %>" data-type="<%= i.getTipo() %>">
      <div class="icon"><i class="fas fa-box"></i></div>
      <div class="details">
        <h3><%= i.getTitulo() %></h3>
        <span class="badge <%= "achado".equals(i.getTipo()) ? "encontrado" : "perdido" %>">
          <%= i.getTipo().toUpperCase() %>
        </span>
        <p class="local"><i class="fas fa-map-marker-alt"></i> <%= i.getLocalizacao() %></p>
        <small><%= i.getDescricao() %></small>
      </div>
    </div>
  <% } %>
  </div>
</section>

<!-- MODAL ANUNCIO (opcional) -->
<div id="modalAnuncio" class="modal2" style="display:none;">
  <div class="modal2-content">
    <span class="close2" onclick="document.getElementById('modalAnuncio').style.display='none'">&times;</span>
    <h2>Divulgue um Item</h2>
    <form action="${pageContext.request.contextPath}/publicar" method="post">
      <input class="f-title" name="titulo" type="text" placeholder="Título do item" required>
      <select class="f-type" name="tipo" required>
        <option value="">Tipo</option>
        <option value="perdido">Perdido</option>
        <option value="achado">Achado</option>
      </select>
      <input class="f-local" name="localizacao" type="text" placeholder="Onde você viu/achou?" required>
      <textarea class="f-desc" name="descricao" placeholder="Descreva o item" required></textarea>
      <button class="cta" type="submit">Publicar</button>
    </form>
  </div>
</div>

<!-- SCRIPTS -->
<script>
  // Sticky nav class toggle
  window.addEventListener('scroll', function() {
    let nav = document.getElementById('mainNavbar');
    if (window.scrollY > 70) nav.classList.add('solid');
    else nav.classList.remove('solid');
  });

  // Mobile menu toggle
  document.getElementById('menuMobile').addEventListener('click', function() {
    document.querySelector('.modern-navbar ul').classList.toggle('active');
  });

  // Filters
  const filterButtons = document.querySelectorAll(".filters button");
  const cards = document.querySelectorAll(".modern-card");

  filterButtons.forEach(btn => {
    btn.addEventListener("click", () => {
      filterButtons.forEach(b => b.classList.remove("active"));
      btn.classList.add("active");
      const filtro = btn.dataset.filter;
      cards.forEach(card => {
        const tipo = card.dataset.type;
        card.style.display = (filtro === "todos" || filtro === tipo) ? "flex" : "none";
      });
    });
  });

  // Search
  const searchInput = document.getElementById("searchInput");
  const searchResults = document.getElementById("searchResults");

  if (searchInput) {
    searchInput.addEventListener("input", () => {
      const value = searchInput.value.toLowerCase().trim();
      searchResults.innerHTML = "";
      if (!value) { searchResults.style.display = "none"; return; }

      let matches = 0;
      cards.forEach(card => {
        const title = card.querySelector("h3").innerText.toLowerCase();
        if (title.includes(value)) {
          matches++;
          const item = document.createElement("div");
          item.textContent = card.querySelector("h3").innerText;
          item.onclick = () => {
            searchInput.value = item.textContent;
            searchResults.style.display = "none";
          };
          searchResults.appendChild(item);
        }
      });
      searchResults.style.display = matches ? "block" : "none";
    });
  }
</script>

</body>
</html>