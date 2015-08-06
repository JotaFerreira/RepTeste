package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MudaStatusController extends HttpServlet {

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String solicitadaLocacao = request.getParameter("btn1");
		String encaminhada = request.getParameter("btn2");
		String locado = request.getParameter("btn3");
		String solicitadoRetorno = request.getParameter("btn4");
		String retornando = request.getParameter("btn5");
		String encerrado = request.getParameter("btn6");
		String encaminharLocacao = request.getParameter("btnEncaminhar");
		String dataLocacao = request.getParameter("txtDataLoc");
		String retornarLocacao = request.getParameter("btnRetornar");
		String dataDevolucao = request.getParameter("txtDataDev");
		String str_id = request.getParameter("txtID");
		String atualizar = request.getParameter("btnAtualizar");
		int id = str_id != "" ? Integer.parseInt(str_id): 0;

		model.Locacao Locacao = new model.Locacao();
		Locacao.setId(id);
		
		// verifica qual a locação foi solicitados para mudança de status e o atualiza.
		// caso não haja nenhum status para alterar, a página será atualizada

		if (solicitadaLocacao != null) {

			try {
				Locacao.mudaStatus("Locação solicitada");
				request.getRequestDispatcher("visualizarlocacoes.jsp").forward(request,
						response);
			} catch (SQLException e) {

				e.printStackTrace();
			}

		}


		else if (locado != null) {
			try {
				Locacao.mudaStatus("Locado");
				request.getRequestDispatcher("visualizarlocacoes.jsp").forward(request,
						response);
			} catch (SQLException e) {

				e.printStackTrace();
			}

		}

		else if (solicitadoRetorno != null) {
			try {
				Locacao.mudaStatus("Solicitado retorno");
				request.getRequestDispatcher("visualizarlocacoes.jsp").forward(request,
						response);
			} catch (SQLException e) {

				e.printStackTrace();
			}

		}

		else if (encerrado != null) {
			try {
				Locacao.mudaStatus("Locação encerrada");
				request.getRequestDispatcher("visualizarlocacoes.jsp").forward(request,
						response);
			} catch (SQLException e) {

				e.printStackTrace();
			}

		}

		else if (encaminharLocacao != null) {

			try {
				Locacao.setDataLocacao(dataLocacao);
				Locacao.mudaStatus("Locação encaminhada");
				Locacao.encaminhaLocacao();
				request.getRequestDispatcher("encaminharfilme.jsp?id=" + id);
				
			} catch (SQLException e) {

				e.printStackTrace();
			}

		}
		
		else if (retornarLocacao != null) {

			try {
				
				Locacao.setDataDevolucao(dataDevolucao);
				Locacao.mudaStatus("Retornando locação");
				Locacao.retornaLocacao();
				request.getRequestDispatcher("confirmacaoencfilme.jsp").forward(request,
						response);	
				
				
			} catch (SQLException e) {

				e.printStackTrace();
			}

		}
		
			
		else{
					
			request.getRequestDispatcher("visualizarlocacoes.jsp").forward(request,
					response);
			
		}


	}

}
