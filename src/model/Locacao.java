package model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class Locacao {

	private int id;
	private double totalDiaria;
	private String rua;
	private int numero;
	private String bairro;
	private String status;
	private String dataLocacao;
	private String dataDevolucao;
	private String cliente;
	private String[] filmes;


	public List getListaLocacoes(String role,String user) { // retorna uma list das locações inseridas no banco, com criterio de usuario

		model.DAO DAO = new model.DAO();
		String filtroRole = role.equals("cliente") ? " WHERE B.CLIENTE ='" + user + "'" : ""; // verifica o privilegio do usuario, caso cliente, a query terá um filtro com seu login do contrario consultará tudo

		return DAO
				.getConsulta("SELECT B.ID,A.NOME AS CLIENTE,DATE(B.DATA_LOCACAO) AS DATA_LOCACAO,coalesce(DATE(B.DATA_DEVOLUCAO),'-') AS DATA_DEVOLUCAO,@DIARIAS:=coalesce((TO_DAYS(DATE(B.DATA_DEVOLUCAO)) - "
						+ "(TO_DAYS(DATE(B.DATA_LOCACAO)))),0) AS NUMERO_DIARIAS,coalesce((E.PRECO * @DIARIAS),0) AS VALOR_LOCACAO,B.STATUS FROM USUARIO AS A "
						+ "JOIN LOCACAO AS B ON A.LOGIN = B.CLIENTE JOIN FILME_LOCACAO AS C ON B.id = C.locacao JOIN FILME AS D ON C.filme = D.id "
						+ "JOIN CATEGORIA AS E ON D.categoria = E.id " + filtroRole + " group by B.ID");

	}

	public List getDetalhesLocacao() { // retorna uma list com os detalhes das locação através do seu id

		model.DAO DAO = new model.DAO();

		return DAO
				.getConsulta("SELECT A.NOME AS FILME,A.NACIONALIDADE,C.NOME AS CATEGORIA,C.PRECO FROM FILME AS A JOIN FILME_LOCACAO AS B ON B.FILME = A.ID "
						+ "JOIN CATEGORIA AS C ON A.CATEGORIA = C.id WHERE B.locacao = "
						+ this.id);

	}

	public double getTotalDiaria() { // retorna o calculo da diara da locacao

		model.DAO DAO = new model.DAO();

		List dados = DAO
				.getConsulta("SELECT SUM(PRECO) as total FROM (SELECT A.NOME AS FILME,A.NACIONALIDADE,C.NOME AS CATEGORIA,C.PRECO AS PRECO FROM FILME AS A JOIN FILME_LOCACAO AS B ON B.FILME = A.ID "
						+ "JOIN CATEGORIA AS C ON A.CATEGORIA = C.id WHERE B.locacao = "
						+ this.id + ") AS X");
		
		
		try {

			Map obj = (Map) dados.get(0);
			this.totalDiaria = Double.parseDouble(obj.get("total").toString());
			
			if(this.totalDiaria >= 1)
			{
			
			return this.totalDiaria;
			
			}
			else{
				
			return 0;	
			
			}
			

		} catch (Exception e) {

			e.printStackTrace();
			return 0;

		}
		
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getRua() { // retorna o nome da rua relacionada a locação
		
		model.DAO DAO = new model.DAO();

		List dados = DAO.getConsulta("select rua from locacao where id = " + this.id);
		
		try {

			Map obj = (Map) dados.get(0);
			this.rua = obj.get("rua").toString();
			return this.rua;

		} catch (Exception e) {

			e.printStackTrace();
			return "";
		}
	}

	public void setRua(String rua) {
		this.rua = rua;
	}

	public int getNumero() { // retorna o numero da rua relacionada a locação
		
		model.DAO DAO = new model.DAO();

		List dados = DAO.getConsulta("select numero from locacao where id = " + this.id);
		
		try {

			Map obj = (Map) dados.get(0);
			this.numero = Integer.parseInt(obj.get("numero").toString());
			return this.numero;

		} catch (Exception e) {

			e.printStackTrace();
			return 0;
		}	
		
	}

	public void setNumero(int numero) {
		this.numero = numero;
	}

	public String getBairro() { // retorna o nome do bairro relacionado a locação
		
		model.DAO DAO = new model.DAO();

		List dados = DAO.getConsulta("select bairro from locacao where id = " + this.id);
		
		try {

			Map obj = (Map) dados.get(0);
			this.bairro = obj.get("bairro").toString();
			return this.bairro;

		} catch (Exception e) {

			e.printStackTrace();
			return "";
		}
		
	}


	public int mudaStatus(String status) throws SQLException // muda o status da locacao
	{
		
		model.DAO DAO = new model.DAO();
		int var = DAO.executarQuery("update locacao set status='" + status + "' where id= " + this.id);
		return var;
			
	}
	
	public void setBairro(String bairro) {
		this.bairro = bairro;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getDataLocacao() { // // retorna a data da locacao relacionada a locação
		
		model.DAO DAO = new model.DAO();

		List dados = DAO.getConsulta("select data_locacao from locacao where id = " + this.id);
		
		try {

			Map obj = (Map) dados.get(0);
			this.dataLocacao = obj.get("data_locacao").toString();
			return this.dataLocacao;

		} catch (Exception e) {

			e.printStackTrace();
			return "";
		}
		
	}
	
	
	public void setDataLocacao(String dataLocacao) {
		this.dataLocacao = dataLocacao;
	}

	public String getDataDevolucao() { // retorna a data de devolucao relacionada a locação
		
		model.DAO DAO = new model.DAO();

		List dados = DAO.getConsulta("select data_devolucao from locacao where id = " + this.id);
		
		try {

			Map obj = (Map) dados.get(0);
			this.dataDevolucao = obj.get("data_devolucao").toString();
			return this.dataDevolucao;

		} catch (Exception e) {

			e.printStackTrace();
			return "";
		}
	}

	public void setDataDevolucao(String dataDevolucao) {
		this.dataDevolucao = dataDevolucao;
	}

	public int encaminhaLocacao() throws SQLException // insere a data de locacao na locacao
	{
	
		model.DAO DAO = new model.DAO();
		int var = DAO.executarQuery("update locacao set data_locacao ='" + this.dataLocacao + "' where id= " + this.id);
		return var;
		
	}
	
	public int retornaLocacao() throws SQLException // insere a data de devolução na locacao
	{
	
		model.DAO DAO = new model.DAO();
		int var = DAO.executarQuery("update locacao set data_devolucao ='" + this.dataDevolucao + "' where id= " + this.id);
		return var;
		
	}
	
	public String getCliente() {
	return cliente;
}

public void setCliente(String cliente) {
	this.cliente = cliente;
}


public String[] getFilmes() {
	return filmes;
}

public void setFilmes(String[] filmes) {
	this.filmes = filmes;
}
	

}
