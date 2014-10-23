<%@page import="mx.com.pastillero.model.dao.DevolucionesDao"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="mx.com.pastillero.types.Types"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
<head>
	<!-- The CSS Styles for forms -->
	<title>Consulta de Proveedores | Cajero</title>
    <link href="<c:url value="/resources/css/edit.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/jquery.dataTables.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
	
	
	<!-- The Javascript config -->
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
	
	<script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
	<!-- <script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script> -->
	<script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
	
	<script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
	<script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script>
	<script src="<c:url value="/resources/js/demo.js" />"></script>
	<script src="<c:url value="/resources/js/jquery.tabletojson.min.js" />"></script>
	
	 <style>
		.ui-menu {
		width: 200px;
		}
	</style>
	
	<script type="text/javascript" language="javascript" class="init">
	var op = false;
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
		$(document).ready(function() {
		
		    // Algoritmo de filtrado
			$("#search thead input").on( 'keypress changed', function (e) 
			{  
					 table
					.column( $(this).parent().index()+':visible' )
					.search(this.value)
					.draw();
				    //alert("valor" + $(this).parent().index());					
                  
			} );			
		    
			
		
		// Se crea array de datos aleatorios
		var data = [];
		<%
			DevolucionesDao dev = new DevolucionesDao();
			List<Object[]> venta = dev.mostrarVentas();
			for(int i = 0; i < venta.size();i++){ 
		%>
		data[<%=i%>]=[  '<%=venta.get(i)[0]%>',
				        '<%=venta.get(i)[1]%>',
				   	    '<%=venta.get(i)[2]%>',
				   	    '<%=venta.get(i)[3]%>',
				   	    '<%=venta.get(i)[4]%>',
				   	    '<%=venta.get(i)[5]%>',
				   	    '<%=venta.get(i)[6]%>',
				   	    '<%=venta.get(i)[7]%>',
				   	 	'<%=venta.get(i)[8]%>',
				   	 	'<%=venta.get(i)[9]%>',
				   	    '<button id="<%=i%>">Devolver</button>'];
		<%}%> 
			// Se establece el control de datos al destino
			var table = $('#search').DataTable( {
			//data:           data,
			//deferRender:    true,
			//dom:            "frtiS",
			//"bSort":		false,
			//scrollY:        500,
			//scrollCollapse: true,
			data:	data,
			dom : "rtiS",
			"stateSave" : true,
		    "bSort": false,
		    scrollY : 350,
			
			scrollCollapse : false
			
		} );
			
			//var table = $('#example').DataTable();
			 
		    $('#search tbody').on( 'click', 'tr', function () {
		        if ( $(this).hasClass('selected') ) {
		            $(this).removeClass('selected');
		        }
		        else {
		            table.$('tr.selected').removeClass('selected');
		            $(this).addClass('selected');
		        }
		    } );	
		    
		   // $('#button').click( function () {
		     //   table.row('.selected').remove().draw( false );
		    //} );
		   		   
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
			
		
		/*Funciones de <A>*/
		$(function(){
			$("#detalleMovimiento thead input").on( 'keypress changed', function (e) 
					{  
							 table
							.column( $(this).parent().index()+':visible' )
							.search(this.value)
							.draw();
						    //alert("valor" + $(this).parent().index());					
		                  
					} );
		
				//Tabla Detalle Movimiento	
				
				<%for(int i=0; i<venta.size(); i++){%>
					var obj=[];
					$("#"+<%=i%>).button().click(function(){
						var t = $('#search').DataTable();
						var nota = "";
						var cont=0;
						$('#search tbody').on('click','button',function(){
							++cont;
							obj = t.row( $(this).parents('tr') ).data();
							if(cont==1){
								if(obj[5] == "COMPLETO"){
									$.post("devolucion.jr",{
										devolucion: 'venta',
										nota: obj[2]
									},function(e){	
									});
									setTimeout(function(e){
										window.open("detalleventasdev.jsp","_blank");
									},2500);
								}else{
									alert("No puede devolver una venta si aun no esta Completa");
								}
							}
						});
						
						
					});
				<%}%>
								
				$("#formDevVentas").dialog({
					modal:true,
					autoOpen: false,
					closeOnEscape: true,
					buttons:{
						"Agregar": {
							text: "Devolver a Proveedor e imprimir",
							id:		"btnDevolver",
							click:	function(){
									$("#formDevVentas").dialog("close");
									setTimeout(function() {
										location.reload();
									},100);
							}
						}
					}
				});
				$("#formDevVentas").dialog("option", "width", 1200);
				$("#formDevVentas").dialog("option", "height", 370);
				
				$("#txtCantidad").keypress(function (e){
					if(e.which == 13){
						$("#btnDevolver").focus();
					}
				});
				
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


<div id="formDevVentas" title="Devolucion de Ventas" class="text-form">
	<table id="detalleMovimiento" class="display"cellspacing="0"  width="760px">
				<thead>	
					<tr>
						<th style="width: 5%">Fecha</th>
						<th style="width: 5%">Nota</th>
						<th style="width: 20%">Clave</th>
						<th style="width: 25%">Descripcion</th>
						<th style="width: 5%">Cantidad</th>
						<th style="width: 5%">PrecioUnit</th>
						<th style="width: 5%">Subtotal</th>
						<th style="width: 5%">Iva</th>
						<th style="width: 5%">Importe</th>
						<th style="width: 5%">Devol</th>
						<th style="width: 5%">Total</th>
						<th></th>
						<th></th>
					 </tr>
				    </thead>
				<tbody>
				</tbody>
		</table>
</div>



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
					
			</ul>

    
	<!--Barra de Navegacion, contiene el contenido que se muestra de lado derecho-->
	<div id="navigatorpanel">
		<ul id="nav-right">
			<li><a id="close" onClick="javascript:window.close();">Salir</a></li>
		</ul>
		
	</div>
	
	
		<div class="container">
			<div>
				<h3></br>Lista de Ventas, presione en el boton Devolver cuando un Cliente devuelva algun producto indicado.<br>¡IMPORTANTE! Tenga cuidado al realizar una devolución.</h3>
			</div>
			
			<table id="search" class="display"cellspacing="0"  width="760px">
				<thead>	
					<tr>
						<th style="width: 5%">Fecha</th>
						<th style="width: 5%">Hora</th>
						<th style="width: 5%">Nota</th>
						<th style="width: 5%">Usuario</th>
						<th style="width: 5%">Cliente</th>
						<th style="width: 5%">Estado</th>
						<th style="width: 5%">Importe</th>
						<th style="width: 5%">Descuento</th>
						<th style="width: 5%">IVA</th>
						<th style="width: 5%">Total</th>
						<th style="width: 5%"></th>
					 </tr>
				    </thead>
				    <thead>
				    <tr>
						<th><input class="boxinit" style="width: 90%" type="text" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" /></th>
					</tr>								
				</thead>
				    
				<tbody>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
					
	 	</div>
	</div>
</body>
</html>
