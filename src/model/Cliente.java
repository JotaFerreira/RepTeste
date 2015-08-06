package model;

import java.sql.SQLException;

public class Cliente {

	private String login;
	private String nome;
	private String senha;
	
	public Cliente(){
		
		
	}
	
	public Cliente(String iLogin,String iNome,String iSenha)
	{
		
		this.login = iLogin;
		this.nome = iNome;
		this.senha = iSenha;
		
	}
	
	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public int cadastrarse() throws SQLException {

		model.DAO DAO = new model.DAO();
		int var = DAO
				.executarQuery("insert into usuario(login,senha,nome) values('"
						+ this.login + "','" + this.senha + "','" + this.nome
						+ "')"); // insere no banco o login,senha e nome do usuário
		var += DAO.executarQuery("insert into role(login,role) values('"
				+ this.login + "','cliente')"); // associa o login ao privilégio do usuário
		return var;

	}
	
	public void solicitaLocacao(String rua,String numero,String bairro,String user,String filmes[]) throws SQLException{
		
		model.DAO DAO = new DAO();	
		model.Locacao Locacao = new Locacao();
		
		DAO.executarQuery("insert into locacao(cliente,rua,numero,bairro,status) values('" + user + "','" + 
		rua + "','" + numero + "','" + bairro + "','Locação Solicitada');"); // insere no banco os dados da locação

		for(int i=0;i<= filmes.length-1;i++){	 // inicia um loop nos filme(s) que foram escolhidos para locação

		if(!filmes[i].equals("")){
			
			DAO.executarQuery("insert into filme_locacao(filme,locacao) values(" + filmes[i] 
					+ ",(SELECT MAX(ID) FROM LOCACAO WHERE CLIENTE='" + user + "'))"); // associa o id do filme com o id da locacao
			
		}
			
		}
		
	}

}
