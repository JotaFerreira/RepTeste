<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap.min.css" media="screen">
<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap-responsive.min.css">

<script type="text/javascript" src="/Locadora/Bootstrap/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/Locadora/Bootstrap/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Locadora - Cliente</title>
</head>
<body>

<form id="form1" class="well well-lg">

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
<div align="center"><h1>Bem vindo <%=session.getAttribute("user")%></h1></div>
<br><br>
<br><br>
    <div align="center">
        <table style="width:100%;">
            <tr>
                <td align="center">
                <a href="pesquisafilme.jsp">
                    <Img ID="Image1" Height="114px" data-toggle="tooltip" title="Navegar Filmes por Genero&#13;Procurar Filmes por Propriedades&#13;Adicionar Filme a Locação&#13;Solicitar Locação" Width="125px" src="<%=request.getContextPath()%>/Imagens/filme.png" />
                    </a>
                    <br>
                    <br>
                    <span class="label label-primary">Pesquisar e Locar Filmes</span>
                </td>
              
                 <td align="center">
                 <a href="visualizarlocacoes.jsp">
                    <Img ID="Image5" Height="114px" Width="125px" data-toggle="tooltip" title="Visualizar e Atualizar Locação&#13;Acompanhar Locações" src="<%=request.getContextPath()%>/Imagens/pesquisalocacoes.png" />
                    </a>
                     <br>
                    <br>
                    <span class="label label-primary">Visualizar,
                     Acompanhar <br> e Atualizar Locação</span>
                </td>         
            
                    <td align="center">
                 <a href="home.jsp">
                    <Img ID="Image5" Height="114px" Width="125px" data-toggle="tooltip" title="Sair do Sistema" src="<%=request.getContextPath()%>/Imagens/exit.png" />
                    </a>
                     <br>
                    <br>
                    <span class="label label-primary">Sair</span>
                </td>
            
            </tr>

        </table>
        
     <!--<a href="#" class="btn btn-success">Success</a>  -->
    
    </div>
    </form>
      
</body>
</html>