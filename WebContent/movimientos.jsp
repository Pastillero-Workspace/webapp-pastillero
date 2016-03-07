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
	<script src="<c:url value="/resources/js/jquery.tabletojson.js" />"></script>
	<script src="<c:url value="/resources/js/jquery.tabletojson.min.js" />"></script>
	<script src="<c:url value="/resources/js/blockUI/jquery.blockUI.js" />"></script>
	
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
	   
				
  </script>
  <script type="text/javascript">
  		var op = false;
		/*Funcion que muestra el formulario de "Alta Medico"*/
		$(document).ready(function () {
			
			$("#search thead input").on( 'keypress changed', function (e) 
					{  
							 table
							.column( $(this).parent().index()+':visible' )
							.search(this.value)
							.draw();				
		                  
					} );
			
					// Se establece el control de datos al destino
					var table = $('#search').DataTable( {
					//deferRender:    true,
					dom: "lrtip",
					//dom:            "rtiS",
					//dom:            "frtiS", //propiedad para mostrar cuadro de busqueda general
					"bSort":false,
					scrollY:        500,
					//scrollCollapse: true,
					paging: false
					} );
					
 				// botones adicionales para limpiar campos de textos
 				/*$('<input type="button" id="refresh" style="width: 25%" value="Limpiar datos"/>').appendTo('div.dataTables_filter');
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
 				});	*/
			
			
	        	$("#btnExcel").button().click(function(e){
					var t = $('#search').tableToJSON();
				    console.log(t.length);
				    var x = $('#search').DataTable();
				   console.log(x.page.info());
					$.post('reporte.jr',{
						reporte: 'movimientos',
						txtTitulo:'Reporte de Movimientos',
						tblMovimientos:JSON.stringify(t)					
					}, function(f){
					});
					window.open("reporte.jsp", "Impresion", "height=600,width=400");
	        	});
	        	
	        	$("#txtFechaIni").datepicker({ dateFormat: "dd-mm-yy"});	
	        	$("#txtFechaFin").datepicker({ dateFormat: "dd-mm-yy"});
	        	$("#btnBuscar").button(function(){
	        		
	        	});
	        	$('#txtFechaIni').keypress(function(event) {
					if (event.which == 13) {
						 $('#txtFechaFin').focus();
						 
				}});
	        	$('#txtFechaFin').keypress(function(event) {
					if (event.which == 13) {
						 $('#btnBuscar').focus();
						 
				}});
	        	$('#txtBuscarCodigo').keypress(function(event) {
					if (event.which == 13) {
						 $('#btnBuscar').focus();
						 
				}});
	        	$('#txtBuscarDocumento').keypress(function(event) {
					if (event.which == 13) {
						 $('#btnBuscar').focus();
						 
				}});
	        	$('#txtBuscarDescripcion').keypress(function(event) {
					if (event.which == 13) {
						 $('#btnBuscar').focus();
						 
				}});
	        	
	        	$("#btnBuscar").button().click(function(e){
	        		if($("#txtMovimiento option:selected").val().trim() != "0"
	        		 || ($("#txtFechaIni").val().trim() != "" && $("#txtFechaFin").val().trim() != "") || $("#txtBuscarCodigo").val().trim() != ""
	        		 || $("#txtBuscarDocumento").val().trim() != "" || $("#txtBuscarDescripcion").val().trim() != ""){
	        			$.ajax({
	        				async:false,
	        		        cache:false,
						    dataType:"json",
	        		        type: 'POST',  
	        		        url: "movimientos.jr",
	        		        data: {
	        		        	txtMovimiento: $("#txtMovimiento option:selected").val(),
	        		        	txtFechaIni:  $("#txtFechaIni").val().trim(),
	        		        	txtFechaFin:  $("#txtFechaFin").val().trim(),
	        		        	txtCodigo:  $("#txtBuscarCodigo").val().trim(),
	        		        	txtDocumento:  $("#txtBuscarDocumento").val().trim(),
	        		        	txtDescripcion:  $("#txtBuscarDescripcion").val().trim()
	        		        }
	        			}).done(function(movimientos){
	        				if(movimientos.length > 0){
	        					table.clear().draw();
	    						$.each(movimientos, function(i, movimiento){
	    							  var fecha1 = movimiento.fecha.split("-");
	    							  var fecha = fecha1[2]+"-"+fecha1[1]+"-"+fecha1[0];
	    							  var descripcion = movimiento.descripcion.replace("'", " ");
	    							  table.row.add([
	    									movimiento.tipo,
	    									movimiento.idNota,
	    									movimiento.documento,
	    									movimiento.clave,
	    									descripcion,		   	               
	    									movimiento.adquiridos,
	    									movimiento.vendidos,
	    									movimiento.valor,
	    									movimiento.habian,
	    									movimiento.quedan,
	    									movimiento.utilidad,
	    									fecha,
	    									movimiento.hora
	    							  ]);
	    						});
	    						table.draw();
	    						$.unblockUI();	
	        				}else{
	        					$.unblockUI();
	        					alert("No se encontraron movimientos, modifique la busqueda.");
	        				}
	        			}).fail(function(xhr,textStatus, errorThrown){
	        				$.unblockUI();
	        				alert("Error al procesar la recepcion: "+errorThrown+" ,"+xhr+" ,"+textStatus);
	        		    });
	        			$("#txtMovimiento").val("0");
						$("#txtFechaIni").val("");
						$("#txtFechaFin").val("");
						$("#txtBuscarCodigo").val("");
						$("#txtBuscarDocumento").val("");
						$("#txtBuscarDescripcion").val("");	
					}else{
						alert("Para realizar una busqueda llene alguno de los campos");
					}
					
				});
	        	
	        	         		        	
	        	// pagina de espera con block page
				function blockpage() {
					$.blockUI({
						css : {
							border : 'none',
							padding : '15px',
							backgroundColor : '#000',
							'-webkit-border-radius' : '10px',
							'-moz-border-radius' : '10px',
							opacity : .6,
							color : '#fff'
						}
					});
				}
	        	
	    });

		
	/*Salir*/
	    $(document).ready(function(){
        	$("#close").click(function(){               
            	var r = confirm("Desea cerrar el panel ?");
            	if (r == true){
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
	
	<div STYLE="float: left; top:150px; left:10px; width:500px; background-color:#00cccc;  margin: 20px;">
				<h3>Seleccione algún criterio de búsqueda para mostrar movimientos.</h3>
				<table>
					<tr>
						<td><label for="tipoMovimiento"><b>Movimiento: </b></label></td>
						<td>
							<select id="txtMovimiento" name="txtMovimiento">
								<option value="0">- Seleccione -</option>
								<option value="1">Venta</option>
								<option value="2">Recepcion</option>
								<option value="3">Salidas</option>
								<option value="4">Devolucion s/Compra</option>
								<option value="5">Devolucion s/Venta</option>
							</select>
						</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><label for="fechaIni"><b>Fecha Ini: </b></label></td>
						<td><input type="text" id="txtFechaIni" name="txtFechaIni" size="20" /></td>
						<td><label for="fechaFin"><b>Fin:</b></label></td>
						<td><input type="text" id="txtFechaFin" name="txtFechaFin" size="20" /></td>
						<td><button type="button" id="btnBuscar">Buscar.</button></td>
					</tr>	
					<tr>
						<td><label for="codigo"><b>Codigo: </b></label></td>
						<td><input type="text" id="txtBuscarCodigo" name="txtBuscarCodigo" size="20"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>				
					<tr>
						<td><label for="documento"><b>Documento: </b></label></td>
						<td><input type="text" id="txtBuscarDocumento" name="txtBuscarDocumento" size="20"></td>
						<td></td>
						<td></td>
						<td></td>					
					</tr>
					<tr>
						<td><label for="descripcion"><b>Descripci&oacute;n: </b></label></td>
						<td><input type="text" id="txtBuscarDescripcion" name="txtBuscarDescripcion" size="20"></td>
						<td></td>
						<td></td>
						<td></td>					
					</tr>
				</table>
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
