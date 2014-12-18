<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@page import="mx.com.pastillero.types.Types"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="es">
<head>
	<title> Sesion de Vendedor | </title>    
	<link href="<c:url value="/resources/css/index.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/jquery.dataTables.css" />"rel="stylesheet">
	<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
	
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
    <script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
    <script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script> 
    <script src="<c:url value="/resources/js/DOMinit.js" />"></script>    
    <script type="text/javascript">

    <% HttpSession sesion = request.getSession(false);
		String usuario = (String)sesion.getAttribute("usuario");
		String nombre = (String)sesion.getAttribute("nombre");
		String apepat = (String)sesion.getAttribute("apepat");
		String apemat = (String)sesion.getAttribute("apemat");
		Integer num =   (Integer) sesion.getAttribute("numero");
		String perfil = (String)session.getAttribute("perfil");
		Integer sesionid =   (Integer) sesion.getAttribute("idSesion");
		Integer activo =   (Integer) sesion.getAttribute("activo");
		boolean res=false;
		if(num==null)
		{
					response.sendRedirect("index.jsp");
		}
		else 
		{
			if(num == 1 && perfil.equalsIgnoreCase(Types.V.getStatusCode()));
			{
				sesion.setAttribute("numero", 2);
			    res=true;
			}
		}
	%>	
         var op = <%=res%>;
    
       $(document).ready(function() 
     		  {	
    	   //local storage items
    		var user = '<%=usuario%>';
 		  	var perfil = '<%=perfil%>';
 		  	
 		  	localStorage.setItem("sesionend","1");
 		  	localStorage.setItem("usuario", user);
 		  	localStorage.setItem("perfil", perfil);
 		  	localStorage.setItem("sessionid",<%=sesionid%>);
 		  	
 		  	console.log(localStorage.getItem("usuario"));
 		  	console.log(localStorage.getItem("perfil"));
 		  	console.log(localStorage.getItem("sesionend"));
 		  	console.log(localStorage.getItem("sessionid"));
 		  	
     		      var t = $('#example').DataTable( {
  
     					deferRender:    true,
     					dom:            "frtiS",
     					scrollY:        200,
     					scrollCollapse: true,
     					pagingType: "full_numbers"
     		  });	
     		  });

		/*Funcion que muestra el formulario de "Alta Medico"*/
		$(document).ready(function () 
		{
	        	$("#openFormAltaMedico").click(
	            function () {
	            $("#formAltaMedico").dialog('open');
	             return false;
	            }
				
        	);
	    });

		/*Funcion que muestra el formulario de "Alta Cliente"*/
	    $(document).ready(function () {
	        	$("#openFormAltaCliente").click(
	            function () {
	                $("#formAltaCliente").dialog('open');
	                return false;
	            }
        	);
	    });
		
		// close the document 
	    $(document).ready(function (){
        	$("#close").click(
            function () 
             {
            	var data = localStorage.getItem("sessionid");
                console.log("click en salir");
                $.post('logout.jr',
                {
                	idLocalSesion: data,
                	workout:'exits'
                },function(data)
                {
                	if(data == "Exit")
                	{
                		localStorage.setItem("sesionend","0");
             		  	localStorage.setItem("usuario","");
             		  	localStorage.setItem("perfil","");
                		alert("Sesion finalizada");
                	    window.location.replace("index.jsp");
                	}
                });
             }
    	    );
         });
		
		//-------------------
	
		
	
	</script>   	   
</head>
<body>
<div>
<div>
	<div id="header">
		<!--div id="logo"></div-->
	</div>
	
	<div id="sucursal">					
					
					<p>Vendedor : <label id="lblname"><%=nombre%> <%=apepat%> <%=apemat%></label></p>
					<p> Usuario : <label id="lbluser"><%=usuario%> | Sucursal: San Martín Texmelucan</label></p>
			
	</div>
    
	<!--Barra de Navegacion de la pagina principal-->
	<ul id="nav">
			<li><a href="${pageContext.request.contextPath}/consulta.jsp"  target="_blank">Consulta</a></li>
			<li><a href="${pageContext.request.contextPath}/cobro.jsp" target="_blank">Cobro</a></li>
			<li><a href="${pageContext.request.contextPath}/clientes.jsp" target="_blank">Clientes</a></li>
		    <li><a href="${pageContext.request.contextPath}/medicos.jsp" target="_blank">Medicos</a></li>
		    <li><a href="${pageContext.request.contextPath}/recepciones.jsp" target="_blank">Recepcion</a></li>
<%-- 		<li><a href="${pageContext.request.contextPath}/recepcion.jsp"  target="_blank">Recepción</a></li>
			<li><a href="${pageContext.request.contextPath}/productos.jsp"  target="_blank">Productos</a></li> --%>

    </ul>
	</div>

	<!--Barra de Navegacion, contiene el contenido que se muestra de lado derecho-->
	<div>
		<ul id="nav-right">
			<li><a id="close" runat="server">Salir</a></li>
			<!--  <li>
				<span id="menu">
					<select>
						<option value="">Barra de Acceso Rápido...</option>
						<option value="">Opcion1</option>
						<option value="">Opcion2</option>
						<option value="">Opcion3</option>
						
				</select>
				</span>
			</li> -->
		</ul>
		
	</div>
	<!--Insersion de la imagen de marca de agua en la parte del centro del sistema-->
	
</div>

</body>
</html>
