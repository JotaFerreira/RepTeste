package model;

import java.util.List;
import java.util.Map;
import java.sql.ResultSet;

public class Genero {
	
	private int id;
	private String nome;
	
	public List listaGeneros() { // retorna todos os generos inseridos no banco

		try {
			
			model.DAO DAO = new model.DAO();
			List dados = DAO.getConsulta("select nome from genero");
			return dados;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;

		}

	}

	public int getId() { // retorna o id de determinada categoria
		
		model.DAO DAO = new model.DAO();
		List dados = DAO.getConsulta("select id from genero where nome ='"
				+ this.nome + "'");

		try {

			Map obj = (Map) dados.get(0);
			this.id = Integer.parseInt(obj.get("id").toString());
			return this.id;

		} catch (Exception e) {

			e.printStackTrace();
			return 0;

		}
		
	}

	public void setId(int id) {
		this.id = id;
	}
	
	
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

}
