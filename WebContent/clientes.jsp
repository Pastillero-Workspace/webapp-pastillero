<%@page import="mx.com.pastillero.model.dao.ClienteDireccionDao"%>
<%@page import="mx.com.pastillero.types.Types"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
<head>
	<!-- The CSS Styles for forms -->
	<title>Consulta de Cliente | </title>
    <link href="<c:url value="/resources/css/edit.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/jquery.dataTables.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
	
	<!-- The Javascript config -->
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
	
	<!-- The Javascript config datatables-->
	<script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
	<script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script>
	<script src="<c:url value="/resources/js/demo.js" />"></script>
	<script src="<c:url value="/resources/js/jquery.tabletojson.min.js" />"></script>
	
	<script type="text/javascript" language="javascript" class="init">
	var op = false;
	var claveRespaldo = "";
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
	 	ClienteDireccionDao cDireccion = new ClienteDireccionDao();
	 	List<Object[]>datos = cDireccion.mostrar();	 	
	%>
		// Setting array data from clientedireccion
		var data = [];
		
		<%for(int i=0; i<datos.size(); i++){%>
		
			data[<%=i%>]=[  '<%=datos.get(i)[0]%>',
			   	            '<%=datos.get(i)[1]%>',
			   	            '<%=datos.get(i)[2]%>',
			   	            '<%=datos.get(i)[3]%>',
			   	            '<%=datos.get(i)[5]%>',		   	               
			   	            '<%=datos.get(i)[6]%>',
			   	            '<%=datos.get(i)[7]%>',
			   	            '<%=datos.get(i)[8]%>',
			   	            '<%=datos.get(i)[9]%>',
			   	            '<%=datos.get(i)[10]%>',
					        '<%=datos.get(i)[11]%>',
					        '<%=datos.get(i)[12]%>',
					        '<%=datos.get(i)[13]%>',
					        '<%=datos.get(i)[14]%>',
					        '<%=datos.get(i)[15]%>',
					        '<%=datos.get(i)[16]%>',
					        '<%=datos.get(i)[17]%>',
					        '<%=datos.get(i)[18]%>',
					        '<%=datos.get(i)[19]%>',];
		<%}%>	
	         
			// Create a datatable for control entity data
			var table = $('#search').DataTable( {
			scrollY:        700,
			scrollX: 		1200,
			scrollCollapse: true,
			data:	data,
			dom : "rtiS",
			"stateSave" : true,
		    "bSort": false,
			scrollY : 800,
			scrollCollapse : true
			
		} );
			
			// dtpc_rem : remove row select from dt
		    $('#search tbody').on( 'click', 'tr', function () {
		        if ( $(this).hasClass('selected') ) {
		            $(this).removeClass('selected');
		        }
		        else {
		            table.$('tr.selected').removeClass('selected');
		            $(this).addClass('selected');
		        }
		    } );	
		    
		   
		// Unsafe function on delete posteriori
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
		// ------------------------- UNSAFE
		
		// ufcp_rem : function remove data from input user to dtdb
			var index = 0;
			var table = $('#search').DataTable();
			$(function(){
				$("#btnEliminar").button().click(function(e){
					index = table.row('.selected').index();
					var registro = table.row('.selected').data();
					var claveCliente="";
					if(index>=0){
						$.each(registro, function(data, value){
							if(data==0){
								claveCliente = value;
							}
						});
						$.post('cliente.jr',{
							tarea: 'eliminar',
							txtClave: claveCliente
						},function(){
							
						});
						table.row(index).remove().draw(true);
					}
					else				
						window.alert("Seleccione un cliente de la lista para poder eliminarlo");
				
					
				// ufcp_add : function add data from input user to dtdb
				});
				$("#btnAgregar").button().click(function(e){
					$("#formClienteNuevo").dialog("open");
					$("#txtClaveNuevo").select();
				});
				$("#btnExcel").button().click(function(e){
					var t = $('#search').tableToJSON();
				    
					$.post('reporte.jr',{
						reporte: 'clientes',
						txtTitulo:'Reporte de Clientes',
						tblClientes:JSON.stringify(t)					
					}, function(f){
					});
					
					//$(location).attr('href', '${pageContext.request.contextPath}/reporte.jsp');
					//window.alert("Módulo en desarrollo");
					window.open("reporte.jsp", "Impresion", "height=600,width=400");
				});
				
				$("#btnEditar").button().click(function(e){
					index = table.row('.selected').index();
					var registro = table.row('.selected').data();
					
					if(index>=0){
						$.each(registro, function(date,value){
							if(date==0){
								$("#txtClave").val(value);
								claveRespaldo = value;
							}
							if(date==1){
								$("#txtNombre").val(value);
							}
							if(date==2){
								$("#txtEmail").val(value);
							}
							if(date==3){
								$("#txtRfc").val(value);
							}
							if(date==4){
								$("#txtCredito").val(value);
							}
							if(date==5){
								$("#txtDiasCred").val(value);
							}
							if(date==6){
								$("#txtLimiteCred").val(value);
							}
							if(date==7){
								$("#txtVentaAnual").val(value);
							}
							if(date==8){
								$("#txtSaldo").val(value);
							}
							if(date==9){
								$("#txtDescExtra").val(value);
							}
							if(date==10){
								$("#txtVentaMensual").val(value);
							}
							if(date==11){
								$("#txtCalle").val(value);
							}
							if(date==12){
								$("#txtNoExt").val(value);
							}
							if(date==13){
								$("#txtNoInt").val(value);
							}
							if(date==14){
								$("#txtColonia").val(value);
							}
							if(date==15){
								$("#txtCiudad").val(value);
							}
							if(date==16){
								$("#txtEstado").val(value);
							}
							if(date==17){
								$("#txtCp").val(value);
							}
							
						});
						$("#formCliente").dialog("open");
						$("#txtClave").select();
					}
					else{
						window.alert("Seleccione a un Cliente");
					}
				});
				
			});
			
			/* declare the input forms*/
			$("#formCliente").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				buttons:{
					"Actualizar": {
						text: "Actualizar",
						id:		"btnActualizar",
						click:	function(){
							if($('#txtNombre').val().trim()!=""){
									$.post('cliente.jr',{
									tarea: 'actualizar',
									claveRespaldo: claveRespaldo,
									txtClave: $('#txtClave').val(),
									txtNombre: $('#txtNombre').val(),
									txtEmail: $('#txtEmail').val(),
									txtRfc: $('#txtRfc').val(),
									txtCredito: $('#txtCredito').val(),
									txtDiasCred: $('#txtDiasCred').val(),
									txtLimiteCred: $('#txtLimiteCred').val(),
									txtVentaAnual: $('#txtVentaAnual').val(),
									txtSaldo: $('#txtSaldo').val(),
									txtDescExtra: $('#txtDescExtra').val(),
									txtVentaMensual: $('#txtVentaMensual').val(),
									txtCalle: $('#txtCalle').val(),
									txtNoExt: $('#txtNoExt').val(),
									txtNoInt: $('#txtNoInt').val(),
									txtColonia: $('#txtColonia').val(),
									txtCiudad: $('#txtCiudad').val(),
									txtEstado: $('#txtEstado').val(),
									txtCp: $('#txtCp').val(),
									opcDesc: $("#opcDesc option:selected").val()
									},function()
									{
										
									});
									
									table.row(index).data([											            
										$('#txtClave').val(),
										$('#txtNombre').val(),
										$('#txtEmail').val(),						
										$('#txtRfc').val(),
										$('#txtCredito').val(),
										$('#txtDiasCred').val(),
										$('#txtLimiteCred').val(),						
										$('#txtVentaAnual').val(),
										$('#txtSaldo').val(),
										$('#opcDesc option:selected').val(),
										$('#txtDescExtra').val(),
										$('#txtVentaMensual').val(),						
										$('#txtCalle').val(),
										$('#txtNoExt').val(),
										$('#txtNoInt').val(),
										$('#txtColonia').val(),
										$('#txtCiudad').val(),
										$('#txtEstado').val(),
										$('#txtCp').val()
									]);
									
									$(this).dialog("close");
									$('#txtClave').val('');
									$('#txtNombre').val('');
									$('#txtEmail').val('');						
									$('#txtRfc').val('');
									$('#txtCredito').val('');
									$('#txtDiasCred').val('');
									$('#txtLimiteCred').val('');						
									$('#txtVentaAnual').val('');
									$('#txtSaldo').val('');
									$('#txtDescExtra').val('');
									$('#txtVentaMensual').val('');						
									$('#txtCalle').val('');
									$('#txtNoExt').val('');
									$('#txtNoInt').val('');
									$('#txtColonia').val('');
									$('#txtCiudad').val();
									$('#txtEstado').val('');
									$('#txtCp').val('');
									$('#opcDesc option[value="0"]:selected');
								}else{
									window.alert("No puede dejar campos vacios");
								}
									
						}

					}
				}
			});
			$("#formCliente").dialog("option", "width", 760);
			$("#formCliente").dialog("option", "height", 600);
						
			$("#formClienteNuevo").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				buttons:{
					"Agregar": {
						text: "Agregar",
						id:		"btnAgregarNuevo",
						click:	function(){
							if($('#txtClaveNuevo').val().trim()!=""){
									$.post('cliente.jr',{
										tarea: 'agregar',
										txtClave: $('#txtClaveNuevo').val(),
										txtNombre: $('#txtNombreNuevo').val(),
										txtEmail: $('#txtEmailNuevo').val(),
										txtRfc: $('#txtRfcNuevo').val(),
										txtCredito: $('#txtCreditoNuevo').val(),
										txtDiasCred: $('#txtDiasCredNuevo').val(),
										txtLimiteCred: $('#txtLimiteCredNuevo').val(),
										txtVentaAnual: $('#txtVentaAnualNuevo').val(),
										txtSaldo: $('#txtSaldoNuevo').val(),
										txtDescExtra: $('#txtDescExtraNuevo').val(),
										txtVentaMensual: $('#txtVentaMensualNuevo').val(),
										txtCalle: $('#txtCalleNuevo').val(),
										txtNoExt: $('#txtNoExtNuevo').val(),
										txtNoInt: $('#txtNoIntNuevo').val(),
										txtColonia: $('#txtColoniaNuevo').val(),
										txtCiudad: $('#txtCiudadNuevo').val(),
										txtEstado: $('#txtEstadoNuevo').val(),
										txtCp: $('#txtCpNuevo').val(),
										opcDesc: $('#opcDescNuevo option:selected').val()
									},function(){
										
									});
									
									table.row.add([
											            
										$('#txtClaveNuevo').val(),
										$('#txtNombreNuevo').val(),
										$('#txtEmailNuevo').val(),						
										$('#txtRfcNuevo').val(),
										$('#txtCreditoNuevo').val(),
										$('#txtDiasCredNuevo').val(),
										$('#txtLimiteCredNuevo').val(),						
										$('#txtVentaAnualNuevo').val(),
										$('#txtSaldoNuevo').val(),
										$('#opcDescNuevo option:selected').val(),
										$('#txtDescExtraNuevo').val(),
										$('#txtVentaMensualNuevo').val(),						
										$('#txtCalleNuevo').val(),
										$('#txtNoExtNuevo').val(),
										$('#txtNoIntNuevo').val(),
										$('#txtColoniaNuevo').val(),
										$('#txtCiudadNuevo').val(),
										$('#txtEstadoNuevo').val(),
										$('#txtCpNuevo').val()
									]).draw();
									
									$(this).dialog("close");
									$('#txtClaveNuevo').val(),
									$('#txtNombreNuevo').val(),
									$('#txtEmailNuevo').val(),						
									$('#txtRfcNuevo').val(),
									$('#txtCreditoNuevo').val(),
									$('#txtDiasCredNuevo').val(),
									$('#txtLimiteCredNuevo').val(),						
									$('#txtVentaAnualNuevo').val(),
									$('#txtSaldoNuevo').val(),
									$('#txtDescExtraNuevo').val(),
									$('#txtVentaMensualNuevo').val(),						
									$('#txtCalleNuevo').val(),
									$('#txtNoExtNuevo').val(),
									$('#txtNoIntNuevo').val(),
									$('#txtColoniaNuevo').val(),
									$('#txtCiudadNuevo').val(),
									$('#txtEstadoNuevo').val(),
									$('#txtCpNuevo').val(),
									$('#opcDescNuevo option[value="0"]:selected');
									
								}else{
									window.alert("No puede dejar campos vacios");
								}	
						}
					}
				}
			});
			$("#formClienteNuevo").dialog("option", "width", 760);
			$("#formClienteNuevo").dialog("option", "height", 600);

			/*end declare input forms*/
			
			
			//Tecla enter en todos los campos
			$("#txtClave").keypress(function(e){
				if(e.which == 13){
					$("#txtNombre").select();
				}
			});
			$("#txtNombre").keypress(function(e){
				if(e.which == 13){
					$("#txtEmail").select();
				}
			});
			$("#txtEmail").keypress(function(e){
				if(e.which == 13){
					$("#txtRfc").select();
				}
			});
			$("#txtRfc").keypress(function(e){
				if(e.which == 13){
					$("#txtCredito").select();
				}
			});
			
			$("#txtCredito").keypress(function(e){
				if(e.which == 13){
					$("#txtDiasCred").select();
				}
			});
			$("#txtDiasCred").keypress(function(e){
				if(e.which == 13){
					$("#txtLimiteCred").select();
				}
			});
			$("#txtLimiteCred").keypress(function(e){
				if(e.which == 13){
					$("#txtVentaAnual").select();
				}
			});
			$("#txtVentaAnual").keypress(function(e){
				if(e.which == 13){
					$("#txtSaldo").select();
				}
			});
			$("#txtSaldo").keypress(function(e){
				if(e.which == 13){
					$("#opcDesc").select();
				}
			});
			$("#opcDesc").keypress(function(e){
				if(e.which == 13){
					$("#txtDescExtra").select();
				}
			});
			$("#txtDescExtra").keypress(function(e){
				if(e.which == 13){
					$("#txtVentaMensual").select();
				}
			});
			$("#txtVentaMensual").keypress(function(e){
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
						$("#txtCiudad").select();
				}
			});
			$("#txtCiudad").keypress(function(e){
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
					$("#btnActualizar").focus();
				}
			});
			
			$("#txtClaveNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtNombreNuevo").select();
				}
			});
			$("#txtNombreNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtEmailNuevo").select();
				}
			});
			$("#txtEmailNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtRfcNuevo").select();
				}
			});
			$("#txtRfcNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtCreditoNuevo").select();
				}
			});
			
			$("#txtCreditoNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtDiasCredNuevo").select();
				}
			});
			$("#txtDiasCredNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtLimiteCredNuevo").select();
				}
			});
			$("#txtLimiteCredNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtVentaAnualNuevo").select();
				}
			});
			$("#txtVentaAnualNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtSaldoNuevo").select();
				}
			});
			$("#txtSaldoNuevo").keypress(function(e){
				if(e.which == 13){
					$("#opcDescNuevo").select();
				}
			});
			$("#opcDescNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtDescExtraNuevo").select();
				}
			});
			$("#txtDescExtraNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtVentaMensualNuevo").select();
				}
			});
			$("#txtVentaMensualNuevo").keypress(function(e){
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
						$("#txtCiudadNuevo").select();
				}
			});
			$("#txtCiudadNuevo").keypress(function(e){
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

<div id="formCliente" title="Editar Cliente" class="text-form">
	<form id="cliente">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Cliente</legend>
		<ol>
			<li><label for="clave">*Clave: </label><input type="text" id="txtClave" name="txtClave" size="5" requiered autofocus><label for="nombre">*Nombre: </label><input type="text" size="45" id="txtNombre" name="txtNombre" requiered> </li>
			<li><label for="email">*Email: </label><input type="text" size="30" id="txtEmail" name="txtEmail" requiered><label for="tel">*Tel: </label><input type="text" size="20" id="txtTel" name="txtTel" requiered></li>
			<li><label for="rfc">*RFC: </label><input type="text" size="15" id="txtRfc" name="txtRfc" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Credito</legend>
		<ol>
			<li><label for="credito">*Credito:</label><input type="text" id="txtCredito" name="txtCredito" size="5" requiered><label for="diasCredito">*Dias Cred:</label><input type="text" id="txtDiasCred" name="txtDiasCred" size="5" requiered>
			<label for="limiteCredito">*Limite Cred:</label><input type="text" id="txtLimiteCred" name="txtLimiteCred" size="5" requiered><label for="ventaAnual">*Venta anual:</label><input type="text" id="txtVentaAnual" name="txtVentaAnual" size="5" requiered></li>
			<li><label for="saldo">*Saldo:</label><input type="text" id="txtSaldo" name="txtSaldo" size="5" requiered>
			<label for="desc">*Descuento</label><select id="opcDesc" name="opcDesc" requiered><option value="0">Sin Descuento</option><option value="5.00">Cliente Frecuente</option><option value="2.00">INSEN 2%</option><option value="3.00">INSEN 3%</option></select>
			<label for="descExtra">*Desc. Extra:</label><input type="text" id="txtDescExtra" name="txtDescExtra" size="5" requiered>
			<label for="ventaMensual">*Venta Mensual:</label><input type="text" id="txtVentaMensual" name="txtVentaMensual" size="5" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalle" name="txtCalle" requiered><label for="noExt">*Num. Ext.: </label><input type="text" id="txtNoExt" name="txtNoExt" size="5" requiered><label for="noInt">*Num. Int.: </label><input type="text" id="txtNoInt" name="txtNoInt" size="5" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColonia" name="txtColonia" requiered><label for="ciudad">*Ciudad: </label><input type="text" id="txtCiudad" name="txtCiudad" size="30" requiered><li>
			<li><label for="estado">*Estado: </label><input type="text" id="txtEstado" name="txtEstado" size="30" requiered><label for="cp">*C.P: </label><input type="text" id="txtCp" name="txtCp" size="7" requiered></li>
		</ol>
	</fieldset>
	</form>
</div>



<div id="formClienteNuevo" title="Agregar Cliente" class="text-form">
	<form id="clienteNuevo">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Cliente</legend>
		<ol>
			<li><label for="clave">*Clave: </label><input type="text" id="txtClaveNuevo" name="txtClaveNuevo" size="5" requiered autofocus><label for="nombre">*Nombre: </label><input type="text" size="45" id="txtNombreNuevo" name="txtNombreNuevo" requiered> </li>
			<li><label for="email">*Email: </label><input type="text" size="30" id="txtEmailNuevo" name="txtEmailNuevo" requiered><label for="tel">*Tel: </label><input type="text" size="20" id="txtTelNuevo" name="txtTelNuevo" requiered></li>
			<li><label for="rfc">*RFC: </label><input type="text" size="15" id="txtRfcNuevo" name="txtRfcNuevo" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Credito</legend>
		<ol>
			<li><label for="credito">*Credito:</label><input type="text" id="txtCreditoNuevo" name="txtCreditoNuevo" size="5" requiered><label for="diasCredito">*Dias Cred:</label><input type="text" id="txtDiasCredNuevo" name="txtDiasCredNuevo" size="5" requiered>
			<label for="limiteCredito">*Limite Cred:</label><input type="text" id="txtLimiteCredNuevo" name="txtLimiteCredNuevo" size="5" requiered><label for="ventaAnual">*Venta anual:</label><input type="text" id="txtVentaAnualNuevo" name="txtVentaAnualNuevo" size="5" requiered></li>
			<li><label for="saldo">*Saldo:</label><input type="text" id="txtSaldoNuevo" name="txtSaldoNuevo" size="5" requiered>
			<label for="desc">*Descuento</label><select id="opcDescNuevo" name="opcDescNuevo" requiered><option value="0">Sin Descuento</option><option value="5.00">Cliente Frecuente</option><option value="2.00">INSEN 2%</option><option value="3.00">INSEN 3%</option><option value="4.00">INSEN 4%</option><option value="50.00">INSEN 5%</option></select>
			<label for="descExtra">*Desc. Extra:</label><input type="text" id="txtDescExtraNuevo" name="txtDescExtraNuevo" size="5" disabled>
			</li>
			<li><label for="ventaMensual">*Venta Mensual:</label><input type="text" id="txtVentaMensualNuevo" name="txtVentaMensualNuevo" size="5" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalleNuevo" name="txtCalleNuevo" requiered><label for="noExt">*Num. Ext.: </label><input type="text" id="txtNoExtNuevo" name="txtNoExtNuevo" size="5" requiered><label for="noInt">*Num. Int.: </label><input type="text" id="txtNoIntNuevo" name="txtNoIntNuevo" size="5" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColoniaNuevo" name="txtColoniaNuevo" requiered><label for="ciudad">*Ciudad: </label><input type="text" id="txtCiudadNuevo" name="txtCiudadNuevo" size="23" requiered><li>
			<li><label for="estado">*Estado: </label><input type="text" id="txtEstadoNuevo" name="txtEstadoNuevo" size="23" requiered><label for="cp">*C.P: </label><input type="text" id="txtCpNuevo" name="txtCpNuevo" size="7" requiered></li>
		</ol>
	</fieldset>
	</form>
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
<div>
			<div id="header">
				<!--div id="logo"></div-->
			</div>
	
			<div id="sucursal">
			   <p>Cajero  : <label id="lblname"><%=nombre%> <%=apepat%> <%=apemat%></label></p>
		       <p>Usuario : <label id="lbluser"><%=usuario%></label><label> | Sucursal: Sin Sucursal</label></p>
			</div>

	<!--Barra de Navegacion de la pagina principal-->
	
			<ul id="nav">
					<li><a href="#">Recargar</a></li>
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
						<th style="width: 2%">Clave</th>
						<th style="width: 80%">Nombre</th>
						<th style="width: 5%">Email</th>
						<th style="width: 10%">RFC</th>
						<th style="width: 2%">Credito</th>
						<th style="width: 2%">Dias Credito</th>
						<th style="width: 2%">Limite Credito</th>
						<th style="width: 2%">Venta Anual</th>
						<th style="width: 2%">Saldo</th>
						<th style="width: 2%">INSEN</th>
						<th style="width: 2%">Desc.Extra</th>
						<th style="width: 2%">Venta Mensual</th>
						<th style="width: 25%" >Calle</th>
						<th style="width: 2%" >No.Ext.</th>
						<th style="width: 2%" >No.Int.</th>
						<th style="width: 10%">Colonia</th>
						<th style="width: 10%">Ciudad</th>
						<th style="width: 5%">Estado</th>
						<th style="width: 5%">CP</th>
				    </tr>
				    </thead>
				    <thead>
				    <tr>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Clave" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Nombre" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Email" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="RFC" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Credito" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="DiasCred" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Limite" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="VtaAnual" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Saldo" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="INSEN" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="DesExtra" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="VtaMes" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Calle" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="NoExt" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="NoInt" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Colonia" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Ciudad" /></th>
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
