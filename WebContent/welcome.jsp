<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="mx.com.pastillero.types.Types"%>
<%@page session="true" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="es">
<head>
	<title>Sesion de Cajero |</title>    
	
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
    <%  HttpSession sesion = request.getSession(false);
		String usuario = (String)sesion.getAttribute("usuario");
		String nombre = (String)sesion.getAttribute("nombre");
		String apepat = (String)sesion.getAttribute("apepat");
		String apemat = (String)sesion.getAttribute("apemat");
		String perfil = (String)session.getAttribute("perfil");
		Integer num =   (Integer) sesion.getAttribute("numero");
		
		boolean res=false;	
		
		if(num == null)
		{
			response.sendRedirect("index.jsp");
		}
		else 
		{
			if(num == 1 && perfil.equalsIgnoreCase(Types.C.getStatusCode()))
			{
				sesion.setAttribute("numero", 2);
			    res = true;
			}
		}
		     
	   %>	
       var op = <%=res%>      
       $(document).ready(function() 
        {	  	        
     		    // save id current session in localstorage
     		  	var user = '<%=usuario%>';
     		  	var perfil = '<%=perfil%>';
     		  	     		     		  	
     		  	localStorage.setItem("usuario", user);
     		  	localStorage.setItem("perfil", perfil);
     		  	
     		  	console.log(localStorage.getItem("usuario"));
     		  	console.log(localStorage.getItem("perfil"));
     		  	console.log(localStorage.getItem("sesionend")); 		   		       
     		 	
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
		
	    $(document).ready(function ()
	    {
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
             });
       }); 
	    
	// function models for welcome jsp	
	function loadpagesession()
    {
		var controlventa = localStorage.getItem("idcontrolventa");
		var arraynt = JSON.parse(localStorage.getItem("nota"));	
		 
		//create table
		var t = $('#example').DataTable({
    		dom : "rtiS",
			"bSort": false,
			scrollY : 100,
			scrollCollapse : true
	
       });
	  	if(controlventa !=null && arraynt !=null)
	  	{
			if(controlventa.localeCompare("1") == 0)
	  		{
				 document.getElementById("cobro").childNodes[0].onclick = function() {return false;};
				 t.row.add([					         
							arraynt.idnt,
							arraynt.usuario,
							'<button type="button" onclick="venta()">Continuar</button>'])
							.draw();
	  		}
			else
			{
				 document.getElementById("cobro").childNodes[0].onclick = function() {return true;};
			}
	  	}  	
    }
	
	// FUNCTIONS
	
	function venta()
	{
		window.open("cobro.jsp");
	}
	
	function info( x)
	{
		if(x == '1')
			alert("Función: Corte aún no implementada");
		if(x == '2')
			alert("Función: Medico en desarrollo");
	}
	
	
	</script>   	   
</head>
<body onload="loadpagesession()">

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
		<!--Contenido de la ventana de dialogo "dialog", muestra un input para colocar la cantidad a depositar en caja al inicio de abrir el sistema-->
	<div id="dialog" title="Caja">
			<p>Coloque la cantidad a depositar para fondo de caja.</p>
			<input type="text" id="cantidad" value="0.00" size="10">
	</div>

	<!--Contenido de la ventana de dialogo "confirmation-1", mmuestra un mensaje de error en caso de que la cantidad de fondo de caja sea mayor o igual a mil pesos-->
	<div id="confirmation-1" class="text-message" title="Error">
		 	 Entrada invalida, favor de ingresar una cantidad menor, esta cantidad no esta autorizada por el gerente.
	</div>

	<!--Contendio de cuadro de dialogo "confirmation-2", muestra un mensaje de bienvenida en caso de que la cantidad ingresada como fondo de caja sea valida-->
	<div id="confirmation-2" class="text-message" title="Bienvenido"> Bienvenido al sistema, ha iniciado correctamente! 
	</div>
	<!--  ......  -->
	
	
	
<div>
<div>
	<div id="header">
		<!--div id="logo"></div-->
	</div>
	
	<div id="sucursal">									
		<p>Cajero  : <label id="lblname"><%=nombre%> <%=apepat%> <%=apemat%></label></p>
		<p>Usuario : <label id="lbluser"><%=usuario%></label><label> | Sucursal: Sin Sucursal</label></p>			
	</div>
    
	<!--Barra de Navegacion de la pagina principal-->
	<ul id="nav">
			<li><a href="${pageContext.request.contextPath}/consulta.jsp"  target="_blank">Consulta</a></li>
			<li id="cobro"><a href="${pageContext.request.contextPath}/cobro.jsp" target="_blank">Cobro</a></li>
			<li><a href="${pageContext.request.contextPath}/clientes.jsp" target="_blank">Clientes</a></li>
			<li><a href="${pageContext.request.contextPath}/medicos.jsp" target="_blank">Medicos</a></li>
			<li><a onclick="info(1)">Corte de Caja</a></li>
			<li><a href="${pageContext.request.contextPath}/recepciones.jsp" target="_blank">Recepcion</a></li>

    </ul>
	</div>
	<!--Barra de Navegacion, contiene el contenido que se muestra de lado derecho-->
	<div>
		<ul id="nav-right">
			<li><a id="close">Salir</a></li>
		</ul>
		
	</div>
	<!--Insersion de la imagen de marca de agua en la parte del centro del sistema-->
	<div id="newPage">
			<div class="infobox">
				<section>				
						<table id="example"  class="display" cellspacing="0" width="300px">
							<thead>
								<tr>					
									<th style="width: 15%">Folio</th>
									<th style="width: 15%">Usuario</th>
									<th style="width: 15%">-</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
							<tfoot>
							</tfoot>
						</table>											
					</section>
			</div>
		
	</div>
</div>
</body>
</html>
<%-- <li id="cobro"><a href="${pageContext.request.contextPath}/cobro.jsp?page=1" target="_blank">Cobro</a></li> 
			<li><a href="${pageContext.request.contextPath}/proveedores.jsp" target="_blank">Proveedores</a></li>
			<li><a href="${pageContext.request.contextPath}/recepcion.jsp"  target="_blank">Recepción</a></li>
			<li><a href="${pageContext.request.contextPath}/productos.jsp"  target="_blank">Productos</a></li>
			<li><a href="${pageContext.request.contextPath}/usuario.jsp"  target="_blank">Usuarios</a></li>
--%>