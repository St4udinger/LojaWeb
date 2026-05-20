package br.com.servlet;

import br.com.dao.UsuarioDAO;
import br.com.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class CadastroServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("abaAtiva", "cadastro");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String nome = req.getParameter("nome");
        String email = req.getParameter("email");
        String senha = req.getParameter("senha");

        if (nome == null || nome.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                senha == null || senha.trim().isEmpty()) {
            req.setAttribute("erro", "Preencha todos os campos.");
            req.setAttribute("abaAtiva", "cadastro");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        if (usuarioDAO.emailJaCadastrado(email)) {
            req.setAttribute("erro", "Esse e-mail já está cadastrado.");
            req.setAttribute("abaAtiva", "cadastro");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        Usuario u = new Usuario();
        u.setNome(nome.trim());
        u.setEmail(email.trim().toLowerCase());
        u.setSenha(senha);

        usuarioDAO.inserir(u);

        HttpSession session = req.getSession(true);
        session.setAttribute("usuarioLogado", u);
        session.setAttribute("nomeUsuario", u.getNome());
        session.setAttribute("usuarioEmail", u.getEmail());

        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}