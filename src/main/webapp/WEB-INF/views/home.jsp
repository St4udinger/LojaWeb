<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Menu Principal - Loja Web</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<div class="page-shell center-screen">
    <section class="menu-card">
        <div class="hero-badge">Projeto Java Web</div>
        <h1>Menu Principal</h1>
        <p class="subtitle">Escolha o módulo que será trabalhado.</p>

        <div class="menu-grid">
            <a class="menu-option" href="${pageContext.request.contextPath}/categorias">
                <span class="menu-icon">🏷</span>
                <span class="menu-title">Gerenciar Categorias</span>
                <span class="menu-text">Consulta, inclusão, alteração e exclusão de categorias.</span>
            </a>

            <a class="menu-option" href="${pageContext.request.contextPath}/produtos">
                <span class="menu-icon">📦</span>
                <span class="menu-title">Gerenciar Produtos</span>
                <span class="menu-text">Consulta, inclusão, alteração e exclusão de produtos.</span>
            </a>
        </div>
    </section>
</div>
</body>
</html>
