<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Consulta de Categorias</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<div class="page">
    <div class="content-card">
        <div class="topbar">
            <div>
                <h1>Consulta de Categorias</h1>
                <p class="subtitle">Gerencie os registros de categorias cadastrados no sistema.</p>
            </div>
            <div class="topbar-actions">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/categorias?acao=novo">＋ Incluir</a>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/index.jsp">← Menu principal</a>
            </div>
        </div>

        <table class="data-table">
            <thead>
            <tr>
                <th class="col-id">ID</th>
                <th>Nome da Categoria</th>
                <th>Descrição</th>
                <th class="col-actions">Ações</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty listaCategorias}">
                    <tr>
                        <td colspan="4" class="empty-state">Nenhuma categoria cadastrada.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="categoria" items="${listaCategorias}">
                        <tr>
                            <td>${categoria.idCategoria}</td>
                            <td>${categoria.nomeCategoria}</td>
                            <td>${categoria.descricao}</td>
                            <td>
                                <div class="action-icons">
                                    <a class="icon-link edit" title="Alterar"
                                       href="${pageContext.request.contextPath}/categorias?acao=editar&id=${categoria.idCategoria}">✏️</a>
                                    <button type="button"
                                            class="icon-link delete"
                                            title="Excluir"
                                            data-id="${categoria.idCategoria}"
                                            data-name="${categoria.nomeCategoria}"
                                            data-url="${pageContext.request.contextPath}/categorias?acao=excluir&id=${categoria.idCategoria}"
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
