package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AtualizaFilmeController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// captura os parametros passados
		Object strFilmes = request.getParameter("txtListaIds");
		Object filme = request.getParameter("txtFilme");
		Object nacionalidade = request.getParameterValues("CbNacionalidade") != null ? request.getParameterValues("CbNacionalidade")[0] : null;
		Object copias = request.getParameter("txtCopias");
		Object nome_categoria = request.getParameterValues("CbCategoria") != null ? request.getParameterValues("CbCategoria")[0] : null;
		String[] generos = request.getParameterValues("select2");
		
		model.Operador Operador = new model.Operador();
		try {
			
			Operador.atualizaFilme(strFilmes, filme, nacionalidade, copias, nome_categoria, generos); // atualiza o filme
			request.getRequestDispatcher("peseditfilme.jsp").forward(request, response); // retorna para página de edição
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			
		}
	
		
	}

}
