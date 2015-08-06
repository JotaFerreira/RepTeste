package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PesquisaFilmeController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pesquisar = request.getParameter("btnPesquisar");
		
		if(pesquisar != null)
		{
			
		// retorna no request a list de filme obtidas na consulta	
		String filme = request.getParameter("txtFilme");
		String categoria = request.getParameter("CbCategoria");
		String nacionalidade = request.getParameter("CbNacionalidade");
		String genero = request.getParameter("select1");
		
		model.Filme Filme = new model.Filme();
		Filme.setNome_filme(filme);
		Filme.setCategoria(categoria);
		Filme.setNacionalidade(nacionalidade);
		Filme.setGenero(genero);
		List resultPesquisa = Filme.getPesquisaFilmes(filme, categoria, nacionalidade, genero);
		
		request.setAttribute("dadosPesquisa",resultPesquisa);
		request.getRequestDispatcher("pesquisafilme.jsp").forward(request,response);
		
		}
		
		else{
			
			request.getRequestDispatcher("previewlocacao.jsp").forward(request,response);
			
		}
		
	}

}
