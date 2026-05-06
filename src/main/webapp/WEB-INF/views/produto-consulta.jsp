<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Consulta de Produtos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<div class="page">
    <div class="content-card">
        <div class="topbar">
            <div>
                <h1>Consulta de Produtos</h1>
                <p class="subtitle">Gerencie os registros de produtos cadastrados no sistema.</p>
            </div>
            <div class="topbar-actions">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/produtos?acao=novo">＋ Incluir</a>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/index.jsp">← Menu principal</a>
            </div>
        </div>

        <table class="data-table">
            <thead>
            <tr>
                <th class="col-id">ID</th>
                <th class="col-id">ID categoria</th>
                <th>Nome do Produto</th>
                <th>preco</th>
                <th>estoque</th>
                <th class="col-actions">Ações</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty listaProdutos}">
                    <tr>
                        <td colspan="4" class="empty-state">Nenhum produto cadastrado.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="produto" items="${listaProdutos}">
                        <tr>
                            <td>${produto.idProduto}</td>
                            <td>${produto.idCategoria}</td>
                            <td>${produto.nomeProduto}</td>
                            <td>${produto.precoProduto}</td>
                            <td>${produto.estoqueProduto}</td>
                            <td>
                                <div class="action-icons">
                                    <a class="icon-link edit" title="Alterar"
                                       href="${pageContext.request.contextPath}/produtos?acao=editar&id=${produto.idProduto}">✏️</a>
                                    <button type="button"
                                            class="icon-link delete"
                                            title="Excluir"
                                            data-id="${produto.idProduto}"
                                            data-name="${produto.nomeProduto}"
                                            data-url="${pageContext.request.contextPath}/produtos?acao=excluir&id=${produto.idProduto}"
                                            onclick="openDeleteModal(this)">🗑️</button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<div id="deleteModal" class="modal-overlay">
    <div class="modal-box">
        <h2>Confirmar exclusão</h2>
        <p id="deleteMessage">Deseja realmente excluir este registro?</p>
        <div class="modal-actions">
            <button class="btn btn-secondary" type="button" onclick="closeDeleteModal()">Cancelar</button>
            <a id="confirmDeleteBtn" class="btn btn-danger" href="#">Confirmar exclusão</a>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
