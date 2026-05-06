package br.com.web;

import br.com.dao.CategoriaDAO;
import br.com.dao.ProdutoDAO;
import br.com.model.Categoria;
import br.com.model.Produto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/produtos")
public class ProdutoServlet extends HttpServlet{

    private static final long serialVersionUID = 1L;

    private final ProdutoDAO produtoDAO = new ProdutoDAO();
    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");

        if (acao == null || acao.equals("listar")) {
            listar(request, response);
            return;
        }

        switch (acao) {
            case "novo":
                abrirCadastro(request, response);
                break;
            case "editar":
                abrirEdicao(request, response);
                break;
            case "excluir":
                excluir(request, response);
                break;
            default:
                listar(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        request.setCharacterEncoding("UTF-8");

        String idProduto = request.getParameter("idProduto");
        String idCategoria = request.getParameter("idCategoria");
        String nomeProduto = request.getParameter("nomeProduto");
        String precoProduto = request.getParameter("precoProduto");
        String estoqueProduto = request.getParameter("estoqueProduto");

        Produto produto = new Produto();
        if (idProduto != null && !idProduto.isBlank()) {
            produto.setIdProduto(Integer.valueOf(idProduto));
        }
        produto.setIdCategoria(Integer.valueOf(idCategoria));
        produto.setNomeProduto(nomeProduto);
        produto.setPrecoProduto(Double.valueOf(precoProduto));
        produto.setEstoqueProduto(Double.valueOf(estoqueProduto));

        if (idProduto == null || idProduto.isBlank()) {
            produtoDAO.inserir(produto);
        } else {
            produto.setIdProduto(Integer.parseInt(idProduto));
            produtoDAO.atualizar(produto);
        }

        response.sendRedirect(request.getContextPath() + "/produtos");
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Produto> produtos = produtoDAO.listar();

        request.setAttribute("listaProdutos", produtos);
        request.getRequestDispatcher("/WEB-INF/views/produto-consulta.jsp").forward(request, response);
    }

    private void abrirCadastro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        carregarCategorias(request);
        request.setAttribute("produto", new Produto());
        request.getRequestDispatcher("/WEB-INF/views/produto-form.jsp").forward(request, response);
    }

    private void abrirEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Produto produto = produtoDAO.buscarPorId(id);
        carregarCategorias(request);
        request.setAttribute("produto", produto);
        request.getRequestDispatcher("/WEB-INF/views/produto-form.jsp").forward(request, response);
    }

    private void carregarCategorias(HttpServletRequest request) {
        List<Categoria> categorias = categoriaDAO.listar();
        request.setAttribute("listaCategorias", categorias);
    }

    private void excluir(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        produtoDAO.excluir(id);
        response.sendRedirect(request.getContextPath() + "/produtos");
    }
}