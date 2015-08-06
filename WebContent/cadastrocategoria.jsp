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
<title>Locadora - Cadastrar Categoria</title>
<script type="text/javascript" src="/Locadora/jsColor/jscolor.js"></script>

<script type="text/javascript">

function validarForm() {
	
    var cat = document.forms["formulario"]["txtCategoria"].value;
    var preco = document.forms["formulario"]["txtPreco"].value;
    var cor = document.forms["formulario"]["txtCor"].value;
    
    if (cat == null || cat == "") {
        alert("A CATEGORIA é obrigatória");
        return false;
    }
    
     if (preco == null || preco == "" || preco <= 0) {
        alert("O PREÇO é obrigatório");
        return false;
    }
     
}

</script>

 <style type="text/css">
    .container {
        width: 250px;
        clear: both;
    }

    </style>

</head>
<body>

<form class="well" name="formulario" onsubmit="return validarForm()" action="CadastroCategoriaController" method="POST">

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

<br>
<br>
<div align="center"><h1>Cadastro de Categorias</h1></div>

<div class="container" align="center">
<br>
<br>

<span>Nome<br></span><input size="100" type="text" placeholder="Digite o seu nome da categoria" name="txtCategoria">
<br>
<br>
<span>Preço da Diária<br></span><input type="text" placeholder="Digite o preço da diária" name="txtPreco">
<br>
<br>
<span>Cor<br></span><input class="color" name="txtCor">
<br>
<br>
<input class="btn btn-success" type="submit" value="Cadastrar Categoria" name="btnCadastrar">
<br>
<br>
<a link href="homeoperador.jsp" class="btn btn-info">Voltar</a>

</div>

</form>

</body>
</html>