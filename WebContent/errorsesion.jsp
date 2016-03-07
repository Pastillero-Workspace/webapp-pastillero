<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>  
	<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
    <script src="<c:url value="/resources/js/welcomefnc.js" />"></script>
<title>Error</title>
</head>
<body>
<h3> Problema : <label><c:out value="${u}"/></label> </h3>
<div><h4>  Una sesión se encuentra activa . Las causas pueden ser :</h4>
     <p> * Cierre inesperado del navegador </p>
     <p> * Se intenta logear dos veces con el mismo user en el mismo perfil </p>
     <p> * Se perdíeron datos de navegador </p>
</div>
<div>
            <input id="u" type="hidden" value="<c:out value="${u}"/>"><br>
  		    Password : <input id="p" type="text" name="password"><br>
            <input id="closeActive" type="button"  value="Cerrar">



</div>
   <a href="${pageContext.request.contextPath}/index.jsp" >Login</a>
</body>
</html>