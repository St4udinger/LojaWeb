package br.com.dao;

import br.com.util.ConnectionFactory;
import br.com.model.Item;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    public void inserir(Item item) {
        String sql = "INSERT INTO itens (titulo, tipo, localizacao, descricao) VALUES (?,?,?,?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, item.getTitulo());
            ps.setString(2, item.getTipo());
            ps.setString(3, item.getLocalizacao());
            ps.setString(4, item.getDescricao());
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Item> listarTodos() {
        List<Item> lista = new ArrayList<>();
        String sql = "SELECT * FROM itens ORDER BY data_criacao DESC";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Item i = new Item();
                i.setId(rs.getInt("id"));
                i.setTitulo(rs.getString("titulo"));
                i.setTipo(rs.getString("tipo"));
                i.setLocalizacao(rs.getString("localizacao"));
                i.setDescricao(rs.getString("descricao"));
                i.setDataCriacao(rs.getTimestamp("data_criacao"));
                lista.add(i);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return lista;
    }
}