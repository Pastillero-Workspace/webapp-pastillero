<%@page import="mx.com.pastillero.model.dao.ClienteDireccionDao"%>
<%@page import="mx.com.pastillero.types.Types"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<script src="<c:url value="/resources/js/functions.js" />"></script>  
	
	<script type="text/javascript" language="javascript" class="init">
	var op = false;
	var claveRespaldo = "";
	<% HttpSession sesion = request.getSession(false);
	   String usuario = (String)sesion.getAttribute("usuario");
	   String perfil = (String)session.getAttribute("perfil");
	   Integer sesionid = (Integer)sesion.getAttribute("idSesion");
	   Integer num = (Integer)sesion.getAttribute("numero");
	   Integer permiso =(Integer)sesion.getAttribute("pv");
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
	 checkEnabledRestriction('<%=usuario%>','<%=permiso%>'); 
	 	
		$(document).ready(function() {
		   // Algoritmo de filtrado
			$("#search thead input").on( 'keypress changed', function (e){  
				 table
				.column( $(this).parent().index()+':visible' )
				.search(this.value)
				.draw();                  
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
						}).done(function(){
							alert("Se elimino cliente con exito");
						}).fail(function(xhr,textStatus, errorThrown){
							alert("Error al eliminar el cliente: "+textStatus +", "+errorThrown + "," +xhr);
						});;
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
					
					window.open("reporte.jsp", "Impresion", "height=600,width=400");
				});
				
				$("#btnEditar").button().click(function(e){
					index = table.row('.selected').index();
					var registro = table.row('.selected').data();
					
					if(index>=0){
						var clienteFrec= [], opcInsen = [];
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
							if(date==9){//insen
								opcInsen = value.split(".");
								if(opcInsen[0] != 0){
									$('#opcDesc').val(opcInsen[0]);
								}
							}
							if(date==10){//cltefrec
								clienteFrec = value.split(".");
								if(clienteFrec[0] != 0){
									$('#opcDesc').val(1);
									$('#txtClienteFrec').val(value);
									$('#txtClienteFrec').prop('disabled',false);
									
								}else{
									$('#txtClienteFrec').val("0.0");
									$('#txtClienteFrec').prop('disabled',true);
								}
							}
							if(date==11){
								$("#txtVentaMensual").val(value);
							}
							if(date==12){
								$("#txtCalle").val(value);
							}
							if(date==13){
								$("#txtNoExt").val(value);
							}
							if(date==14){
								$("#txtNoInt").val(value);
							}
							if(date==15){
								$("#txtColonia").val(value);
							}
							if(date==16){
								$("#txtCiudad").val(value);
							}
							if(date==17){
								$("#txtEstado").val(value);
							}
							if(date==18){
								$("#txtCp").val(value);
							}
						});
						if(opcInsen[0] == 0 && clienteFrec[0] == 0){
							$('#opcDesc').val(0);
						}
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
							$.ajax({
								async:false,
								cache:false,
								type: 'POST',  
								url: "cliente.jr",
								data: {
									tarea: 'verifica',
									txtClave: $('#txtClave').val().trim()
								}
							}).done(function(result){
								if(result == 'noExiste' || result == claveRespaldo){
									if($('#txtNombre').val().trim()!=""){
										
										var cltefrec = 0.00;
										var insen = 0.00;
										
										switch($("#opcDesc option:selected").val()){
										    case '1':cltefrec = $('#txtClienteFrec').val();break;
										    case '2':insen = 2.00;break;
										    case '3':insen = 3.00;break;
										    case '4':insen = 4.00;break;
										    case '5':insen = 5.00;break;
										    default: cltefrec = 0.00;insen = 0.00;break;
										}
										
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
												txtClienteFrec: $('#txtClienteFrec').val(),
												txtCalle: $('#txtCalle').val(),
												txtNoExt: $('#txtNoExt').val(),
												txtNoInt: $('#txtNoInt').val(),
												txtColonia: $('#txtColonia').val(),
												txtCiudad: $('#txtCiudad').val(),
												txtEstado: $('#txtEstado').val(),
												txtCp: $('#txtCp').val(),
												opcDesc: $("#opcDesc option:selected").val()
											}).done(function(){
												alert("Se actualizo cliente con exito");
											}).fail(function(xhr,textStatus, errorThrown){
												alert("Error al actualizar el cliente: "+textStatus +", "+errorThrown + "," +xhr);
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
												//$('#opcDesc option:selected').val(),
												//$('#txtDescExtra').val(),
												parseFloat(insen).toFixed(1),
												parseFloat(cltefrec).toFixed(1),
												$('#txtVentaMensual').val(),						
												$('#txtCalle').val(),
												$('#txtNoExt').val(),
												$('#txtNoInt').val(),
												$('#txtColonia').val(),
												$('#txtCiudad').val(),
												$('#txtEstado').val(),
												$('#txtCp').val()
											]);
											
											$("#formCliente").dialog("close");
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
											$('#txtClienteFrec').val(''),
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
								}else{
									alert("La clave de cliente ya existe en otro cliente, coloque una clave diferente.");
								}
								
							}).fail(function(xhr,textStatus, errorThrown){
								alert("Error: "+textStatus +", "+errorThrown + "," +xhr);
							});	
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
							$.ajax({
								async:false,
								cache:false,
								type: 'POST',  
								url: "cliente.jr",
								data: {
									tarea: 'verifica',
									txtClave: $('#txtClaveNuevo').val().trim()
								}
							}).done(function(result){
								if(result == 'noExiste'){
									if($('#txtClaveNuevo').val().trim()!=""){								
										var cltefrec = 0.00;
										var insen = 0.00;									
										switch($('#opcDescNuevo option:selected').val()){
										    case '1':cltefrec = $('#txtClienteFrecNuevo').val();break;
										    case '2':insen = 2.00;break;
										    case '3':insen = 3.00;break;
										    case '4':insen = 4.00;break;
										    case '5':insen = 5.00;break;
										    default: cltefrec = 0.00;insen = 0.00;break;
										}
										
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
												txtClienteFrec: $('#txtClienteFrecNuevo').val(),
												txtCalle: $('#txtCalleNuevo').val(),
												txtNoExt: $('#txtNoExtNuevo').val(),
												txtNoInt: $('#txtNoIntNuevo').val(),
												txtColonia: $('#txtColoniaNuevo').val(),
												txtCiudad: $('#txtCiudadNuevo').val(),
												txtEstado: $('#txtEstadoNuevo').val(),
												txtCp: $('#txtCpNuevo').val(),
												opcDesc: $('#opcDescNuevo option:selected').val()
											}).done(function(){
													alert("Se agrego cliente con exito");
											}).fail(function(xhr,textStatus, errorThrown){
													alert("Error al agregar el cliente: "+textStatus +", "+errorThrown + "," +xhr);
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
												//$('#opcDescNuevo option:selected').val(),
												//$('#txtDescExtraNuevo').val(),
												parseFloat(insen).toFixed(1),
												parseFloat(cltefrec).toFixed(1),
												$('#txtVentaMensualNuevo').val(),						
												$('#txtCalleNuevo').val(),
												$('#txtNoExtNuevo').val(),
												$('#txtNoIntNuevo').val(),
												$('#txtColoniaNuevo').val(),
												$('#txtCiudadNuevo').val(),
												$('#txtEstadoNuevo').val(),
												$('#txtCpNuevo').val()
											]).draw();
											
											$("#formClienteNuevo").dialog("close");
											$('#txtClaveNuevo').val(''),
											$('#txtNombreNuevo').val(''),
											$('#txtEmailNuevo').val(''),						
											$('#txtRfcNuevo').val(''),
											$('#txtCreditoNuevo').val(''),
											$('#txtDiasCredNuevo').val(''),
											$('#txtLimiteCredNuevo').val(''),						
											$('#txtVentaAnualNuevo').val(''),
											$('#txtSaldoNuevo').val(''),
											$('#txtDescExtraNuevo').val(''),
											$('#txtVentaMensualNuevo').val(''),	
											$('#txtClienteFrecNuevo').val(''),
											$('#txtCalleNuevo').val(''),
											$('#txtNoExtNuevo').val(''),
											$('#txtNoIntNuevo').val(''),
											$('#txtColoniaNuevo').val(''),
											$('#txtCiudadNuevo').val(''),
											$('#txtEstadoNuevo').val(''),
											$('#txtCpNuevo').val(''),
											$('#opcDescNuevo option[value="0"]:selected');
											
										}else{
											window.alert("No puede dejar campos vacios");
										}
								}else{
									alert("La clave de cliente ya existe, coloque una clave diferente.");
								}
							}).fail(function(xhr,textStatus, errorThrown){
								alert("Error: "+textStatus +", "+errorThrown + "," +xhr);
							});
								
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
			$('#opcDesc').change(function(e){
				if($('#opcDesc').val() == 1){
					$('#txtClienteFrec').prop('disabled',false);
					$('#txtClienteFrec').select();
				}else{
					$('#txtClienteFrec').val("0.0");
					$('#txtClienteFrec').prop('disabled',true);
				}
			});
			$('#opcDescNuevo').change(function(e){
				if($('#opcDescNuevo').val() == 1){
					$('#txtClienteFrecNuevo').prop('disabled',false);
					$('#txtClienteFrecNuevo').select();
				}else{
					$('#txtClienteFrecNuevo').val("0.0");
					$('#txtClienteFrecNuevo').prop('disabled',true);
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
		<c:url value="Templates/formcliente.jsp" var="myURL"></c:url>
	    <c:import url="${myURL}"/>
<div>
	<div id="header"></div>
	<div id="sucursal">
	   <p><c:out value="${sessionScope.perfil}"/>  : <label id="lblname"><c:out value="${sessionScope.nombre}"/><c:out value="${sessionScope.apepat}"/><c:out value="${sessionScope.apemat}"/></label></p>
       <p>Usuario : <label id="lbluser"><%=usuario%></label><label> | Sucursal: <c:out value="${sessionScope.scr}" /></label></p>
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
						<th style="width: 2%">Cliente Frec</th>
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
