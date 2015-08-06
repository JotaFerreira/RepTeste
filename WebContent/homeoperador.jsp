<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bem-Vindo</title>

<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap.min.css" media="screen">
<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap-responsive.min.css">

<script type="text/javascript" src="/Locadora/Bootstrap/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/Locadora/Bootstrap/js/bootstrap.min.js"></script>

</head>
<body>

<form id="form1" class="well">

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
                <li class="active"><a href="#">Inicio</a></li>
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
                <a href="cadastrocategoria.jsp">
                    <Img ID="Image1" Height="114px" Width="125px" src="<%=request.getContextPath()%>/Imagens/default-category.png" />
                    </a>
                    <br>
                    <br>
                    <span class="label label-primary">Cadastrar Categoria</span>
                </td>
                <td align="center">
                 <a href="cadastrogenero.jsp">
                    <Img ID="Image2" Height="114px" Width="125px" src="<%=request.getContextPath()%>/Imagens/genero.png" />
                    </a>
                    <br>
                    <br>
                    <span class="label label-primary">Cadastrar Genero</span>
                </td>
                <td align="center">
                 <a href="cadastrafilme.jsp">
                    <Img ID="Image3" Height="114px" Width="125px" src="<%=request.getContextPath()%>/Imagens/filme.png" />
                    </a>
                    <br>
                    <br>
                    <span class="label label-primary">Cadastrar Filme</span>
                </td>
            </tr>
            <tr>
            <td>
            <br><br>
            </td>
            </tr>
            <tr>
                <td align="center">
                 <a href="peseditfilme.jsp">
                    <Img ID="Image4" Height="114px" Width="125px" src="<%=request.getContextPath()%>/Imagens/pesquisarfilme.png" />
                    </a>
                     <br>
                    <br>
                    <span class="label label-primary">Pesquisar e Editar Filme</span>
                </td>
                <td align="center">
                 <a href="visualizarlocacoes.jsp">
                    <Img ID="Image5" Height="114px" Width="125px" src="<%=request.getContextPath()%>/Imagens/pesquisalocacoes.png" />
                    </a>
                     <br>
                    <br>
                    <span class="label label-primary">Visualizar,Acompanhar e Gerenciar Locações</span>
                </td>            
                <td align="center">
                 <a href="home.jsp">
                    <Img ID="Image5" Height="114px" Width="125px" src="<%=request.getContextPath()%>/Imagens/exit.png" />
                    </a>
                     <br>
                    <br>
                    <span class="label label-primary">Sair</span>
                </td>
            </tr>
        </table>  
    </div>
    
    <br><br><br>
<footer class="footer">
      <div align="center" class="container">
        <p class="text muted">Todos os direitos reservados</p>
      </div>
    </footer>
    
    </form>
       
</body>
</html>