<%@page import="model.DAO"%>
<%@ page import= "java.sql.Connection" %>
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
<title>Locadora - Autoridade Filmes</title>

<script type="text/javascript">

function validarForm() {
	
    var login = document.forms["formulario"]["txtLogin"].value;
    var senha = document.forms["formulario"]["txtPass"].value;
    
    if (login == null || login == "") {
        alert("O LOGIN é obrigatório");
        return false;
    }
      
     if (senha == null || senha == "") {
         alert("A SENHA é obrigatória");
         return false;
     }
     
}

</script>
</head>
<body>
<form name="formulario" onsubmit="return validarForm()" action="AutenticacaoController" method="POST">
<div align="center">
<img alt="Locadora Logo" height="350" width="500" src="<%=request.getContextPath()%>/Imagens/p8095424.jpg">
<br>
<br>
<span>Login:</span><input type="text" name="txtLogin">
<br>
<br>
<span>Senha:</span><input type="password" name="txtPass">
<br>
<%if(request.getAttribute("msg") != null){out.print("<span style='color:red'>" + request.getAttribute("msg") + "</span><br>");}; %>
<br> 
<input class="btn btn-success" type="submit" value="Logar" name="btnLogar">
<br>
<br>
<a link href="cadastro.jsp" class="btn btn-info">Cadastrar-se</a>
</div>

</form>

</body>
</html>