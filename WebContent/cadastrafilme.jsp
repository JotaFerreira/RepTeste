<%@page import="model.Filme"%>
<%@ page import="java.util.*" %>
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

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cadastro de Filme</title>

<script type="text/javascript">
	function validarForm() {

		var filme = document.forms["formulario"]["txtFilme"].value;
		var copias = document.forms["formulario"]["txtCopias"].value;
		
		$('#select2 option').prop('selected', true);

		if (filme == null || filme == "") {
			alert("O NOME DO FILME é obrigatório");
			return false;
		}

		if (copias == null || copias == "" || copias <= 0) {
			alert("O NUMERO DE COPIAS é obrigatório");
			return false;
		}
		
		if( $('#select2').has('option').length <= 0 ){
			
			alert("Selecione um GENERO para o filme");
			return false;			
			
		}

	}
		
</script>

<script type="text/javascript">

$().ready(function() {  
	 $('#add').click(function() {  
	  return !$('#select1 option:selected').remove().appendTo('#select2');  
	 });  
	 $('#remove').click(function() {  
	  return !$('#select2 option:selected').remove().appendTo('#select1');  
	 });  
	}); 

</script>

</head>
<body>

	<form class="well" name="formulario" onsubmit="return validarForm()" action="CadastraFilmeController"
		 method="POST">
		 
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
      <div align="center"><h1>Cadastro de Filmes</h1></div>

		<div class="form-group" align="center">
			<br> <br> <span>Nome<br></span><input type="text"
				placeholder="Digite o nome do filme" name="txtFilme"><br>
			<br> <span>Nacionalidade<br></span><select name="CbNacionalidade">
				<option value="brasil">Brasil</option>
				<option value="eua">EUA</option>
				<option value="europa">Europa</option>
			</select> <br> <br> <span>Copias<br></span>
			<input name="txtCopias" placeholder="Digite o número de cópias">* <br> <br>

			<span>Categoria<br></span> <select name="CbCategoria">
				<%
					try {

						model.Categoria Categoria = new model.Categoria();
						List temp = Categoria.listaCategorias();
						
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

			</select> <br> <br>
			<table>
				<tr>
					<td><span>Generos Disponíveis</span><br><select id="select1" multiple="multiple">
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

					</select> </td>
					<td>
					<input class="btn btn-warning btn-xs" type="button" id="add" value=">>"> 
					<br>
					<input class="btn btn-warning btn-xs" type="button" id="remove" value="<<">					
					</td>
								
			<td><span>Genero(s) do Filme</span><br>
			 <select id="select2" name="select2" multiple="multiple"></select></td></tr>				
			</table>
			<br>
			<br><input class="btn btn-success btn-lg" type="submit"
				value="Cadastrar Filme" name="btnCadastrar"><br><br>

			<a link href="homeoperador.jsp" class="btn btn-info">Voltar</a>

		</div>

	</form>

</body>
</html>