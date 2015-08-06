<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cadastro de Clientes</title>

<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap.min.css" media="screen">
<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap-responsive.min.css">

<script type="text/javascript" src="/Locadora/Bootstrap/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/Locadora/Bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">

function validarForm() {
	
    var nome = document.forms["formulario"]["txtNome"].value;
    var login = document.forms["formulario"]["txtLogin"].value;
    var senha1 = document.forms["formulario"]["txtPass"].value;
    var senha2 = document.forms["formulario"]["txtPass2"].value;
    
    if (nome == null || nome == "") {
        alert("O NOME é obrigatório");
        return false;
    }
    
     if (login == null || login == "") {
        alert("O LOGIN é obrigatório");
        return false;
    }
     
     if (senha1 == null || senha1 == "") {
         alert("A SENHA é obrigatória");
         return false;
     }
     
     if (senha2 == null || senha2 == "") {
         alert("A REPETIÇÃO DA SENHA é obrigatória");
         return false;
     }
     
     if (senha1 != senha2) {
         alert("As senhas não coincidem!");
         return false;
     }
     
}

</script>

</head>
<body>

<form class="well" name="formulario" onsubmit="return validarForm()" action="CadastroClienteController" method="POST">

<div align="center">
<img alt="Locadora Logo" height="350" width="500" src="<%=request.getContextPath()%>/Imagens/p8095424.jpg">
<br>
<br>
<span>Nome:</span><input type="text" placeholder="Digite o seu nome completo" name="txtNome">*
<br>
<br>
<span>Login:</span><input type="text" placeholder="Digite o usuário de logon" maxlength="20" name="txtLogin">*
<br>
<br>
<span>Senha:</span><input type="password" name="txtPass">*
<br>
<br>
<span>Repita a senha:</span><input type="password" name="txtPass2">*
<br>
<br>
<input class="btn btn-success" type="submit" value="Cadastrar" name="btnCadastrar">
<br>
<br>
<a link class="btn btn-primary" href="/Locadora/home.jsp">Voltar</a>

</div>

</form>

</body>
</html>