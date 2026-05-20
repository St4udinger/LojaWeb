package br.com.servlet;

import br.com.dao.UsuarioDAO;
import br.com.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet de autenticação: processa login e cadastro de usuários.
 * Mapeado em /login via web.xml.
 */
public class LoginServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Se já estiver logado, vai direto para a home
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("usuarioLogado") != null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String acao  = req.getParameter("acao");
        String email = req.getParameter("email");
        String senha = req.getParameter("senha");

        if ("cadastro".equals(acao)) {
            // -------- CADASTRO
            String nome = req.getParameter("nome");

            if (usuarioDAO.emailJaCadastrado(email)) {
                req.setAttribute("erro", "Este e-mail já está cadastrado.");
                req.setAttribute("abaAtiva", "cadastro");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            Usuario novo = new Usuario();
            novo.setNome(nome);
            novo.setEmail(email);
            novo.setSenha(senha);

            usuarioDAO.inserir(novo);

            Usuario criado = usuarioDAO.buscarPorEmailSenha(email, senha);
            criarSessao(req, criado);
            resp.sendRedirect(req.getContextPath() + "/index.jsp");

        } else {
            // -------- LOGIN
            Usuario usuario = usuarioDAO.buscarPorEmailSenha(email, senha);

            if (usuario == null) {
                req.setAttribute("erro", "E-mail ou senha incorretos.");
                req.setAttribute("abaAtiva", "login");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }

            criarSessao(req, usuario);
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        }
    }

    private void criarSessao(HttpServletRequest req, Usuario u) {
        HttpSession session = req.getSession(true);
        session.setAttribute("usuarioLogado", u);
        session.setAttribute("nomeUsuario", u.getNome());
        session.setAttribute("usuarioEmail", u.getEmail());
    }
}