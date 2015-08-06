<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap.min.css"
	media="screen">
<link rel="stylesheet"
	href="/Locadora/Bootstrap/css/bootstrap-responsive.min.css">

<script type="text/javascript"
	src="/Locadora/Bootstrap/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript"
	src="/Locadora/Bootstrap/js/bootstrap.min.js"></script>

<title>Retornar Filme</title>
</head>
<body>

<form class="well" id="formulario" name="formulario" action="MudaStatusController" method="POST">

<%model.Locacao Locacao = new model.Locacao();
Locacao.setId(Integer.parseInt(request.getParameter("id")));
DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
Date date = new Date();
String dataAtual = dateFormat.format(date);

%>

<span class="label label-info">Data Devolução: </span><br><input type="text" name="txtDataDev" id="txtDataLoc" value="<%=dataAtual%>">
<br><br>
<input class="btn btn-success" type="submit" value="Retornar Locação" name="btnRetornar">
<input type="hidden" name="txtID" id="txtID" value="<%=request.getParameter("id")%>">

</form>

</body>
</html>