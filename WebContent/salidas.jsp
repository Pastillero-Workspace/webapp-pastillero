<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="mx.com.pastillero.model.dao.ProductoDao"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>Pastillero 4.0 | Recepciones </title>
<meta name="description" content="venta">
<link href="<c:url value="/resources/css/edit.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/recepcionstyle.css" />"rel="stylesheet">
<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>"rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/jquery.dataTables.css" />"rel="stylesheet">
<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">

<!-- Javascript functions-->
<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
<script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
<script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script>
<script src="<c:url value="/resources/js/demo.js" />"></script>
<script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
<script src="<c:url value="/resources/js/jquery.tabletojson.min.js" />"></script>





<!--  Script inicializador -->

<script type="text/javascript" language="javascript" class="init">
	/* Codigo javascript agrega*/
	
	// PASAR CODIGO A REFACTORING : Codigo de prueba funcional para el tratamiento de la tabla
	
	$(document)
			.ready(
					function() {
						var t = $('#salidas').DataTable({
							dom : "rtiS",
							"stateSave" : true,
						    "bSort": false,
							scrollY : 200,
							scrollCollapse : true
						});
												
						var counter = 0;
						
						$(window).load(function(){
							$( "#txtFecha" ).datepicker({ dateFormat: "dd-mm-yy"});		
							$( "#txtCaducidad" ).datepicker({ dateFormat: "dd-mm-yy"});
							$.post('salida.jr',{
								tarea: "cargar"
							},function(data){
								$("#txtFolio").val(data);
							});
						});
												
						$(this).keypress(function(e){
							if(e.which == 17){
								console.log("se presiono tecla espaciadora");	
							}	
						});
						
						//No esta en uso, se reemplazo por funcion dentro del metodo click del boton Editar $('#btnEditar')
						  window.editar = function editar () 
						  {
								var t = $('#salidas').DataTable();
							  	var cont=0;	
							  	$('#salidas tbody').on('click','button',function(){
							  		++cont;
								  	var obj = t.row( $(this).parents('tr') ).data();
									//index = t.row('.selected').index();
									if(cont==1){
										index = t.row( $(this).parents('tr') ).index();
										 										 		
										$("#txtCantidad").val(obj[0]);
										$("#txtCodigo").val(obj[1]);
										$("#txtDescp").val(obj[2]);
										if(obj[3]=="1"){
											$('#chkIVA').prop('checked',true);
										}
										if(obj[4]=="1"){
											$('#chkIEPS1').prop('checked',true);
										}
										$("#txtCosto").val(obj[5]);
										$("#txtImporte").val(obj[6]);
										$("#txtLote").val(obj[7]);
										$("#txtCaducidad").val(obj[8]);
										
										$("#txtLote").prop('disabled',false);
										$("#txtCaducidad").prop('disabled',false);
										$('#btnAgregar').prop('disabled',true);
										$('#btnModificar').prop('disabled',false);
										$("#Del"+index+"").prop('disabled',true);
									}
								});
							};  
							    
							window.eliminar = function eliminar () 
							{
								var t = $('#salidas').DataTable();
								var cont=0;
						 	  	$('#salidas tbody').on('click','button',function(){
						 	  		++cont;
						 	  		if(cont==1){
							 			t.row( $(this).parents('tr') ).remove().draw( false );
						 	  		}
							  	});
							};
				
						
						//Tecla enter en todos los campos
						$("#txtFecha").keypress(function(e){
							if(e.which == 13){
								$("#txtMerma").focus();
							}
						});
						$("#txtMerma").keypress(function(e){
							if(e.which == 13){
								$("#txtResponsable").focus();
							}
						});
						$("#txtResponsable").keypress(function(e){
							if(e.which == 13){
								$("#txtFolio").focus();
							}
						});
						$("#txtFolio").keypress(function(e){
							if(e.which == 13){
								$("#txtFactura").focus();
							}
						});
						
						$("#txtFactura").keypress(function(e){
							if(e.which == 13){
								
								$('#txtCantidad').prop('disabled',false);
								$('#txtCodigo').prop('disabled',false);
								$('#chkIVA').prop('disabled',false);
								$('#chkIEPS1').prop('disabled',false);
								$('#txtCosto').prop('disabled',false);
								$('#btnAgregar').prop('disabled',false);
								$('#btnModificar').prop('disabled',true);
								
								$("#form-mensaje").dialog("open");
							
							}
						});
						$("#txtCantidad").keypress(function(e){
							if(e.which == 13){
								var cantidad = $("#txtCantidad").val();
								if(cantidad>0){
									$("#txtCodigo").focus();	
								}else{
									window.alert("La cantidad de producto no puede ser menor a 1")
								}
								
							}
						});
						$("#txtCodigo").keypress(function(e) {
							if(e.which == 13){
								var codigo=$('#txtCodigo').val();
								
								$.post('salida.jr',{tarea:'buscar',txtCodigo:codigo}, function(descripcion){
									console.log(descripcion);
									if(descripcion!=0){
										var datos = descripcion.split("~");
										if(datos[4]<=0){
											alert("El producto no se puede agregar porque no tiene existencias");
										}else{
											$('#txtDescp').val(datos[0]);
											if(datos[1]=="2")
												$('#chkIVA').prop('checked',true);
											if(datos[2]=="2")
												$('#chkIEPS1').prop('checked',true);
											
											$("#txtCosto").val(datos[3]);
											$("#btnAgregar").focus();
										}
									}else{
										window.alert("Error, el codigo no existe");
										$("#txtCodigo").select();
									}
									
								});
							}
							
						});
						$("#txtCosto").keypress(function(e){
							if(e.which == 13){
								var costo = $("#txtCosto").val(); 
								if(costo>0){
									$("#btnAgregar").focus();
								}else{
									window.alert("El costo del producto debe ser mayor a $0.00");
								}
							}
						});
						$("#txtFormLote").keypress(function(e){
							if(e.which == 13){
								$("#txtFormCaducidad").focus();		
							}
						});
						$("#txtFormCaducidad").keypress(function(e){
							if(e.which == 13){
								$("#btnAceptar").focus();		
							}	
						});
						
						// se establece el control al detectar tecla enter en el campo
							
						$('#btnAgregar').on('click ',function(e){
							var cantidad = $('#txtCantidad').val(); 
							var codigo = $('#txtCodigo').val(); 	
							var descp = $('#txtDescp').val(); 
							var costo = $('#txtCosto').val();
								
									
							if(cantidad.trim()!=""&&codigo.trim()!=""&&descp.trim()!=""&&costo.trim()!=""){
								$("#form-salidas").dialog("open");
											
							}else{
								window.alert("Revise que ninguno de los datos esten vacios y/o los descuentos sean igual o mayores que 0");
								$('#txtCantidad').focus();
							}
						});	
													
						
						$('#btnModificar').on('click ',function(e){
							console.log("click en modificar");
							t.row(index).data([
						            
						            $('#txtCantidad').val(),
									$('#txtCodigo').val(),
									$('#txtDescp').val(),						
									$('#chkIVA:checked').length,
									$('#chkIEPS1:checked').length,
									$('#txtCosto').val(),
									($('#txtCantidad').val()*$('#txtCosto').val()).toFixed(2),
									$("#txtLote").val(),
									$("#txtCaducidad").val(),
									'<button type="button" class="myButton" id="Mod'+index+'" onclick="editar()">Editar</button>',
									'<button type="button" class="myButton" id="Del'+index+'" onclick="eliminar()">X</button>'
							 ]);
							$('#txtCantidad').val("1"),
							$('#txtCodigo').val(""),
							$('#txtDescp').val(""),
							$('#chkIVA').prop('checked',false);
							$('#chkIEPS1').prop('checked',false);
							$('#txtCosto').val("");
							$('#txtImporte').val("");
							$("#txtLote").val("");
							$("#txtCaducidad").val("");
															
						});
						$("#btnGuardar").button().click(function(){
							var table = $("#salidas").tableToJSON();
							$.post("salida.jr",{
								tarea: "guardar",
								txtFecha: $("#txtFecha").val(), 
								txtMerma: $("#optMerma").val(),
								txtResponsable: $("#txtResponsable").val(),
								txtFolio: $("#txtFolio").val(),
								txtFactura: $("#txtFactura").val(),
								tblDatos: JSON.stringify(table)	
							});
							t.row('').remove().draw( false );
							window.alert("Salida de mercancia realizada.");
							$("#txtFecha").val("");
							$("#txtFolio").val("");
							$("#txtFactura").val("");
							window.close();
						});
							
							
						 // PASAR CODIGO A REFACTORING : Eliminacion de filas
						  $('#example tbody').on( 'click', 'tr', function () {
							        if ( $(this).hasClass('selected') ) {
							            $(this).removeClass('selected');
							            
							        }
							        else {
							            t.$('tr.selected').removeClass('selected');
							            $(this).addClass('selected');
							        }
						  });
						
						$("#txtFormCaducidad").datepicker({ dateFormat: "dd-mm-yy"});
						$("#form-salidas").dialog({
							modal: true,
							autoOpen: false,
							closeOnEscape: true,
							buttons:{
								"Aceptar": {
									text: "Aceptar",
									id: "btnAceptar",
									click: function(){
											
										if($("#txtFormLote").val()!=""&&$("#txtFormCaducidad").val()!=""){
											var codigo1 = "";
											var tamano = $("#txtCodigo").val().trim().length;
											if(tamano<16){
												var falta = 16 - tamano;
												for(var i=0;i<falta;i++){
													codigo1 = "0".concat(codigo1);
												}
											}
											
											t.row.add([
												$('#txtCantidad').val(),
												codigo1.concat($("#txtCodigo").val().trim()),
												$('#txtDescp').val(),						
												$('#chkIVA:checked').length,
												$('#chkIEPS1:checked').length,
												($('#txtCosto').val()*1).toFixed(2),
												($('#txtCosto').val()*$('#txtCantidad').val()).toFixed(2),
												$("#txtFormLote").val(),
												$("#txtFormCaducidad").val(),
												'<button type="button" class="myButton" id="Edit'+counter+'" onclick="editar()">Editar</button>',
												'<button type="button" class="myButton" id="Del'+counter+'" onclick="eliminar()">X</button>'
											])
											.draw();
										    counter++;	
											$('#txtCantidad').val("1");
											$('#txtCodigo').val("");
											$('#chkIVA').prop('checked',false);
											$('#chkIEPS1').prop('checked',false);
											$('#txtCosto').val("");
											$('#txtDescp').val("");
											$("#txtFormLote").val("");
											$("#txtFormCaducidad").val("");
											
											$(this).dialog("close");
											$('#txtCantidad').select();
											$('#txtCantidad').focus();
																				
											
										}else{
											window.alert("Debe contener datos en el campo Lote y Caducidad");
										}
									}
								}		
							}
						});
						$("#form-salidas").dialog("option","width",300);
						$("#form-salidas").dialog("option","height",250);
						
							 
						$("#form-mensaje").dialog({
							modal:true,
							autoOpen: false,
							closeOnEscape: true,
							buttons:{
								"Aceptar":{
									text:"Aceptar",
									id:"btnAceptarForm2",
									click: function(){
											
										$(this).dialog("close");
										$("#txtCantidad").focus();										
										$("#txtCantidad").select();
									}
								}
							}
						});	
						$("#form-mensaje").dialog("option","width",650);
						$("#form-mensaje").dialog("option","height",200);
						

 					});
