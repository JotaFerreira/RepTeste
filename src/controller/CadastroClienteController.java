package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastroClienteController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String nome = request.getParameter("txtNome");
		String login = request.getParameter("txtLogin");
		String senha = request.getParameter("txtPass");
		
		model.Cliente Cliente = new model.Cliente(login,nome,senha);
		try {
			Cliente.cadastrarse(); // cadastra o cliente no banco
			request.getRequestDispatcher("CadastroSucess.jsp").forward(request, response); // mostra a página de confirmação
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
	}

}
