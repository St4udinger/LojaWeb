package br.com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Filtro de autenticação: intercepta todas as requisições e redireciona
 * para a página de login caso o usuário não esteja autenticado.
 */
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String ctx = req.getContextPath();

        // Recursos liberados sem login
        boolean isAuthPage = uri.equals(ctx + "/login.jsp")
                || uri.equals(ctx + "/")
                || uri.equals(ctx + "/login")
                || uri.equals(ctx + "/cadastro");

        boolean isStaticAsset = uri.startsWith(ctx + "/css/")
                || uri.startsWith(ctx + "/js/")
                || uri.startsWith(ctx + "/img/")
                || uri.startsWith(ctx + "/fonts/")
                || uri.startsWith(ctx + "/assets/")
                || uri.startsWith(ctx + "/webjars/");

        if (isAuthPage || isStaticAsset) {
            chain.doFilter(request, response);
            return;
        }

        // Verifica sessão
        HttpSession session = req.getSession(false);
        boolean logado = (session != null && session.getAttribute("usuarioLogado") != null);

        if (logado) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(ctx + "/login.jsp");
        }
    }

    @Override
    public void init(FilterConfig fc) {}

    @Override
    public void destroy() {}
}