</script>


</head>

<body>
	<div id="form-mensaje">
		<h4>Si vas a devolver varias piezas de un mismo producto y el lote y caducidad es diferente en cada pieza, debes
			ingresar cada pieza en renglones diferentes de acuerdo a su lote y caducidad para que cada pieza diferente 
			en lote y caducidad se muestre en la pantalla con su respectivo lote y caducidad.
		</h4>
	</div>
	<div id="form-salidas" title="Lote y Caducidad de mercancia">
		<form id="formSalidas">
			<ol>
				<li><label for="lblLote">LOTE: </label><input type="text" id="txtFormLote" name="txtFormLote"></li>
				<li><label for="lblCaducidad">CADUCIDAD: </label><input type="text" id="txtFormCaducidad" name="txtFormCaducidad" ></li>
			</ol>
		</form>
	</div>
	
	 	<%  HttpSession sesion = request.getSession(false);
		String usuario = (String)sesion.getAttribute("usuario");
		String nombre = (String)sesion.getAttribute("nombre");
		String apepat = (String)sesion.getAttribute("apepat");
		%>
	<!-- barra de navegación  de la pagina -->
	<nav> </nav>
	<div class="container-p clearfix">
	  <form method="post" action="/webapp-pastillero/recepcion.jr">
		<!-- contenedor principal wrapper -->
		<div id="width-extension">
			<label id="title-point">SALIDA DE MERCANCIAS</label>
		</div>
		<div id="width-extension">
			<!-- panel superior S1 -->
			<div class="float-left">
				<!-- wrapper 1 -->
				
				<label id="box-caja">Fecha</label>
				<%
					Date date = new Date();
					DateFormat fecha = new SimpleDateFormat("dd-MM-yyyy");
					out.println("<input type=\"text\" id=\"txtFecha\" name=\"txtFecha\" value="+fecha.format(date)+">");
				%>
					
					
			</div>
			<div class="float-left">
				<!-- wrapper 1 -->
				<label id="lblMerma">Merma</label>
					<select id="optMerma" name="optMerma">
						<option value="Quebrado">1. Quebrado</option>
						<option value="Caducado">2. Caducado</option>
						<option value="Robo">3. Robo</option>
						<option value="ProblemasSIF">4. Problemas de SIF</option>
						<option value="Magia">5. Magia</option>
						<option value="Cobranza">6. Devolucion por Cobranza</option>
						<option value="Promo">7. Devolucion por Promo nadro</option>
						<option value="Traspaso">8. Por Traspaso</option>
					</select>
					
			</div>
			<div class="float-left">
			<!-- div class="box-container clearfix"-->
				<label id="lblResponsable">Responsable</label>
					<!-- input type="text" id="txtUsuario"-->
					<input type="text" name="txtResponsable" id="txtResponsable" value="<%=nombre%>" disabled></input>
			</div>
			<div class="float-left">
				<!-- wrapper 1 -->
				<label id="lblFolio">Folio Electronico</label>
					<input type="text" id="txtFolio" name="txtFolio" disabled>
					
			</div>
			
			<div class="float-left">
				<label id="lblFactura">Factura</label>
				<input type="text" id="txtFactura" name="txtFactura">
			</div>
			
		</div>
		
		
		<!-- Panel S2-->
		<div id="width-extension">
			<div class="datagridstyle">
					<section>
					<!-- form id="formrecepcion" action="" method="post"-->
						<table id="salidas" class="display" cellspacing="0" width="100%">
							<thead>
								<tr>									
									<th style="width: 1%">Cant</th>
									<th style="width: 11%">Codigo</th>
									<th style="width: 25%">Descripcion</th>
									<th style="width: 0%">IVA</th>
									<th style="width: 0%">IEPS1</th>
									<th>Costo</th>
									<th>Importe</th>
									<th>Lote</th>
									<th>Caducidad</th>
									<th style="width: 10%"></th>
									<th style="width: 7%"></th>
									
									
					
									
								</tr>
							</thead>
							<thead>						
								<tr>
									<th style="width: 5%"><input type="text" id="txtCantidad" name="txtCantidad" value="1" disabled="disabled"></th>
									<th style="width: 17%"><input type="text" id="txtCodigo" name="txtCodigo"  disabled="disabled"></th>
									<th style="width: 25%"><input type="text" id ="txtDescp" name="txtDescp" disabled="disabled"></th>
									<th style="width: 1%"><input type="checkbox" id="chkIVA" name="chBoxIva" disabled="disabled"></th>
									<th style="width: 1%"><input type="checkbox" id="chkIEPS1" name="chBoxIeps1" disabled="disabled"></th>
									<th style="width: 8%"><input type="text" id="txtCosto" name="txtCosto" disabled="disabled"></th>
									<th style="width: 8%"><input type="text" id="txtImporte" name="txtImporte" disabled="disabled"></th>
									<th style="width: 8%"><input type="text" id="txtLote" name="txtLote" disabled="disabled"></th>
									<th style="width: 10%"><input type="text" id="txtCaducidad" name="txtCaducidad" disabled="disabled"></th>
									<th style="width: 10%"><button type="button" class="myButton" id="btnAgregar" name="btnAgregar" disabled="disabled">Agregar</button></th>
									<th style="width: 15%"><button type="button" class="myButton" id="btnModificar" name="btnModificar" disabled="disabled">Agr.Editado</button></th>
							
								</tr>
							</thead>
							<tbody>
							</tbody>
							<tfoot>
							</tfoot>
						</table>
					<!--/form-->

					</section>
			</div>
		</div>
		<!-- S2-->
		<!-- Panel S3-->
			<div id="width-extension">
					<button type="button" id="btnGuardar" name="btnGuardar">Guardar</button>
			</div>
	 </form>
	</div>
	<!-- contenedor principal -->
	

</body>
</html>