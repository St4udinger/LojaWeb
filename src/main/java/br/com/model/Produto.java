package br.com.model;

public  class Produto extends Categoria {

    private Integer idProduto;
    private Integer idCategoria;

    private String nomeProduto;
    private Double estoqueProduto;
    private Double precoProduto;

    public Produto() {
    }

    public Produto(Integer idProduto, Integer idCategoria, String nomeProduto, Double estoqueProduto, Double precoProduto) {
        this.idProduto = idProduto;
        this.idCategoria = idCategoria;
        this.nomeProduto = nomeProduto;
        this.estoqueProduto = estoqueProduto;
        this.precoProduto = precoProduto;
    }

    public Integer getIdProduto() { return idProduto;}

    public void setIdProduto(Integer idProduto) { this.idProduto = idProduto;}

    public Integer getIdCategoria() { return idCategoria;}

    public void setIdCategoria(Integer idCategoria) { this.idCategoria = idCategoria;}

    public String getNomeProduto() { return nomeProduto; }

    public void setNomeProduto(String nomeProduto) {this.nomeProduto = nomeProduto;}

    public Double getEstoqueProduto() {return estoqueProduto;}

    public void setEstoqueProduto(Double estoqueProduto) {this.estoqueProduto = estoqueProduto;}

    public Double getPrecoProduto() {return precoProduto;}

    public void setPrecoProduto(Double precoProduto) {this.precoProduto = precoProduto;}

}