<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@page import="mx.com.pastillero.types.Types"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
<head>
	<title>Sesion de Administrador |</title>    
	
	<link href="<c:url value="/resources/css/index.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/jquery.dataTables.css" />"rel="stylesheet">
	<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
    <script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
    <script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script>   
    
    <script type="text/javascript">
    
    <% HttpSession sesion = request.getSession(false);
		  String usuario = (String)sesion.getAttribute("usuario");
		   String nombre = (String)sesion.getAttribute("nombre");
		   String apepat = (String)sesion.getAttribute("apepat");
		   String apemat = (String)sesion.getAttribute("apemat");
		   String perfil = (String)session.getAttribute("perfil");
		Integer sesionid = (Integer)sesion.getAttribute("idSesion");
		     Integer num = (Integer)sesion.getAttribute("numero");	
		
		if(num == null)
		{
					response.sendRedirect("index.jsp");
		}
		else 
		{
			if(num == 1 && perfil.equalsIgnoreCase(Types.A.getStatusCode()))
			{
				sesion.setAttribute("numero", 2);
			}
			if(num == 2 && perfil.equalsIgnoreCase(Types.A.getStatusCode()))
			{
				sesion.setAttribute("numero", 2);
			}
		}
		     
	   %>	
	   var op = false;
       $(document).ready(function() 
     		  {	
     		  	var data = [];
     		  	
     		    /* save id current session in localstorage*/
     		  	var user = '<%=usuario%>';
     		  	var perfil = '<%=perfil%>';    		  	
     		  	localStorage.setItem("sesionend","1");
     		  	localStorage.setItem("usuario", user);
     		  	localStorage.setItem("perfil", perfil);
     		  	localStorage.setItem("sessionid",<%=sesionid%>);
     		  	
     		  	/*Print the storage value*/
     		  	console.log("      usuario : "+localStorage.getItem("usuario"));
     		  	console.log("       perfil : "+localStorage.getItem("perfil"));
     		  	console.log("sesion activa : "+localStorage.getItem("sesionend"));
     		  	console.log("    sesion id : "+localStorage.getItem("sessionid"));
   		
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
		
	    $(document).ready(function (){
        	$("#close").click(
            function () 
             {
            	var data = localStorage.getItem("sessionid");
                console.log("click en salir: sesion num # "+data);
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
        	$(function(){
        		$("#menuSecond").change(function() {
                    if ($(this).val()) {
                        window.open($(this).val(), '_blank');
                    }
        		});
        	});
    });
	     	   	
	</script>   	   
</head>
<body>

<!--Fomulario para dar de alta un medico, este formulario se mostrara en un Dialog de JQuery, se activara al hacer click en el menu "Alta medico" dentro de la pagina principal-->
	<div id="formAltaMedico" title="Alta de nuevo Médico" class="text-form">
		<form  method="post" action="/webapp-pastillero/altaMedico.jr" id="formMedico">
			<legend>* Campos Obligatorios</legend>
			<fieldset>
				<legend>Generales</legend>
				<ol>
					<li><label for="clave">* Clave:</label><input type="text" name="clave" id="clave" placeholder="Ingrese Clave de Médico" requiered autofocus> <label for="cedula">* Cédula:</label><input type="text" name="cedula" id="cedula" requiered></li>
					<li><label for="nombre">* Nombre:</label><input type="text" name="nombre" id="nombre" size="54" requiered></li>
				</ol>
			</fieldset>
			<fieldset>
				<legend>Datos de Domicilio</legend>
				<ol>
					<li><label for="calle">Calle:</label><input type="text" name="calle" id="calle"><label for="numero">Número:</label><input type="text" name="numero" id="numero"></li>
					<li><label for="municipio">Municipio:</label><input type="text" name="municipio" id="municipio"><label for="estado">Estado:</label><input type="text" name="estado" id="estado"></li>
					<li><label for="cp">C.P:</label><input type="text" name="cp" id="cp"></li>
				</ol>
			</fieldset>
			<fieldset>
				<legend>Datos de Contacto</legend>
				<ol>
					<li><label for="telefono">Telefono:</label><input type="text" name="telefono" id="telefono"><label for="email">E-Mail:</label><input type="text" name="email" id="email"></li>
				</ol>
			</fieldset>
			<fieldset>
				<ol>
					<li><input type="submit" name="submit" value="Dar de Alta">
				</ol>
			</fieldset>
		</form>
	</div>	
	<!-- ...... -->
<!--Fomulario para dar de alta a un cliente, este formulario se mostrara en un Dialog de JQuery, se activara al hacer click en el menu "Alta cliente" dentro de la pagina principal-->
	<div id="formAltaCliente" title="Alta de nuevo Cliente" class="text-form">
		<form action="" id="formCliente">
			<legend>* Campos Obligatorios</legend>
			<fieldset>
				<legend>Generales</legend>
				<ol>
					<li><label for="clave">* Clave:</label><input type="text" name="clave" id="clave" placeholder="Ingrese Clave de Cliente" requiered autofocus> <label for="rfc">* RFC:</label><input type="text" name="rfc" id="rfc" requiered></li>
					<li><label for="nombre">* Nombre:</label><input type="text" name="nombre" id="nombre" size="54" requiered></li>
				</ol>
			</fieldset>
			<fieldset>
				<legend>Datos de Domicilio</legend>
				<ol>
					<li><label for="calle">Calle:</label><input type="text" name="calle" id="calle"><label for="numero">Número:</label><input type="text" name="numero" id="numero"></li>
					<li><label for="municipio">Municipio:</label><input type="text" name="municipio" id="municipio"><label for="estado">Estado:</label><input type="text" name="estado" id="estado"></li>
					<li><label for="cp">C.P:</label><input type="text" name="cp" id="cp"></li>
				</ol>
			</fieldset>
			<fieldset>
				<legend>Datos de Contacto</legend>
				<ol>
					<li><label for="telefono">Telefono:</label><input type="text" name="telefono" id="telefono"><label for="email">E-Mail:</label><input type="text" name="email" id="email"></li>
				</ol>
			</fieldset>
		</form>
	</div>
	<!-- ...... -->
<div>
<div>
	<div id="header">
		<!--div id="logo"></div-->
	</div>
	
	<div id="sucursal">					
					
					<p>Administrador  : <label id="lblname"><%=nombre%> <%=apepat%> <%=apemat%></label></p>
					<p>Usuario : <label id="lbluser"><%=usuario%></label><label> | Sucursal: San Martín Texmelucan</label></p>
			
	</div>
    
	<!--Barra de Navegacion de la pagina principal-->
	<ul id="nav">
			<li><a href="${pageContext.request.contextPath}/consulta.jsp"  target="_blank">Consulta</a></li>
			<li><a href="${pageContext.request.contextPath}/clientes.jsp" target="_blank">Clientes</a></li>
			<li><a href="${pageContext.request.contextPath}/proveedores.jsp" target="_blank">Proveedores</a></li>
			<li><a href="${pageContext.request.contextPath}/recepciones.jsp"  target="_blank">Recepción</a></li>
			<li><a href="${pageContext.request.contextPath}/productos.jsp"  target="_blank">Productos</a></li>
			<li><a href="${pageContext.request.contextPath}/usuario.jsp"  target="_blank">Usuarios</a></li>
			<li><a href="${pageContext.request.contextPath}/movimientos.jsp"  target="_blank">Movimientos</a></li>
			<li><a href="${pageContext.request.contextPath}/salidas.jsp"  target="_blank">Salidas</a></li>
    </ul>
	</div>
	<!--Barra de Navegacion, contiene el contenido que se muestra de lado derecho-->
	<div>
		<ul id="nav-right">
			<li><a id="close" runat="server">Salir</a></li>
			<li>
				<span id="menu">
					<select id="menuSecond">
						<option value="">Barra de Acceso Rápido...</option>
						<option value="${pageContext.request.contextPath}/configuraciones.jsp">Configuraciones</option>
						<option value="${pageContext.request.contextPath}/sesiones.jsp">Sesiones de Usuarios</option>
						
				</select>
				</span>
			</li>
		</ul>
		
	</div>
	<!--Insersion de la imagen de marca de agua en la parte del centro del sistema-->
	<div id="newPage">
	
	</div>
</div>
</body>
</html>
