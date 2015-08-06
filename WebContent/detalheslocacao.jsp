<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap.min.css"
	media="screen">
<link rel="stylesheet"
	href="/Locadora/Bootstrap/css/bootstrap-responsive.min.css">

<script type="text/javascript"
	src="/Locadora/Bootstrap/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript"
	src="/Locadora/Bootstrap/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<title>Detalhes da Locação</title>
</head>
<body>

<form class="well" id="formulario" name="formulario" method="POST">
		<table class="table table-striped table-hover" id="tablePesquisa">
			<tr>
	
				<th style="text-align: center">Filme</th>
				<th style="text-align: center">Nacionalidade</th>
				<th style="text-align: center">Categoria</th>
				<th style="text-align: center">Preço</th>

			</tr>
			<tbody>

				<%
					model.Locacao Locacao = new model.Locacao();
					Locacao.setId(Integer.parseInt(request.getParameter("id")));
					Double totalDiaria = Locacao.getTotalDiaria();
					String rua = Locacao.getRua();
					int numero = Locacao.getNumero();
					String bairro = Locacao.getBairro();
				
					try {

						List dados = Locacao.getDetalhesLocacao();

							for (int i = 0; i <= dados.size()-1; i++) {

								Map obj = (Map) dados.get(i);
				%>

				<tr class="success">

					<td style="text-align: center">
						<%
							out.print(obj.get("FILME"));
						%>
					</td>

					<td style="text-align: center">
						<%
							out.print(obj.get("NACIONALIDADE"));
						%>
					</td>
					<td style="text-align: center">
						<%
							out.print(obj.get("CATEGORIA"));
						%>
					</td>

					<td style="text-align: center">
						<%
							out.print(obj.get("PRECO"));
						%>
					</td>
			
				</tr>

				<%
					}


					}

					catch (Exception e) {

						e.printStackTrace();

					}
				%>

			</tbody>
		</table>
		<br><br>
		
		<span class="label label-info">Rua:<%=rua%></span><br>
		<span class="label label-info">Número:<%=numero%></span><br>
		<span class="label label-info">Bairro:<%=bairro%></span><br>
		<span class="label label-important">Total da Diária:<%=totalDiaria%></span>
</form>

</body>
</html>