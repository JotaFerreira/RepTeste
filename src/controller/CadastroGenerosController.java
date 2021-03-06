package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CadastroGenerosController
 */
public class CadastroGenerosController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String genero = request.getParameter("txtGenero");
		
		try	{
			
			model.Operador Operador = new model.Operador();
			Operador.cadastraGenero(genero); // cadastra o genero no banco
			request.getRequestDispatcher("homeoperador.jsp").forward(request, response); // volta para pagina inicial do operador
		}
		
		catch(Exception e)
		{
			
			e.printStackTrace();
			
		}
		
	}

}
