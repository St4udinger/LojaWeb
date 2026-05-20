package br.com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {

    // URL com parâmetros para garantir UTF-8
    private static final String URL = "jdbc:mysql://localhost:3306/lsrWeb?useSSL=false&serverTimezone=America/Sao_Paulo&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "LSR";
    private static final String PASSWORD = "LSR";

    private ConnectionFactory() {
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver do MySQL não encontrado.", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}