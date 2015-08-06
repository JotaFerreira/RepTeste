<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap.min.css" media="screen">
<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap-responsive.min.css">

<script type="text/javascript" src="/Locadora/Bootstrap/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/Locadora/Bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">

function removeFilme(e)
{
	
$(e).closest('tr').remove();
setIDs();
calculaTotal();
	
}

function calculaTotal(){
	
	var colunaPrecos = $("tr").find("td:eq(4)");
	var precos= colunaPrecos.text().trim().replace(/\t/g, ';');
	precos = precos.split(";");
	var total = 0;
	
	for(i=0; i <= precos.length-1;i++){
		
		if(isNaN(precos[i].replace('.',',')) == true){
			
			total += parseFloat(precos[i]);
			
		}
		
	}
		
	$("#txtTotal").val("R$ " + total);	
		
}

function setIDs(){
	
	var selectedElements = $("tr").find("td:eq(0)");
	var ids= selectedElements.text().trim().replace(/\t/g, ';');
	ids = ids.split(";");
	
	 var idsFix = new Array();
	  for(var i = 0; i< ids.length; i++){
	      if (ids[i]){
	        idsFix.push(ids[i].trim().replace(',',''));
	    }
	  }
	
	$("#txtIDs").val(idsFix);
	
}

</script>


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Preview da Locação</title>
</head>
<body>

<form class="well" id="formulario" action="SolicitarLocacaoController" name="formulario" method="POST">

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
<input type="hidden" id="txtIDs" name="txtIDs" value="<%=request.getParameter("txtCarrinho")%>">

		<table class="table table-bordered table-condensed" id="tablePreview">
			<tr>
	
				<th style="text-align: center ; Display:none">ID</th>
				<th style="text-align: center">Filme</th>
				<th style="text-align: center">Nacionalidade</th>
				<th style="text-align: center">Categoria</th>
				<th style="text-align: center">Preço da Diária</th>
				<th style="text-align: center">#</th>

			</tr>

				<%
					model.Filme Filme = new Filme();
					Categoria Categoria = new Categoria();
					String ids = request.getParameter("txtCarrinho");
				
					try {

						
						List dados = Filme.getFilmesPorIDs(ids);

							for (int i = 0; i <= dados.size()-1; i++) {

								Map obj = (Map) dados.get(i);
								String nacionalidade = obj.get("NACIONALIDADE").toString();
								Categoria.setNome(obj.get("CATEGORIA").toString());
				%>

				<tr>

					<td style="text-align: center; Display: none">
						<%
							out.print(obj.get("ID"));
						%>
					</td>

					<td style="text-align: center">
						<%
							out.print(obj.get("FILME"));
						%>
					</td>

					<td style="text-align: center">
					
						 <%if(nacionalidade.toLowerCase().equals("brasil")){ %>
			               
			               <img alt="" src="<%=request.getContextPath()%>/Imagens/brasil.jpg" width="42" height="42"> 
			               
			              <% }if(nacionalidade.toLowerCase().equals("eua")){ %>
			                
			                <img alt="" src="<%=request.getContextPath()%>/Imagens/usa.jpg" width="42" height="42"> 
			               
			              <% }if(nacionalidade.toLowerCase().equals("europa")){ %>
			                
			                <img alt="" src="<%=request.getContextPath()%>/Imagens/europa.jpg" width="42" height="42"> 
			               
			              <%}
					
					%>
					</td>
					<td bgcolor="<%=Categoria.getCor()%>">
						<%
						
						%>
					</td>

					<td style="text-align: center">
						<%
							out.print(obj.get("PRECO"));
						%>
					</td>
					
					<td style="text-align: center">
						
						<input class="btn btn-warning" type="button" onclick="removeFilme(this);return false;" value="Remover" name="btnRemover" id="btnRemover">
						
					</td>
			
				</tr>

				<%					}

					}

					catch (Exception e) {

						e.printStackTrace();
					}
				%>

		</table>
		<br><br>
		
		<span class="label label-important">Valor Total da Diária:</span>
		<input type="text" style="width:60px" disabled id="txtTotal" name="txtTotal" value="R$ <%=Filme.getTotalDiaria(request.getParameter("txtCarrinho"))%>">
		
		<br><br>
		<div align="center">
		<input class="btn btn-info" type="submit" value="Confimar e Continuar" onclick="setIDs()" name="btnConfirmar" id="btnConfirmar">
		</div>
		
</form>


</body>
</html>