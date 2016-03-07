<%@page import="mx.com.pastillero.types.Types"%>
<%@page import="mx.com.pastillero.model.dao.ProductosDao"%>
<%@page import="mx.com.pastillero.model.dao.FamiliaDao"%>
<%@page import="mx.com.pastillero.model.formBeans.Familia"%>
<%@page import="mx.com.pastillero.model.formBeans.Productos"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
<head>
	<!-- The CSS Styles for forms -->
	<title> Consulta de Productos | </title>
    <link href="<c:url value="/resources/css/edit.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/jquery.dataTables.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
	
	<!-- The Javascript config -->
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
	<script src="<c:url value="/resources/js/blockUI/jquery.blockUI.js" />"></script>
	
	<!-- The Javascript config datatables -->
	<script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
	<script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script>
	<script src="<c:url value="/resources/js/demo.js" />"></script>
	<script src="<c:url value="/resources/js/jquery.tabletojson.min.js" />"></script>
	
	<script type="text/javascript" language="javascript" class="init">
	var op = false;
	var codBarRespaldo = "";
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
			/*$("#search thead input").on( 'keypress changed', function (e){  
					 table
					.column( $(this).parent().index()+':visible' )
					.search(this.value)
					.draw();				                  
			});*/
			$("#filtros input").on( 'keypress changed', function (e){  
				 table
				//.column(5)
				.column( $(this).parent().index()+':visible' )
				.search(this.value)
				.draw();				                  
			});
			
 	         
			// Se establece el control de datos al destino
			var table = $('#search').DataTable({
				//data:	data,
				dom : "plrti",
				"stateSave" : true,
			    "bSort": false,
				scrollY : 900,
				scrollX : 1400,
				scrollCollapse : true,
				"columnDefs": [{
					"targets": [ 1 ],
	                "visible": false
	              },
	              {
					"targets": [ 2 ],
		            "visible": false
		              }]
			});
			
			$('#txtCodigo').keypress(function(event) {
				if (event.which == 13) {
					 $('#btnBuscar').focus();
					 
				}});
			$('#txtDescripcionBusqueda').keypress(function(event) {
				if (event.which == 13) {	
					$('#btnBuscar').focus();
					
				}});
			$("#btnBuscar").button().click(function(e){
				if($("#txtCodigo").val().trim() != ""){
					buscar($('#txtCodigo').val(),"");	
					$('#txtCodigo').val('');
				}else if($("#txtDescripcionBusqueda").val().trim() != ""){
					buscar("",$('#txtDescripcionBusqueda').val());
					$('#txtDescripcionBusqueda').val('');
				}else{
					alert("Para realizar una busqueda llene alguno de los campos");
				}
				
			});
			function buscar(txtcodigo, txtdescripcion){
				blockpage();
				var table = $('#search').DataTable();
				$.ajax({
					url: "consulta.jr",
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        mimeType: 'application/json',
			        data:{
			        	workout:'producto',
			        	txtCodigo: txtcodigo,
			        	txtDescripcion: txtdescripcion
			        	}
				}).done(function(listaConsulta){
					if(listaConsulta.length > 0){
					  table.clear().draw();
					  
					  $.each(listaConsulta, function(i, producto){
						  table.row.add([
						             producto[0],producto[1],producto[2],producto[3],producto[4],producto[5],producto[6],producto[7],producto[8],
						             producto[9],producto[10],producto[11],producto[12],producto[13],producto[14],producto[15],producto[16],producto[17],
						             producto[18],producto[19],producto[20],producto[21],producto[22],producto[23],producto[24],producto[25],producto[26],
						             producto[27],producto[28],producto[29],producto[30],producto[31],producto[32],producto[33],producto[34],producto[35],
						             producto[36],producto[37],producto[38],producto[39],producto[40],producto[41],producto[42],producto[43],producto[44]
						  ]);
					  });
					  table.draw();
					  $.unblockUI();
					}else{
						$.unblockUI();
						alert("No se encontraron productos, intente con otra busqueda.");
					}
				}).fail(function(data,status,er) {
			        	$.unblockUI();
			            alert("error: "+data+" status: "+status+" er:"+er);
			   });
			}
			
			// datatable configuration
		    $('#search tbody').on( 'click', 'tr', function () {
		        if ( $(this).hasClass('selected') ) {
		            $(this).removeClass('selected');
		        }
		        else {
		            table.$('tr.selected').removeClass('selected');
		            $(this).addClass('selected');
		        }
		    } );	
				 
			var index = 0;
			var table = $('#search').DataTable();
			$(function()
			{
				/*RECHARGE*/
				$("#btnRecargar").button().click(function(e){
			        alert ("En construccion");
				});
				/*DELETE*/
				$("#btnEliminar").button().click(function(e){
					index = table.row('.selected').index();
					var registro = table.row('.selected').data();
					var nombreProducto='';
					if (window.confirm("Desea eliminar este producto seleccionado")){ 
						if(index>=0){
							$.each(registro, function(data, value){
							 	if(data==2){
									nombreProducto = value;
								}
							});
							$.post('productos.jr',{
								tarea: 'eliminar',
								txtNombre: nombreProducto
							},function(){
							});
							table.row(index).remove().draw(true);
						}
						else{
							window.alert("Seleccione un producto de la lista para poder eliminarlo");
						}
					}
				});
				$("#btnExcel").button().click(function(e){
					var t = $('#search').tableToJSON();
				    
					$.post('reporte.jr',{
						reporte: 'productos',
						txtTitulo:'Reporte de Productos',
						tblProductos:JSON.stringify(t)					
					}, function(f){
					});
					window.open("reporte.jsp", "Impresion", "height=600,width=400");
				});
				$("#btnAgregar").button().click(function(e)
				{												
						$("#atxtProveedor").select();
						$('input[type="text"]').val('');
						$("#atxtProveedor").val("PASTILLERO");
						$("#atxtProveedor2").val("PASTILLERO");
						$("#atxtProveedor3").val("PASTILLERO");
						$("#atxtClave").val("");
						$("#atxtCodBar").val("");
						$("#atxtDescripcion").val("SIN DESCRIPCION");
						$("#atxtFamilia").val("SIN FAMILIA");
						$("#atxtLinea").val("SINLINEA");
						$("#atxtReferencia").val("SINREF");
						$("#atxtssa").val("SINSSA");
						$("#atxtLaboratorio").val("SIN LABORATORIO");
						$("#atxtDepartamento").val("SINDEPTO");					
						$("#atxtCategoria").val("SINCAT");
						$("#atxtDescuento").val("0");
						$("#atxtCosto").val("0.0");
						$("#atxtEquivalencia").val("SINEQ");
						$("#atxtSuperfamilia").val("SINSFAM");
						$("#atxtCls").val("SINCLASF");
						$("#atxtZona").val("SINZONA");
						$("#atxtPareto").val("SINPAR");
						$("#atxtPareto2").val("SINPAR");
						$("#atxtReferencia").val("SINREF");
						$("#atxtKit").val("SINKIT");
						$("#atxtGrupo").val("SINGRUPO");
						$("#atxtEspecial").val("SINESPEC");
						$("#atxtUProveedor").val("SINUPROVEEDOR");
						//values
						$("#atxtExistencias").val("0");
						$("#atxtPrecPub").val("0.00");
						$("#atxtPrecDesc").val("0.00");
						$("#atxtFarmacia").val("0.00");
						$("#atxtDescBase").val("0");
						$("#atxtmaxDescuento").val("0");
						$("#atxtIva").val("0");
						$("#atxtIeps").val("0");
						$("#atxtIeps2").val("0");
						$("#atxtLimitado").val("0");
						$("#atxtComision").val("0");
						$("#atxtAntibiotico").val("0");
						$("#atxtActualizable").val("0");
						$("#atxtPoliticaOferta").val("0");
						$("#atxtfamActualizar").val("0");
						$("#atxtcomInmediata").val("0");
						$("#atxtUltimoCosto").val("0.00");
						$("#atxtCostoPromedio").val("0.00");
						$("#atxtCostoReal").val("0.00");
						$("#atxtFechaPcio").val("2015-01-01");
						$("#formAlta").dialog("open");						
				});
				
				// agrega todos los datos al campo de editar
				$("#btnEditar").button().click(function(e){
					index = table.row('.selected').index();
					var registro = table.row('.selected').data();
					console.log(registro[3]);
					if(index>=0)
					{
						$.each(registro, function(date,value){
							if(date==0)
							{
								$("#txtProveedor").val(value);
							}
							if(date==1){
								$("#txtProveedor2").val(value);
							}
							if(date==2){
								$("#txtProveedor3").val(value);
							}
							if(date==3){
								$("#txtClave").val(value);
							}
							if(date==4){
								$("#txtCodBar").val(value);
								codBarRespaldo = value;
							}
							if(date==5){
								$("#txtDescripcion").val(value);
							}
							if(date==6){
								$("#txtExistencias").val(value);
							}
							if(date==7){
								$("#txtFamilia").val(value);
							}
							if(date==8){
								$("#txtPrecPub").val(value);
							}
							if(date==9){
								$("#txtPrecDesc").val(value);
							}
							if(date==10){
								$("#txtFarmacia").val(value);
							}
							if(date==11){
								$("#txtFechaPcio").val(value);
							}
							if(date==12){
								$("#txtIva").val(value);
							}
							if(date==13){
								$("#txtLinea").val(value);
							}
							if(date==14){
								$("#txtReferencia").val(value);
							}
							if(date==15){
								$("#txtssa").val(value);
							}
							if(date==16){
								$("#txtLaboratorio").val(value);
							}
							if(date==17){
								$("#txtDepartamento").val(value);
							}
							if(date==18){
								$("#txtCategoria").val(value);
							}
							if(date==19){
								$("#txtActualizable").val(value);
							}
							if(date==20){
								$("#txtDescuento").val(value);
							}
							if(date==21){
								$("#txtCosto").val(value);
							}
							if(date==22){
								$("#txtEquivalencia").val(value);
							}
							if(date==23){
								$("#txtSuperfamilia").val(value);
							}
							if(date==24){
								$("#txtCls").val(value);
							}
							if(date==25){
								$("#txtZona").val(value);
							}
							if(date==26){
								$("#txtPareto").val(value);
							}
							if(date==27){
								$("#txtPareto2").val(value);
							}
							if(date==28){
								$("#txtIeps").val(value);
							}
							if(date==29){
								$("#txtIeps2").val(value);
							}
							if(date==30){
								$("#txtLimitado").val(value);
							}
							if(date==31){
								$("#txtKit").val(value);
							}
							if(date==32){
								$("#txtComision").val(value);
							}
							if(date==33){
								$("#txtmaxDescuento").val(value);
							}
							if(date==34){
								$("#txtGrupo").val(value);
							}
							if(date==35){
								$("#txtDescBase").val(value);
							}
							if(date==36){
								$("#txtPoliticaOferta").val(value);
							}
							if(date==37){
								$("#txtAntibiotico").val(value);
							}
							if(date==38){
								$("#txtEspecial").val(value);
							}
							if(date==39){
								$("#txtfamActualizar").val(value);
							}
							if(date==40){
								$("#txtcomInmediata").val(value);
							}
							if(date==41){
								$("#txtUProveedor").val(value);
							}
							if(date==42){
								$("#txtUltimoCosto").val(value);
							}
							if(date==43){
								$("#txtCostoPromedio").val(value);
							}
							if(date==44){
								$("#txtCostoReal").val(value);
							}						
						});
						$("#formProductos").dialog("open");
						$("#txtProveedor").select();
					}
					else{
						window.alert("Seleccione a un producto antes de editar");
					}
				});
				
			});
			// FORMS
			$("#formAlta").dialog(
					{
						modal:true,
						autoOpen: false,
						closeOnEscape: true,
						buttons:
						{
							    "Agregar": {
								text:   "Agregar",
								id:		"btnAdd",
								click:	function()								
									{
									 if($('#atxtProveedor').val().trim()!=""&&$('#atxtClave').val().trim()!=""&&$('#atxtCodBar').val().trim()!=""&&
										$('#atxtDescripcion').val().trim()!=""&&$('#atxtFamilia').val().trim()!=""&&$('#atxtPrecPub').val().trim()!=""&&
										$('#atxtPrecDesc').val().trim()!=""&&$('#atxtFarmacia').val().trim()!=""&&$('#atxtIva').val().trim()!=""&&
										$('#atxtLinea').val().trim()!=""&&$('#atxtReferencia').val().trim()!=""&&$('#atxtssa').val().trim()!=""&&
										$('#atxtLaboratorio').val().trim()!=""&&$('#atxtDepartamento').val().trim()!=""&&
									    $('#atxtCategoria').val().trim()!=""&&$('#atxtActualizable').val().trim()!=""&&
									    $('#atxtDescuento').val().trim()!=""&&$('#atxtCosto').val().trim()!=""&&
									    $('#atxtEquivalencia').val().trim()!=""&&$('#atxtSuperfamilia').val().trim()!=""&&
									    $('#atxtCls').val().trim()!=""&&$('#atxtZona').val().trim()!=""&&$('#atxtPareto').val().trim()!=""&&
									    $('#atxtIeps').val().trim()!=""&&$('#atxtIeps2').val().trim()!=""&&$('#atxtLimitado').val().trim()!=""&&
									    $('#atxtKit').val().trim()!=""&&$('#atxtComision').val().trim()!=""&&$('#atxtmaxDescuento').val().trim()!=""&&
									    $('#atxtGrupo').val().trim()!=""&&$('#atxtDescBase').val().trim()!=""&&$('#atxtPoliticaOferta').val().trim()!=""&&
									    $('#atxtAntibiotico').val().trim()!=""&&$('#atxtExistencias').val().trim()!=""&&$('#atxtUProveedor').val().trim()!=""&&
									    $('#atxtUltimoCosto').val().trim()!=""&&$('#atxtCostoPromedio').val().trim()!=""&&$('#atxtCostoReal').val().trim()!=""){
											$.post('recepcion.jr',{tarea:'buscar',txtCodigo:$('#atxtCodBar').val().trim()}, function(descripcion){
													if(descripcion==0){
														$.post('productos.jr',				
														        {
																	tarea: 'Agregar',					
																	txtProveedor: $('#atxtProveedor').val(),
																	txtProveedor2: $('#atxtProveedor2').val(),
																	txtProveedor3: $('#atxtProveedor3').val(),
																	txtClave: $('#atxtClave').val(),
																	txtCodBar: $('#atxtCodBar').val(),
																	txtDescripcion: $('#atxtDescripcion').val(),
																	txtFamilia: $('#atxtFamilia').val(),
																	txtPrecioPub: $('#atxtPrecPub').val(),
																	txtPrecDesc: $('#atxtPrecDesc').val(),
																	txtFarmacia: $('#atxtFarmacia').val(),
																	txtFechaPcio: $('#atxtFechaPcio').val(),
																	txtIva: $('#atxtIva').val(),
																	txtLinea: $('#atxtLinea').val(),
																	txtReferencia: $('#atxtReferencia').val(),
																	txtssa: $('#atxtssa').val(),
																	txtLaboratorio: $('#atxtLaboratorio').val(),
																	txtDepto: $('#atxtDepartamento').val(),
																	txtCategoria: $('#atxtCategoria').val(),
																	txtActualizable: $('#atxtActualizable').val(),
																	txtDescuento: $('#atxtDescuento').val(),
																	txtCosto: $('#atxtCosto').val(),
																	txtEquivalencia: $('#atxtEquivalencia').val(),
																	txtSuperfamilia: $('#atxtSuperfamilia').val(),
																	txtCls: $('#atxtCls').val(),
																	txtZona: $('#atxtZona').val(),
																	txtPareto: $('#atxtPareto').val(),
																	txtPareto2: $('#atxtPareto2').val(),
																	txtIeps: $('#atxtIeps').val(),
																	txtIeps2: $('#atxtIeps2').val(),
																	txtLimitado: $('#atxtLimitado').val(),
																	txtKit: $('#atxtKit').val(),
																	txtComision: $('#atxtComision').val(),
																	txtMaxDescuento: $('#atxtmaxDescuento').val(),
																	txtGrupo: $('#atxtGrupo').val(),
																	txtDescBase: $('#atxtDescBase').val(),
																	txtPoliticaOferta: $('#atxtPoliticaOferta').val(),
																	txtAntibiotico: $('#atxtAntibiotico').val(),
																	txtExistencias: $('#atxtExistencias').val(),
																	txtEspecial: $('#atxtEspecial').val(),
																	txtFamActualizar: $('#atxtfamActualizar').val(),
																	txtComInmediata: $('#atxtcomInmediata').val(),
																	txtUProveedor: $('#atxtUProveedor').val(),
																	txtUCosto: $('#atxtUltimoCosto').val(),
																	txtCostoPromedio: $('#atxtCostoPromedio').val(),
																	txtCostoReal: $('#atxtCostoReal').val()
																					
																	},function(data){
																	//if(data == 'Create')
																	//{}									
																  });
														table.row.add
														([										            
															$('#atxtProveedor').val(),
															$('#atxtProveedor2').val(),
															$('#atxtProveedor3').val(),
															$('#atxtClave').val(),
															$('#atxtCodBar').val(),
															$('#atxtDescripcion').val(),
															$('#atxtExistencias').val(),
														    $('#atxtFamilia').val(),
															$('#atxtPrecPub').val(),
															$('#atxtPrecDesc').val(),
															$('#atxtFarmacia').val(),
															$('#atxtFechaPcio').val(),
															$('#atxtIva').val(),
															$('#atxtLinea').val(),
															$('#atxtReferencia').val(),
														    $('#atxtssa').val(),
															$('#atxtLaboratorio').val(),
															$('#atxtDepartamento').val(),
															$('#atxtCategoria').val(),
															$('#atxtActualizable').val(),
															$('#atxtDescuento').val(),
															$('#atxtCosto').val(),
															$('#atxtEquivalencia').val(),
															$('#atxtSuperfamilia').val(),
															$('#atxtCls').val(),
															$('#atxtZona').val(),
															$('#atxtPareto').val(),
															$('#atxtPareto2').val(),
															$('#atxtIeps').val(),
															$('#atxtIeps2').val(),
															$('#atxtLimitado').val(),
															$('#atxtKit').val(),
															$('#atxtComision').val(),
															$('#atxtmaxDescuento').val(),
															$('#atxtGrupo').val(),
															$('#atxtDescBase').val(),
															$('#atxtPoliticaOferta').val(),
															$('#atxtAntibiotico').val(),
															$('#atxtEspecial').val(),
															$('#atxtfamActualizar').val(),
															$('#atxtcomInmediata').val(),
															$('#atxtUProveedor').val(),
															$('#atxtUltimoCosto').val(),
															$('#atxtCostoPromedio').val(),
															$('#atxtCostoReal').val()										
														]).draw();
														$("#formAlta").dialog("close");	
														window.alert("Se agrego nuevo producto con exito");															
															
													}else{
														window.alert("El codigo ya existe, coloque otro codigo nuevo");
														$("#atxtCodBar").select();
													}
													
										 	});
									 }
										else
											{
											  window.alert("No puede dejar campos vacios");
											}									
									}

							    }		
					
						}
					    // add buttons
					});
					$("#formAlta").dialog("option", "width", 900);
					$("#formAlta").dialog("option", "height", 600);	
					
			$("#formProductos").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				buttons:
				{
				    "Actualizar": {
					text:   "Actualizar",
					id:		"btnActualizar",
					click:	function(){
						        if($('#txtProveedor').val().trim()!=""&&$('#txtClave').val().trim()!=""&&$('#txtCodBar').val().trim()!=""&&
								$('#txtDescripcion').val().trim()!=""&&$('#txtFamilia').val().trim()!=""&&$('#txtPrecPub').val().trim()!=""&&
								$('#txtPrecDesc').val().trim()!=""&&$('#txtFarmacia').val().trim()!=""&&$('#txtIva').val().trim()!=""&&
								$('#txtLinea').val().trim()!=""&&$('#txtReferencia').val().trim()!=""&&$('#txtssa').val().trim()!=""&&
								$('#txtLaboratorio').val().trim()!=""&&$('#txtDepartamento').val().trim()!=""&&
							    $('#txtCategoria').val().trim()!=""&&$('#txtActualizable').val().trim()!=""&&
							    $('#txtDescuento').val().trim()!=""&&$('#txtCosto').val().trim()!=""&&
							    $('#txtEquivalencia').val().trim()!=""&&$('#txtSuperfamilia').val().trim()!=""&&
							    $('#txtCls').val().trim()!=""&&$('#txtZona').val().trim()!=""&&$('#txtPareto').val().trim()!=""&&
							    $('#txtIeps').val().trim()!=""&&$('#txtIeps2').val().trim()!=""&&$('#txtLimitado').val().trim()!=""&&
							    $('#txtKit').val().trim()!=""&&$('#txtComision').val().trim()!=""&&$('#txtmaxDescuento').val().trim()!=""&&
							    $('#txtGrupo').val().trim()!=""&&$('#txtDescBase').val().trim()!=""&&$('#txtPoliticaOferta').val().trim()!=""&&
							    $('#txtAntibiotico').val().trim()!=""&&$('#txtExistencias').val().trim()!=""&&$('#txtUProveedor').val().trim()!=""&&
							    $('#txtUltimoCosto').val().trim()!=""&&$('#txtCostoPromedio').val().trim()!=""&&$('#txtCostoReal').val().trim()!=""){
								$.post('productos.jr',				
						        {
									tarea: 'actualizar',	
									codBarRespaldo: codBarRespaldo,
									txtProveedor: $('#txtProveedor').val(),
									txtProveedor2: $('#txtProveedor2').val(),
									txtProveedor3: $('#txtProveedor3').val(),
									txtClave: $('#txtClave').val(),
									txtCodBar: $('#txtCodBar').val(),
									txtDescripcion: $('#txtDescripcion').val(),
									txtFamilia: $('#txtFamilia').val(),
									txtPrecioPub: $('#txtPrecPub').val(),
									txtPrecDesc: $('#txtPrecDesc').val(),
									txtFarmacia: $('#txtFarmacia').val(),
									txtFechaPcio: $('#txtFechaPcio').val(),
									txtIva: $('#txtIva').val(),
									txtLinea: $('#txtLinea').val(),
									txtReferencia: $('#txtReferencia').val(),
									txtssa: $('#txtssa').val(),
									txtLaboratorio: $('#txtLaboratorio').val(),
									txtDepto: $('#txtDepartamento').val(),
									txtCategoria: $('#txtCategoria').val(),
									txtActualizable: $('#txtActualizable').val(),
									txtDescuento: $('#txtDescuento').val(),
									txtCosto: $('#txtCosto').val(),
									txtEquivalencia: $('#txtEquivalencia').val(),
									txtSuperfamilia: $('#txtSuperfamilia').val(),
									txtCls: $('#txtCls').val(),
									txtZona: $('#txtZona').val(),
									txtPareto: $('#txtPareto').val(),
									txtPareto2: $('#txtPareto2').val(),
									txtIeps: $('#txtIeps').val(),
									txtIeps2: $('#txtIeps2').val(),
									txtLimitado: $('#txtLimitado').val(),
									txtKit: $('#txtKit').val(),
									txtComision: $('#txtComision').val(),
									txtMaxDescuento: $('#txtmaxDescuento').val(),
									txtGrupo: $('#txtGrupo').val(),
									txtDescBase: $('#txtDescBase').val(),
									txtPoliticaOferta: $('#txtPoliticaOferta').val(),
									txtAntibiotico: $('#txtAntibiotico').val(),
									txtExistencias: $('#txtExistencias').val(),
									txtEspecial: $('#txtEspecial').val(),
									txtFamActualizar: $('#txtfamActualizar').val(),
									txtComInmediata: $('#txtcomInmediata').val(),
									txtUProveedor: $('#txtUProveedor').val(),
									txtUCosto: $('#txtUltimoCosto').val(),
									txtCostoPromedio: $('#txtCostoPromedio').val(),
									txtCostoReal: $('#txtCostoReal').val()
									
								},function(data)
								{
									console.log(data)
									if(data == 'Update')
									  {
										table.row(index).data([	
										$('#txtProveedor').val(),
										$('#txtProveedor2').val(),
										$('#txtProveedor3').val(),
										$('#txtClave').val(),
										$('#txtCodBar').val(),
										$('#txtDescripcion').val(),
										$('#txtExistencias').val(),
										$('#txtFamilia').val(),
										$('#txtPrecPub').val(),
										$('#txtPrecDesc').val(),
										$('#txtFarmacia').val(),
										$('#txtFechaPcio').val(),
										$('#txtIva').val(),
										$('#txtLinea').val(),
										$('#txtReferencia').val(),
										$('#txtssa').val(),
										$('#txtLaboratorio').val(),
										$('#txtDepartamento').val(),
										$('#txtCategoria').val(),
										$('#txtActualizable').val(),
										$('#txtDescuento').val(),
										$('#txtCosto').val(),
										$('#txtEquivalencia').val(),
										$('#txtSuperfamilia').val(),
									    $('#txtCls').val(),
										$('#txtZona').val(),
										$('#txtPareto').val(),
										$('#txtPareto2').val(),
										$('#txtIeps').val(),
									    $('#txtIeps2').val(),
										$('#txtLimitado').val(),
										$('#txtKit').val(),
										$('#txtComision').val(),
										$('#txtmaxDescuento').val(),
										$('#txtGrupo').val(),
										$('#txtDescBase').val(),
										$('#txtPoliticaOferta').val(),
										$('#txtAntibiotico').val(),
										$('#txtEspecial').val(),
										$('#txtfamActualizar').val(),
										$('#txtcomInmediata').val(),
										$('#txtUProveedor').val(),
										$('#txtUltimoCosto').val(),
										$('#txtCostoPromedio').val(),
										$('#txtCostoReal').val()
										]);										
										window.alert("Actualizacion existosa");
									  }									  								
								});
								$(this).dialog("close");
							}
						     else
								window.alert("No puede dejar campos vacios");									
						}
					}		
			
				}
			
			// add buttons
			});
			$("#formProductos").dialog("option", "width", 900);
			$("#formProductos").dialog("option", "height", 600);
					
			//Tecla enter en todos los campos
			$("#txtProveedor").keypress(function(e){
				if(e.which == 13){
					$("#txtProveedor2").select();
				}
			});
			$("#txtProveedor2").keypress(function(e){
				if(e.which == 13){
					$("#txtProveedor3").select();
				}
			});
			$("#txtProveedor3").keypress(function(e){
				if(e.which == 13){
					$("#txtClave").select();
				}
			});
			$("#txtClave").keypress(function(e){
				if(e.which == 13){
					$("#txtCodBar").select();
				}
			});
			$("#txtCodBar").keypress(function(e){
				if(e.which == 13){
					$("#txtDescripcion").select();
				}
			});
			$("#txtDescripcion").keypress(function(e){
				if(e.which == 13){
					$("#txtExistencias").select();
				}
			});
			$("#txtExistencias").keypress(function(e){
				if(e.which == 13){
					$("#txtFamilia").select();
				}
			});
			$("#txtFamilia").keypress(function(e){
				if(e.which == 13){
					$("#txtPrecPub").select();
				}
			});
			$("#txtPrecPub").keypress(function(e){
				if(e.which == 13){
					$("#txtPrecDesc").select();
				}
			});
			$("#txtPrecDesc").keypress(function(e){
				if(e.which == 13){
					$("#txtFarmacia").select();
				}
			});
			$("#txtFarmacia").keypress(function(e){
				if(e.which == 13){
					$("#txtFechaPcio").select();
				}
			});
			$("#txtFechaPcio").keypress(function(e){
				if(e.which == 13){
					$("#txtIva").select();
				}
			});
			$("#txtIva").keypress(function(e){
				if(e.which == 13){
					$("#txtLinea").select();
				}
			});
			$("#txtLinea").keypress(function(e){
				if(e.which == 13){
					$("#txtReferencia").select();
				}
			});
			$("#txtReferencia").keypress(function(e){
				if(e.which == 13){
					$("#txtssa").select();
				}
			});
			$("#txtssa").keypress(function(e){
				if(e.which == 13){
					$("#txtLaboratorio").select();
				}
			});
			$("#txtLaboratorio").keypress(function(e){
				if(e.which == 13){
					$("#txtDepartamento").select();
				}
			});
			$("#txtDepartamento").keypress(function(e){
				if(e.which == 13){
					$("#txtCategoria").select();
				}
			});
			$("#txtCategoria").keypress(function(e){
				if(e.which == 13){
					$("#txtActualizable").select();
				}
			});
			$("#txtActualizable").keypress(function(e){
				if(e.which == 13){
					$("#txtDescuento").select();
				}
			});
			$("#txtDescuento").keypress(function(e){
				if(e.which == 13){
					$("#txtCosto").select();
				}
			});
			$("#txtCosto").keypress(function(e){
				if(e.which == 13){
					$("#txtEquivalencia").select();
				}
			});
			$("#txtEquivalencia").keypress(function(e){
				if(e.which == 13){
					$("#txtSuperfamilia").select();
				}
			});
			$("#txtSuperfamilia").keypress(function(e){
				if(e.which == 13){
					$("#txtCls").select();
				}
			});
			$("#txtCls").keypress(function(e){
				if(e.which == 13){
					$("#txtZona").select();
				}
			});
			$("#txtZona").keypress(function(e){
				if(e.which == 13){
					$("#txtPareto").select();
				}
			});
			$("#txtPareto").keypress(function(e){
				if(e.which == 13){
					$("#txtPareto2").select();
				}
			});
			$("#txtPareto2").keypress(function(e){
				if(e.which == 13){
					$("#txtIeps").select();
				}
			});
			$("#txtIeps").keypress(function(e){
				if(e.which == 13){
					$("#txtIeps2").select();
				}
			});
			$("#txtIeps2").keypress(function(e){
				if(e.which == 13){
					$("#txtLimitado").select();
				}
			});
			$("#txtLimitado").keypress(function(e){
				if(e.which == 13){
					$("#txtKit").select();
				}
			});
			$("#txtKit").keypress(function(e){
				if(e.which == 13){
					$("#txtComision").select();
				}
			});
			$("#txtComision").keypress(function(e){
				if(e.which == 13){
					$("#txtmaxDescuento").select();
				}
			});
			$("#txtmaxDescuento").keypress(function(e){
				if(e.which == 13){
					$("#txtGrupo").select();
				}
			});
			$("#txtGrupo").keypress(function(e){
				if(e.which == 13){
					$("#txtDescBase").select();
				}
			});
			$("#txtDescBase").keypress(function(e){
				if(e.which == 13){
					$("#txtPoliticaOferta").select();
				}
			});
			$("#txtPoliticaOferta").keypress(function(e){
				if(e.which == 13){
					$("#txtAntibiotico").select();
				}
			});
			$("#txtAntibiotico").keypress(function(e){
				if(e.which == 13){
					$("#txtEspecial").select();
				}
			});
			$("#txtEspecial").keypress(function(e){
				if(e.which == 13){
					$("#txtfamActualizar").select();
				}
			});
			$("#txtfamActualizar").keypress(function(e){
				if(e.which == 13){
					$("#txtcomInmediata").select();
				}
			});
			$("#txtcomInmediata").keypress(function(e){
				if(e.which == 13){
					$("#txtUProveedor").select();
				}
			});
			$("#txtUProveedor").keypress(function(e){
				if(e.which == 13){
					$("#txtUltimoCosto").select();
				}
			});
			$("#txtUltimoCosto").keypress(function(e){
				if(e.which == 13){
					$("#txtCostoPromedio").select();
				}
			});
			$("#txtCostoPromedio").keypress(function(e){
				if(e.which == 13){
					$("#txtCostoReal").select();
				}
			});
			$("#txtCostoReal").keypress(function(e){
				if(e.which == 13){
					$("#btnActualizar").focus();
				}
			});
			
			
			//Campos formulario para agregar nuevo producto
			$("#atxtProveedor").keypress(function(e){
				if(e.which == 13){
					$("#atxtProveedor2").select();
				}
			});
			$("#atxtProveedor2").keypress(function(e){
				if(e.which == 13){
					$("#atxtProveedor3").select();
				}
			});
			$("#atxtProveedor3").keypress(function(e){
				if(e.which == 13){
					$("#atxtClave").select();
				}
			});
			$("#atxtClave").keypress(function(e){
				if(e.which == 13){
					$("#atxtCodBar").select();
				}
			});
			$("#atxtCodBar").keypress(function(e){
				if(e.which == 13){
					$("#atxtDescripcion").select();
				}
			});
			$("#atxtDescripcion").keypress(function(e){
				if(e.which == 13){
					$("#atxtExistencias").select();
				}
			});
			$("#atxtExistencias").keypress(function(e){
				if(e.which == 13){
					$("#atxtFamilia").select();
				}
			});
			$("#atxtFamilia").keypress(function(e){
				if(e.which == 13){
					$("#atxtPrecPub").select();
				}
			});
			$("#atxtPrecPub").keypress(function(e){
				if(e.which == 13){
					$("#atxtPrecDesc").select();
				}
			});
			$("#atxtPrecDesc").keypress(function(e){
				if(e.which == 13){
					$("#atxtFarmacia").select();
				}
			});
			$("#atxtFarmacia").keypress(function(e){
				if(e.which == 13){
					$("#atxtFechaPcio").select();
				}
			});
			$("#atxtFechaPcio").keypress(function(e){
				if(e.which == 13){
					$("#atxtIva").select();
				}
			});
			$("#atxtIva").keypress(function(e){
				if(e.which == 13){
					$("#atxtLinea").select();
				}
			});
			$("#atxtLinea").keypress(function(e){
				if(e.which == 13){
					$("#atxtReferencia").select();
				}
			});
			$("#atxtReferencia").keypress(function(e){
				if(e.which == 13){
					$("#atxtssa").select();
				}
			});
			$("#atxtssa").keypress(function(e){
				if(e.which == 13){
					$("#atxtLaboratorio").select();
				}
			});
			$("#atxtLaboratorio").keypress(function(e){
				if(e.which == 13){
					$("#atxtDepartamento").select();
				}
			});
			$("#atxtDepartamento").keypress(function(e){
				if(e.which == 13){
					$("#atxtCategoria").select();
				}
			});
			$("#atxtCategoria").keypress(function(e){
				if(e.which == 13){
					$("#atxtActualizable").select();
				}
			});
			$("#atxtActualizable").keypress(function(e){
				if(e.which == 13){
					$("#atxtDescuento").select();
				}
			});
			$("#atxtDescuento").keypress(function(e){
				if(e.which == 13){
					$("#atxtCosto").select();
				}
			});
			$("#atxtCosto").keypress(function(e){
				if(e.which == 13){
					$("#atxtEquivalencia").select();
				}
			});
			$("#atxtEquivalencia").keypress(function(e){
				if(e.which == 13){
					$("#atxtSuperfamilia").select();
				}
			});
			$("#atxtSuperfamilia").keypress(function(e){
				if(e.which == 13){
					$("#atxtCls").select();
				}
			});
			$("#atxtCls").keypress(function(e){
				if(e.which == 13){
					$("#atxtZona").select();
				}
			});
			$("#atxtZona").keypress(function(e){
				if(e.which == 13){
					$("#atxtPareto").select();
				}
			});
			$("#atxtPareto").keypress(function(e){
				if(e.which == 13){
					$("#atxtPareto2").select();
				}
			});
			$("#atxtPareto2").keypress(function(e){
				if(e.which == 13){
					$("#atxtIeps").select();
				}
			});
			$("#atxtIeps").keypress(function(e){
				if(e.which == 13){
					$("#atxtIeps2").select();
				}
			});
			$("#atxtIeps2").keypress(function(e){
				if(e.which == 13){
					$("#atxtLimitado").select();
				}
			});
			$("#atxtLimitado").keypress(function(e){
				if(e.which == 13){
					$("#atxtKit").select();
				}
			});
			$("#atxtKit").keypress(function(e){
				if(e.which == 13){
					$("#atxtComision").select();
				}
			});
			$("#atxtComision").keypress(function(e){
				if(e.which == 13){
					$("#atxtmaxDescuento").select();
				}
			});
			$("#atxtmaxDescuento").keypress(function(e){
				if(e.which == 13){
					$("#atxtGrupo").select();
				}
			});
			$("#atxtGrupo").keypress(function(e){
				if(e.which == 13){
					$("#atxtDescBase").select();
				}
			});
			$("#atxtDescBase").keypress(function(e){
				if(e.which == 13){
					$("#atxtPoliticaOferta").select();
				}
			});
			$("#atxtPoliticaOferta").keypress(function(e){
				if(e.which == 13){
					$("#atxtAntibiotico").select();
				}
			});
			$("#atxtAntibiotico").keypress(function(e){
				if(e.which == 13){
					$("#atxtEspecial").select();
				}
			});
			$("#atxtEspecial").keypress(function(e){
				if(e.which == 13){
					$("#atxtfamActualizar").select();
				}
			});
			$("#atxtfamActualizar").keypress(function(e){
				if(e.which == 13){
					$("#atxtcomInmediata").select();
				}
			});
			$("#atxtcomInmediata").keypress(function(e){
				if(e.which == 13){
					$("#atxtUProveedor").select();
				}
			});
			$("#atxtUProveedor").keypress(function(e){
				if(e.which == 13){
					$("#atxtUltimoCosto").select();
				}
			});
			$("#atxtUltimoCosto").keypress(function(e){
				if(e.which == 13){
					$("#atxtCostoPromedio").select();
				}
			});
			$("#atxtCostoPromedio").keypress(function(e){
				if(e.which == 13){
					$("#atxtCostoReal").select();
				}
			});
			$("#atxtCostoReal").keypress(function(e){
				if(e.which == 13){
					$("#btnAdd").focus();
				}
			});
			$("#txtFechaPcio").datepicker({ dateFormat: "yy-mm-dd"});
			$("#atxtFechaPcio").datepicker({ dateFormat: "yy-mm-dd"});
			
			$("#btnQuitarFiltros").hide();
			
			$("#btnFiltros").button().click(function(){
				$("#filtros").fadeIn(600);
				$("#btnFiltros").hide();
				$("#btnQuitarFiltros").show();
			});
			$("#btnQuitarFiltros").button().click(function(){
				$("#filtros").fadeOut(600);
				$("#btnQuitarFiltros").hide();
				$("#btnFiltros").show();
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

<!--Fomulario para dar de alta un producto, este formulario se mostrara en un Dialog de JQuery, se activara al hacer click en el menu "Alta medico" dentro de la pagina principal-->	
	<div id="formProductos" title="Editar Productos" class="text-form">
		<form id="productos">
			<legend>* Campos Obligatorios</legend>
			<fieldset>
				<legend>Generales</legend>
				<ol>
					<li><label for="proveedor">* Proveedor:</label><input type="text" name="proveedor" id="txtProveedor" size="55" requiered autofocus><li>
					<li><label for="proveedor2">* Proveedor2:</label><input type="text" name="proveedor2" id="txtProveedor2" size="20" requiered><label for="proveedor3">* Proveedor3:</label><input type="text" name="proveedor3" id="txtProveedor3" size="20" requiered></li>
					<li><label for="clave">*Clave:</label><input type="text" name="clave" id="txtClave" size="20" disabled><label for="codBar">*Codigo Barras:</label><input type="text" name="codBar" id="txtCodBar" size="20" disabled></li>
					<li><label for="descripcion">*Descripcion:</label><input type="text" name="txtDescripcion" id="txtDescripcion" size="45" /><label for="existencias">Existencias:</label><input type="text" name="existencias" id="txtExistencias" size="10"></li>
					<li><label for="familia">*Familia:</label><input type="text" name="familia" id="txtFamilia" size="15"><label for="preciopub">*Precio Publico:</label><input type="text" name="preciopub" id="txtPrecPub" size="15"><label for="descripcion">*Precio Descuento:</label><input type="text" name="preciodescuento" id="txtPrecDesc" size="15"></li>
					<li><label for="preciofarmacia">*Precio Farmacia:</label><input type="text" name="preciofarmacia" id="txtFarmacia" size="15"><label for="fechaPcio">*Fecha Pcio:</label><input type="text" name="FechaPcio" id="txtFechaPcio" size="15"><label for="iva">*IVA:</label><input type="text" name="iva" id="txtIva" size="15"></li>
					<li><label for="linea">*Linea:</label><input type="text" name="iva" id="txtLinea" size="15"><label for="referencia">*Referencia:</label><input type="text" name="referencia" id="txtReferencia" size="15"><label for="ssa">*SSA:</label><input type="text" name="ssa" id="txtssa" size="15"></li>
					<li><label for="laboratorio">*Laboratorio:</label><input type="text" name="laboratorio" id="txtLaboratorio" size="57"></li>
					<li><label for="departamento">Departamento:</label><input type="text" name="departamento" id="txtDepartamento" size="15"><label for="categoria">*Categoria:</label><input type="text" name="categoria" id="txtCategoria" size="15"><label for="actualizable">*Actualizable:</label><input type="text" name="iva" id="txtActualizable" size="10"></li>
					<li><label for="descuento">Descuento:</label><input type="text" name="descuento" id="txtDescuento" size="15"><label for="costo">Costo:</label><input type="text" name="costo" id="txtCosto" size="15"><label for="equivalencia">Equivalencia:</label><input type="text" name="equivalencia" id="txtEquivalencia" size="15"></li>
					<li><label for="superfamilia">Superfamilia:</label><input type="text" name="superfamilia" id="txtSuperfamilia" size="15"><label for="cls">CLS:</label><input type="text" name="cls" id="txtCls" size="15"><label for="zona">Zona:</label><input type="text" name="zona" id="txtZona" size="15"></li>
					<li><label for="pareto">Pareto:</label><input type="text" name="pareto" id="txtPareto" size="15"><label for="pareto2">Pareto2:</label><input type="text" name="pareto2" id="txtPareto2" size="15"></li>
					<li><label for="ieps">*IEPS 1:</label><input type="text" name="ieps" id="txtIeps" size="15"><label for="ieps2">*IEPS 2:</label><input type="text" name="ieps2" id="txtIeps2" size="15"></li>
					<li><label for="lmitado">Limitado:</label><input type="text" name="limitado" id="txtLimitado" size="15"><label for="kit">Kit:</label><input type="text" name="kit" id="txtKit" size="15"><label for="comision">*Comision:</label><input type="text" name="comision" id="txtComision" size="15"></li>
					<li><label for="maxdescuento">Descuento Maximo:</label><input type="text" name="maxdescuento" id="txtmaxDescuento" size="15"><label for="grupo">Grupo:</label><input type="text" name="grupo" id="txtGrupo" size="15"><label for="aplicades">Aplica Des Base:</label><input type="text" name="descbase" id="txtDescBase" size="15"></li>
					<li><label for="politicaoferta">Politica Oferta:</label><input type="text" name="politicaoferta" id="txtPoliticaOferta" size="15"><label for="antibiotico">Antibiotico:</label><input type="text" name="antibiotico" id="txtAntibiotico" size="15"></li>
					<li><label for="especial">Especial: </label><input type="text" name="especial" id="txtEspecial" size="15"><label for="famactualizar">Fam. Actualizar: </label><input type="text" name="famactualizar" id="txtfamActualizar" size="15"><label for="cominmediata">Com. Inmediata: </label><input type="text" name="cominmediata" id="txtcomInmediata" size="15"></li>
					<li><label for="ultimoproveedor">Ultimo Proveedor:</label><input type="text" name="ultimoproveedor" id="txtUProveedor" size="15"><label for="ultimocosto">Ultimo Costo:</label><input type="text" name="ultimocosto" id="txtUltimoCosto" size="15"></li>
					<li><label for="costopromedio">Costo Promedio:</label><input type="text" name="costopromedio" id="txtCostoPromedio" size="15"><label for="costoreal">Costo Real:</label><input type="text" name="costoreal" id="txtCostoReal" size="15"></li>
				</ol>
			</fieldset>
		</form>
	</div>
	<div id="formAlta" title="Alta Productos" class="text-form">
		<form id="Alta">
			<legend>* Campos Obligatorios</legend>
			<fieldset>
				<legend>Generales</legend>
				<ol>
					<li><label for="proveedor">* Proveedor:</label><input type="text" name="proveedor" id="atxtProveedor" size="55" requiered autofocus>
					<li><label for="proveedor2">* Proveedor2:</label><input type="text" name="proveedor2" id="atxtProveedor2" size="20" requiered><label for="proveedor3">* Proveedor3:</label><input type="text" name="proveedor3" id="atxtProveedor3" size="20" requiered></li> 
					<li><label for="clave">*Clave:</label><input type="text" name="clave" id="atxtClave" size="20"><label for="codBar">*Codigo Barras:</label><input type="text" name="codBar" id="atxtCodBar" size="20"></li>
					<li><label for="descripcion">*Descripcion:</label><input type="text" name="descripcion" id="atxtDescripcion" size="45"><label for="existencias">Existencias:</label><input type="text" name="existencias" id="atxtExistencias" size="10"></li>
					<li><label for="familia">*Familia:</label><input type="text" name="familia" id="atxtFamilia" size="15"><label for="preciopub">*Precio Publico:</label><input type="text" name="preciopub" id="atxtPrecPub" size="15"><label for="descripcion">*Precio Descuento:</label><input type="text" name="preciodescuento" id="atxtPrecDesc" size="15"></li>
					<li><label for="preciofarmacia">*Precio Farmacia:</label><input type="text" name="preciofarmacia" id="atxtFarmacia" size="15"><label for="fechaPcio">*Fecha Pcio:</label><input type="text" name="FechaPcio" id="atxtFechaPcio" size="15"><label for="iva">*IVA:</label><input type="text" name="iva" id="atxtIva" size="15"></li>
					<li><label for="linea">*Linea:</label><input type="text" name="linea" id="atxtLinea" size="15"><label for="referencia">*Referencia:</label><input type="text" name="referencia" id="atxtReferencia" size="15"><label for="ssa">*SSA:</label><input type="text" name="ssa" id="atxtssa" size="15"></li>
					<li><label for="laboratorio">*Laboratorio:</label><input type="text" name="laboratorio" id="atxtLaboratorio" size="57"></li>
					<li><label for="departamento">Departamento:</label><input type="text" name="departamento" id="atxtDepartamento" size="15"><label for="categoria">*Categoria:</label><input type="text" name="categoria" id="atxtCategoria" size="15"><label for="actualizable">*Actualizable:</label><input type="text" name="iva" id="atxtActualizable" size="10"></li>
					<li><label for="descuento">Descuento:</label><input type="text" name="descuento" id="atxtDescuento" size="15"><label for="costo">Costo:</label><input type="text" name="costo" id="atxtCosto" size="15"><label for="equivalencia">Equivalencia:</label><input type="text" name="equivalencia" id="atxtEquivalencia" size="15"></li>
					<li><label for="superfamilia">Superfamilia:</label><input type="text" name="superfamilia" id="atxtSuperfamilia" size="15"><label for="cls">CLS:</label><input type="text" name="cls" id="atxtCls" size="15"><label for="zona">Zona:</label><input type="text" name="zona" id="atxtZona" size="15"></li>
					<li><label for="pareto">Pareto:</label><input type="text" name="pareto" id="atxtPareto" size="15"><label for="pareto2">Pareto2:</label><input type="text" name="pareto2" id="atxtPareto2" size="15"></li>
					<li><label for="ieps">*IEPS 1:</label><input type="text" name="ieps" id="atxtIeps" size="15"><label for="ieps2">*IEPS 2:</label><input type="text" name="ieps2" id="atxtIeps2" size="15"></li>
					<li><label for="lmitado">Limitado:</label><input type="text" name="limitado" id="atxtLimitado" size="15"><label for="kit">Kit:</label><input type="text" name="kit" id="atxtKit" size="15"><label for="comision">*Comision:</label><input type="text" name="comision" id="atxtComision" size="15"></li>
					<li><label for="maxdescuento">Descuento Maximo:</label><input type="text" name="maxdescuento" id="atxtmaxDescuento" size="15"><label for="grupo">Grupo:</label><input type="text" name="grupo" id="atxtGrupo" size="15"><label for="aplicades">Aplica Des Base:</label><input type="text" name="descbase" id="atxtDescBase" size="15"></li>
					<li><label for="politicaoferta">Politica Oferta:</label><input type="text" name="politicaoferta" id="atxtPoliticaOferta" size="15"><label for="antibiotico">Antibiotico:</label><input type="text" name="antibiotico" id="atxtAntibiotico" size="15"></li>
					<li><label for="especial">Especial: </label><input type="text" name="especial" id="atxtEspecial" size="15"><label for="famactualizar">Fam. Actualizar: </label><input type="text" name="famactualizar" id="atxtfamActualizar" size="15"><label for="cominmediata">Com. Inmediata: </label><input type="text" name="cominmediata" id="atxtcomInmediata" size="15"></li>
					<li><label for="ultimoproveedor">Ultimo Proveedor:</label><input type="text" name="ultimoproveedor" id="atxtUProveedor" size="15"><label for="ultimocosto">Ultimo Costo:</label><input type="text" name="ultimocosto" id="atxtUltimoCosto" size="15"></li>
					<li><label for="costopromedio">Costo Promedio:</label><input type="text" name="costopromedio" id="atxtCostoPromedio" size="15"><label for="costoreal">Costo Real:</label><input type="text" name="costoreal" id="atxtCostoReal" size="15"></li>
				</ol>
			</fieldset>
		</form>
	</div>	
<div>
			<div id="header">
				<!--div id="logo"></div-->
			</div>
	
			<div id="sucursal">
				<p>Cajero  : <label id="lblname"><%=nombre %> <%=apepat %> <%=apemat %></label></p>
		        <p>Usuario : <label id="lbluser"><%=usuario %></label><label> | Sucursal: Sin Sucursal</label></p>
			</div>

	<!--Barra de Navegacion de la pagina principal-->
	
			<ul id="nav">
					<li><button id="btnRecargar">Recargar</button></li>
					<li><button id="btnEditar">Editar</button></li>
					<li><button id="btnEliminar">Eliminar</button></li>
					<li><button id="btnAgregar">Agregar</button></li>	
					<li><button id="btnExcel">Excel</button>				
			</ul>   
	<!--Barra de Navegacion, contiene el contenido que se muestra de lado derecho-->
	<div id="navigatorpanel">
		<ul id="nav-right">
			<li><a href="#" id="close">Salir</a></li>
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
		<div class="container">
			
			<div id="buttons">
							
			</div>
			<div STYLE="float: left; top:150px; left:10px; width:600px; background-color:#00cccc;  margin: 20px;">
				<form>
				  <table>
					<tr>
						<td><label for="codigo"><b>Codigo:</b></label></td>
						<td><input type="text" id="txtCodigo" name="codigo" size="50"><button type="button" id="btnBuscar">Buscar.</button></td>
					</tr>
					<tr>
						<td><label for="descripcion"><b>Descripcion:</b></label></td>
						<td><input type="text" id="txtDescripcionBusqueda" name="descripcion" size="50"><button type="button" id="btnFiltros">mas filtros.</button><button type="button" id="btnQuitarFiltros">quitar filtros.</button></td>
					</tr>
				  </table>
				</form>
			</div>
			<div id="filtros" style="-webkit-column-count: 5; -moz-column-count: 5; column-count: 5;  display: none; width:1100px; background-color:#00cccc; float: left; left:10px;margin: 5px;">
				<ul style="list-style-type: none;">
					<li><input type="text" class="boxinit" placeholder="Proveedor" ></li>
					<li><input type="text" class="boxinit" placeholder="Clave" ></li>
					<li><input type="text" class="boxinit" placeholder="Codigo" ></li>
					<li><input type="text" class="boxinit" placeholder="Descripcion" ></li>
					<li><select><option>Mayor a</option><option>Menor a</option><option>Igual a</option></select><input type="text" class="boxinit" placeholder="Existen." size="6"></li>
					<li><input type="text" class="boxinit" placeholder="Familia" ></li>
					<li><input type="text" class="boxinit" placeholder="PrecioPub" ></li>
					<li><input type="text" class="boxinit" placeholder="PrecioDesc" ></li>
					<li><input type="text" class="boxinit" placeholder="PrecioFarm" ></li>
					<li><input type="text" class="boxinit" placeholder="FechaPcio" ></li>
					<li><input type="text" class="boxinit" placeholder="IVA" ></li>
					<li><input type="text" class="boxinit" placeholder="Linea" ></li>
					<li><input type="text" class="boxinit" placeholder="Referencia" ></li>
					<li><input type="text" class="boxinit" placeholder="SSA" ></li>
					<li><input type="text" class="boxinit" placeholder="Laboratorio" ></li>
					<li><input type="text" class="boxinit" placeholder="Departamento" ></li>
					<li><input type="text" class="boxinit" placeholder="Categoria" ></li>
					<li><input type="text" class="boxinit" placeholder="Actualizable" ></li>
					<li><input type="text" class="boxinit" placeholder="Descuento" ></li>
					<li><input type="text" class="boxinit" placeholder="Costo" ></li>
					<li><input type="text" class="boxinit" placeholder="Equivalencia" ></li>
					<li><input type="text" class="boxinit" placeholder="Superfamilia" ></li>
					<li><input type="text" class="boxinit" placeholder="CLS" ></li>
					<li><input type="text" class="boxinit" placeholder="Zona" ></li>
					<li><input type="text" class="boxinit" placeholder="Pareto" ></li>
					<li><input type="text" class="boxinit" placeholder="Pareto2" ></li>
					<li><input type="text" class="boxinit" placeholder="IEPS" ></li>
					<li><input type="text" class="boxinit" placeholder="IEPS2" ></li>
					<li><input type="text" class="boxinit" placeholder="Limitado" ></li>
					<li><input type="text" class="boxinit" placeholder="Kit" ></li>
					<li><input type="text" class="boxinit" placeholder="Comision" ></li>
					<li><input type="text" class="boxinit" placeholder="MaxDescuento" ></li>
					<li><input type="text" class="boxinit" placeholder="Grupo" ></li>
					<li><input type="text" class="boxinit" placeholder="DescuentoBase" ></li>
					<li><input type="text" class="boxinit" placeholder="PoliticaOfer" ></li>
					<li><input type="text" class="boxinit" placeholder="Antibiotico" ></li>
					<li><input type="text" class="boxinit" placeholder="Especial" ></li>
					<li><input type="text" class="boxinit" placeholder="FamActualiz" ></li>
					<li><input type="text" class="boxinit" placeholder="ComInmediata" ></li>
					<li><input type="text" class="boxinit" placeholder="U.Proveedor" ></li>
					<li><input type="text" class="boxinit" placeholder="U.Costo"></li>
					<li><input type="text" class="boxinit" placeholder="CostoPromedio"></li>
					<li><input type="text" class="boxinit" placeholder="CostoReal"></li>
				</ul>
			</div>
			<!-- panel de productos -->
			<table id="search" class="display"cellspacing="0" width="1400px">
				<thead>	
					<tr>
						<th style="width: 10%">Proveedor</th>
						<th style="width: 10%">Proveedor2</th>
						<th style="width: 10%">Proveedor3</th>
						<th style="width: 20%">Clave</th>
						<th style="width: 20%">Codigo</th>
						<th style="width: 50%">Descripcion</th>
						<th style="width: 5%">Existencias</th>
						<th style="width: 10%">Familia</th>
						<th style="width: 5%">Precio Pub</th>
						<th style="width: 5%">Precio Desc</th>
						<th style="width: 5%">Precio Farm</th>
						<th style="width: 5%">Fecha Pcio</th>
						<th style="width: 5%" >IVA</th>
						<th style="width: 5%" >Linea</th>
						<th style="width: 5%" >Referencia</th>
						<th style="width: 5%">SSA</th>
						<th style="width: 20%">Laboratorio</th>
						<th style="width: 7%">Departamento</th>
						<th style="width: 5%">Categoria</th>
						<th style="width: 5%">Actualizable</th>
						<th style="width: 5%">Descuento</th>
						<th style="width: 10%">Costo</th>
						<th style="width: 7%">Equivalencia</th>
						<th style="width: 7%">Superfamilia</th>
						<th style="width: 7%">CLS</th>
						<th style="width: 5%">Zona</th>
						<th style="width: 5%">Pareto</th>
						<th style="width: 5%">Pareto2</th>
						<th style="width: 5%">IEPS</th>
						<th style="width: 5%">IEPS2</th>
						<th style="width: 10%">Limitado</th>
						<th style="width: 10%">Kit</th>
						<th style="width: 5%">Comision</th>
						<th style="width: 7%">Max Descuento</th>
						<th style="width: 5%">Grupo</th>
						<th style="width: 5%">Descuento Base</th>
						<th style="width: 5%">Politica Ofer</th>
						<th style="width: 5%">Antibiotico</th>
						<th style="width: 5%">Especial</th>
						<th style="width: 5%">Fam Actualizar</th>
						<th style="width: 5%">Com Inmediata</th>
						<th style="width: 10%">U. Proveedor</th>
						<th style="width: 10%">U. Costo</th>
						<th style="width: 10%">Costo Promedio</th>
						<th style="width: 10%">Costo Real</th>
				    </tr>
				    </thead>
				  <!-- <thead>	
					<tr>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th><input class="boxinit" style="width: 30px" type="text" /></th>
						<th><input class="boxinit" style="width: 70px" type="text"/></th>
						<th><input class="boxinit" style="width: 30px" type="text"/></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th><input class="boxinit" style="width: 50px" type="text"/></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
					</tr>								
				</thead> --> 
				<tbody>
				</tbody>
			</table>
					
	 	</div>
	</div>
</body>
</html>

