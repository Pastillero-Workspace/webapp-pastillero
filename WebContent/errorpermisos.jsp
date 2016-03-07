<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>  
	<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
<title>Aviso !</title>
</head>
<body>
<h3> Problema : <label><c:out value="${sessionScope.usuario}"/></label> </h3>
<div><h4> Sus permisos de usuario han cambiado :</h4>
     <p> * Asegurese de que su gerente o administrador le haya notificado el cambio </p>
     <p> * En caso que no y el problema persiste; contacte el administrador </p>
</div>
<div>Presione el boton para cerrar esta ventana y actualize el panel de accesos </div>
	<div> <input type="button" value="Cerrar Ventana" onclick="window.close();"> </div>
</body>
</html>