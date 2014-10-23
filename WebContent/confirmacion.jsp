<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Confirmacion | </title>

<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet">

<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
<script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>

<script type="text/javascript">
	$(document).ready(function () {
		$("#confirmation").dialog({
			modal:true,
			autoOpen: true,
			closeOnEscape: true,
			buttons:{
				"Aceptar": {
					text: "Aceptar",
					id:		"btnAceptar",
					click:	function(){
						window.close();
					}

				}
			}
		});
		$("#confirmation").dialog("option", "width", 400);
		$("#confirmation").dialog("option", "height", 150);
				
	});

</script>



</head>
<body>
	<div id="confirmation" class="text-message" title="Datos Guardados">
		 	 Los datos de la Sucursal han sido Guardados con Éxito.
	</div>
	<!-- <div>
		 <p>${message}</p> 
	</div>-->
   </body>
</html>