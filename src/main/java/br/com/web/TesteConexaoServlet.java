package br.com.web;

import br.com.util.ConnectionFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/teste-conexao")
public class TesteConexaoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try (Connection conn = ConnectionFactory.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Teste de Conexão</title>");
                out.println("<style>body{font-family:Arial,sans-serif;padding:40px;background:#f5f7fb} .box{max-width:680px;margin:0 auto;background:#fff;padding:28px;border-radius:14px;box-shadow:0 12px 30px rgba(0,0,0,.08)} .ok{color:#0a7a37}</style>");
                out.println("</head><body><div class='box'><h1 class='ok'>Conexão com o banco realizada com sucesso!</h1>");
                out.println("<p>O projeto conseguiu acessar o MySQL corretamente.</p>");
                out.println("<p><a href='" + request.getContextPath() + "/'>Ir para o menu principal</a></p></div></body></html>");
            } else {
                out.println("<h1>Falha na conexão.</h1>");
                out.println("<p>A conexão retornou nula ou fechada.</p>");
            }
        } catch (SQLException e) {
            out.println("<h1>Erro ao conectar com o banco.</h1>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace();
        }
    }
}
