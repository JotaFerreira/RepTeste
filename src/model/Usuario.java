package model;

import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class Usuario {

	public boolean autenticado(String login, String senha) throws SQLException { // verifica se o usuário tem cadastro no sistema

		model.DAO DAO = new model.DAO();
		String var = "select * from usuario where login ='" + login + "' and senha = '" + senha + "'";
		List dados = DAO.getConsulta("select * from usuario where login ='" + login + "' and senha = '" + senha + "'"); // consulta no banco as informações passadas pelo usuario

		if (dados.size() == 1) { // se o valor for maior que 1, é porque o usuario tem cadastro no sistema

			return true;

		}

		else {

			return false;

		}

	}

	public String getRole(String login) throws SQLException { // retorna o privilegio do usuario através do seu login

		model.DAO DAO = new model.DAO();
		List dados = DAO.getConsulta("select role from role where login = '"+ login + "'");		

		try {
			 Map obj = (Map)dados.get(0);
				return obj.get("role").toString();
		} catch (Exception e) {

			e.printStackTrace();
			return "";

		}

	}
}
