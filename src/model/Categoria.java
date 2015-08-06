package model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

public class Categoria {
	
	private int id;
	private String nome;
	private String cor;
	private double preco;
	
	public Categoria()
	{	
	}
	
	public Categoria(String nome_categoria)
	{
		
		this.nome = nome_categoria;
		
	}

	public List listaCategorias() { // retorna uma lista de todas as categorias inseridas no banco

		try {
			
			model.DAO DAO = new model.DAO();
			List dados = DAO.getConsulta("select nome from categoria");
			return dados;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;

		}

	}
	

	public int getId() { // retorna o ID da categoria
		
		model.DAO DAO = new model.DAO();
		List dados = DAO.getConsulta("select id from categoria where nome = '"
				+ this.nome + "'");		

		try {
			 Map obj = (Map)dados.get(0);
			 this.id = Integer.parseInt(obj.get("id").toString());
				return this.id;
		} catch (Exception e) {

			e.printStackTrace();
			return 0;

		}
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCor() { // retorna a cor da categoria
		
		model.DAO DAO = new model.DAO();
		List dados = DAO.getConsulta("select cor from categoria where nome = '"
				+ this.nome + "'");		

		try {
			 Map obj = (Map)dados.get(0);
				return "#" + obj.get("cor").toString();
		} catch (Exception e) {

			e.printStackTrace();
			return "";

		}
	
	}

	public void setCor(String cor) {
		this.cor = cor;
	}

	public double getPreco() { // retornar o preço da categoria
		
		model.DAO DAO = new model.DAO();
		List dados = DAO.getConsulta("select preco from categoria where nome = '"
				+ this.nome + "'");		

		try {
			 Map obj = (Map)dados.get(0);
				return Double.parseDouble(obj.get("preco").toString());
		} catch (Exception e) {

			e.printStackTrace();
			return 0;

		}
		
	}

	public void setPreco(double preco) {
		this.preco = preco;
	}
	
}
