<%@page import="model.Filme"%>
<%@page import="java.util.*"%>
<%@ page language="java" import="java.sql.*"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap.min.css"
	media="screen">
<link rel="stylesheet"
	href="/Locadora/Bootstrap/css/bootstrap-responsive.min.css">

<script type="text/javascript"
	src="/Locadora/Bootstrap/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript"
	src="/Locadora/Bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						var $checkboxes = $('#formulario td input[type="checkbox"]');

						$checkboxes.change(function() {
							var countCheckedCheckboxes = $checkboxes
									.filter(':checked').length;
							// $('#count-checked-checkboxes').text(countCheckedCheckboxes);

							$('#contChecks').val(countCheckedCheckboxes);

						});

						$('#btnEditar')
								.on(
										'click',
										function() {

											var countCheckedCheckboxes = $checkboxes
													.filter(':checked').length;

											if (countCheckedCheckboxes == 0) {

												alert('Ao menos um filme deve estar selecionado!');	
												return false;

											}
											
											else{
																								
												var checkedRows = $(':checkbox:checked')
												.closest('tr').find('td:eq(0)')
												.map(function() {
													return $(this).html();
												}).get();
												var ids = JSON.stringify(checkedRows);
										$('#valuesFilmes').val(JSON.parse(ids));
												
											}

										});

					});
</script>

<script type="text/javascript">
	function validarForm() {

		var checks = document.forms["formulario"]["contChecks"].value;
		
		if (checks == 0 | checks == null | checks == ""){

			return false;
		
		}
		

	}
</script>

<title>Pesquisar e Editar Filmes</title>

</head>
<body>

	<form class="well" id="formulario" name="formulario" action="PesquisaEditaController" onsubmit="validarForm()" method="POST">
	
	<div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
          <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="brand" <%if (session.getAttribute("role").toString().equals("operador"))
            {%>href="homeoperador.jsp" <%}else{%> href="homecliente.jsp" <%} %> >Locadora</a>
            <div class="nav-collapse collapse">
              <ul class="nav">
                <li class="active"><a <%if (session.getAttribute("role").toString().equals("operador"))
            {%>href="homeoperador.jsp" <%}else{%> href="homecliente.jsp" <%} %>>Inicio</a></li>
                <li><a href="home.jsp">Sair</a></li>
              </ul>
            </div>   
          </div>  
        </div>
      </div>
	<br><br>
		<div align="center">

			<span>Nome:</span><input type="text" placeholder="Nome do filme" name="txtFilme" value=${filme}>
			<span>Categoria:</span>
			<input type="text" placeholder="Nome da categoria" name="txtCategoria" value=${categoria}> 
			<span>Genero:</span>
			<input type="text" placeholder="Nome do genero" name="txtGenero" value=${genero}>
			<input class="btn btn-success" type="submit" value="Filtrar" name="btnFiltrar" id="btnFiltrar">
			<input class="btn btn-warning" type="submit" value="Editar" name="btnEditar" id="btnEditar">

		</div>
		<br> <br>

		<table class="table table-hover" id="tablePesquisa">
			<tr>
				<th style="text-align: center">ID</th>
				<th style="text-align: center">Filme</th>
				<th style="text-align: center">Nacionalidade</th>
				<th style="text-align: center">Categoria</th>
				<th style="text-align: center">Genero(s)</th>
				<th style="text-align: center">#</th>
			</tr>
			<tbody>

				<%
					Filme Filme = new Filme();

					try {

						List dados = null;

						if (request.getAttribute("filtrolista") != null) {

							dados = (List) request.getAttribute("filtrolista");

							for (int i = 0; i <= dados.size() - 1; i++) {

								Map obj = (Map) dados.get(i);
				%>

				<tr class="success">

					<td style="text-align: center">
						<%
							out.print(obj.get("id"));
						%>
					</td>
					<td style="text-align: center">
						<%
							out.print(obj.get("filme"));
						%>
					</td>
					<td style="text-align: center">
						<%
							out.print(obj.get("nacionalidade"));
						%>
					</td>
					<td style="text-align: center">
						<%
							out.print(obj.get("categoria"));
						%>
					</td>

					<td style="text-align: center">
						<%
							out.print(obj.get("genero"));
						%>
					</td>

					<td style="text-align: center"><input type="checkbox">

					</td>

				</tr>

				<%
					}

						}

						else {

							dados = Filme.getListaFilmes();

							for (int i = 0; i <= dados.size() - 1; i++) {

								Map obj = (Map)dados.get(i);
				%>
				<tr class="success">

					<td style="text-align: center">
						<%
							out.print(obj.get("id"));
						%>
					</td>
					<td style="text-align: center">
						<%
							out.print(obj.get("filme"));
						%>
					</td>
					<td style="text-align: center">
						<%
							out.print(obj.get("nacionalidade"));
						%>
					</td>
					<td style="text-align: center">
						<%
							out.print(obj.get("categoria"));
						%>
					</td>

					<td style="text-align: center">
						<%
							out.print(obj.get("genero"));
						%>
					</td>

					<td style="text-align: center"><input type="checkbox">

					</td>

				</tr>

				<%
					}
						}
					}

					catch (Exception e) {

						e.printStackTrace();

					}
				%>

			</tbody>
		</table>
<br>
<div align="center"><a link href="homeoperador.jsp" class="btn btn-info">Voltar</a></div>

		<input type="hidden" name="contChecks" id="contChecks"></input> <input
			type="hidden" name="valuesChecks" id="valuesFilmes"></input>

	</form>

</body>
</html>