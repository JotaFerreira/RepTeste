package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Categoria;

public class CadastraFilmeController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String filme = request.getParameter("txtFilme");
		String nacionalidade = request.getParameterValues("CbNacionalidade")[0];
		int copias = Integer.parseInt(request.getParameter("txtCopias"));
		String nome_categoria = request.getParameterValues("CbCategoria")[0];
		String[] generos = request.getParameterValues("select2");
				
		model.Operador Operador = new model.Operador();
		model.Categoria Categoria = new Categoria(nome_categoria);
		int id_categoria = Categoria.getId();
		
		try {
			Operador.cadastraFilme(filme, nacionalidade,copias, id_categoria); // cadastra o filme no banco
		} catch (SQLException e1) {
			
			e1.printStackTrace();
		}
		
		for(int i = 0; i <= generos.length-1;i++) // faz um loop no generos adicionados pro filme e o associa com seus repectivos ids
		{
			
			try {
				
				model.Filme Filme = new model.Filme(filme,generos[i]);
				Filme.setNome_filme(filme);
				Filme.setGenero(generos[i]);
				Filme.associaFilme_Genero();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
		}
		
		request.getRequestDispatcher("homeoperador.jsp")
		.forward(request, response);
		
	}

}
