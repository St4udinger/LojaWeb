<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Loja Web - Cadastro de Produto</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
</head>
<body>
<h4>Cadastro de Produtos</h4>
<form id="form-categoria" action="produtos.jsp" method="post">
    <label>Nome Produto</label>
    <input type="text" id="nomeProduto" name="nomeProduto" required placeholder="Informe o nome do produto" maxlength="50">

    <label>Estoque</label>
    <textarea name="estoqueProduto" rows="8" cols="60" placeholder="Informe o estoque do produto"></textarea>

    <label>Preço</label>
    <textarea name="precoProduto" rows="8" cols="60" placeholder="Informe o preço do produto"></textarea>


    <button type="submit">Cadastrar Categoria</button>
</form>
<a href="index.jsp">Voltar</a>
</body>
</html>