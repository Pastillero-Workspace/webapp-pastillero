<%@page import="mx.com.pastillero.model.dao.DevolucionesDao"%>
<%@page import="java.util.List"%>
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
			List<Object[]> recepcion = dev.mostrarRecepcion();
			for(int i = 0; i < recepcion.size();i++){ 
		%>
		data[<%=i%>]=[  '<%=recepcion.get(i)[0]%>',
				        '<%=recepcion.get(i)[1]%>',
				   	    '<%=recepcion.get(i)[2]%>',
				   	    '<%=recepcion.get(i)[3]%>',
				   	    '<%=recepcion.get(i)[4]%>',
				   	    '<%=recepcion.get(i)[5]%>',
				   	    '<%=recepcion.get(i)[6]%>',
				   	    '<%=recepcion.get(i)[7]%>',
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
				var cantidad = 0;
				<%for(int i=0; i<recepcion.size(); i++){%>
					var obj=[];
					$("#"+<%=i%>).button().click(function(){
						var t = $('#search').DataTable();
						var cont=0;
						$('#search tbody').on('click','button',function(){
							++cont;
							obj = t.row( $(this).parents('tr') ).data();
							if(cont==1){
								$.post('devolucion.jr',{
									devolucion:'verificaCompra',
									txtCodigo: obj[5],
									txtDocumento: obj[3]
								},function(verifica){
									console.log(verifica);
									if(parseInt(verifica) < parseInt(obj[4])){
										$.post('salida.jr',{tarea:'buscar',txtCodigo:obj[5]}, function(descripcion){
											console.log(descripcion);
											var datos = descripcion.split("~");
											if(datos[4]<=0){
												alert("No puede devolver el producto porque no tiene existencias");
											}else{
												$("#txtFecha").val(obj[0]);
												$("#txtProveedor").val(obj[1]);
												$("#txtFolio").val(obj[2]);
												$("#txtDocumento").val(obj[3]);
												$("#txtCantidad").val(parseInt(obj[4]) - parseInt(verifica));
												cantidad = obj[4];
												$("#txtCodigo").val(obj[5]);
												$("#txtDescripcion").val(obj[6]);
												$("#txtCosto").val(obj[7]);
												$("#txtCantidad").focus();
												$("#txtCantidad").select();
												$("#formDevCompras").dialog("open");		
											}
										});
									}
									else{
										alert("No puede devolver este producto, porque ya devolvio la cantidad total de esta recepcion");
									}
								});
							}
						});
					});
				<%}%>
				
				var motivo = "";
				$( "#menu" ).menu();
				$("#item1-1").click(function (e){
					$("#motivo").html("Elija el motivo de la devolucion: Producto Caducado");
					motivo = "Producto Caducado";
				});
				$("#item1-2").click(function (e){
					$("#motivo").html("Elija el motivo de la devolucion: Producto Proximo a Caducar");
					motivo = "Producto Proximo a Caducar"; 
				});
				$("#item2-1").click(function (e){
					$("#motivo").html("Elija el motivo de la devolucion: Producto Falto Completamente");
					motivo = "Producto Falto Completamente";
				});
				$("#item2-2").click(function (e){
					$("#motivo").html("Elija el motivo de la devolucion: Producto Llego Cambiado");
					motivo = "Producto Llego Cambiado";
				});
				$("#item3-1").click(function (e){
					$("#motivo").html("Elija el motivo de la devolucion: Producto Llego Quebrado");
					motivo = "Producto Llego Quebrado";
				});
				$("#item3-2").click(function (e){
					$("#motivo").html("Elija el motivo de la devolucion: Producto Llego Mojado");
					motivo = "Producto Llego Mojado";
				});
				$("#item3-3").click(function (e){
					$("#motivo").html("Elija el motivo de la devolucion: Producto Llego Marcado");
					motivo = "Producto Llego Marcado";
				});
				$("#item3-4").click(function (e){
					$("#motivo").html("Elija el motivo de la devolucion: Producto Llego Maltratado");
					motivo = "Producto Llego Maltratado";
				});
				
				
				$("#formDevCompras").dialog({
					modal:true,
					autoOpen: false,
					closeOnEscape: true,
					buttons:{
						"Agregar": {
							text: "Devolver a Proveedor e imprimir",
							id:		"btnDevolver",
							click:	function(){
								console.log(cantidad);
								console.log($("#txtCantidad").val());
								if(parseFloat($("#txtCantidad").val()) <= 0 || parseFloat($("#txtCantidad").val()) > cantidad){
									window.alert("La cantidad a devolver no puede ser 0  o mayor a la cantidad comprada");
								}else{
									window.alert("correcto");
									$.post('devolucion.jr',{
										devolucion: 'compra',
										txtMotivo: 	motivo,
										txtFolio: 	$("#txtFolio").val(),
										txtCantidad:$("#txtCantidad").val(),
										txtDocumento: $("#txtDocumento").val(),
										txtCodigo: 	$("#txtCodigo").val(),
										txtDescripcion: $("#txtDescripcion").val(),
										txtCosto: $("#txtCosto").val(),
										txtUsuario: $("#lbluser").text()
										},function(e){
									});
									$("#formDevCompras").dialog("close");
									$("#motivo").html("Elija el motivo de la devolucion:");
								}
							}
						}
					}
				});
				$("#formDevCompras").dialog("option", "width", 1100);
				$("#formDevCompras").dialog("option", "height", 370);
				
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


<div id="formDevCompras" title="Devolucion de Compras" class="text-form">
	<form id="devCompras">
		<table>
			<tr>
				<td align="center"><label for="clave">Fecha</label></td>
				<td align="center"><label for="nombre">Proveedor</label></td>
				<td align="center"><label for="folio">Folio</label></td>
				<td align="center"><label for="documento">Documento</label></td>
				<td align="center"><label for="cantidad">Cantidad</label></td>
				<td align="center"><label for="codigo">Codigo</label></td>
				<td align="center"><label for="descripcion">Descripcion</label></td>
				<td align="center"><label for="costo">Costo</label></td>
			</tr>
			<tr>
				<td><input type="text" size="8" id="txtFecha" name="txtFecha" disabled></td>
				<td><input type="text" size="15" id="txtProveedor" name="txtProveedor" disabled></td>
				<td><input type="text" size="5" id="txtFolio" name="txtFolio" disabled></td>
				<td><input type="text" size="5" id="txtDocumento" name="txtDocumento" disabled></td>
				<td><input type="text" size="2" id="txtCantidad" name="txtCantidad"></td>
				<td><input type="text" size="15" id="txtCodigo" name="txtCodigo" disabled></td>
				<td><input type="text" size="25" id="txtDescripcion" name="txtDescripcion" disabled></td>
				<td><input type="text" size="5" id="txtCosto" name="txtCosto" disabled></td>
			</tr>
		</table>
		<h2 id="motivo">Elija el motivo de la devolucion: </h2>
		<table align="center">
		<tr><td>
		<ul id="menu">
			<li><a>Caducidad</a>
				<ul>
					<li id="item1-1">Producto Caducado</li>
					<li id="item1-2">Producto Proximo a Caducar</li>
				</ul>
			</li>
			<li><a>Faltante</a>
				<ul>
					<li id="item2-1">Producto Falto Completamente</li>
					<li id="item2-2">Producto Llego Cambiado</li>
				</ul>
			</li>
			<li><a>Mal Estado</a>
				<ul>
					<li id="item3-1">Producto Llego Quebrado</li>
					<li id="item3-2">Producto Llego Mojado</li>
					<li id="item3-3">Producto Llego Marcado</li>
					<li id="item3-4">Producto Llego Maltratado</li>
				</ul>
			</li>
		</ul>
		</td></tr>
		</table>
	</form>
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
				<h3></br>Lista de Recepciones, presione en el boton Devolver para hacer una devolución al Proveedor del producto indicado.<br>¡IMPORTANTE! Tenga cuidado al realizar una devolución.</h3>
			</div>
			
			<table id="search" class="display"cellspacing="0"  width="760px">
				<thead>	
					<tr>
						<th style="width: 5%">Fecha</th>
						<th style="width: 5%">Proveedor</th>
						<th style="width: 5%">Folio</th>
						<th style="width: 5%">Documento</th>
						<th style="width: 5%">Cantidad</th>
						<th style="width: 5%">Codigo</th>
						<th style="width: 5%">Descripcion</th>
						<th style="width: 5%">Costo</th>
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
