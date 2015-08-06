<%@page import="model.DAO"%>
<%@ page import="java.util.*" %>
<%@ page language="java" import="java.sql.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap.min.css" media="screen">
<link rel="stylesheet" href="/Locadora/Bootstrap/css/bootstrap-responsive.min.css">

<script type="text/javascript" src="/Locadora/Bootstrap/js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="/Locadora/Bootstrap/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cadastro Realizado!</title>
</head>
<body>


<div align="center">
<img alt="Locadora Logo" height="350" width="500" src="<%=request.getContextPath()%>/Imagens/p8095424.jpg">
<p><strong>Cadastro Realizado com Sucesso! </strong></p>  
<table border=1 cellspacing=0 cellpadding=0>  
  
   <tr>  
    <td width=250><strong>  
      Nome  
   </strong></td>      
   <td width=50><strong>  
      Login 
   </strong></td>      
   </tr>  
  </div>
  
<%    
	DAO dao = new DAO();

   try {  

	  String login = request.getParameter("txtLogin");
      List temp = dao.getConsulta("select nome,login from usuario where login='" + login + "'");


		 Map obj = (Map)temp.get(0);
      %>  
      <tr>  
          <td width=200>  
               <%out.print(obj.get("nome"));%>  
         </td>  
          <td width=50>  
               <%out.print(obj.get("login"));%>  
         </td>  

      </tr>  
      <%
     
   }catch (Exception e) {  
      e.printStackTrace();  
   }  
     
%>  
</table>  
  <p> </p>
  <a link href="home.jsp" class="btn btn-primary">Voltar</a>

</body>
</html>