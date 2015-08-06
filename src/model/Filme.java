package model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class Filme {

	private String genero;
	private String categoria;
	private String nome_filme;
	private String nacionalidade;
	private int copias;
	private int id_filme;

	public Filme() {

	}

	public Filme(String nome_filme) {

		this.nome_filme = nome_filme;

	}
	
	
	public Filme(int id_filme) {

		this.id_filme = id_filme;

	}

	public Filme(String nome_filme, String nome_genero) {

		this.nome_filme = nome_filme;
		this.genero = nome_genero;

	}

	public Filme(String nome_filme, String nome_categoria, String nome_genero) {

		this.nome_filme = nome_filme;
		this.categoria = nome_categoria;
		this.genero = nome_genero;

	}

	public List getFiltroFilmes(String filme, String categoria, String genero) { // retorna uma list com os filmes obtidos através de uma query com critérios de pesquisa

		try {
			
			// verifica quais campos estão em branco e contrói parte da query com o criterio de pesquisa
			String f_filme = filme.equals("") ? "" : " and a.nome ='" + filme
					+ "'";
			String f_categoria = categoria.equals("") ? "" : " and b.nome ='"
					+ categoria + "'";
			String f_genero = genero.equals("") ? "" : " and d.nome ='"
					+ genero + "'";
			

			model.DAO DAO = new model.DAO();
			return DAO
					.getConsulta("SELECT @ID:=a.id as id, a.nome AS filme, a.nacionalidade as nacionalidade, b.nome AS categoria, (SELECT GROUP_CONCAT(C.NOME) FROM filme AS a JOIN filme_genero AS b ON a.id = b.filme JOIN genero AS c ON b.genero = c.id WHERE a.id = @ID) AS genero FROM filme a "
							+ "JOIN categoria b ON a.categoria = b.id JOIN filme_genero c on c.filme = a.id "
							+ "JOIN genero as d on c.genero = d.id WHERE 1 = 1 " // o " where 1 =1 serve para adicionar previamente o AND na query
							+ f_filme + f_categoria + f_genero + "  GROUP BY 2");

		} catch (Exception e) {
			e.printStackTrace();
			return null;

		}

	}

	public List getListaFilmes() { // retorna uma lista com todos os filmes inseridos no banco

		try {

			model.DAO DAO = new model.DAO();
			return DAO
					.getConsulta("SELECT @ID:=a.id as id, a.nome AS filme, a.nacionalidade, b.nome AS categoria, (SELECT GROUP_CONCAT(C.NOME) FROM filme AS a JOIN filme_genero AS b ON a.id = b.filme JOIN genero AS c ON b.genero = c.id WHERE a.id = @ID) AS genero FROM filme a "
							+ "JOIN categoria b ON a.categoria = b.id JOIN filme_genero c on c.filme = a.id "
							+ "JOIN genero as d on c.genero = d.id GROUP BY 2");

		} catch (Exception e) {
			e.printStackTrace();
			return null;

		}

	}
	
	
	public List getGeneros() { // retorna uma lista com os generos de um filme usando seu ID

		try {

			model.DAO DAO = new model.DAO();
			return DAO
					.getConsulta("select c.nome as genero from filme as a join filme_genero as b on a.id = b.filme join genero as c on b.genero = c.id "
							+ "where a.id = " + this.id_filme);

		} catch (Exception e) {
			e.printStackTrace();
			return null;

		}

	}
	
	public String getStringGeneros(){ // retorna uma string com os generos de um filme usando seu ID
		
		try {

			model.DAO DAO = new model.DAO();
		List dados= DAO
					.getConsulta("select group_concat(c.nome) as genero from filme as a join filme_genero as b on a.id = b.filme join genero as c on b.genero = c.id "
							+ "where a.id = " + this.id_filme);
		
		Map obj = (Map) dados.get(0);
		return obj.get("genero").toString();

		} catch (Exception e) {
			e.printStackTrace();
			return "";
			
		}
		
		
	}
	
	public List getGenerosNaoAtribuidos() // retorna uma list com os generos que não foram associados a um filme determinado pelo ID
	{
		
		try {

			model.DAO DAO = new model.DAO();
			return DAO
					.getConsulta("select nome as genero from genero where genero.nome not in(SELECT distinct c.nome as genero FROM filme AS a "
							+ "JOIN filme_genero AS b ON a.id = b.filme JOIN genero AS c ON b.genero = c.id WHERE a.id =" + this.id_filme + ")");

			
		} catch (Exception e) {
			e.printStackTrace();
			return null;

		}
			
	}
	
	public int associaFilme_Genero() throws SQLException { // associa o filme ao genero usando seus repectivos id's

		model.DAO DAO = new model.DAO();
		model.Genero Genero = new model.Genero();
		Genero.setNome(this.genero);
		int var = DAO.executarQuery("insert into filme_genero(filme,genero) values("
						+ this.getIDFilme() + "," + Genero.getId() + ")");

		return var;

	}

	public void setId_filme(int id_filme) {
		this.id_filme = id_filme;
	}

	public int getIDFilme() throws SQLException { // retorna o ID do filme atráves do seu nome

		model.DAO DAO = new model.DAO();
		List dados = DAO.getConsulta("select id from filme where nome = '"
				+ this.nome_filme + "'");

		try {

			Map obj = (Map) dados.get(0);
			return Integer.parseInt(obj.get("id").toString());

		} catch (Exception e) {

			e.printStackTrace();
			return 0;

		}

	}

	public int getDiasAdicionado() throws SQLException { // retorna a quantos dias atrás o filme foi adicionado no banco

		model.DAO DAO = new model.DAO();
		List dados = DAO
				.getConsulta("select to_days(date(now())) - to_days(date(data_insercao)) as Dias from filme where id="
						+ this.id_filme);

		try {
			Map obj = (Map) dados.get(0);
			return Integer.parseInt(obj.get("Dias").toString());
		} catch (Exception e) {

			e.printStackTrace();
			return 0;

		}

	}

	public int getCopiasDisponiveis() { // retorna a quantidade de copias disponiveis levando em conta as copias locadas

		model.DAO DAO = new model.DAO();
		List dados = DAO.getConsulta("SELECT (C.COPIAS - COUNT(A.FILME)) AS COPIAS FROM FILME_LOCACAO AS A JOIN LOCACAO AS B ON A.LOCACAO = B.ID JOIN FILME AS C ON C.ID = A.FILME "
				+ "WHERE B.STATUS <> 'LOCAÇÃO ENCERRADA' AND A.FILME = " + this.id_filme);

		try {
			
			Map obj = (Map) dados.get(0);
			this.copias = Integer.parseInt(obj.get("COPIAS").toString());
			return this.copias;
			
		} catch (Exception e) {

			e.printStackTrace();
			return 0;

		}

	}
	
	public int getCopias() { // retorna a quantidade de copias totais do filme

		model.DAO DAO = new model.DAO();
		List dados = DAO.getConsulta("SELECT COPIAS FROM FILME WHERE ID = " + this.id_filme);

		try {
			
			Map obj = (Map) dados.get(0);
			this.copias = Integer.parseInt(obj.get("COPIAS").toString());
			return this.copias;
			
		} catch (Exception e) {

			e.printStackTrace();
			return 0;

		}

	}

	public void setGenero(String genero) {
		this.genero = genero;
	}

	public String getCategoria() { // retorna a categoria do filme
		

		model.DAO DAO = new model.DAO();
		List dados = DAO.getConsulta("SELECT b.nome as categoria FROM filme as a join categoria as b on a.categoria = b.id where a.id ="
				+ this.id_filme);

		try {
			Map obj = (Map) dados.get(0);
			this.categoria = obj.get("categoria").toString();
			return this.categoria;
		} catch (Exception e) {

			e.printStackTrace();
			return "";

		}
		
		
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}

	public String getNome_Filme() { // retorna o nome do filme através do id
		
		model.DAO DAO = new model.DAO();
		List dados = DAO.getConsulta("select nome as filme from filme where id ="
				+ this.id_filme);

		try {
			
			Map obj = (Map) dados.get(0);
			this.nome_filme = obj.get("filme").toString();
			return this.nome_filme;
			
		} catch (Exception e) {

			e.printStackTrace();
			return "";

		}
	}

	public String getNacionalidade() { // retorna a nacionalidade do filme através do seu id

		model.DAO DAO = new model.DAO();
		List dados = DAO.getConsulta("select nacionalidade from filme where id="
				+ this.id_filme);

		try {
			Map obj = (Map) dados.get(0);
			this.nacionalidade = obj.get("nacionalidade").toString();
			return this.nacionalidade;
		} catch (Exception e) {

			e.printStackTrace();
			return "";

		}
			
	}
	
	public List getPesquisaFilmes(String filme, String categoria,String nacionalidade, String genero) { // retorna uma list do filmes inseridos no banco com criterio de pesquisa

		try {
			

			// verifica quais campos estão em branco e contrói parte da query com o criterio de pesquisa
			String f_filme = filme.equals("") ? "" : " and a.nome ='" + filme
					+ "'";
			String f_categoria = categoria.equals("") ? "" : " and b.nome ='"
					+ categoria + "'";
			String f_nacionalidade = nacionalidade.equals("") ? "" : " and a.nacionalidade ='"
					+ nacionalidade + "'";
			String f_genero = genero.equals("") ? "" : " and d.nome ='"
					+ genero + "'";
			

			model.DAO DAO = new model.DAO();
			return DAO
					.getConsulta("SELECT a.id as id, a.nome as filme, a.nacionalidade as nacionalidade, b.nome AS categoria, d.nome as genero FROM filme a "
							+ "JOIN categoria b ON a.categoria = b.id JOIN filme_genero c on c.filme = a.id "
							+ "JOIN genero as d on c.genero = d.id WHERE 1 = 1 " // // o " where 1 =1 serve para adicionar previamente o AND na query
							+ f_filme + f_categoria + f_nacionalidade + f_genero + " GROUP BY 2");
			

		} catch (Exception e) {
			e.printStackTrace();
			return null;

		}

	}
	
	public List getFilmesPorIDs(String ids){ // retorna uma list de filmes através de vários ids
		
		model.DAO DAO = new model.DAO();
		ids = ids.replace(";",",");
		
		return DAO
				.getConsulta("SELECT a.id as ID, a.nome as FILME, a.nacionalidade as NACIONALIDADE, b.nome AS CATEGORIA, b.preco as PRECO FROM filme a "
						+ "JOIN categoria b ON a.categoria = b.id JOIN filme_genero c on c.filme = a.id "
						+ "JOIN genero as d on c.genero = d.id WHERE a.id in (" + ids + ") GROUP BY 2");		

	}
	
public double getTotalDiaria(String ids){ // retorna o calculo da diária da locação através de varios ids
	
	model.DAO DAO = new model.DAO();

	ids = ids.replace(";",","); 
	List dados = DAO.getConsulta("SELECT SUM(A.PRECO) AS PRECO FROM CATEGORIA AS A JOIN FILME AS B ON A.id = B.categoria WHERE B.ID IN (" 
	+ ids + ")");

	try {
		Map obj = (Map) dados.get(0);
		double var = Double.parseDouble(obj.get("PRECO").toString());
		return var;
	} catch (Exception e) {

		e.printStackTrace();
		return 0;

	}
		
}

	
	public String getNome_filme() {
		return nome_filme;
	}

	public void setNome_filme(String nome_filme) {
		this.nome_filme = nome_filme;
	}

	public int getId_filme() {
		return id_filme;
	}

	public void setNacionalidade(String nacionalidade) {
		this.nacionalidade = nacionalidade;
	}

	public void setCopias(int copias) {
		this.copias = copias;
	}
	
}
