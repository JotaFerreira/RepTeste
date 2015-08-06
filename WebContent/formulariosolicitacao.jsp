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

<script type="text/javascript">

function validarForm() {
	
    var rua = document.forms["formulario"]["txtRua"].value;
    var numero = document.forms["formulario"]["txtNumero"].value;
    var bairro = document.forms["formulario"]["txtBairro"].value;

    if (rua == null || rua == "") {
        alert("A RUA é obrigatória");
        return false;
    }
    
     if (numero == null || numero == "") {
        alert("O NUMERO é obrigatório");
        return false;
    }
     
     if (bairro == null || bairro == "") {
         alert("O BAIRRO é obrigatório");
         return false;
     }
     
}

</script>

<title>Formulário de Solicitação de Locação</title>
</head>
<body>

<form class="well" name="formulario" onsubmit="return validarForm()" action="SolicitarLocacaoController" method="POST">

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

<div align="center">
<br>
<br>
<span>Rua:</span><input type="text" placeholder="Digite o nome da rua" name="txtRua" id="txtRua">*
<br>
<br>
<span>Número:</span><input type="text" placeholder="Digite o número da casa" name="txtNumero" id="Numero">*
<br>
<br>
<span>Bairro:</span><input type="text" placeholder="Digite o bairro" name="txtBairro" id="txtBairro">*
<br>
<br>
<input class="btn btn-success" type="submit" value="Solicitar Locação" name="btnSolicitar">
<br>
<br>
</div>
<input type="hidden" name="txtIDs" id="txtIDs" value="<%=request.getParameter("txtIDs")%>"> 
<input type="hidden" name="txtUser" id="txtUser" value="<%=session.getAttribute("user")%>"> 

</form>


</body>
</html>