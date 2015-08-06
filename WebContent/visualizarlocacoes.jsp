<%@page import="model.Usuario"%>
<%@page import="model.Operador"%>
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
	
	<script type="text/javascript">

function abreDetalhes(element)
{

	var id = $(element).closest('tr').find('td:eq(0)').text().trim();
	
	window.open("<%=request.getContextPath()%>/detalheslocacao.jsp?id=" + id,null,
	"height=400,width=400,status=yes,toolbar=no,menubar=no,location=no");	
	
}

function pegaIDSubmit(element)
{
	
	var id = $(element).closest('tr').find('td:eq(0)').text().trim();	
	$('#txtID').val(id);
	$("#formulario").submit();
	
}

function encaminhar(element)
{

	var id = $(element).closest('tr').find('td:eq(0)').text().trim();
	window.open("<%=request.getContextPath()%>/encaminharfilme.jsp?id=" + id,null,
	"height=200,width=400,status=yes,toolbar=no,menubar=no,location=no");	
	
}

function retornar(element)
{

	var id = $(element).closest('tr').find('td:eq(0)').text().trim();
	window.open("<%=request.getContextPath()%>/retornarfilme.jsp?id=" + id,null,
	"height=200,width=400,status=yes,toolbar=no,menubar=no,location=no");	
	
}


</script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Visualização de Locações</title>
</head>
<body>

<form class="well" id="formulario" name="formulario" action="MudaStatusController" method="POST">

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
      
      <div align="center"><h1>Visualização de Locações</h1></div>
      <br><br>
		<table class="table table-bordered table-condensed" id="tablePesquisa">
		<tbody>
			<tr>
				<th style="text-align: center;Display:None">Id</th>
				<th style="text-align: center">Cliente</th>
				<th style="text-align: center">Data Locação</th>
				<th style="text-align: center">Data Devolução</th>
				<th style="text-align: center">Numero Diárias</th>
				<th style="text-align: center">Valor Locação</th>
				<th style="text-align: center" colspan="6">Status</th>
				<th style="text-align: center">#</th>
			</tr>

				<%
				
				model.Locacao Locacao = new model.Locacao();
				model.Usuario Usuario = new Usuario();
				String user = (String)request.getSession().getAttribute("user");
				String role = Usuario.getRole(user);

					try {

						List dados = Locacao.getListaLocacoes(role,user);

							for (int i = 0; i <= dados.size()-1; i++) {

								Map obj = (Map) dados.get(i);
				%>

				<tr>

					<td style="text-align: center;Display:none">
						<%
							out.print(obj.get("ID"));
						%>
					</td>

					<td style="text-align: center">
						<%
							out.print(obj.get("CLIENTE"));
						%>
					</td>
					<td style="text-align: center">
						<%
							out.print(obj.get("DATA_LOCACAO"));
						%>
					</td>
					<td style="text-align: center">
						<%
							out.print(obj.get("DATA_DEVOLUCAO"));
						%>
					</td>
					<td style="text-align: center">
						<%
							out.print(obj.get("NUMERO_DIARIAS"));
						%>
					</td>

					<td style="text-align: center">
						<%
							out.print("R$ " + obj.get("VALOR_LOCACAO"));
						%>
					</td>
								
						<%
						String status = obj.get("STATUS").toString();
						%>
						
               <td <%if(status.equalsIgnoreCase("Locação Solicitada")){out.print("bgcolor=gray");}; %>>
              <button <%if(role.equals("cliente")){out.print(" disabled ");}; %> onclick="pegaIDSubmit(this)" data-toggle="tooltip" title="Locação Solicitada" name="btn1" value="btn1"> <img name="img1" src="<%=request.getContextPath()%>/Imagens/solicitada_locacao.jpg" width="30" height="30" alt="solicitadaL"> </button>
               </td>
               
                <td <%if(status.equalsIgnoreCase("Locação encaminhada")){out.print("bgcolor=gray");}; %>>
               <button <%if(role.equals("cliente")){out.print(" disabled ");}; %> onclick="encaminhar(this)" data-toggle="tooltip" title="Locação Encaminhada" name="btn2"> <img  src="<%=request.getContextPath()%>/Imagens/encaminhada.jpg" width="30" height="30" alt="encaminhar"></button>
                </td> 
                           
                <td <%if(status.equalsIgnoreCase("Locado")){out.print("bgcolor=gray");}; %>  >
                <button <%if(role.equals("cliente")){out.print(" disabled ");}; %> onclick="pegaIDSubmit(this)" data-toggle="tooltip" title="Locado" name="btn3"><img src="<%=request.getContextPath()%>/Imagens/locado.jpg" width="30" height="30" alt="locado"></button> 
               </td>
  
              <td <%if(status.equalsIgnoreCase("Solicitado retorno")){out.print("bgcolor=gray");};%>>
               <button <%if(!status.equals("Locado") && role.equals("cliente")){out.print(" disabled ");};%> onclick="pegaIDSubmit(this)" data-toggle="tooltip" title="Solicitado Retorno" name="btn4"><img src="<%=request.getContextPath()%>/Imagens/solicitado_retorno.jpg" width="30" height="30" alt="solicitadaR"></button> 
              </td>
             
            <td <%if(status.equalsIgnoreCase("Retornando locação")){out.print("bgcolor=gray");};%>>
             <button <%if(role.equals("cliente")){out.print(" disabled ");}; %> onclick="retornar(this)" name="btn5" data-toggle="tooltip" title="Retornando Locação"><img src="<%=request.getContextPath()%>/Imagens/retornando.jpg" width="30" height="30" alt="retornando"></button> 
            </td>
           
          <td <%if(status.equalsIgnoreCase("Locação encerrada")){out.print("bgcolor=gray");};%>>
           <button <%if(role.equals("cliente")){out.print(" disabled ");}; %> onclick="pegaIDSubmit(this)" name="btn6" data-toggle="tooltip" title="Locação Encerrada"><img src="<%=request.getContextPath()%>/Imagens/encerrada.jpg" width="30" height="30" alt="encerrada"></button> 
          </td>
          
          			<td style="text-align: center">
					
					<input class="btn btn-info" type="button" value="Detalhar" name="btnDetalhar" onclick="abreDetalhes(this)">

					</td>
               
        <%}
                           
               %>
												

				</tr>

				<%
	
					}

					catch (Exception e) {

						e.printStackTrace();

					}
				%>

			</tbody>
		</table>
		<br>
		<div align="center">
		
			<input type="submit" name="btnAtualizar" value="Atualizar" class="btn btn-success"> 
			<br>
			<br>
		
		<%if(role.equals("operador")){
			
			out.print("<a link href=\"homeoperador.jsp\" class=\"btn btn-info\">Voltar</a>");
			
			} else{
			
			out.print("<a link href=\"homecliente.jsp\" class=\"btn btn-info\">Voltar</a>");					
			
		}%>
		
	
		</div>
		
		<input type="hidden" name="txtID" id="txtID">
</form>
</body>
</html>