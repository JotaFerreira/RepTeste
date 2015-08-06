package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AutenticacaoController extends HttpServlet {

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		if (request.getParameter("btnLogar") != null) {

			String login = request.getParameter("txtLogin");
			String senha = request.getParameter("txtPass");
			model.Usuario User = new model.Usuario();

			try {

				boolean autenticado = User.autenticado(login, senha);

				if (autenticado) { // verifica se o usuário tem acesso ao sistema

					String role = User.getRole(login);

					if (role.equals("cliente")) { // verifica se ele é um cliente
						
						request.getSession().setAttribute("user",login); // atribui seu login a sessão
						request.getSession().setAttribute("role","cliente"); // atribui seu privilegio a sessão
						request.getRequestDispatcher("homecliente.jsp") // leva até a página inicial do cliente
								.forward(request, response);
						return;

					}

					else if (role.equals("operador")) {

						request.getSession().setAttribute("user",login);  // atribui seu login a sessão
						request.getSession().setAttribute("role","operador"); // atribui seu privilegio a sessão
						request.getRequestDispatcher("homeoperador.jsp") // leva até a página inicial do operador
								.forward(request, response);
						return;

					}

				}

				else {

					request.setAttribute("msg", "Usuário ou senha incorreto(s)"); // caso o usuário não esteja autenticado será mostrado uma mensagem de erro
					request.getRequestDispatcher("home.jsp").forward(request,
							response);
					return;

				}

			} catch (SQLException e) {

				e.printStackTrace();
				return;

			}

		}

	}

}
