<%@ page import="java.util.*"%>
<%@ page language="java" import="java.sql.*"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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

<script type="text/javascript">
	//Script para habilitar e desabilitar os controles de acordo com a checkbox

	$(document).ready(function() {

		// Habilita ou desabilita os controles na página

		$('#altNome').change(function() {

			$("#txtFilme").prop("disabled", !$(this).is(':checked'));

		});

		$('#altNacionalidade').change(function() {

			$("#CbNacionalidade").prop("disabled", !$(this).is(':checked'));

		});

		$('#altCopias').change(function() {

			$("#txtCopias").prop("disabled", !$(this).is(':checked'));

		});

		$('#altCategoria').change(function() {

			$("#CbCategoria").prop("disabled", !$(this).is(':checked'));

		});

		$('#altGenero').change(function() {

			$("#select1").prop("disabled", !$(this).is(':checked'));
			$("#select2").prop("disabled", !$(this).is(':checked'));
			$("#add").prop("disabled", !$(this).is(':checked'));
			$("#remove").prop("disabled", !$(this).is(':checked'));

		});

	});
</script>

<script type="text/javascript">
	function validarForm() {

		var filme = document.forms["formulario"]["txtFilme"].value;
		var copias = document.forms["formulario"]["txtCopias"].value;

		if (filme == null || filme == "") {
			alert("O NOME DO FILME é obrigatório");
			return false;
		}

		if (copias == null || copias == "" || copias <= 0) {
			alert("O NUMERO DE COPIAS é obrigatório");
			return false;
		}

		if ($('#select2').has('option').length <= 0) {

			alert("Selecione um GENERO para o filme");
			return false;

		}

	}
	
	function selecionaGeneros(){
		
		$('#select2 option').prop('selected', true);
		
	}
	
</script>

<script type="text/javascript">
	$().ready(
			function() {
				$('#add').click(
						function() {
							return !$('#select1 option:selected').remove()
									.appendTo('#select2');
						});
				$('#remove').click(
						function() {
							return !$('#select2 option:selected').remove()
									.appendTo('#select1');
						});
			});
