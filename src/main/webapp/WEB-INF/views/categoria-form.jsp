<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title><c:choose><c:when test="${not empty categoria.idCategoria}">Alterar Categoria</c:when><c:otherwise>Incluir Categoria</c:otherwise></c:choose></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<div class="page page-center">
    <div class="form-card">
        <h1>
            <c:choose>
                <c:when test="${not empty categoria.idCategoria}">Alterar Categoria</c:when>
                <c:otherwise>Incluir Categoria</c:otherwise>
            </c:choose>
        </h1>
        <p class="subtitle">Preencha os campos abaixo e salve para retornar à consulta de categorias.</p>

        <form action="${pageContext.request.contextPath}/categorias" method="post" class="form-grid">
            <input type="hidden" name="idCategoria" value="${categoria.idCategoria}">

            <div class="form-group">
                <label for="nomeCategoria">Nome da categoria</label>
                <input id="nomeCategoria" type="text" name="nomeCategoria" value="${categoria.nomeCategoria}" required maxlength="100">
            </div>

            <div class="form-group">
                <label for="descricao">Descrição</label>
                <textarea id="descricao" name="descricao" rows="5">${categoria.descricao}</textarea>
            </div>

            <div class="form-actions">
                <button class="btn btn-primary" type="submit">Salvar</button>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/categorias">Cancelar</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
