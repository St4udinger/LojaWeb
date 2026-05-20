<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="br.com.dao.ItemDAO,br.com.model.Item,br.com.model.Usuario,java.util.List" %>
<%
    // Força redirecionamento para login se não estiver logado
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Item> lista = new ItemDAO().listarTodos();
    String nomeUsuario = usuarioLogado.getNome();
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Achei! Achados e Perdidos</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<!-- NAVBAR -->
<nav class="modern-navbar" id="mainNavbar">
    <div class="container">
        <!-- Logo (esquerda) -->
        <span class="brand">
            <i class="fas fa-compass"></i>
            Achei
        </span>

        <!-- Menu centralizado -->
        <ul class="nav-menu">
            <li><a href="#inicio">Início</a></li>
            <li><a href="${pageContext.request.contextPath}/itens.jsp">Itens</a></li>
            <li><a href="#sobre">Sobre</a></li>
            <li><a href="#contato">Contato</a></li>
        </ul>

        <!-- Área do usuário logado (direita) -->
        <div class="user-area">
            <span class="user-greeting" title="Você está logado">
                <i class="fas fa-user-circle" aria-hidden="true"></i>
                <span class="user-name"><%= nomeUsuario %></span>
            </span>

            <a href="${pageContext.request.contextPath}/logout" class="btn-logout" title="Sair">
                <i class="fas fa-sign-out-alt" aria-hidden="true"></i>
                Sair
            </a>
        </div>

        <!-- Menu mobile -->
        <button class="menu-mobile" id="menuMobile" aria-label="Abrir menu">
            <span></span><span></span><span></span>
        </button>
    </div>
</nav>

<!-- HERO SECTION -->
<section class="modern-hero" id="inicio">
    <div class="hero-content">
        <h1>O ponto de encontro para<br><span>achados e perdidos</span><br>em sua cidade.</h1>
        <p>Encontre e divulgue objetos com facilidade, segurança e rapidez.<br>Somos a ponte entre pessoas honestas!</p>
        <div class="search-box-glass">
            <input type="text" id="searchInput" placeholder="Busque por nome, cor ou local..." />
            <i class="fas fa-search"></i>
            <div id="searchResults" class="search-results"></div>
        </div>
        <button class="cta" onclick="document.getElementById('modalAnuncio').style.display='flex'">
            <i class="fas fa-plus"></i> Anunciar item agora
        </button>
    </div>
</section>

<!-- ITENS RECENTES -->
<section class="modern-itens" id="itens">
    <div class="section-title">
        <h2><i class="fas fa-box-open"></i> Itens Recentes</h2>
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

<!-- SOBRE -->
<section class="sobre" id="sobre">
    <div class="sobre-content">
        <h2>Como funciona?</h2>
        <p>Achei conecta pessoas honestas.<br>Relate o que achou ou perdeu.<br>Filtros inteligentes e uma plataforma ética, feita para todos.<br><i class="fas fa-heart"></i></p>
    </div>
</section>

<!-- FOOTER -->
<footer class="modern-footer" id="contato">
    <div class="footer-col">
        <h3>Fale com a gente</h3>
        <form class="contactform">
            <input type="text" placeholder="Seu nome" required>
            <input type="email" placeholder="Seu email" required>
            <textarea placeholder="Digite sua mensagem" required></textarea>
            <button class="cta">Enviar</button>
        </form>
    </div>
    <div class="footer-col">
        <h3>Transparência & Utilidade</h3>
        <p>O Achei é gratuito e sempre será.<br>Relate, encontre e ajude alguém localmente!</p>
    </div>
    <div class="footer-copy">
        <small>&copy; 2026 Achei • Todos os direitos reservados</small>
    </div>
</footer>

<!-- MODAL ANUNCIO -->
<div id="modalAnuncio" class="modal2">
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
    // sticky nav class toggle
    window.addEventListener('scroll', function() {
        let nav = document.getElementById('mainNavbar');
        if (window.scrollY > 70) {
            nav.classList.add('solid');
        } else {
            nav.classList.remove('solid');
        }
    });

    // mobile menu toggle (works now with UL)
    document.getElementById('menuMobile').addEventListener('click', function() {
        document.querySelector('.modern-navbar ul').classList.toggle('active');
    });

    // filters (unchanged)
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

    // search (unchanged)
    const searchInput = document.getElementById("searchInput");
    const searchResults = document.getElementById("searchResults");
    const cardsList = document.querySelectorAll(".modern-card");

    if (searchInput) {
      searchInput.addEventListener("input", () => {
          const value = searchInput.value.toLowerCase().trim();
          searchResults.innerHTML = "";
          if (value === "") {
              searchResults.style.display = "none";
              return;
          }

          let matches = 0;
          cardsList.forEach(card => {
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