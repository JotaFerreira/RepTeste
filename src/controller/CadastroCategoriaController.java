package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CadastroCategoriaController
 */
public class CadastroCategoriaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String categoria = request.getParameter("txtCategoria");
		String preco = request.getParameter("txtPreco").replace(",",".");
		String cor = request.getParameter("txtCor");
		
		model.Operador Operador = new model.Operador();
		
		try {
			
		Operador.cadastraCategoria(categoria,cor,preco); // cadastra a categoria no banco
		request.getRequestDispatcher("homeoperador.jsp").forward(request, response); // retorna pra pagina inicial do operador
						
		} catch (SQLException e) {
			
			e.printStackTrace();
			
		}
		
	}

}
