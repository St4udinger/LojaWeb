package br.com.dao;

import br.com.model.Usuario;
import br.com.util.ConnectionFactory;

import java.sql.*;

/**
 * DAO responsável pelas operações de banco de dados do usuário.
 *
 * SQL para criar a tabela (execute uma vez no MySQL):
 * -------------------------------------------------------
 * CREATE TABLE IF NOT EXISTS usuarios (
 *     id    INT AUTO_INCREMENT PRIMARY KEY,
 *     nome  VARCHAR(100) NOT NULL,
 *     email VARCHAR(150) NOT NULL UNIQUE,
 *     senha VARCHAR(255) NOT NULL
 * );
 * -------------------------------------------------------
 *
 * AVISO DE SEGURANÇA: em produção, use BCrypt ou similar para
 * armazenar a senha de forma segura. Aqui a senha é comparada
 * em texto plano apenas para simplicidade do exemplo.
 */
public class UsuarioDAO {

    /** Insere um novo usuário e retorna o id gerado. */
    public int inserir(Usuario u) {
        String sql = "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)";

        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, u.getNome());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getSenha());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir usuário: " + e.getMessage(), e);
        }
        return -1;
    }

    /** Retorna um usuário pelo e-mail e senha, ou null se não encontrado. */
    public Usuario buscarPorEmailSenha(String email, String senha) {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ?";

        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, senha);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar usuário: " + e.getMessage(), e);
        }
        return null;
    }

    /** Verifica se um e-mail já está cadastrado. */
    public boolean emailJaCadastrado(String email) {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE email = ?";

        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao verificar e-mail: " + e.getMessage(), e);
        }
        return false;
    }

    private Usuario mapear(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        u.setId(rs.getInt("id"));
        u.setNome(rs.getString("nome"));
        u.setEmail(rs.getString("email"));
        u.setSenha(rs.getString("senha"));
        return u;
    }
}