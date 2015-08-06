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
<title>Locação Solicitada!</title>
</head>
<body>

<form class="well">

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
<h1>Locação Solicitada com Sucesso!</h1>
<br>
<div class="alert alert-dismissible alert-success">
  <button type="button" class="close" data-dismiss="alert">×</button>
  <strong>Obrigado pela preferencia <%=session.getAttribute("user")%>!</strong><br><br> O(s) filme(s) serão entregues assim que possível, você pode acompanhar o andamento da sua solicitação <a href="visualizarlocacoes.jsp" class="alert-link">aqui</a>.
</div>
<br>
<div align="center">
<a link href="homecliente.jsp" class="btn btn-info">Página Principal</a>
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