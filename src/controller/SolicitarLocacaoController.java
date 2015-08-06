package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SolicitarLocacaoController extends HttpServlet {

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		if (request.getParameter("btnSolicitar") != null) {

			try {
				
				// gera uma locação e redireciona para pagina de confirmação
				String rua = request.getParameter("txtRua");
				String numero = request.getParameter("txtNumero");
				String bairro = request.getParameter("txtBairro");
				String user = request.getParameter("txtUser");
				String ids = request.getParameter("txtIDs").toString();
				String[] filmes = ids.split(",");
				model.Cliente Cliente = new model.Cliente();				
				Cliente.solicitaLocacao(rua, numero, bairro, user, filmes);
				response.sendRedirect("confirmacaoloc.jsp");
				
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}

		else {

			request.getRequestDispatcher("formulariosolicitacao.jsp").forward(
					request, response);

		}

	}

}
