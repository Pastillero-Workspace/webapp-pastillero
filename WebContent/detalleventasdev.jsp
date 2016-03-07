<%@page import="mx.com.pastillero.model.formBeans.DetalleDevolucionVenta"%>
<%@page import="mx.com.pastillero.utils.DevolucionVentaDet"%>
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
		width: 400px;
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
		    
		    
			$("#devolucion thead input").on( 'keypress changed', function (e) 
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
			List<DetalleDevolucionVenta>detalle = DevolucionVentaDet.getDetalleVenta();
			int tam = detalle.size();
			
			for(int i=0; i<detalle.size(); i++){
				String[] fecha1 = detalle.get(i).getFecha().toString().split("-");
				String fecha = fecha1[2]+"-"+fecha1[1]+"-"+fecha1[0];
				
			
		%>
		
		data[<%=i%>]=['<%=fecha%>',
				   '<%=detalle.get(i).getNota()%>',
				   '<%=detalle.get(i).getClave()%>',
				   '<%=detalle.get(i).getDescripcion()%>',
				   '<%=detalle.get(i).getCantidad()%>',
				   '<%=detalle.get(i).getPrecioUnitario()%>',
				   '<%=detalle.get(i).getSubtotal()%>',
				   '<%=detalle.get(i).getIva()%>',
				   '<%=detalle.get(i).getImporte()%>',
				   '<%=detalle.get(i).getDevolucion()%>',
				   '<%=detalle.get(i).getTotal()%>',
				   '<button id="btn<%=i%>">Dev</button>',
				   '<input type="text" id="inp<%=i%>" size="3" disabled> '];
		 <%
		 }
		 DevolucionVentaDet.limpiar();
		 %>
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
			var devolucion = [];
			$("#formDevVentas").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				buttons:{
					"Cancelar": {
						text: "Cancelar",
						id:		"btnCancelar",
						click:	function(){
								$("#formDevVentas").dialog("close");
						}
					},
					"Aceptar": {
						text: "Aceptar",
						id:		"btnAceptar",
						click:	function(){
								var numDatos = <%=tam%>;
								var t = $('#search').DataTable();
								var obj = [];
								var cont = 0;
								for(var i = 0; i<numDatos;i++){
									if($("#inp"+i+"").val() != 0){
										obj = t.row(i).data();
										if($("#inp"+i+"").val() <= 0 || $("#inp"+i+"").val() > obj[4]){
											alert("La cantidad devuelta no puede ser 0 ni mayor a la cantidad adquirida, verifique la cantidad devuelta");
										}else{
											//$.post("devolucion.jr",{
											//	devolucion: "detalleVenta"
											//	
											//},function(e){
											//});
											devolucion[cont] = [obj[2],obj[3],$("#inp"+i+"").val(),0,obj[5],obj[5]*$("#inp"+i+"").val(),obj[7],(obj[7]*1)+(obj[5]*$("#inp"+i+"").val())];
											cont++;
											//devolucion[0]=['uno','dos','tres','cuatro','cinco','seis','siete','ocho'];
											
										}
									}	
								}
								// Se establece el control de datos al destino
								var table2 = $('#devolucion').DataTable( {
								data:	devolucion,
								dom : "rtiS",
								"stateSave" : true,
							    "bSort": false,
							    scrollY : 300,
								scrollCollapse : false
								});
								
								//var table = $('#example').DataTable();
								 
							    $('#devolucion tbody').on( 'click', 'tr', function () {
							        if ( $(this).hasClass('selected') ) {
							            $(this).removeClass('selected');
							        }
							        else {
							            table2.$('tr.selected').removeClass('selected');
							            $(this).addClass('selected');
							        }
							    });
							    $("#formDevVentas2").dialog("open");								
								$("#formDevVentas").dialog("close");
						}
					}
				}
			});
			$("#formDevVentas").dialog("option", "width", 450);
			$("#formDevVentas").dialog("option", "height", 330);
			
			
			$("#formDevVentas2").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				buttons:{
					"Cancelar": {
						text: "Cancelar",
						id:		"btnCancelarImprimir",
						click:	function(){
								devolucion.length=0;
								$("#formDevVentas2").dialog("close");
								window.close();
						}
					
					},
					"AceptarImprimir": {
						text: "Aceptar e Imprimir",
						id:		"btnAceptarImprimir",
						click:	function(){
								var table = $("#devolucion").tableToJSON();
								$.post("devolucion.jr",{
									devolucion: "detalleVenta",
									txtUsuario: $("#lbluser").text(),
									txtMotivo: $("#motivo").text(),
									tbldatos: JSON.stringify(table)
								},function(e){	
								});
								console.log(table[0]);
								devolucion.length=0;
								$("#formDevVentas2").dialog("close");
								setTimeout(function(){
									var popPrinter;
									popPrinter = window.open("ticketdevventa.jsp", "Impresion", "height=600,width=400");			 			
						 			popPrinter.focus();
						 	
								},4500);
								setTimeout(function(){
					 				window.close();	
					 			},5500);
								
						}
					}
				}
			});
			$("#formDevVentas2").dialog("option", "width", 900);
			$("#formDevVentas2").dialog("option", "height", 500);
							
				<%for(int i=0;i<tam;i++){%>
					$("#btn"+<%=i%>).button().click(function(){
						$("#inp"+<%=i%>).prop("disabled",false);
						$("#inp"+<%=i%>).select();
						
					});
				<%}%>
				$("#btnDevolver").button().click(function(){
					
				});
				$("#btnProcesar").button().click(function(){
					$("#formDevVentas").dialog("open");	
				});		
				$("#btnAceptar").button().click(function(){
					
				});
				$("#btnCancelar").button().click(function(){
	
				});
				$("#motivo1").click(function(){
					$("#motivo").text("El Cliente no necesita el producto");
					
				});
				$("#motivo2").click(function(){
					$("#motivo").text("El Cliente cambia presentacion del mismo producto");
					
				});
				$("#motivo3").click(function(){
					$("#motivo").text("El Cliente pide otro producto diferente");
					
				});
				$("#motivo4").click(function(){
					$("#motivo").text("El Cliente reclama mal estado o Caducidad");
					
				});
				$("#motivo5").click(function(){
					$("#motivo").text("El Cliente reclama precio alto");
					
				});
				$("#motivo6").click(function(){
					$("#motivo").text("El Cliente solicita otro producto parecido");
					
				});
				$("#motivo7").click(function(){
					$("#motivo").text("S.Dom: Producto no coincide con la hoja de Pedido");
					
				});
				$("#motivo8").click(function(){
					$("#motivo").text("S.Dom: El Producto no es el que el Cliente pedia");
					
				});
				$("#motivo9").click(function(){
					$("#motivo").text("S.Dom: El tiempo de entrega fue inadecuado");
					
				});
				$("#motivo10").click(function(){
					$("#motivo").text("S.Dom: No se encontro al Cliente");
					
				});
				
				
				
				$("#menu").menu();
					
				
				
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
<div id="formDevVentas" title="Seleccion de Codigo de Razon" class="text-form">
	<div>
		<label id="motivo">Seleccione el motivo de la devolucion</label>
		<ul id="menu">
			<li id="motivo1">El Cliente no necesita el producto</li>
			<li id="motivo2">El Cliente cambia presentacion del mismo producto</li>
			<li id="motivo3">El Cliente pide otro producto diferente</li>
			<li id="motivo4">El Cliente reclama mal estado o Caducidad</li>
			<li id="motivo5">El Cliente reclama precio alto</li>
			<li id="motivo6">El Cliente solicita otro producto parecido</li>
			<li id="motivo7">S.Dom: Producto no coincide con la hoja de Pedido</li>
			<li id="motivo8">S.Dom: El Producto no es el que el Cliente pedia</li>
			<li id="motivo9">S.Dom: El tiempo de entrega fue inadecuado</li>
			<li id="motivo10">S.Dom: No se encontro al Cliente</li>
		</ul>
	</div>
</div>

<div id="formDevVentas2" title="Productos devueltos" class="text-form">
	<div>
		<table id="devolucion" class="display"cellspacing="0"  width="800px">
				<thead>	
					<tr>
						<th style="width: 25%">Clave</th>
						<th style="width: 35%">Descripcion</th>
						<th style="width: 10%">Cantidad</th>
						<th style="width: 10%">Unit s/desc</th>
						<th style="width: 10%">PrecioUnit</th>
						<th style="width: 10%">Subtotal</th>
						<th style="width: 10%">Iva</th>
						<th style="width: 10%">Importe</th>
					 </tr>
				    </thead>    
				<tbody>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
	</div>
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
				<tfoot>
				</tfoot>
			</table>
			<div align="center">
				<button id="btnDevolver">Devolver toda la nota</button>
				<button id="btnProcesar">Procesar</button>
			</div>		
	 	</div>
	</div>
</body>
</html>
