<%@page import="java.util.List"%>
<%@page import="mx.com.pastillero.types.Types"%>

<%@page import="mx.com.pastillero.model.formBeans.MovimientoGeneral"%>
<%@page import="mx.com.pastillero.model.viewdao.ViewModelMovimientosDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
<head>
	<!-- The CSS Styles for forms -->
	<title>Consulta de Movimientos | Cajero</title>
    <link href="<c:url value="/resources/css/index.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/jquery.dataTables.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
	
	<!-- The Javascript config -->
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
	
	<script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
	<script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script>
	<script src="<c:url value="/resources/js/demo.js" />"></script>
	<script src="<c:url value="/resources/js/jquery.tabletojson.min.js" />"></script>
	
	<script type="text/javascript" language="javascript" class="init">
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
			if(num == 1 && perfil.equalsIgnoreCase(Types.A.getStatusCode()))
			{
			sesion.setAttribute("numero", 2);
			}
	 %>	
	   var op = false;
		$(document).ready(function() {
			
			$("#search thead input").on( 'keypress changed', function (e) 
			{  
					 table
					.column( $(this).parent().index()+':visible' )
					.search(this.value)
					.draw();				
                  
			} );
			
			
	<%
	 	ViewModelMovimientosDao vmm = new ViewModelMovimientosDao();
	 	List<MovimientoGeneral> datos = vmm.getViewStored();
	 	
	%>
		// Se crea array de datos aleatorios
		var data = [];
		<%for(int i=0; i<datos.size(); i++){%>
		
			data[<%=i%>]=[  '<%=datos.get(i).getTipo()%>',
			   	            '<%=datos.get(i).getIdNota()%>',
			   	            '<%=datos.get(i).getDocumento()%>',
			   	            '<%=datos.get(i).getClave()%>',
			   	            '<%=datos.get(i).getDescripcion()%>',		   	               
			   	            '<%=datos.get(i).getAdquiridos()%>',
			   	            '<%=datos.get(i).getVendidos()%>',
			   	            '<%=datos.get(i).getValor()%>',
			   	            '<%=datos.get(i).getHabian()%>',
			   	            '<%=datos.get(i).getQuedan()%>',
			   	         	'<%=datos.get(i).getUtilidad()%>',
					        '<%=datos.get(i).getFecha()%>',
					        '<%=datos.get(i).getHora()%>'];
		<%}%>	
		
			// Se establece el control de datos al destino
			var table = $('#search').DataTable( {
			data:           data,
			deferRender:    true,
			dom:            "frtiS",
			"bSort":false,
			scrollY:        500,
			scrollCollapse: true,
		} );
			
		// botones adicionales para limpiar campos de textos
		$('<input type="button" id="refresh" style="width: 25%" value="Limpiar datos"/>').appendTo('div.dataTables_filter');
			$('#refresh').click(function(e) 
				{					
					var elem = document.getElementsByClassName("boxinit");
						var names = [];
							for(var i = 0; i < 13; ++i) 
							{		
								if(elem[i].value.length != 0)
								{
									names.push(elem[i].value);
									elem[i].value = '';
									elem[i].focus();									
								}
							}					     			
				});	
		});		
  </script>
  <script type="text/javascript">
		/*Funcion que muestra el formulario de "Alta Medico"*/
		$(document).ready(function () {
	        	$("#openFormAltaMedico").click(
	            	function () {
	           		$("#formAltaMedico").dialog('open');
	           	  	return false;
	           		 }
        		);
	        	$("#btnExcel").button().click(function(e){
					var t = $('#search').tableToJSON();
				    
					$.post('reporte.jr',{
						reporte: 'movimientos',
						txtTitulo:'Reporte de Movimientos',
						tblMovimientos:JSON.stringify(t)					
					}, function(f){
					});
					window.open("reporte.jsp", "Impresion", "height=600,width=400");
					console.log("tipo: "+t[205].Movimiento+" Folio: "+t[205].Folio);
	        	});
	        	
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
		
	/*Salir*/
	    $(document).ready(function ()
	    {
        	$("#close").click(
            function () 
             {               
            	var r = confirm("Desea cerrar el panel ?");
            	if (r == true) 
            	{
            	    window.close();
            	} 
             });
       }); 
	</script>
</head>
<body>
<div>
			<div id="header">
				<!--div id="logo"></div-->
			</div>
	
			<div id="sucursal">
			   <p>Cajero  : <label id="lblname"><%=nombre%> <%=apepat%> <%=apemat%></label></p>
		       <p>Usuario : <label id="lbluser"><%=usuario%></label><label> | Sucursal: San Martín Texmelucan</label></p>
			</div>

	<!--Barra de Navegacion de la pagina principal-->
	
			<ul id="nav">
					<li><a href="#">Recargar Datos</a></li>
			</ul>

    
	<!--Barra de Navegacion, contiene el contenido que se muestra de lado derecho-->
	<div id="navigatorpanel">
		<ul id="nav-right">
			<li><a id="close" runat="server">Cerrar</a></li>
			<li>
				<span id="menu">
					<select>
						<option value="">Barra de Acceso Rápido...</option>
						<option value="">Opcion1</option>
						<option value="">Opcion2</option>
						<option value="">Opcion3</option>
				</select>
				</span>
			</li>
		</ul>
	</div>
	
	<!--Fomulario para dar de alta un medico, este formulario se mostrara en un Dialog de JQuery, se activara al hacer click en el menu "Alta medico" dentro de la pagina principal-->
	<div id="formAltaMedico" title="Alta de nuevo Médico" class="text-form">
		<form action="" id="formMedico">
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
		</form>
	</div>	
	<!--Insersion de la imagen de marca de agua en la parte del centro del sistema-->
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
		<div class="container">
			<section>
			<button id="btnExcel">Excel</button>
			<table id="search" class="display"cellspacing="0" width="1024px">
				<thead>	
					<tr>
						<th style="width: 8%">Movimiento</th>
						<th style="width: 2%">Folio</th>
						<th style="width: 2%">Documento</th>
						<th style="width: 3%">Clave</th>
						<th style="width: 30%">Descripcion</th>
						<th style="width: 1%">Adq</th>
						<th style="width: 1%">Vendidos</th>
						<th style="width: 2%">Valor</th>
						<th style="width: 2%">Habian</th>
						<th style="width: 2%">Quedan</th>
						<th style="width: 2%">Utilidad</th>
						<th style="width: 6%">Fecha</th>
						<th style="width: 6%">Hora</th>
				    </tr>	
				</thread>
				<thead>
					<tr>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Movimiento" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Folio" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Documento" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Clave" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Descripcion" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Adquiridos" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Vendidos" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Valor" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Habian" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Quedan" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Utilidad" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Fecha" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Hora" /></th>						
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
</body>
</html>
