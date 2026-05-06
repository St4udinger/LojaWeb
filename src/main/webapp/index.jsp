<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Sistema Loja</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<div class="page page-center">
    <div class="hero-card">
        <h1>Menu Principal</h1>
        <p class="subtitle">Sistema de gerenciamento didático para categorias e produtos</p>

        <div class="menu-grid">
            <a class="menu-card" href="${pageContext.request.contextPath}/categorias">
                <div class="menu-icon">📁</div>
                <div>
                    <h2>Gerenciar Categorias</h2>
                    <p>Consulta, inclusão, alteração e exclusão de categorias.</p>
                </div>
            </a>
<!-- Em desenvolvimento -->
            <a class="menu-card" href="${pageContext.request.contextPath}/produtos">
                <div class="menu-icon">📦</div>
                <div>
                    <h2>Gerenciar Produtos</h2>
                    <p>Consulta, inclusão, alteração e exclusão de produtos.</p>
                </div>
            </a>
        </div>

        <div class="small-actions">
            <a class="secondary-link" href="${pageContext.request.contextPath}/teste-conexao">Testar conexão com o banco</a>
        </div>
    </div>
</div>
</body>
</html>
