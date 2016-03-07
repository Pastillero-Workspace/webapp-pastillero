<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Error</title>
</head>
<body>
<h3> Problema </h3>
<div><h4> No se puede acceder al sistema. Verifique que </h4>
     <p> * usuario y password sean correctos </p>
     <p> * Que su acceso exista en la base </p>
     <p> Si el problema persiste: Contacte al administrador y/o envíe un mensaje</p><a href="www.google.com" >Contacto</a>
</div>

<div>
		 <p> Para volver a login presione Home </p>
</div>
   <a href="${pageContext.request.contextPath}/index.jsp" >Home</a>
</body>
</html>