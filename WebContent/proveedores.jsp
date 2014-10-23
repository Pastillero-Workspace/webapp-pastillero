<%@page import="java.util.List"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="mx.com.pastillero.types.Types"%>

<%@page import="mx.com.pastillero.model.dao.ProveedorDireccionDao"%>
<%@page import="mx.com.pastillero.model.formBeans.MovimientoGeneral"%>
<%@page import="mx.com.pastillero.model.viewdao.ViewModelMovimientosDao"%>
<%@page import="mx.com.pastillero.model.formBeans.MovimientoRecepcion"%>
<%@page import="mx.com.pastillero.model.dao.MovimientoRecepcionDao"%>
<%@page import="mx.com.pastillero.model.dao.MovimientosDao"%>
<%@page import="mx.com.pastillero.model.formBeans.Movimientos"%>
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
	<script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
	
	<script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
	<script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script>
	<script src="<c:url value="/resources/js/demo.js" />"></script>
	<script src="<c:url value="/resources/js/jquery.tabletojson.min.js" />"></script>
	
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
	<% 		 	
	 	ProveedorDireccionDao pD = new ProveedorDireccionDao();
	 	List<Object[]> datos = pD.mostrar();	 	
	%>
		// Se crea array de datos aleatorios
		var data = [];
		
		<%for(int i=0; i<datos.size(); i++){%>
		
			data[<%=i%>]=[  '<%=datos.get(i)[1]%>',
			   	            '<%=datos.get(i)[2]%>',
			   	            '<%=datos.get(i)[3]%>',
			   	            '<%=datos.get(i)[4]%>',
			   	            '<%=datos.get(i)[5]%>',		   	               
			   	            '<%=datos.get(i)[7]%>',
			   	            '<%=datos.get(i)[8]%>',
			   	            '<%=datos.get(i)[9]%>',
			   	            '<%=datos.get(i)[10]%>',
			   	            '<%=datos.get(i)[12]%>',
					        '<%=datos.get(i)[11]%>',
					        '<%=datos.get(i)[13]%>',
					        '<%=datos.get(i)[14]%>',
					        '<%=datos.get(i)[15]%>'];
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
			scrollY : 200,
			scrollCollapse : true
			
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
			 
			var index = 0;
			var table = $('#search').DataTable();
			$(function(){
				$("#btnEliminar").button().click(function(e){
					index = table.row('.selected').index();
					var registro = table.row('.selected').data();
					var nombreProveedor;
					if(index>=0){
						$.each(registro, function(data, value){
							if(data==0){
								nombreProveedor = value;
							}
						});
						$.post('proveedor.jr',{
							tarea: 'eliminar',
							txtNombre: nombreProveedor
						},function(){
							
						});
						table.row(index).remove().draw(true);
					}else{
						window.alert("Seleccione un proveedor de la lista para poder eliminarlo");
					}
				});
				$("#btnAgregar").button().click(function(e){
					$("#formProveedorNuevo").dialog("open");
					$("#txtNombreNuevo").select();
				});
				$("#btnExcel").button().click(function(e){
					var t = $('#search').tableToJSON();
				    
					$.post('reporte.jr',{
						reporte: 'proveedores',
						txtTitulo:'Reporte de Proveedores',
						tblProveedores:JSON.stringify(t)					
					}, function(f){
					});
					window.open("reporte.jsp", "Impresion", "height=600,width=400");
				});
				$("#btnEditar").button().click(function(e){
					index = table.row('.selected').index();
					var registro = table.row('.selected').data();
					
					if(index>=0){
						$.each(registro, function(date,value){
							if(date==0){
								$("#txtNombre").val(value);
							}
							if(date==1){
								$("#txtEmail").val(value);
							}
							if(date==2){
								$("#txtFax").val(value);
							}
							if(date==3){
								$("#txtRfc").val(value);
							}
							if(date==4){
								$("#txtDiasCredito").val(value);
							}
							if(date==5){
								$("#txtDescGeneral").val(value);
							}
							if(date==6){
								$("#txtDesc2").val(value);
							}
							if(date==7){
								$("#txtDesc3").val(value);
							}
							if(date==8){
								$("#txtCalle").val(value);
							}
							if(date==9){
								$("#txtNoExt").val(value);
							}
							if(date==10){
								$("#txtNoInt").val(value);
							}
							if(date==11){
								$("#txtColonia").val(value);
							}
							if(date==12){
								$("#txtEstado").val(value);
							}
							if(date==13){
								$("#txtCp").val(value);
							}
							
						});
						$("#formProveedor").dialog("open");
						$("#txtNombre").select();
					}
					else{
						window.alert("Seleccione a un Proveedor");
					}
				});
			});
			$("#formProveedor").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				buttons:{
					"Actualizar": {
						text: "Actualizar",
						id:		"btnActualizar",
						click:	function(){
							if($('#txtNombre').val().trim()!=""&&$('#txtEmail').val().trim()!=""&&$('#txtFax').val().trim()!=""&&
									$('#txtRfc').val().trim()!=""&&$('#txtDiasCredito').val().trim()!=""&&$('#txtCalle').val().trim()!=""&&
									$('#txtNoInt').val().trim()!=""&&$('#txtNoExt').val().trim()!=""&&$('#txtColonia').val().trim()!=""&&
									$('#txtEstado').val().trim()!=""&&$('#txtCp').val().trim()!=""&&$('#txtDescGeneral').val().trim()!=""&&
									$('#txtDesc2').val().trim()!=""&&$('#txtDesc3').val().trim()!=""){
									$.post('proveedor.jr',{
										tarea: 'actualizar',
										txtNombre: $('#txtNombre').val(),
										txtEmail: $('#txtEmail').val(),
										txtFax: $('#txtFax').val(),
										txtRfc: $('#txtRfc').val(),
										txtDiasCredito: $('#txtDiasCredito').val(),
										txtCalle: $('#txtCalle').val(),
										txtNoInt: $('#txtNoInt').val(),
										txtNoExt: $('#txtNoExt').val(),
										txtColonia: $('#txtColonia').val(),
										txtEstado: $('#txtEstado').val(),
										txtCp: $('#txtCp').val(),
										txtDescGeneral: $('#txtDescGeneral').val(),
										txtDesc2: $('#txtDesc2').val(),
										txtDesc3: $('#txtDesc3').val() 
										
									},function(){
										
									});
									
									table.row(index).data([
											            
										$('#txtNombre').val(),
										$('#txtEmail').val(),
										$('#txtFax').val(),						
										$('#txtRfc').val(),
										$('#txtDiasCredito').val(),
										$('#txtDescGeneral').val(),
										$('#txtDesc2').val(),						
										$('#txtDesc3').val(),
										$('#txtCalle').val(),
										$('#txtNoExt').val(),
										$('#txtNoInt').val(),						
										$('#txtColonia').val(),
										$('#txtEstado').val(),
										$('#txtCp').val()
									]);
									
									$(this).dialog("close");
									$('#txtNombre').val('');
									$('#txtEmail').val('');
									$('#txtFax').val('');
									$('#txtRfc').val('');
									$('#txtDiasCredito').val('');
									$('#txtCalle').val('');
									$('#txtNoInt').val('');
									$('#txtNoExt').val('');
									$('#txtColonia').val('');
									$('#txtEstado').val('');
									$('#txtCp').val('');
									$('#txtDescGeneral').val('');
									$('#txtDesc2').val('');
									$('#txtDesc3').val('');
									
								}else{
									window.alert("No puede dejar campos vacios");
								}
									
						}

					}
				}
			});
			$("#formProveedor").dialog("option", "width", 760);
			$("#formProveedor").dialog("option", "height", 600);
			
			
			
			$("#formProveedorNuevo").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				buttons:{
					"Agregar": {
						text: "Agregar",
						id:		"btnAgregarNuevo",
						click:	function(){
							if($('#txtNombreNuevo').val().trim()!=""&&$('#txtEmailNuevo').val().trim()!=""&&$('#txtFaxNuevo').val().trim()!=""&&
									$('#txtRfcNuevo').val().trim()!=""&&$('#txtDiasCreditoNuevo').val().trim()!=""&&$('#txtCalleNuevo').val().trim()!=""&&
									$('#txtNoIntNuevo').val().trim()!=""&&$('#txtNoExtNuevo').val().trim()!=""&&$('#txtColoniaNuevo').val().trim()!=""&&
									$('#txtEstadoNuevo').val().trim()!=""&&$('#txtCpNuevo').val().trim()!=""&&$('#txtDescGeneralNuevo').val().trim()!=""&&
									$('#txtDesc2Nuevo').val().trim()!=""&&$('#txtDesc3Nuevo').val().trim()!=""){
									$.post('proveedor.jr',{
										tarea: 'agregar',
										txtNombre: $('#txtNombreNuevo').val(),
										txtEmail: $('#txtEmailNuevo').val(),
										txtFax: $('#txtFaxNuevo').val(),
										txtRfc: $('#txtRfcNuevo').val(),
										txtDiasCredito: $('#txtDiasCreditoNuevo').val(),
										txtCalle: $('#txtCalleNuevo').val(),
										txtNoInt: $('#txtNoIntNuevo').val(),
										txtNoExt: $('#txtNoExtNuevo').val(),
										txtColonia: $('#txtColoniaNuevo').val(),
										txtEstado: $('#txtEstadoNuevo').val(),
										txtCp: $('#txtCpNuevo').val(),
										txtDescGeneral: $('#txtDescGeneralNuevo').val(),
										txtDesc2: $('#txtDesc2Nuevo').val(),
										txtDesc3: $('#txtDesc3Nuevo').val() 
										
									},function(){
										
									});
									
									table.row.add([
											            
										$('#txtNombreNuevo').val(),
										$('#txtEmailNuevo').val(),
										$('#txtFaxNuevo').val(),						
										$('#txtRfcNuevo').val(),
										$('#txtDiasCreditoNuevo').val(),
										$('#txtDescGeneralNuevo').val(),
										$('#txtDesc2Nuevo').val(),						
										$('#txtDesc3Nuevo').val(),
										$('#txtCalleNuevo').val(),
										$('#txtNoExtNuevo').val(),
										$('#txtNoIntNuevo').val(),						
										$('#txtColoniaNuevo').val(),
										$('#txtEstadoNuevo').val(),
										$('#txtCpNuevo').val()
									]).draw();
									
									$(this).dialog("close");
									$('#txtNombreNuevo').val('');
									$('#txtEmailNuevo').val('');
									$('#txtFaxNuevo').val('');
									$('#txtRfcNuevo').val('');
									$('#txtDiasCreditoNuevo').val('');
									$('#txtCalleNuevo').val('');
									$('#txtNoIntNuevo').val('');
									$('#txtNoExtNuevo').val('');
									$('#txtColoniaNuevo').val('');
									$('#txtEstadoNuevo').val('');
									$('#txtCpNuevo').val('');
									$('#txtDescGeneralNuevo').val('');
									$('#txtDesc2Nuevo').val('');
									$('#txtDesc3Nuevo').val('');
									
								}else{
									window.alert("No puede dejar campos vacios");
								}	
						}
					}
				}
			});
			$("#formProveedorNuevo").dialog("option", "width", 760);
			$("#formProveedorNuevo").dialog("option", "height", 600);

			
			
			
			
			//Tecla enter en todos los campos
			$("#txtNombre").keypress(function(e){
				if(e.which == 13){
					console.log("enter");
					$("#txtEmail").select();
				}
			});
			$("#txtEmail").keypress(function(e){
				if(e.which == 13){
					$("#txtFax").select();
				}
			});
			$("#txtFax").keypress(function(e){
				if(e.which == 13){
					$("#txtRfc").select();
				}
			});
			$("#txtRfc").keypress(function(e){
				if(e.which == 13){
					$("#txtDiasCredito").select();
				}
			});
			
			$("#txtDiasCredito").keypress(function(e){
				if(e.which == 13){
					$("#txtCalle").select();
				}
			});
			$("#txtCalle").keypress(function(e){
				if(e.which == 13){
					$("#txtNoExt").select();
				}
			});
			$("#txtNoExt").keypress(function(e){
				if(e.which == 13){
					$("#txtNoInt").select();
				}
			});
			$("#txtNoInt").keypress(function(e){
				if(e.which == 13){
					$("#txtColonia").select();
				}
			});
			$("#txtColonia").keypress(function(e){
				if(e.which == 13){
					$("#txtEstado").select();
				}
			});
			$("#txtEstado").keypress(function(e){
				if(e.which == 13){
					$("#txtCp").select();
				}
			});
			$("#txtCp").keypress(function(e){
				if(e.which == 13){
					$("#txtDescGeneral").select();
				}
			});
			$("#txtDescGeneral").keypress(function(e){
				if(e.which == 13){
					$("#txtDesc2").select();
				}
			});
			$("#txtDesc2").keypress(function(e){
				if(e.which == 13){
					$("#txtDesc3").select();
				}
			});
			$("#txtDesc3").keypress(function(e){
				if(e.which == 13){
					$("#btnActualizar").focus();
				}
			});
			
			$("#txtNombreNuevo").keypress(function(e){
				if(e.which == 13){
					console.log("enter");
					$("#txtEmailNuevo").select();
				}
			});
			$("#txtEmailNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtFaxNuevo").select();
				}
			});
			$("#txtFaxNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtRfcNuevo").select();
				}
			});
			$("#txtRfcNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtDiasCreditoNuevo").select();
				}
			});
			
			$("#txtDiasCreditoNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtCalleNuevo").select();
				}
			});
			$("#txtCalleNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtNoExtNuevo").select();
				}
			});
			$("#txtNoExtNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtNoIntNuevo").select();
				}
			});
			$("#txtNoIntNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtColoniaNuevo").select();
				}
			});
			$("#txtColoniaNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtEstadoNuevo").select();
				}
			});
			$("#txtEstadoNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtCpNuevo").select();
				}
			});
			$("#txtCpNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtDescGeneralNuevo").select();
				}
			});
			$("#txtDescGeneralNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtDesc2Nuevo").select();
				}
			});
			$("#txtDesc2Nuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtDesc3Nuevo").select();
				}
			});
			$("#txtDesc3Nuevo").keypress(function(e){
				if(e.which == 13){
					$("#btnAgregarNuevo").focus();
				}
			});
		
		});
			
		
	
			/*Funcion que muestra el formulario de "Alta Medico"*/
			$(document).ready(function () {
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





<div id="formProveedor" title="Editar Proveedor" class="text-form">
	<form id="proveedor">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Proveedor</legend>
		<ol>
			<li><label for="nombre">*Nombre: </label><input type="text" size="56" id="txtNombre" name="txtNombre" requiered autofocus >  </li>
			<li><label for="email">*Email: </label><input type="text" size="25" id="txtEmail" name="txtEmail" requiered><label for="fax">*Fax: </label><input type="text" size="18" id="txtFax" name="txtFax" requiered></li>
			<li><label for="rfc">*RFC: </label><input type="text" size="25" id="txtRfc" name="txtRfc" requiered><label for="diasCredito">* Dias Credito: </label><input type="text" size="10" id="txtDiasCredito" name="txtDiasCredito" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalle" name="txtCalle" requiered><label for="noExt">*Num. Ext.: </label><input type="text" id="txtNoExt" name="txtNoExt" size="5" requiered><label for="noInt">*Num. Int.: </label><input type="text" id="txtNoInt" name="txtNoInt" size="5" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColonia" name="txtColonia" requiered><label for="estado">*Estado: </label><input type="text" id="txtEstado" name="txtEstado" size="23" requiered><li>
			<li><label for="cp">*C.P: </label><input type="text" id="txtCp" name="txtCp" size="7" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Descuentos</legend>
		<ol>
			<li><label for="descGeneral">*Descuento General: </label><input type="text" size="5" id="txtDescGeneral" name="txtDescGeneral" requiered></li>
			<li><label for="desc2">*Descuento 2: </label><input type="text" size="5" id="txtDesc2" name="txtDesc2" requiered></li>
			<li><label for="desc3">*Descuento 3</label><input type="text" size="5" id="txtDesc3" name="txtDesc3" requiered></li>
		</ol>
	</fieldset>
	</form>
</div>

<div id="formProveedorNuevo" title="Nuevo Proveedor" class="text-form">
	<form id="proveedorNuevo">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Proveedor</legend>
		<ol>
			<li><label for="nombre">*Nombre: </label><input type="text" size="56" id="txtNombreNuevo" name="txtNombreNuevo" requiered autofocus >  </li>
			<li><label for="email">*Email: </label><input type="text" size="25" id="txtEmailNuevo" name="txtEmailNuevo" requiered><label for="fax">*Fax: </label><input type="text" size="18" id="txtFaxNuevo" name="txtFaxNuevo" requiered></li>
			<li><label for="rfc">*RFC: </label><input type="text" size="25" id="txtRfcNuevo" name="txtRfcNuevo" requiered><label for="diasCredito">* Dias Credito: </label><input type="text" size="10" id="txtDiasCreditoNuevo" name="txtDiasCreditoNuevo" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalleNuevo" name="txtCalleNuevo" requiered><label for="noExt">*Num. Ext.: </label><input type="text" id="txtNoExtNuevo" name="txtNoExtNuevo" size="5" requiered><label for="noInt">*Num. Int.: </label><input type="text" id="txtNoIntNuevo" name="txtNoIntNuevo" size="5" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColoniaNuevo" name="txtColoniaNuevo" requiered><label for="estado">*Estado: </label><input type="text" id="txtEstadoNuevo" name="txtEstadoNuevo" size="23" requiered><li>
			<li><label for="cp">*C.P: </label><input type="text" id="txtCpNuevo" name="txtCpNuevo" size="7" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Descuentos</legend>
		<ol>
			<li><label for="descGeneral">*Descuento General: </label><input type="text" size="5" id="txtDescGeneralNuevo" name="txtDescGeneralNuevo" requiered></li>
			<li><label for="desc2">*Descuento 2: </label><input type="text" size="5" id="txtDesc2Nuevo" name="txtDesc2Nuevo" requiered></li>
			<li><label for="desc3">*Descuento 3</label><input type="text" size="5" id="txtDesc3Nuevo" name="txtDesc3Nuevo" requiered></li>
		</ol>
	</fieldset>
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
					<li><a href="#">Recargar Datos</a></li>
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
				<button id="btnEditar">Editar</button>
				<button id="btnEliminar">Eliminar</button>
				<button id="btnAgregar">Agregar</button>
				<button id="btnExcel">Excel</button>
			</div>
			<table id="search" class="display"cellspacing="0" width="1024px">
				<thead>	
					<tr>
						<th style="width: 30%">Nombre</th>
						<th style="width: 20%">Email</th>
						<th style="width: 5%">Fax</th>
						<th style="width: 10%">RFC</th>
						<th style="width: 2%">Dias Credito</th>
						<th style="width: 2%">Desc General</th>
						<th style="width: 2%">Desc2</th>
						<th style="width: 2%">Desc3</th>
						<th style="width: 25%" >Calle</th>
						<th style="width: 2%" >No.Ext.</th>
						<th style="width: 2%" >No.Int.</th>
						<th style="width: 15%">Colonia</th>
						<th style="width: 10%">Estado</th>
						<th style="width: 5%">CP</th>
				    </tr>
				    </thead>
				    <thead>							
				    <tr>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Nombre" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Email" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Fax" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="RFC" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="DiasCred" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="DescGen" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Desc2" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Desc3" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Calle" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="No.Ext" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="No.Int" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Colonia" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Estado" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="CP" /></th>	
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
