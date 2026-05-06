<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title><c:choose><c:when test="${not empty produto.idProduto}">Alterar Produto</c:when><c:otherwise>Incluir Produto</c:otherwise></c:choose></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<div class="page page-center">
    <div class="form-card">
        <h1>
            <c:choose>
                <c:when test="${not empty produto.idProduto}">Alterar Produto</c:when>
                <c:otherwise>Incluir Produto</c:otherwise>
            </c:choose>
        </h1>
        <p class="subtitle">Preencha os campos abaixo e salve para retornar à consulta de produtos.</p>

        <form action="${pageContext.request.contextPath}/produtos" method="post" class="form-grid">
            <input type="hidden" name="idProduto" value="${produto.idProduto}">

            <div class="form-group">
                <label for="idCategoria">Categoria</label>
                <select id="idCategoria" name="idCategoria" required>
                    <option value="">Selecione...</option>
                    <c:forEach var="cat" items="${listaCategorias}">
                        <c:choose>
                            <c:when test="${cat.idCategoria == produto.idCategoria}">
                                <option value="${cat.idCategoria}" selected="selected">${cat.idCategoria} - ${cat.nomeCategoria}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${cat.idCategoria}">${cat.idCategoria} - ${cat.nomeCategoria}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="nomeProduto">Nome do produto</label>
                <input id="nomeProduto" type="text" name="nomeProduto"
                       value="${produto.nomeProduto}" required maxlength="100">
            </div>

            <div class="form-group">
                <label for="estoqueProduto">Estoque</label>
                <input id="estoqueProduto" type="number" name="estoqueProduto"
                       value="${produto.estoqueProduto}" min="0" step="0.01" required>
            </div>

            <div class="form-group">
                <label for="precoProduto">Preço</label>
                <input id="precoProduto" type="number" name="precoProduto"
                       value="${produto.precoProduto}" min="0" step="0.01" required>
            </div>

            <div class="form-actions">
                <button class="btn btn-primary" type="submit">Salvar</button>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/produtos">Cancelar</a>
            </div>
        </form>

    </div>
</div>
</body>
</html>
