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
	<script src="<c:url value="/resources/js/blockUI/jquery.blockUI.js" />"></script>
	
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
			 window.nota = function nota () 
			{
				var obj=[];
				var t = $('#search').DataTable();
				var nota = "";
				var cont=0;
				$('#search tbody').on('click','button',function(){
					++cont;
					obj = t.row( $(this).parents('tr') ).data();
					if(cont==1){
						if(obj[5] == "COMPLETO"){
							blockpage();
							$.post("devolucion.jr",{
								devolucion: 'venta',
								nota: obj[2]
							},function(e){	
							});
							setTimeout(function(e){
								window.open("detalleventasdev.jsp","_blank");
							},2500);
							$.unblockUI();
						}else{
							alert("No puede devolver una venta si aun no esta Completa");
						}
					}
				});
			}
			
			
		    // Algoritmo de filtrado
			$("#search thead input").on( 'keypress changed', function (e) 
			{  
					 table
					.column( $(this).parent().index()+':visible' )
					.search(this.value)
					.draw();
				    //alert("valor" + $(this).parent().index());					
                  
			} );			
		    
			
			// Se establece el control de datos al destino
			var table = $('#search').DataTable( {
			//data:           data,
			//deferRender:    true,
			//dom:            "frtiS",
			//"bSort":		false,
			//scrollY:        500,
			//scrollCollapse: true,
			//data:	data,
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
				$("#formBuscarNota").dialog({
					modal:true,
					autoOpen: false,
					closeOnEscape: true,
					buttons:{
						"Buscar": {
							text: "Buscar",
							id:		"btnBuscar",
							click:	function(){
									blockpage();
									$("#formBuscarNota").dialog("close");
									var table = $('#search').DataTable();
									table.clear().draw();
									$.post("consultanota.jr",{
										tarea: "consultar",
										txtFechaIni: $("#txtFechaIni").val(),
										txtFechaFin: $("#txtFechaFin").val()
									},function(e){
										$.each(e, function(key, nota) { // Iterate over the JSON object.
											var fecha1 = nota[0].split("-");
											var fecha = fecha1[2]+"-"+fecha1[1]+"-"+fecha1[0];
											table.row.add([fecha,nota[1],nota[2],nota[3],nota[4]
								  			,nota[5],nota[6],nota[7],nota[8]
								  			,nota[9],'<button onclick="nota()" id="'+key+'">Devolver</button>']);
							  			});
							  			table.draw();
									});
									$.unblockUI();
							}
						}
					}
				});
				$("#formBuscarNota").dialog("option", "width", 450);
				$("#formBuscarNota").dialog("option", "height", 200);
				
				$( "#txtFechaIni" ).datepicker({ dateFormat: "dd-mm-yy"});
				$( "#txtFechaFin" ).datepicker({ dateFormat: "dd-mm-yy"});
				
				$("#txtCantidad").keypress(function (e){
					if(e.which == 13){
						$("#btnDevolver").focus();
					}
				});
				$("#btnMostrar").button().click(function(e){
					blockpage();
					var table = $('#search').DataTable();
					table.clear().draw();
					$.post("consultanota.jr",{
						tarea: "mostrar"	
					},function(e){
						 
						 $.each(e, function(key, value) { // Iterate over the JSON object.
							var fecha1 = value[0].split("-");
							var fecha = fecha1[2]+"-"+fecha1[1]+"-"+fecha1[0];
							table.row.add([fecha,value[1],value[2],value[3]
				  			,value[4],value[5],value[6],value[7]
				  			,value[8],value[9],'<button onclick="nota()" id="'+key+'">Devolver</button>']);
			  			});
			  			table.draw();
					});
					$.unblockUI();
				});
				
				$("#btnBuscar").button().click(function(e){
					$("#formBuscarNota").dialog("open");
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

<div id="formBuscarNota" title="Buscar Nota" class="text-form">
	<p>Coloque el rango de fechas entre las cuales se encuentra la nota.</p>
	<label for="fechaIni">Fecha Inicial: </label><input type="text" id="txtFechaIni" size="10">
	<label for="fechaFin">Fecha Final: </label><input type="text" id="txtFechaFin" size="10"> 
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
			<div>
				<button id="btnMostrar">Mostrar todas</button>
				<button id="btnBuscar">Buscar nota</button>
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