</script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alterar Propriedades de Filme</title>
</head>
<body>

	<form class="well" name="formulario" action="AtualizaFilmeController" method="POST">
	
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
	
		<div class="form-group" align="center">
			<br> <br> 
				<%
				
					int contFilme = Integer.parseInt(request.getAttribute("contChecks").toString());

					if (contFilme > 1) {
						
						%>
						
						<span>Nome<br></span><input type="text"
				placeholder="Digite o nome do filme" name="txtFilme" id="txtFilme"
				disabled><input type="checkbox" id="altNome" name="altNome"></input><br>
			<br> <span>Nacionalidade<br></span> <select
				name="CbNacionalidade" id="CbNacionalidade" disabled>
				<option value="brasil">Brasil</option>
				<option value="eua">EUA</option>
				<option value="europa">Europa</option>
			</select><input type="checkbox" name="altNacionalidade" id="altNacionalidade"></input>
			<br>
			<br> <span>Copias<br></span><input name="txtCopias"
				id="txtCopias" placeholder="Digite o número de cópias" value=0 disabled><input
				type="checkbox" name="altCopias" id="altCopias"></input><br> <br>
			<span>Categoria<br></span> <select name="CbCategoria"
				id="CbCategoria" disabled>
				
				<%

						try {

							model.Categoria Categoria = new model.Categoria();
							List temp = Categoria.listaCategorias();

							for (int i = 0; i <= temp.size() - 1; i++) {
								Map obj = (Map) temp.get(i);
				%>


				<option value=<%out.print(obj.get("nome"));%>>
					<%
						out.print(obj.get("nome"));
					%>
				</option>

				<%
					}

						} catch (Exception e) {
							e.printStackTrace();
						}
				%>

			</select><input type="checkbox" name="altCategoria" id="altCategoria"></input><br>
			<br>

						<table>
				<tr>
					<td><span>Generos Disponíveis</span><br><select id="select1" multiple="multiple" disabled>
							<%
								try {

									model.Genero Genero = new model.Genero();
									List temp = Genero.listaGeneros();

									for (int i = 0; i <= temp.size() - 1; i++) {
										 Map obj = (Map)temp.get(i);
							%>


							<option value=<%out.print(obj.get("nome"));%>>
								<%
									out.print(obj.get("nome"));
								%>
							</option>


							<%
								}

								} catch (Exception e) {
									e.printStackTrace();
								}
							%>

					</select></td>
					<td>
					<input class="btn btn-warning btn-xs" type="button" id="add" value=">>" disabled> 
					<br>
					<input class="btn btn-warning btn-xs" type="button" id="remove" disabled value="<<">					
					</td>
								
			<td><span>Genero(s) do Filme</span><br>
			 <select id="select2" name="select2" multiple="multiple" disabled></select>
			  <input type="checkbox" name="altGenero" id="altGenero"></input></td>
			  </tr>				
			</table>
			
			<% }
					
					else{
						
						int idFilme = Integer.parseInt(request.getAttribute("listaIDs").toString().trim());
						model.Filme Filme = new model.Filme(idFilme);
						String cat = Filme.getCategoria();
						int copias = Filme.getCopias();
						String nomeFilme = Filme.getNome_Filme();
						String nacionalidadeFilme = Filme.getNacionalidade();
						String[] nacionalidades = {"Brasil","EUA","Europa"};
						List generos = Filme.getGeneros();
						List generosNaoAtribuidos = Filme.getGenerosNaoAtribuidos();
						
						%>
						
						<span>Nome<br></span><input type="text"
				placeholder="Digite o nome do filme" name="txtFilme" id="txtFilme" value="<%=nomeFilme%>" disabled>
				<input type="checkbox" id="altNome" name="altNome"></input><br>
			<br> <span>Nacionalidade<br></span> 
			<select
				name="CbNacionalidade" id="CbNacionalidade" disabled>
				<%
				for(int i =0;i<=nacionalidades.length-1;i++)
				{
					
					if(nacionalidadeFilme.equals(nacionalidades[i].toLowerCase()))
					{
						%>
						
						<option value="<%=nacionalidades[i]%>" selected><%=nacionalidades[i]%></option>
						
						<%				
						
					}
					
					else{
						
						%>
						
						<option value="<%=nacionalidades[i]%>"><%=nacionalidades[i]%></option>
						
						<%	
						
					}
					
				}		
				
				%>

			</select>
			<input type="checkbox" name="altNacionalidade" id="altNacionalidade"></input>
			<br>
			<br> <span>Copias<br></span><input name="txtCopias"
				id="txtCopias" placeholder="Digite o número de cópias" value="<%=copias%>" disabled><input
				type="checkbox" name="altCopias" id="altCopias"></input><br> <br>
			<span>Categoria<br></span> <select name="CbCategoria"
				id="CbCategoria" disabled>
				
				<%
						
						try {

							model.Categoria Categoria = new model.Categoria();
							List temp = Categoria.listaCategorias();

							for (int i = 0; i <= temp.size() - 1; i++) {
								Map obj = (Map)temp.get(i);
								String categoria = obj.get("nome").toString();
								String select = "";
								
								if(categoria.equals(cat))
								{
								
									select = " selected";
									
								}
								
				%>


				<option value=<%=categoria%> <%=select%> >
					<%
						out.print(obj.get("nome"));
					%>
				</option>

				<%
					}

						} catch (Exception e) {
							e.printStackTrace();
						}
				%>

			</select>
			
			<input type="checkbox" name="altCategoria" id="altCategoria"></input><br>
			
			</tr>
		
			
			<br>

			<table>
				<tr>
					<td><span>Generos Disponíveis</span><br>
					<select name="select1" id="select1" multiple="multiple" disabled>
							<%
								try {


										for (int i = 0; i <= generosNaoAtribuidos.size() - 1; i++) {

											Map obj = (Map) generosNaoAtribuidos.get(i);
							%>

							<option value=<%out.print(obj.get("genero"));%>>
								<%
									out.print(obj.get("genero"));
								%>
							</option>

							<%
								}

									} catch (Exception e) {
										e.printStackTrace();
									}		
				
				
							%>

					</select></td>
					<td><input class="btn btn-warning btn-xs" type="button"
						id="add" value=">>" disabled> <br> <input
						class="btn btn-warning btn-xs" type="button" disabled id="remove"
						value="<<"></td>

					<td><span>Genero(s) do Filme</span><br>
					<select id="select2" name="select2" multiple disabled>
					
					
					<%
								try {


										for (int i = 0; i <= generos.size() - 1; i++) {

											Map obj = (Map)generos.get(i);
							%>

							<option value=<%out.print(obj.get("genero"));%>>
								<%
									out.print(obj.get("genero"));
								%>
							</option>

							<%
										}	

									} catch (Exception e) {
										e.printStackTrace();
									}	
					
					%>
					</select>
					<input type="checkbox" name="altGenero" id="altGenero"></input></td>
			</tr>
		</table>
					<%
					
					}
									
							%>
									
					
			<br> <br>
			<input class="btn btn-success btn-lg" onclick="selecionaGeneros()" type="submit" value="Alterar Propriedades" name="btnAlterar">
					<br><input type="hidden" value="<%=request.getAttribute("listaIDs")%>" name="txtListaIds"> <br><br>
				 <br>
			<br>

		</div>
	</form>
</body>
</html>