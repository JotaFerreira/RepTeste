package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PesquisaEditaController extends HttpServlet {

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		int checks = 0;
		
		// retorna a list com os filmes encontrados na busca
		
		if (request.getParameter("btnFiltrar") != null) {

			String filme = request.getParameter("txtFilme");
			String categoria = request.getParameter("txtCategoria");
			String genero = request.getParameter("txtGenero");
			
			model.Filme Filme = new model.Filme();
			List filtroLista = Filme.getFiltroFilmes(filme, categoria, genero);
			List listaFilmesCompleta = Filme.getListaFilmes();
			
			try {

				// atribui os valores da consulta no request para serem devolvidos a seus repectivos campos na pagina
				request.setAttribute("filtrolista", filtroLista);
				request.setAttribute("filme", filme);
				request.setAttribute("categoria", categoria);
				request.setAttribute("genero", genero);
				request.getRequestDispatcher("peseditfilme.jsp").forward(
						request, response);

			}

			catch (Exception e) {

				e.printStackTrace();

			}

		}

		// caso tenho sido solicitada a edição de filme
		else if (request.getParameter("btnEditar") != null) {
					
			String strFilmes = request.getParameter("valuesChecks");
			String contChecks = request.getParameter("contChecks");
			strFilmes = strFilmes.replace(" ","");
			strFilmes = strFilmes.replace("[","");
			strFilmes = strFilmes.replace("]","");

			// atribui ao request a lista de ids com os filmes selecionados para edição e a quantidade de filmes selecionados
			request.setAttribute("listaIDs",strFilmes);
			request.setAttribute("contChecks",contChecks);
			request.getRequestDispatcher("alterafilme.jsp").forward(request,response); // redireciona para a pagina de alteração de filme

		}
		

	}

}
