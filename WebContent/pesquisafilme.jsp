<%@page import="model.Filme"%>
<%@page import="model.Categoria"%>
<%@page import="java.util.*" %>
<%@ page language="java" import="java.sql.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap.min.css" media="screen">
<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap-responsive.min.css">

<script type="text/javascript" src="/Locadora/Bootstrap/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/Locadora/Bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">

function adicionarCarrinho(e){
	
	var id = $(e).closest('tr').find('th:eq(0)').text().trim();
	var itensCarrinho = $('#txtCarrinho').val();
	var selectedElements = $("tr").find("th:eq(0)");
	var row_index = $(e).parent().index();
	var col_index = $(e).index();
	$(e).css('background-color', '#228B22');
	
	if(itensCarrinho == null | itensCarrinho == ""){
		
		$('#txtCarrinho').val(id);
		
	}
	
	else{
		
		$('#txtCarrinho').val(itensCarrinho + ";" + id);
		
	}
	
}

function validarFinalizacao(){
	
	var carrinho = $("#txtCarrinho").val();
	
	if(carrinho == null | carrinho == ""){
		
		return false;
		
	}
	else{
		
		//alert(carrinho);
		$("#formulario").submit();
		
	}
	
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Filmes por Genero</title>
</head>
<body>

<form class="well" id="formulario" name="formulario" action="PesquisaFilmeController" method="POST">

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
<span>Nome:</span><input type="text" name="txtFilme" id="txtFilme" placeholder="Digite o nome do filme">
<span>Categoria:</span> <select name="CbCategoria">
<option value=""></option>
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

			</select>
			
			<span>Nacionalidade</span><select name="CbNacionalidade">
				<option value=""></option>
				<option value="brasil">Brasil</option>
				<option value="eua">EUA</option>
				<option value="europa">Europa</option>
			</select>

<span>Genero:</span>
<select name="select1" id="select1">
<option value=""></option>
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

					</select>
					
<input class="btn btn-success" type="submit" value="Pesquisar" name="btnPesquisar" id="btnPesquisar">
<input class="btn btn-danger" type="button" onclick="validarFinalizacao()" value="Finalizar" name="btnFinalizar" id="btnFinalizar">

 </div>
<br>

<span name="spanInfo" id="spanInfo" class="label label-primary"></span>

<table name="tabela" id="tabela" class="table table-striped table-bordered table-condensed" id="tablePesquisa" >  

<tbody>
  
<%    
	Filme Filme = new Filme();
	Categoria Categoria = new Categoria();

   try {  

	  String login = request.getParameter("txtLogin");
      List temp = (List)request.getAttribute("dadosPesquisa");
      
      if(temp == null){
    	  
    	  temp = Filme.getListaFilmes();
    	  
      }

  	for (int i = 0; i <= temp.size() - 1; i++) {
		 Map obj = (Map)temp.get(i);
            
      Filme.setId_filme(Integer.parseInt(obj.get("id").toString()));
      Categoria.setNome(obj.get("categoria").toString());
      int dias_insercao = Filme.getDiasAdicionado();
     String nacionalidade = obj.get("nacionalidade").toString();   
      
      %>  
      <tr align="center">  
          <th style="display:none">  
        	<%out.print(obj.get("id"));%>  
         </th> 
          <th colspan="2" style="text-align: center">  
               <%out.print(obj.get("filme"));
               
               if(dias_insercao <= 15)
               {%>
               <img alt="" src="<%=request.getContextPath()%>/Imagens/new.gif">            
               <%}        
              if(Filme.getCopiasDisponiveis() > 0){ %>         
                <button onclick="adicionarCarrinho(this); return false;"><img alt="" src="<%=request.getContextPath()%>/Imagens/alugar2.jpg"></button>
              <%}else{ %> 
              
            <button disabled onclick="adicionarCarrinho(this); return false;"><img alt="" src="<%=request.getContextPath()%>/Imagens/alugar2.jpg"></button>
            <%} %>
         </th>  
          <th colspan="2" style="text-align: center">  
               <%if(nacionalidade.toLowerCase().equals("brasil")){ %>
               
               <img alt="" src="<%=request.getContextPath()%>/Imagens/brasil.jpg" width="42" height="42"> 
               
              <% }if(nacionalidade.toLowerCase().equals("eua")){ %>
                
                <img alt="" src="<%=request.getContextPath()%>/Imagens/usa.jpg" width="42" height="42"> 
               
              <% }if(nacionalidade.toLowerCase().equals("europa")){ %>
                
                <img alt="" src="<%=request.getContextPath()%>/Imagens/europa.jpg" width="42" height="42"> 
               
              <%}
                       
               %>  
         </th>  
         </tr>
         <tr>
         
          <td style="text-align: center">  
               <%out.print("Generos: " + Filme.getStringGeneros());%>  
         </td> 
         
         <td style="text-align: center">
         
         <%out.print("Disponiveis: " + Filme.getCopiasDisponiveis());%>
         
         </td>
         
          <td bgcolor="<%=Categoria.getCor()%>" >            
              
         </td> 
         
         <td style="text-align: center">
         
         <%out.print("R$: " + Categoria.getPreco());%>
         
         </td>
         
         </tr>

      <%}
     
   }catch (Exception e) {  
      e.printStackTrace();  
   }  
     
%> 

</tbody>
</table> 
<br>
<div align="center">
<a link href="homecliente.jsp" class="btn btn-info">Voltar</a>
</div>
<input type="hidden" id="txtCarrinho" name="txtCarrinho">
</form>

</body>
</html>