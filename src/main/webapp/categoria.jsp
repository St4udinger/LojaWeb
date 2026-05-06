<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Loja Web - Cadastro de Categoria</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles.css">
    </head>
    <body>
        <h4>Cadastro de Categorias</h4>
        <form id="form-categoria" action="categoria.jsp" method="post">
            <label>Nome Categoria</label>
            <input type="text" id="nomeCategoria" name="nomeCategoria" required placeholder="Informe o nome da categoria" maxlength="50">

            <label>Descrição</label>
            <textarea name="descricao" rows="8" cols="60" placeholder="Informe a descrição da categoria"></textarea>

            <button type="submit">Cadastrar Categoria</button>
        </form>
        <a href="index.jsp">Voltar</a>
    </body>
</html>