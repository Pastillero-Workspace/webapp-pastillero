<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="mx.com.pastillero.model.dao.ProductoDao"%>
<%@page import="java.util.List"%>
<%@page import="mx.com.pastillero.model.dao.RecepcionDao"%>
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
						var t = $('#example').DataTable({
							dom : "rtiS",
							"stateSave" : true,
						    "bSort": false,
							scrollY : 200,
							scrollCollapse : true
						});
												
						
						var counter = 0;
						var productos = [];
						var productos2 = [];
						$(window).load(function(){
							
							$( "#txtFecha" ).datepicker({ dateFormat: "dd-mm-yy"});
							
							console.log(localStorage.getItem('recepcion'));
							if(localStorage.getItem('recepcion')){
								console.log("si hay datos");
								var storage2 = JSON.parse(localStorage.getItem('recepcion'));
								productos2 = JSON.parse(localStorage.getItem('productos'));
								
								console.log(storage2);
								console.log(productos2);
						
								
								$("#txtFecha").val(storage2.fecha);
								$("#txtFactura").val(storage2.factura);
								//$('#usuario option:contains(usuario)').prop('selected',true);
								$('#usuario').val(storage2.usuario);
								if(storage2.nota==1)
									$("#chkNota").prop('checked',true);
								$("#proveedor").val(storage2.proveedor);
								$("#txtDescuento1").val(storage2.desc1);
								$("#txtDescuento2").val(storage2.desc2);
								$('#txtFolioE').val(storage2.folioE);
								
								console.log(productos2.length);
								
								var ivaT = 0;
								var ieps1T = 0;
								var ieps2T = 0;
								var subtotalT = 0;
								var totalT = 0;
								var folio = 0;
								for(var i=0;i<productos2.length;i++){
									t.row.add([
									            productos2[i].cantidad,
									            productos2[i].codigo,
									            productos2[i].descripcion,						
									            productos2[i].desc1,
									            productos2[i].desc2,
									            productos2[i].iva,
									            productos2[i].ieps1,
									            productos2[i].ieps2,
												0,
												productos2[i].costo,
												productos2[i].importe,
												'',
												//'<button type="button" class="myButton" id="Mod'+counter+'" onclick="editar()">Editar</button>',
												'<button type="button" class="myButton" id="Del'+i+'" onclick="eliminar()">X</button>'
												 ])
												.draw();
												console.log(productos2[i]);
												
												ivaT += productos2[i].ivaImporte;
												ieps1T += productos2[i].ieps1Importe;
												ieps2T += productos2[i].ieps2Importe;
												
												subtotalT += productos2[i].importe*1;										        
												totalT += productos2[i].importe*1+productos2[i].ivaImporte+productos2[i].ieps1Importe+productos2[i].ieps2Importe;
												
												
												console.log(ieps1T);
												console.log(ieps2T);
												console.log(ivaT);
												console.log(subtotalT);
												console.log(totalT);
												
								}
								$('#lblDesc1').val(0.00);
								$('#lblDesc2').val(0.00);
								$('#lblIeps1').val(ieps1T.toFixed(2));
								$('#lblIeps2').val(ieps2T.toFixed(2));
								$('#lblIeps3').val(0.00);
								$('#lblIva').val(ivaT.toFixed(2));
								$('#lblSubtotal').val(subtotalT.toFixed(2));
								$('#lblTotal').val(totalT.toFixed(2));
						
							}else{
								console.log("no hay datos");
								$.post('recepcion.jr',{
									tarea:'cargar'
								},function(date){
									$('#txtFolioE').val(date);
									folio = date;
								});
								
								
								setTimeout(function() {
									var storage1 = {'fecha':$('#txtFecha').val(),
											   'factura':$('#txtFactura').val(),
											   'usuario':$('#usuario').val(),
											   'folioE':$('#txtFolioE').val(),
											   'nota':$('#chkNota:checked').length,
											   'proveedor':$('#proveedor option:selected').val(),
											   'desc1':$('#txtDescuento1').val(),
											   'desc2':$('#txtDescuento2').val()
											   				   
											};
									console.log(storage1);
									localStorage.setItem('recepcion', JSON.stringify(storage1));
								}, 2000);
														
							
							}
							
									
						});
												
						$(this).keypress(function(e){
							if(e.which == 17){
								console.log("se presiono tecla espaciadora");	
							
							}	
							
						
						});
						
						
						var descuento1=0;
						var descuento2=0;
						var ieps1=0;
						var ieps2=0;
						var ieps3=0;
						var iva=0;
						var subtotal=0;
						var total=0;
						var index=0;
						var importe=0;
						
						//No esta en uso, se reemplazo por funcion dentro del metodo click del boton Editar $('#btnEditar')
						  window.editar = function editar () 
								  {
							  		console.log("======click en editar=========");
						  			console.log("Iva: "+iva);
						  			console.log("Subtotal: "+subtotal);
						  			console.log("Total: "+total);
						  			console.log("Ieps1: "+ieps1);
						  			console.log("Ieps2: "+ieps2);
							 		//var obj = t.row('.selected').data();
							 		var t = $('#example').DataTable();
							 		
							 		var isIva=0;
							 		var isIeps1=0;
							 		var isIeps2=0;
							 		var isIeps3=0;
							 		var desIva = 0;
							 		var desIeps1 = 0;
							 		var desIeps2=0;
						 			var contador=0;
							  		
							  		
							  		$('#example tbody').on('click','button',function(){
							  			
							  			var obj = t.row( $(this).parents('tr') ).data();
								 		//index = t.row('.selected').index();
								 		index = t.row( $(this).parents('tr') ).index();
								 		$('#btnAgregar').prop('disabled',true);
								 		$('#btnModificar').prop('disabled',false);
								 		$("#Del"+index+"").prop('disabled',true);
								 		//console.log('Del'+(counter-1));
								 		//  mapping object and fill textbox element
								 		$.each( obj, function( key, value ) {	
								 			//console.log(key ,value);
								 			if(key == 0){
								 				$('#txtCantidad').val(value);
							 				}
								 			if(key == 1) $('#txtCodigo').val(value);
								 			if(key == 2) $('#txtDescp').val(value);
								 			if(key == 3) $('#txtDesc1').val(value);
								 			if(key == 4) $('#txtDesc2').val(value);
								 			if(key == 5){
								 				if(value==1){
								 					$('#chkIVA').prop('checked',true);
								 					isIva=1;
								 				}
								 			}
								 			if(key == 6){
								 				if(value==1){
								 					$('#chkIEPS1').prop('checked',true);
								 					isIeps1=1;
								 				}
								 			}
								 			if(key == 7){
								 				if(value==1){
								 					$('#chkIEPS2').prop('checked',true);
								 					IsIeps2=1;
								 				}
								 			}
								 			if(key == 8){
								 				if(value==1){
								 					$('#chkIEPS3').prop('checked',true);
								 					isIeps3=0;
								 				}
								 			}
								 			if(key == 9){
								 				$('#txtCosto').val(value);
								 			}
								 			if(key == 10){
								 				$('#txtImporte').val(value);
								 				importe = value*1;
												}
								 			
								 			});
								 		
								 		
								 		if(isIva==1){
								 			desIva=0;
								 			desIva += importe*0.16;
								 			//iva = iva - (importe*0.16); 
								 			total = total- (importe*0.16);
								 			
								 		}
								 		if(isIeps1==1){
								 			desIeps1 = ((importe*0.25)+((importe*0.25)*0.16));
								 			ieps1 = ieps1 - ((importe*0.25)+((importe*0.25)*0.16));
								 			total = total - ((importe*0.25)+((importe*0.25)*0.16));
								 		}
								 		if(isIeps2==1){
								 			desIeps2 = (importe*0.08);
								 			//ieps2 = ieps2 - desIeps2;
								 			ieps2 = (importe*0.08);
								 			total = total - (importe*0.08);
								 		}
								 		if(contador==0){
								 			console.log("========="+subtotal);
									 		console.log(total);
									 		console.log("Contador"+contador++);
									 		
									 		subtotal = subtotal - importe;
									 		//total = total - importe - desIva - desIeps1 - desIeps2;
									 		total = total - importe;
									 		iva = iva - desIva;
									 		
									 		
									 		$('#lblDesc1').val(descuento1);
											$('#lblDesc2').val(descuento2);
											$('#lblIeps1').val(ieps1);
											$('#lblIeps2').val(ieps2);
											$('#lblIeps3').val(ieps3);
											$('#lblIva').val(iva.toFixed(2));
											$('#lblSubtotal').val(subtotal.toFixed(2));
											$('#lblTotal').val(total.toFixed(2));
											$('#txtImporte').val("");
											
								  		
									  		console.log("==========================");
											console.log("Iva: "+iva);
								  			console.log("Subtotal: "+subtotal);
								  			console.log("Total: "+total);
								  			console.log("Ieps1: "+ieps1);
								  			console.log("Ieps2: "+ieps2);
											
											$('#txtCantidad').focus();
									 		
								 		}
								 	
								 	});
							  	};  
							    
							 window.eliminar = function eliminar () 
								  {
								var t = $('#example').DataTable();
								
						 		
							  	$('#example tbody').on('click','button',function(){
								  	var obj = t.row( $(this).parents('tr') ).data();
								  	var isIva=0;
							 		var isIeps1=0;
							 		var isIeps2=0;
							 		var isIeps3=0;
							 		var desIva = 0;
							 		var desIeps1 = 0;
							 		var desIeps2=0;
							 		var desIvaIeps=0;
							 		
							 		/*$.post('recepcion.jr',{
										tarea:'eliminar',
										producto:t.row( $(this).parents('tr') ).index(),
									}, function(f){
											//$('#txtDescp').val(descripcion);
									});*/
							 		
							 		var cantidadP;
			        	 			var codigoP;
			        	 			var descripcionP;
			        	 			var desc1P;
			        	 			var desc2P;
			        	 			var ivaP;
			        	 			var ieps1P;
			        	 			var ieps2P;
			        	 			var costoP;
			        	 			var importeP;
			        	 			var ivaImporteP = 0;
			        	 			var ieps1ImporteP;
			        	 			var ieps2ImporteP;
							 		
								  	//  mapping object and fill textbox element
							 		$.each( obj, function( key, value ) {	
							 			//console.log(key ,value);
							 			if(key == 0)
							 				cantidadP = value;
							 			if(key == 1)
							 				codigoP = value;
							 			if(key == 2)
							 				descripcionP = value;
							 			if(key == 3){
							 				desc1P = value;
							 				desc1=value;
							 			}
							 			if(key == 4){
							 				desc2P = value;
							 				desc2=value;
							 			}
							 			if(key == 5){
							 				ivaP = value;
							 				if(value==1){
							 					isIva=1;
							 				}
							 			}
							 			if(key == 6){
							 				ieps1P = value;
							 				if(value==1){
							 					isIeps1=1;
							 				}
							 			}
							 			if(key == 7){
							 				ieps2P = value;
							 				if(value==1){
							 					IsIeps2=1;
							 				}
							 			}
							 			if(key == 8){
							 				if(value==1){
							 					isIeps3=0;
							 				}
							 			}
							 			if(key == 9){
							 				costoP = value;
							 			}
							 			if(key == 10){
							 				importeP = value;
							 				importe = value;
							 			}
							 			});
							 	
							 		ieps1 = $('#lblIeps1').val()*1;
									ieps2 = $('#lblIeps2').val()*1;
									iva = $('#lblIva').val()*1;
									subtotal = $('#lblSubtotal').val()*1;
									total = $('#lblTotal').val()*1;
							 		if(isIva==1){
							 			desIva = (importe*0.16);
							 			iva = iva - desIva;
							 			ivaImporteP = (importe*0.16);
							 		}
							 		if(isIeps1==1){
							 			desIeps1 = (importe*0.25);
							 			desIvaIeps = (importe*0.25)*0.16;
							 			ieps1 = ieps1 - desIeps1;
							 			iva = iva - desIvaIeps;
							 			ieps1ImporteP = (importe*0.25);
							 			ivaImporteP += (importe*0.25)*0.16;
							 		}
							 		if(isIeps2==1){
							 			desIeps2 = (importe*0.08);
							 			ieps2 = ieps2 - desIeps2;
							 			ieps2ImporteP = (importe*0.08);
							 		}
							 		
							 		
							 		subtotal = subtotal - importe;
							 		total = total - importe - desIva - desIeps1 - desIeps2 - desIvaIeps;
									$('#txtImporte').val("");
							 		$('#txtCantidad').focus();
							 		
							 		$('#lblDesc1').val(descuento1.toFixed(2));
									$('#lblDesc2').val(descuento2.toFixed(2));
									$('#lblIeps1').val(ieps1.toFixed(2));
									$('#lblIeps2').val(ieps2.toFixed(2));
									$('#lblIeps3').val(ieps3.toFixed(2));
									$('#lblIva').val(iva.toFixed(2));
									$('#lblSubtotal').val(subtotal.toFixed(2));
									$('#lblTotal').val(total.toFixed(2));
									$('#txtImporte').val("");
							 		
							 						 								  						  
									t.row( $(this).parents('tr') ).remove().draw( false );
									
									if(localStorage.getItem('productos')){
										//productos2.
										
										var producto1 = {'cantidad':cantidadP,
						        	 			'codigo':codigoP,
						        	 			'descripcion':descripcionP,
						        	 			'desc1':desc1P,
						        	 			'desc2':desc2P,
						        	 			'iva':ivaP,
						        	 			'ieps1':ieps1P,
						        	 			'ieps2':ieps2P,
						        	 			'costo':costoP,
						        	 			'importe':importeP,
						        	 			'ivaImporte':ivaImporteP,
						        	 			'ieps1Importe':ieps1ImporteP,
						        	 			'ieps2Importe':ieps1ImporteP
						        	 			};
										
										console.log(producto1);
						         	var productosT = productos2.slice(producto1);
						         	console.log(productosT);
									}
									
							  	});
							    												        
							    };
						
										
						//$('#btnEditar').on('click',function(e){
						 $('#btnEditar').button().click(function(e){	
								
						 		var obj = t.row('.selected').data();
						 								 		
						 		var isIva=0;
						 		var isIeps1=0;
						 		var isIeps2=0;
						 		var isIeps3=0;
						 		var desIva = 0;
						 		var desIeps1 = 0;
						 		var desIeps2=0;
					 			
								index = t.row('.selected').index();
								if(index>=0){
									$('#btnAgregar').prop('disabled',true);
									$('#btnModificar').prop('disabled',false);
									$("#Del"+index+"").prop('disabled',true);
									//console.log('Del'+(counter-1));
									//  mapping object and fill textbox element
									$.each( obj, function( key, value ) {	
										//console.log(key ,value);
										if(key == 0){
											$('#txtCantidad').val(value);
							 			}
								 		if(key == 1) $('#txtCodigo').val(value);
								 		if(key == 2) $('#txtDescp').val(value);
								 		if(key == 3) $('#txtDesc1').val(value);
								 		if(key == 4) $('#txtDesc2').val(value);
								 		if(key == 5){
								 			if(value==1){
								 				$('#chkIVA').prop('checked',true);
								 				isIva=1;
								 			}
								 		}
								 		if(key == 6){
								 			if(value==1){
								 				$('#chkIEPS1').prop('checked',true);
								 				isIeps1=1;
								 			}
								 		}
								 		if(key == 7){
								 			if(value==1){
								 				$('#chkIEPS2').prop('checked',true);
								 				IsIeps2=1;
								 			}
								 		}
								 		if(key == 8){
								 			if(value==1){
								 				$('#chkIEPS3').prop('checked',true);
								 				isIeps3=0;
								 			}
								 		}
								 		if(key == 9){
								 			$('#txtCosto').val(value);
								 		}
								 		if(key == 10){
								 			$('#txtImporte').val(value);
								 			importe = value*1;
										}
									});
								 		
								 		
								 		ieps1 = $('#lblIeps1').val()*1;
										ieps2 = $('#lblIeps2').val()*1;
										iva = $('#lblIva').val()*1;
										subtotal = $('#lblSubtotal').val()*1;
										total = $('#lblTotal').val()*1;
								 		if(isIva==1){
								 			desIva=0;
								 			desIva += importe*0.16;
								 			//iva = iva - (importe*0.16); 
								 			total = total- (importe*0.16);
								 			
								 		}
								 		if(isIeps1==1){
								 			desIeps1 = ((importe*0.25)+((importe*0.25)*0.16));
								 			ieps1 = ieps1 - (importe*0.25);
								 			iva = iva - (importe*0.25)*0.16;
								 			total = total - ((importe*0.25)+((importe*0.25)*0.16));
								 		}
								 		if(isIeps2==1){
								 			desIeps2 = (importe*0.08);
								 			//ieps2 = ieps2 - desIeps2;
								 			ieps2 = (importe*0.08);
								 			total = total - (importe*0.08);
								 		}
								 		
								 									 		
										subtotal = subtotal - importe;
										//total = total - importe - desIva - desIeps1 - desIeps2;
										total = total - importe;
										iva = iva - desIva;
																	 		
										$('#lblDesc1').val(descuento1);
										$('#lblDesc2').val(descuento2);
										$('#lblIeps1').val(ieps1);
										$('#lblIeps2').val(ieps2);
										$('#lblIeps3').val(ieps3);
										$('#lblIva').val(iva.toFixed(2));
										$('#lblSubtotal').val(subtotal.toFixed(2));
										$('#lblTotal').val(total.toFixed(2));
										$('#txtImporte').val("");
										
										$('#txtCantidad').focus();	
								}else{
									window.alert("Seleccion un producto para poder editarlo");
								}
								
						});
						
						
						//Tecla enter en todos los campos
						$("txtFecha").keypress(function(e){
							if(e.which == 13){
								$("#txtFactura").focus();
							}
						});
						$("#txtFactura").keypress(function(e){
							if(e.which == 13){
								$("#chkNota").focus();
								var storage = {'fecha':$('#txtFecha').val(),
										   'factura':$('#txtFactura').val(),
										   'usuario':$('#usuario').val(),
										   'nota':$('#chkNota:checked').length,
										   'proveedor':$('#proveedor option:selected').val(),
										   'desc1':$('#txtDescuento1').val(),
										   'desc2':$('#txtDescuento2').val(),
										   'folioE':$('#txtFolioE').val()				   
								};
								console.log($('#usuario').val());
								console.log($('#txtFolioE').val());
								localStorage.setItem('recepcion', JSON.stringify(storage));
							}
						});
						$("#chkNota").keypress(function(e){
							if(e.which == 13){
								$("#proveedor").focus();
							}
						});
						$("#proveedor").keypress(function(e){
							if(e.which == 13){
								$("#txtDescuento1").val("0");
								$("#txtDescuento1").select();
							}
						});
						$("#txtDescuento1").keypress(function(e){
							if(e.which == 13){
								$("#txtDescuento2").val("0");
								$("#txtDescuento2").select();
							}
						});
						$("#txtDescuento2").keypress(function(e){
							if(e.which == 13){
								$("#btnCapturar").focus();
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
								console.log(codigo);
								$.post('recepcion.jr',{tarea:'buscar',txtCodigo:codigo}, function(descripcion){
									if(descripcion!=0){
										var datos = descripcion.split("~");
										$('#txtDescp').val(datos[0]);
										if(datos[1]=="2")
											$('#chkIVA').prop('checked',true);
										if(datos[2]=="2")
											$('#chkIEPS1').prop('checked',true);
										
										$("#txtDesc1").val("0");
										$("#txtDesc2").val("0");
										$("#txtCosto").focus();
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
						
						
						$('#btnCapturar').on('click ',function(e)
								{						
									var fecha = $('#txtFecha').val();
									var factura = $('#txtFactura').val();
									var usuario = $('#usuario').val();
									var proveedor = $('#proveedor option:selected').val();
									var desc1 = $('#txtDescuento1').val();
									var desc2 = $('#txtDescuento2').val();
									var folioE = $('#txtFolioE').val();
									
									if(fecha.trim()!="" && factura.trim()!="" && usuario.trim()!="" && proveedor.trim()!="" && desc1.trim()!="" &&desc1.trim()>=0 && desc2.trim()!="" &&desc2.trim()>=0 && folioE.trim()!=""){
										$('#txtCantidad').prop('disabled',false);
										$('#txtCodigo').prop('disabled',false);
										$('#txtDesc1').prop('disabled',false);
										$('#txtDesc2').prop('disabled',false);
										$('#chkIVA').prop('disabled',false);
										$('#chkIEPS1').prop('disabled',false);
										$('#chkIEPS2').prop('disabled',false);
										$('#chkIEPS3').prop('disabled',false);
										$('#txtCosto').prop('disabled',false);
										$('#btnAgregar').prop('disabled',false);
										$('#btnModificar').prop('disabled',true);
										
										$('#txtCantidad').select();
										$('#txtCantidad').focus();
									
										
										var storage = {'fecha':$('#txtFecha').val(),
													   'factura':$('#txtFactura').val(),
													   'usuario':$('#usuario').val(),
													   'nota':$('#chkNota:checked').length,
													   'proveedor':$('#proveedor option:selected').val(),
													   'desc1':$('#txtDescuento1').val(),
													   'desc2':$('#txtDescuento2').val(),
													   'folioE':$('#txtFolioE').val()				   
													};
										
										localStorage.setItem('recepcion', JSON.stringify(storage));
										
									}else{
										window.alert("No puede iniciar la captura porque alguno de los campos anteriores esta vacio");
									}
										
																											
								});	
												
					
						
						$('#btnGuardar').on('click ',function(e)
								{						
							
							var fecha = $('#txtFecha').val();
							var factura = $('#txtFactura').val();
							var usuario = $('#usuario').val();
							var nota = $('#chkNota:checked').length;
							var proveedor = $('#proveedor option:selected').val();
							var desc1 = $('#txtDescuento1').val();
							var desc2 = $('#txtDescuento2').val();
							var folioE = $('#txtFolioE').val();
							var subtotal = $('#lblSubtotal').val();
							//var filas = t.length;
							var table = $("#example").tableToJSON();
							
							console.log("Contenido de la tabla: "+table);
							console.log(JSON.stringify(table));
							
							if(fecha.trim()!=""&&factura.trim()!=""&&usuario.trim()!=""&&proveedor.trim()!=""&&desc1.trim()!=""&&desc2.trim()!=""&&folioE.trim()!=""&&subtotal.trim()!=""){
								$.post('recepcion.jr',{
									tarea:'guardar',
									txtFecha:fecha,
									txtFactura:factura,
									txtUsuario:usuario,
									chBoxNota:nota,
									lblSubtotal:subtotal,
									txtProveedor:proveedor,
									txtDescuento1:desc1,
									txtDescuento2:desc2,
									txtFolioE:folioE,
									txtNota:$('#txtFolioE').val(),
									tblProductos:JSON.stringify(table)
																
									
								}, function(){
										//$('#txtDescp').val(descripcion);
								});
								
								
								$('#txtFecha').val("");
								$('#txtFactura').val("");
								$('#usuario').val("");
								$('#chkNota').prop('checked',false);
								$('#proveedor').val("");
								$('#txtDescuento1').val("");
								$('#txtDescuento2').val("");
								$('#txtFolioE').val("");
								
								$('#lblDesc1').val("");
								$('#lblDesc2').val("");
								$('#lblIeps1').val("");
								$('#lblIeps2').val("");
								$('#lblIeps3').val("");
								$('#lblIva').val("");
								$('#lblSubtotal').val("");
								$('#lblTotal').val("");
								
								$('#txtCantidad').prop('disabled',true);
								$('#txtCodigo').prop('disabled',true);
								$('#txtDesc1').prop('disabled',true);
								$('#txtDesc2').prop('disabled',true);
								$('#chkIVA').prop('disabled',true);
								$('#chkIEPS1').prop('disabled',true);
								$('#chkIEPS2').prop('disabled',true);
								$('#chkIEPS3').prop('disabled',true);
								$('#txtCosto').prop('disabled',true);
								$('#btnAgregar').prop('disabled',true);
								

								t.row('').remove().draw( false );
								$("#txtDescp").val("");
								$('#txtFecha').focus();
								
								descuento1=0;
								descuento2=0;
								ieps1=0;
								ieps2=0;
								ieps3=0;
								iva=0;
								subtotal=0;
								total=0;
								
								//window.open('','_self',''); 
								//window.close();
								
								localStorage.removeItem('recepcion');
								localStorage.removeItem('productos');
								
								//$(location).attr('href', '${pageContext.request.contextPath}/recepciones.jsp');
									
							}else{
								window.alert("No puedo guardar una recepcion si tiene datos de recepcion vacios y/o los descuentos sean igual o mayores que 0");
							}
							
																																				
						});	
						
						$('#btnBorrar').on('click ',function(e)
						{
							descuento1=0;
							descuento2=0;
							ieps1=0;
							ieps2=0;
							ieps3=0;
							iva=0;
							subtotal=0;
							total=0;
							
							/*$.post('recepcion.jr',{
								tarea:'borrar',
								txtIdRecepcion:$('#txtFolioE').val()
							}, function(f){
							});*/
							
							
							$('#txtFecha').val("");
							$('#txtFactura').val("");
							$('#usuario').val("");
							$('#chkNota').val("");
							$('#proveedor').val("");
							$('#txtDescuento1').val("");
							$('#txtDescuento2').val("");
							//$('#txtFolioE').val("");
							
							$('#txtCantidad').val("1");
							$('#txtCodigo').val("");
							$('#txtDesc1').val("");
							$('#txtDesc2').val("");
							$('#chkIVA').prop('checked',false);
							$('#chkIEPS1').prop('checked',false);
							$('#chkIEPS2').prop('checked',false);
							$('#chkIEPS3').prop('checked',false);
							$('#txtCosto').val("");
							$('#btnAgregar').prop('disabled',true);
							$('#btnModificar').prop('disabled',true);
														
							$('#lblDesc1').val("");
							$('#lblDesc2').val("");
							$('#lblIeps1').val("");
							$('#lblIeps2').val("");
							$('#lblIeps3').val("");
							$('#lblIva').val("");
							$('#lblSubtotal').val("");
							$('#lblTotal').val("");
							
							$('#txtCantidad').prop('disabled',true);
							$('#txtCodigo').prop('disabled',true);
							$('#txtDesc1').prop('disabled',true);
							$('#txtDesc2').prop('disabled',true);
							$('#chkIVA').prop('disabled',true);
							$('#chkIEPS1').prop('disabled',true);
							$('#chkIEPS2').prop('disabled',true);
							$('#chkIEPS3').prop('disabled',true);
							$('#txtCosto').prop('disabled',true);
							$('#btnAgregar').prop('disabled',true);
							
							//$.post('recepcion.jr',{
							//	tarea:'cargar'
							//},function(date){
							//	$('#txtFolioE').val(date);
							//});

							t.row('').remove().draw( false );
							$("#txtDescp").val("");
							$('#txtFecha').focus();
													
						});
						
						
						// se establece el control al detectar tecla enter en el campo
							
							$('#btnAgregar').on('click ',function(e){
										var cantidad = $('#txtCantidad').val(); 
										var codigo = $('#txtCodigo').val(); 	
										var descp = $('#txtDescp').val(); 
										var des1 = 	$('#txtDesc1').val();
										var des2 = 	$('#txtDesc2').val();
										var costo = $('#txtCosto').val();
										var importeIva = 0;
										var importeIeps1 = 0;
										var importeIeps2 = 0;
										var importeIeps3 = 0;
										
												
										if(cantidad.trim()!=""&&codigo.trim()!=""&&descp.trim()!=""&&des1.trim()!=""&&des1.trim()>=0&&des2.trim()!=""&&des2.trim()>=0&&costo.trim()!=""){
											/*$.post('recepcion.jr',{
												tarea:'agregar',
												txtNota:$('#txtFolioE').val(),
												txtFactura:$('#txtFactura').val(),
												txtCodigo:$('#txtCodigo').val(),
												txtDescp:$('#txtDescp').val(),
												txtCantidad:$('#txtCantidad').val(),
												txtCosto:$('#txtCosto').val(),
												txtFecha:$('#txtFecha').val()
												
											}, function(f){
													//$('#txtDescp').val(descripcion); **ya no
											});*/
											
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
													$('#txtDesc1').val(),
													$('#txtDesc2').val(),
													$('#chkIVA:checked').length,
													$('#chkIEPS1:checked').length,
													$('#chkIEPS2:checked').length,
													$('#chkIEPS3:checked').length,
													($('#txtCosto').val()*1).toFixed(2),
													($('#txtCosto').val()*$('#txtCantidad').val()).toFixed(2),
													'',
													//'<button type="button" class="myButton" id="Mod'+counter+'" onclick="editar()">Editar</button>',
													'<button type="button" class="myButton" id="Del'+counter+'" onclick="eliminar()">X</button>'
													 ])
													.draw();
											         counter++;	
											         var ivaProducto = 0;
											         var ieps1Producto = 0;
											         var ieps2Producto = 0;
											         if($('#chkIVA:checked').length==1){
															ivaProducto = $('#txtCantidad').val()*$('#txtCosto').val()*0.16;
											         }
											         if($('#chkIEPS1:checked').length==1){
															//ieps1 += ($('#txtCantidad').val()*$('#txtCosto').val()*0.25)+(($('#txtCantidad').val()*$('#txtCosto').val()*0.25)*0.16);
															ieps1Producto += $('#txtCantidad').val()*$('#txtCosto').val()*0.25;
															ivaProducto += $('#txtCantidad').val()*($('#txtCosto').val()*0.25)*0.16;
											         }
											         if($('#chkIEPS2:checked').length==1){
															ieps2Producto += $('#txtCantidad').val()*$('#txtCosto').val()*0.08;
											         }
											         var producto = {'cantidad':$('#txtCantidad').val(),
											        	 			'codigo':codigo1.concat($("#txtCodigo").val().trim()),
											        	 			'descripcion':$('#txtDescp').val(),
											        	 			'desc1':$('#txtDesc1').val(),
											        	 			'desc2':$('#txtDesc2').val(),
											        	 			'iva':$('#chkIVA:checked').length,
											        	 			'ieps1':$('#chkIEPS1:checked').length,
											        	 			'ieps2':$('#chkIEPS2:checked').length,
											        	 			'costo':($('#txtCosto').val()*1).toFixed(2),
											        	 			'importe':($('#txtCosto').val()*$('#txtCantidad').val()).toFixed(2),
											        	 			'ivaImporte':ivaProducto,
											        	 			'ieps1Importe':ieps1Producto,
											        	 			'ieps2Importe':ieps2Producto
											        	 			};
											         productos.push(producto);
											         localStorage.setItem('productos', JSON.stringify(productos));
											         console.log(producto);
											         console.log(productos);
											         console.log(localStorage.getItem('productos'));
																	         
											descuento1 += parseFloat($('#txtDesc1').val());
											descuento2 += parseFloat($('#txtDesc2').val());
											if($('#chkIVA:checked').length==1){
												iva += $('#txtCantidad').val()*$('#txtCosto').val()*0.16;
												importeIva = $('#txtCantidad').val()*$('#txtCosto').val()*0.16;
											}
											if($('#chkIEPS1:checked').length==1){
												//ieps1 += ($('#txtCantidad').val()*$('#txtCosto').val()*0.25)+(($('#txtCantidad').val()*$('#txtCosto').val()*0.25)*0.16);
												ieps1 += $('#txtCantidad').val()*$('#txtCosto').val()*0.25;
												iva+=$('#txtCantidad').val()*($('#txtCosto').val()*0.25)*0.16;
												importeIeps1 = ($('#txtCantidad').val()*$('#txtCosto').val()*0.25);
												importeIva += (($('#txtCantidad').val()*$('#txtCosto').val()*0.25)*0.16);
											}
											if($('#chkIEPS2:checked').length==1){
												ieps2 += $('#txtCantidad').val()*$('#txtCosto').val()*0.08;
												importeIeps2 = $('#txtCantidad').val()*$('#txtCosto').val()*0.08;
											}
											if($('#chkIEPS3:checked').length){
												ieps3 += $('#txtCantidad').val()*$('#txtCosto').val()*0.10;
												importeIeps3 = $('#txtCantidad').val()*$('#txtCosto').val()*0.10;
											}
											
											subtotal = $('#txtCantidad').val()*$('#txtCosto').val();										        
											total = subtotal+importeIva+importeIeps1+importeIeps2+importeIeps3;
											
											
											var sumaDesc1 = $('#lblDesc1').val()*1+descuento1;
											var sumaDesc2 = $('#lblDesc2').val()*1+descuento2;
											var sumaIeps1 = $('#lblIeps1').val()*1+importeIeps1;
											var sumaIeps2 = $('#lblIeps2').val()*1+importeIeps2;
											var sumaIeps3 = $('#lblIeps3').val()*1+importeIeps3;
											var sumaIva = $('#lblIva').val()*1+importeIva;
											var sumaSubtotal = $('#lblSubtotal').val()*1+subtotal;
											var sumaTotal = $('#lblTotal').val()*1+total;
											
											$('#lblDesc1').val(sumaDesc1.toFixed(2));
											$('#lblDesc2').val(sumaDesc2.toFixed(2));
											$('#lblIeps1').val(sumaIeps1.toFixed(2));
											$('#lblIeps2').val(sumaIeps2.toFixed(2));
											$('#lblIeps3').val(sumaIeps3.toFixed(2));
											$('#lblIva').val(sumaIva.toFixed(2));
											$('#lblSubtotal').val(sumaSubtotal.toFixed(2));
											//$('#lblTotal').val("$ "+total.toFixed(2));
											$('#lblTotal').val(sumaTotal.toFixed(2));
											
											console.log("subtotal: "+subtotal);
											console.log("sumaSubt: "+sumaSubtotal);
											
											$('#txtCantidad').val("1");
											$('#txtCodigo').val("");
											$('#txtDesc1').val("");
											$('#txtDesc2').val("");
											$('#chkIVA').prop('checked',false);
											$('#chkIEPS1').prop('checked',false);
											$('#chkIEPS2').prop('checked',false);
											$('#chkIEPS3').prop('checked',false);
											$('#txtCosto').val("");
											$('#txtDescp').val("");
													
											$('#txtCantidad').select();
											$('#txtCantidad').focus();	
							
										}else{
											window.alert("Revise que ninguno de los datos esten vacios y/o los descuentos sean igual o mayores que 0");
											$('#txtCantidad').focus();
										}
										
									
																						
							});	
													
						
							$('#btnModificar').on('click ',function(e){
								console.log("=====click en Modificar=======");
								console.log("subtotal: "+subtotal);
								console.log("iva: "+iva);
								console.log("ieps1: "+ieps1);
								console.log("ieps2: "+ieps2);
								console.log("total: "+total);
								/*$.post('recepcion.jr',{
									tarea:'modificar',
									producto:index,
									txtCantidad:$("#txtCantidad").val(),
									txtCodigo:$("#txtCodigo").val(),
									txtDescp:$('#txtDescp').val(),
									txtCosto:$('#txtCosto').val(),
									
								}, function(f){
										//$('#txtDescp').val(descripcion);
								});*/
								t.row(index).data([
							            
							            $('#txtCantidad').val(),
										$('#txtCodigo').val(),
										$('#txtDescp').val(),						
										$('#txtDesc1').val(),
										$('#txtDesc2').val(),
										$('#chkIVA:checked').length,
										$('#chkIEPS1:checked').length,
										$('#chkIEPS2:checked').length,
										$('#chkIEPS3:checked').length,
										$('#txtCosto').val(),
										($('#txtCantidad').val()*$('#txtCosto').val()).toFixed(2),
										'',
										//'<button type="button" class="myButton" id="Mod'+index+'" onclick="editar()">Editar</button>',
										'<button type="button" class="myButton" id="Del'+index+'" onclick="eliminar()">X</button>'
										 ]);											         
								
								descuento1 += parseFloat($('#txtDesc1').val());
								descuento2 += parseFloat($('#txtDesc2').val());
								if($('#chkIVA:checked').length==1)
									iva += $('#txtCantidad').val()*$('#txtCosto').val()*0.16;
								if($('#chkIEPS1:checked').length==1){
									ieps1 += $('#txtCantidad').val()*$('#txtCosto').val()*0.25;
									iva += ($('#txtCantidad').val()*$('#txtCosto').val()*0.25)*0.16;
								}
								if($('#chkIEPS2:checked').length==1)
									ieps2 += $('#txtCantidad').val()*$('#txtCosto').val()*0.08;
								if($('#chkIEPS3:checked').length)
									ieps3 += $('#txtCantidad').val()*$('#txtCosto').val()*0.10;
								
								subtotal += $('#txtCantidad').val()*$('#txtCosto').val();
								//total += ($('#txtCantidad').val()*$('#txtCosto').val())+($('#txtCantidad').val()*$('#txtCosto').val()*0.16)+(($('#txtCantidad').val()*$('#txtCosto').val()*0.25)+(($('#txtCantidad').val()*$('#txtCosto').val()*0.25)*0.16))+($('#txtCantidad').val()*$('#txtCosto').val()*0.08)+ieps3;
								total = subtotal + iva + ieps1 + ieps2;
															         
								$('#lblDesc1').val(descuento1.toFixed(2));
								$('#lblDesc2').val(descuento2.toFixed(2));
								$('#lblIeps1').val(ieps1.toFixed(2));
								$('#lblIeps2').val(ieps2.toFixed(2));
								$('#lblIeps3').val(ieps3.toFixed(2));
								$('#lblIva').val(iva.toFixed(2));
								$('#lblSubtotal').val(subtotal.toFixed(2));
								$('#lblTotal').val(total.toFixed(2));
								         
								$('#txtCantidad').val("1");
								$('#txtCodigo').val("");
								$('#txtDesc1').val("");
								$('#txtDesc2').val("");
								$('#chkIVA').prop('checked',false);
								$('#chkIEPS1').prop('checked',false);
								$('#chkIEPS2').prop('checked',false);
								$('#chkIEPS3').prop('checked',false);
								$('#txtCosto').val("");
								$('#txtDescp').val("");
										
								$('#btnAgregar').prop('disabled',false);	
								$('#btnModificar').prop('disabled',true);
								
								$('#txtCantidad').focus();
								console.log("====================");
								console.log("subtotal: "+subtotal);
								console.log("iva: "+iva);
								console.log("ieps1: "+ieps1);
								console.log("ieps2: "+ieps2);
								console.log("total: "+total);
																
							});
							$("#btnDevolucion").button().click(function(){
								window.open("listadevolrecepciones.jsp", "_blank");
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
							 
							
						 						  
						 
						
						//$('#btnAgregar').click();

// 						// Previene la perdidá de datos en el formulario actual 
// 					 	window.onbeforeunload = function(evt) 
// 						{
// 							var message = 'Are you sure you want to leave?';
// 							if (typeof evt == 'undefined') {
// 								evt = window.event;
// 							}
// 							if (evt) {
// 								evt.returnValue = message;
// 							}
// 							return message;
// 						} 

 					});
</script>


</head>

<body>
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
			<label id="title-point">ALTA DE RECEPCION</label>
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
				<label id="lblFactura">No.Factura</label>
					<input type="text" id="txtFactura" name="txtFactura">
					
			</div>
			<div class="box-container clearfix">
				<label id="lblUsuario">Usuario</label>
					<!-- input type="text" id="txtUsuario"-->
					<input type="text" name="usuario" id="usuario" value="<%=nombre%>" disabled></input>
			</div>
			<div class="float-left">
				<!-- wrapper 1 -->
				<label id="lbNota">Nota</label>
					<input type="checkbox" id="chkNota" name="chBoxNota">
					
			</div>
			
		</div>
		<!-- Encabezado 2-->
		
		<div id="width-extension">
			<!-- panel superior S1 -->
			<div class="float-left">
				<!-- wrapper 1 -->
				<label id="lblProveedor">Proveedor</label>
				 <select name="proveedor" id="proveedor">
					<%
						RecepcionDao recepcion = new RecepcionDao();
						List<Object> proveedores = recepcion.muestraProveedores();
						for (Object proveedor:proveedores)
							out.println("<option value="+proveedor+">"+proveedor+"</option>");			
					%>
				</select>
			</div>
			<div class="float-left">
				<!-- wrapper 1 -->
				<label id="lblDescuento1">Descuento 1</label>
					<input type="text" id="txtDescuento1" name="txtDescuento1">
			</div>
			<div class="float-left">
				<!-- wrapper 1 -->
				<label id="lblDescuento2">Descuento 2</label>
					<input type="text" id="txtDescuento2" name="txtDescuento2">
			</div>
			<div class="float-left">
				<!-- wrapper 1 -->
				<label id="lblFolioE">Folio Electronico</label>
					<input type="text" id="txtFolioE" name="txtFolioE">
			</div>
			
		</div>
			
		<div id="width-extension">
					<input type="button" class="myButton" id="btnCapturar"  name="btnCapturar" value="Iniciar Captura">					
					<input type="button" class="myButton" id="btnGuardar" name="btnGuardar" value="Guardar Captura">
					<input type="button" class="myButton" id="btnBorrar" name="btnBorrar" value="Borrar Captura">
					<input type="button" class="myButton" id="btnImprimir" name="btnImprimir" value="Imprimir">
			</div>
		<!-- Panel S2-->
		<div id="width-extension">
			<div class="datagridstyle">
					<section>
					<!-- form id="formrecepcion" action="" method="post"-->
						<table id="example" class="display" cellspacing="0" width="100%">
							<thead>
								<tr>									
									<th style="width: 1%">Cant</th>
									<th style="width: 11%">Codigo</th>
									<th style="width: 22%">Descripcion</th>
									<th style="width: 0%">Desc1</th>
									<th style="width: 0%">Desc2</th>
									<th style="width: 0%">IVA</th>
									<th style="width: 0%">IEPS1</th>
									<th style="width: 0%">IEPS2</th>
									<th style="width: 0%">IEPS3</th>
									<th>Costo</th>
									<th>Importe</th>
									<th style="width: 10%"></th>
									<th style="width: 8%"></th>
									
									
					
									
								</tr>
							</thead>
							<thead>						
								<tr>
									<th style="width: 5%"><input type="text" id="txtCantidad" name="txtCantidad" value="1" disabled="disabled"></th>
									<th style="width: 15%"><input type="text" id="txtCodigo" name="txtCodigo"  disabled="disabled"></th>
									<th style="width: 20%"><input type="text" id ="txtDescp" name="txtDescp" disabled="disabled"></th>
									<th style="width: 5%"><input type="text" id="txtDesc1" name="txtDesc1" disabled="disabled"></th>
									<th style="width: 5%"><input type="text" id="txtDesc2" name="txtDesc2" disabled="disabled"></th>
									<th style="width: 1%"><input type="checkbox" id="chkIVA" name="chBoxIva" disabled="disabled"></th>
									<th style="width: 1%"><input type="checkbox" id="chkIEPS1" name="chBoxIeps1" disabled="disabled"></th>
									<th style="width: 1%"><input type="checkbox" id="chkIEPS2" name="chBoxIeps2" disabled="disabled"></th>
									<th style="width: 1%"><input type="checkbox" id="chkIEPS3" name="chBoxIeps3" disabled="disabled"></th>
									<th style="width: 6%"><input type="text" id="txtCosto" name="txtCosto" disabled="disabled"></th>
									<th style="width: 4%"><input type="text" id="txtImporte" name="txtImporte" disabled="disabled"></th>
									<th style="width: 8%"><button type="button" class="myButton" id="btnAgregar" name="btnAgregar" disabled="disabled">Agregar</button></th>
									<th style="width: 10%"><button type="button" class="myButton" id="btnModificar" name="btnModificar" disabled="disabled">Agr.Editado</button></th>
							
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
					<!-- <input type="submit" class="myButton" id="btnSecundarios" name="btnEliminar" value="Eliminar Fila Seleccionada">-->
					<!-- <button type ="button" class="myButton" id="btnEliminar" name="btnEliminar">Eliminar Fila Seleccionada</button>-->
					<button type="button" id="btnDevolucion" name="btnDevolucion">Devolucion</button>
					<button type="button" id="btnEditar" name="btnEditar">Editar Producto Seleccionado</button>
			</div>
		<div id="width-extension">
			<div class="group-left">
				<p>
					<label> --</label>
			</div>
			<div class="group-right">
				<div class="subgroup-left">
					<label> Descuento 1 :</label> 
				    <label> Descuento 2 :</label> 				
					<label>IEPS1 </label>
					<label> IEPS2 </label>
					<label> IEPS3 </label>
					<label> IVA </label> 
					<label> Subtotal $ </label> 
					<label> TOTAL </label>
				</div>
				<div class="subgroup-left">
					<input type="text" disabled="disabled" id="lblDesc1" name="lblDesc1" value="00.00">
					<input type="text" disabled="disabled" id="lblDesc2" name="lblDesc2" value="00.00">
					<input type="text" disabled="disabled" id="lblIeps1" name="lblIeps1" value="00.00">
					<input type="text" disabled="disabled" id="lblIeps2" name="lblIeps2" value="00.00">
					<input type="text" disabled="disabled" id="lblIeps3" name="lblIeps3" value="00.00">
					<input type="text" disabled="disabled" id="lblIva" name="lblIva" value="00.00">
					<input type="text" disabled="disabled" id="lblSubtotal" name="lblSubtotal" value="00.00">
					<input type="text" disabled="disabled" id="lblTotal" name="lblTotal" value="00.00">
				</div>
			</div>
		</div>
		<!-- S3-->
		<!-- Panel S4-->
		<!-- s4 -->
	 </form>
	</div>
	<!-- contenedor principal -->
	

</body>
</html>
