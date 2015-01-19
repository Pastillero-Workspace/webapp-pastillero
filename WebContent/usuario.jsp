<%@page import="mx.com.pastillero.model.dao.UPDDao"%>
<%@page import="java.util.List"%>
<%@page import="mx.com.pastillero.types.Types"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
<head>
	<!-- The CSS Styles for forms -->
	<title>Consulta de Usuario | </title>
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
    <%    HttpSession sesion = request.getSession(false);
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
			{
				if(num == 1 && perfil.equalsIgnoreCase(Types.A.getStatusCode()))
				{
					sesion.setAttribute("numero", 2);
				}
			}
	     
  %>	
		$(document).ready(function() {
			$("#search thead input").on( 'keypress changed', function (e) 
			{  
					 table
					.column( $(this).parent().index()+':visible' )
					.search(this.value)
					.draw();				
                  
			} );
						
	<% 	 		 	
	    UPDDao uspd = new UPDDao();
	 	List<Object[]>datos = uspd.mostrar();	 	
	%>
		// Se crea array de datos aleatorios
		var data = [];
		
		<%for(int i=0; i<datos.size(); i++){%>
		
			data[<%=i%>]=[  '<%=datos.get(i)[0]%>',
			   	            '<%=datos.get(i)[1]%>',
			   	            '<%=datos.get(i)[2]%>',
			   	            '<%=datos.get(i)[3]%>',
			   	            '<%=datos.get(i)[4]%>',
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
					        '<%=datos.get(i)[19]%>',
					        '<%=datos.get(i)[20]%>',
					        '<%=datos.get(i)[21]%>'];
		<%}%>	
	         
			// Se establece el control de datos al destino
			var table = $('#search').DataTable( {
			scrollY:        700,
			scrollX: 		1700,
			data:	data,
			
			dom : "rtiS",
			"stateSave" : true,
		    "bSort": false,
			scrollY : 350,
			scrollX : 1280,
			scrollCollapse : true
			
		} );
			
			 
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
			var oldvalue = "";
			
			//botton eliminar			
			$(function()
		    {
				$("#btnEliminar").button().click(function(e){
					index = table.row('.selected').index();
					var registro = table.row('.selected').data();
					var claveUsuario ="";
					if(index>=0)
					{
						$.each(registro, function(data, value)
						{
							if(data == 0)
							{
								claveUsuario = value;
								$.post('usuario.jr',{
										tarea: 'delete',
										Usuario: claveUsuario
									},function(data)
									{
										console.log(data);
										if(data == 'Delete')
										{
											
											table.row(index).remove().draw(true);
											alert("Usuario eliminado con éxito");
										}
									});
							}
						});
						
						
					}
					else
					{
						window.alert("Seleccione un usuario a eliminar");
					}
				});
				
				// boton agregar
				$("#btnAgregar").button().click(function(e)
			    {					
					$("#txtFechaIngresoNuevo").val('01-01-14');
					$("#txtNoExtNuevo").val('0');
					$("#txtNoIntNuevo").val('0');
					$("#txtCpNuevo").val('0');
					$("#formUsuarioNuevo").dialog("open");
					$("#txtUsuarioNuevo").select();
				});
				$("#btnExcel").button().click(function(e){
					var t = $('#search').tableToJSON();
				    
					$.post('reporte.jr',{
						reporte: 'usuarios',
						txtTitulo:'Reporte de Usuarios',
						tblUsuarios:JSON.stringify(t)					
					}, function(f){
					});
					window.open("reporte.jsp", "Impresion", "height=600,width=400");
				});
				
				$("#btnEditar").button().click(function(e){
					index = table.row('.selected').index();
					var registro = table.row('.selected').data();					
					if(index>=0){
						$.each(registro, function(date,value){
							if(date==0)
							{
								$("#txtUsuario").val(value);
								oldvalue = value;
							}
							if(date==1){
								$("#txtContrasena").val(value);
							}
							if(date==2){
								$("#txtPerfil").val(value);
							}
							if(date==3){
								 if(value == '1')
								 {
								  	$("#chkActivo").prop("checked",true);
								 	$("#chkActivo").val(value);
								 }
								 else
								 {
									$("#chkActivo").prop("checked",false);
									$("#chkActivo").val(value);
								 }
							}
							if(date==4){
								$("#txtSucursal").val(value);
							}
							if(date==5){
								$("#txtNombre").val(value);
							}
							if(date==6){
								$("#txtApePat").val(value);
							}
							if(date==7){
								$("#txtApeMat").val(value);
							}
							if(date==8){
								$("#txtFechaIngreso").val(value);
							}
							if(date==9){
								$("#txtRFC").val(value);
							}
							if(date==10){
								$("#txtCURP").val(value);
							}
							if(date==11){
								$("#txtTurno").val(value);
							}
							if(date==12){
								$("#txtEmail").val(value);
							}
							if(date==13){
								$("#txtTelFijo").val(value);
							}
							if(date==14){
								$("#txtTelMovil").val(value);
							}

							if(date==15){
								$("#txtCalle").val(value);
							}
							if(date==16){
								$("#txtNoExt").val(value);
							}
							if(date==17){
								$("#txtNoInt").val(value);
							}
							if(date==18){
								$("#txtColonia").val(value);
							}
							if(date==19){
								$("#txtCiudad").val(value);
							}
							if(date==20){
								$("#txtEstado").val(value);
							}
							if(date==21){
								$("#txtCp").val(value);
							}
							
						});
						$("#formUsuario").dialog("open");
						$("#txtUsuario").select();
					}
					else{
						window.alert("Seleccione a un usuario");
					}
				});
				
			});
			
			$("#formUsuario").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				buttons:{
					"Actualizar": {
						text: "Actualizar",
						id:		"btnActualizar",
						click:	function(){
										$.post('usuario.jr',
										{
											tarea: 'update',
											olduser : oldvalue,
											txtUsuario:     $('#txtUsuario').val(),
											txtContrasena:  $('#txtContrasena').val(),
											txtPerfil:   $('#txtPerfil').val(),
											txtActivo:   $('#chkActivo').val(),
											txtSucursal: $('#txtSucursal').val(),
											txtNombre: $('#txtNombre').val(),
											txtApePat: $('#txtApePat').val(),
											txtApeMat: $('#txtApeMat').val(),
											txtFechaIn: $('#txtFechaIngreso').val(),
											txtRFC: $('#txtRFC').val(),
											txtCURP: $('#txtCURP').val(),
											txtTurno: $('#txtTurno').val(),
											txtEmail: $('#txtEmail').val(),
											txtTelFijo: $('#txtTelFijo').val(),
											txtTelMovil: $('#txtTelMovil').val(),
											txtCalle: $('#txtCalle').val(),
											txtNoExt: $('#txtNoExt').val(),
											txtNoInt: $('#txtNoInt').val(),
											txtColonia: $('#txtColonia').val(),
											txtCiudad: $('#txtCiudad').val(),
											txtEstado: $('#txtEstado').val(),
											txtCp: $('#txtCp').val()										
										}
							        
							        ,function(data)
									{
										console.log(data)
										if(data == 'Update')
											{
											  alert("Usuario modificado existosamente");
											  $("#formUsuario").dialog("close");
											  table.row(index).data([	
												$('#txtUsuario').val(),
												$('#txtContrasena').val(),
												$('#txtPerfil').val(),
												$('#chkActivo').val(),
												$('#txtSucursal').val(),
												$('#txtNombre').val(),
												$('#txtApePat').val(),
												$('#txtApeMat').val(),
												$('#txtFechaIngreso').val(),
												$('#txtRFC').val(),
												$('#txtCURP').val(),
												$('#txtTurno').val(),
												$('#txtEmail').val(),
												$('#txtTelFijo').val(),
												$('#txtTelMovil').val(),
												$('#txtCalle').val(),
												$('#txtNoExt').val(),
												$('#txtNoInt').val(),
												$('#txtColonia').val(),
												$('#txtCiudad').val(),
												$('#txtEstado').val(),
												$('#txtCp').val()	
									        ]);	
							           }																																		
						        });																			
					}
				  }
				}
			});
			$("#formUsuario").dialog("option", "width", 800);
			$("#formUsuario").dialog("option", "height", 600);
			
			/* Formulario de usuario nuevo */
						
			$("#formUsuarioNuevo").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				buttons:{
					"Agregar": {
						text: "Agregar",
						id:		"btnAgregarNuevo",
						click:	function(){
							if($('#txtUsuarioNuevo').val().trim()!="" && $('#txtContrasenaNuevo').val().trim()!="" )
							{
									$.post('usuario.jr',{
										tarea: 'create',
										txtUsuario:   $('#txtUsuarioNuevo').val(),
										txtContrasena:  $('#txtContrasenaNuevo').val(),
										txtPerfil:   $('#txtPerfilNuevo').val(),
										txtActivo:   $('#chkActivoNuevo').val(),
										txtSucursal: $('#txtSucursalNuevo').val(),
										txtNombre: $('#txtNombreNuevo').val(),
										txtApePat: $('#txtApePatNuevo').val(),
										txtApeMat: $('#txtApeMatNuevo').val(),
										txtFechaIn: $('#txtFechaIngresoNuevo').val(),
										txtRFC: $('#txtRFCNuevo').val(),
										txtCURP: $('#txtCURPNuevo').val(),
										txtTurno: $('#txtTurnoNuevo').val(),
										txtEmail: $('#txtEmailNuevo').val(),
										txtTelFijo: $('#txtTelFijoNuevo').val(),
										txtTelMovil: $('#txtTelMovilNuevo').val(),
										txtCalle: $('#txtCalleNuevo').val(),
										txtNoExt: $('#txtNoExtNuevo').val(),
										txtNoInt: $('#txtNoIntNuevo').val(),
										txtColonia: $('#txtColoniaNuevo').val(),
										txtCiudad: $('#txtCiudadNuevo').val(),
										txtEstado: $('#txtEstadoNuevo').val(),
										txtCp: $('#txtCpNuevo').val()										
									},function(data){
										console.log(data)
										if(data == 'Create')
											{
											  alert("Usuario agregado existosamente");
											  $("#formUsuarioNuevo").dialog("close");
											  table.row(index).data([	
														$('#txtUsuarioNuevo').val(),
														$('#txtContrasenaNuevo').val(),
														$('#txtPerfilNuevo').val(),
														$('#chkActivoNuevo').val(),
														$('#txtSucursalNuevo').val(),
														$('#txtNombreNuevo').val(),
														$('#txtApePatNuevo').val(),
														$('#txtApeMatNuevo').val(),
														$('#txtFechaIngresoNuevo').val(),
														$('#txtRFCNuevo').val(),
														$('#txtCURPNuevo').val(),
														$('#txtTurnoNuevo').val(),
														$('#txtEmailNuevo').val(),
														$('#txtTelFijoNuevo').val(),
														$('#txtTelMovilNuevo').val(),
														$('#txtCalleNuevo').val(),
														$('#txtNoExtNuevo').val(),
														$('#txtNoIntNuevo').val(),
														$('#txtColoniaNuevo').val(),
														$('#txtCiudadNuevo').val(),
														$('#txtEstadoNuevo').val(),
														$('#txtCpNuevo').val()	
													]);	
										}									
										
									});
									
								}else
								{
									window.alert("No puede dejar campos vacios");
								}	
						}
					}
				}
			});
			$("#formUsuarioNuevo").dialog("option", "width", 800);
			$("#formUsuarioNuevo").dialog("option", "height", 650);
			// cheboxes
			
			
		    $('#chkActivoNuevo').click(function() {
		        if (!$(this).is(':checked')) 
		        {
		        	$('#chkActivoNuevo').val('0');
		        }
		        else
		        {
		        	$('#chkActivoNuevo').val('1');
		        }
		    });
			
		    $('#chkActivo').click(function() {
		        if (!$(this).is(':checked')) 
		        {
		        	$('#chkActivo').val('0');
		        }
		        else
		        {
		        	$('#chkActivo').val('1');
		        }
		    });
			
			
			
			//Tecla enter en todos los campos
			$("#txtUsuario").keypress(function(e){
				if(e.which == 13){
					$("#txtContrasena").select();
				}
			});
			$("#txtContrasena").keypress(function(e){
				if(e.which == 13){
					$("#txtPerfil").select();
				}
			});
			$("#txtPerfil").keypress(function(e){
				if(e.which == 13){
					$("#txtSucursal").select();
				}
			});
			$("#txtSucursal").keypress(function(e){
				if(e.which == 13){
					$("#txtNombre").select();
				}
			});
			
			$("#txtNombre").keypress(function(e){
				if(e.which == 13){
					$("#txtApePat").select();
				}
			});
			$("#txtApePat").keypress(function(e){
				if(e.which == 13){
					$("#txtApeMat").select();
				}
			});
			$("#txtApeMat").keypress(function(e){
				if(e.which == 13){
					$("#txtFechaIngreso").select();
				}
			});
			$("#txtFechaIngreso").keypress(function(e){
				if(e.which == 13){
					$("#txtRFC").select();
				}
			});
			$("#txtRFC").keypress(function(e){
				if(e.which == 13){
					$("#txtCURP").select();
				}
			});
			$("#txtCURP").keypress(function(e){
				if(e.which == 13){
					$("#txtTurno").select();
				}
			});
			$("#txtTurno").keypress(function(e){
				if(e.which == 13){
					$("#txtEmail").select();
				}
			});
			$("#txtEmail").keypress(function(e){
				if(e.which == 13){
					$("#txtTelFijo").select();
				}
			});
			$("#txtTelFijo").keypress(function(e){
				if(e.which == 13){
					$("#txtTelMovil").select();
				}
			});
			$("#txtTelMovil").keypress(function(e){
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
			
			// eventos del segundo formulario
			$("#txtUsuarioNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtContrasenaNuevo").select();
				}
			});
			$("#txtContrasenaNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtPerfilNuevo").select();
				}
			});
			$("#txtPerfilNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtSucursalNuevo").select();
				}
			});
			$("#txtSucursalNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtNombreNuevo").select();
				}
			});
			
			$("#txtNombreNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtApePatNuevo").select();
				}
			});
			$("#txtApePatNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtApeMatNuevo").select();
				}
			});
			$("#txtApeMatNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtFechaIngresoNuevo").select();
				}
			});
			$("#txtFechaIngresoNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtRFCNuevo").select();
				}
			});
			$("#txtRFCNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtCURPNuevo").select();
				}
			});
			$("#txtCURPNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtTurnoNuevo").select();
				}
			});
			$("#txtTurnoNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtEmailNuevo").select();
				}
			});
			$("#txtEmailNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtTelFijoNuevo").select();
				}
			});
			$("#txtTelFijoNuevo").keypress(function(e){
				if(e.which == 13){
					$("#txtTelMovilNuevo").select();
				}
			});
			$("#txtTelMovilNuevo").keypress(function(e){
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
			
			
			$(function() {
			    $("#txtFechaIngresoNuevo").datepicker();
			});
			$(function() {
			    $("#txtFechaIngreso").datepicker();
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

<div id="formUsuario" title="Actualizar Usuario" class="text-form">
	<form id="clienteActualizar">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Usuario</legend>
		<ol>
			<li><label for="usuario">*Usuario: </label><input type="text" id="txtUsuario" name="usuario" size="20" requiered ><label for="nombre">*Contraseña: </label><input type="text" size="15" id="txtContrasena" name="contraseña" requiered> </li>
			<li><label for="perfil">*Perfil: </label><input type="text" size="20" id="txtPerfil" name="Perfil" requiered><label for="tel">*Usuario Activo:</label><input type="checkbox" id="chkActivo"name="Activo" value="0"requiered>
	        <label for="sucursal">*Sucursal: </label><input type="text" size="15" id="txtSucursal" name="sucursal" value="SIN ASIGNAR" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Datos Personales</legend>
		<ol>
			<li><label for="persona">Nombre:</label><input type="text" id="txtNombre" name="Nombre" size="25" requiered><label for="Apellido Paterno">*Apellido Paterno:</label><input type="text" id="txtApePat" name="Apellido Paterno" size="25" requiered></li>
			<li><label for="apellidopat">*Apellido Materno:</label><input type="text" id="txtApeMat" name="apellidopat" size="25" requiered><label for="fechaingreso">*Fecha Ingreso:</label><input type="text" id="txtFechaIngreso" name="fechaingreso" size="25" value="00-00-0000" requiered></li>
			<li><label for="rfc">*RFC:</label><input type="text" id="txtRFC" name="rfc" size="25" value="SIN ASIGNAR" requiered><label for="curp">*CURP:</label><input type="text" id="txtCURP" name="curp" size="25" value="SIN ASIGNAR" requiered></li>
			<li><label for="turno">*Turno:</label><input type="text" id="txtTurno" name="turno" size="25" value="SIN ASIGNAR" requiered><label for="email">*Email:</label><input type="text" id="txtEmail" name="email" size="25" value="SIN ASIGNAR" requiered></li>
			<li><label for="telfijo">*Telefono Fijo:</label><input type="text" id="txtTelFijo" name="telfijo" size="15" value="(000)-000-00-00" requiered><label for="telmovil">*Telefono Móvil:</label><input type="text" id="txtTelMovil" name="telmovil" size="15" value="00-00-00-00-00"></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalle" name="txtCalle" value="SIN ASIGNAR" requiered><label for="noExt">*Num.Ext.: </label><input type="text" id="txtNoExt" name="txtNoExt" size="5" value="00" requiered><label for="noInt">*Num.Int.: </label><input type="text" id="txtNoInt" name="txtNoInt" size="5" value="00" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColonia" name="txtColonia" value="SIN ASIGNAR" requiered><label for="ciudad">*Ciudad: </label><input type="text" id="txtCiudad" name="txtCiudad" size="15" value="SIN ASIGNAR" requiered><li>
			<li><label for="estado">*Estado: </label><input type="text" id="txtEstado" name="txtEstado" size="15" value="SIN ASIGNAR" requiered><label for="cp">*C.P: </label><input type="text" id="txtCp" name="txtCp" size="5" value="00000" requiered></li>
		</ol>
	</fieldset>
	</form>
</div>
<div id="formUsuarioNuevo" title="Agregar Usuario" class="text-form">
	<form id="UsuarioNuevo">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Usuario</legend>
		<ol>
			<li><label for="usuario">*Usuario: </label><input type="text" id="txtUsuarioNuevo" name="usuario" size="20" requiered autofocus><label for="contrasena">*Contraseña: </label><input type="text" size="15" id="txtContrasenaNuevo" name="contrasena" requiered> </li>
			<li><label for="perfil">*Perfil: </label><input type="text" size="20" id="txtPerfilNuevo" name="Perfil" requiered><label for="tel">*Usuario Activo:</label><input type="checkbox" id="chkActivoNuevo" name="Activo" value="0" requiered>
			<label for="sucursal">*Sucursal: </label><input type="text" size="15" id="txtSucursalNuevo" name="sucursal" value="SIN ASIGNAR" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Datos Personales</legend>
		<ol>
			<li><label for="nombre">Nombre:</label><input type="text" id="txtNombreNuevo" name="Nombre" size="25" requiered><label for="apellidoPat">*Apellido Paterno:</label><input type="text" id="txtApePatNuevo" name="Apellido Paterno" size="25" requiered></li>
			<li><label for="apellidoMat">*Apellido Materno:</label><input type="text" id="txtApeMatNuevo" name="apellidoMat" size="25" requiered><label for="fechaingreso">*Fecha Ingreso:</label><input type="text" id="txtFechaIngresoNuevo" name="fechaingreso" size="25" value="00-00-0000" requiered></li>
			<li><label for="rfc">*RFC:</label><input type="text" id="txtRFCNuevo" name="rfc" size="25" value="SIN ASIGNAR" requiered><label for="curp">*CURP:</label><input type="text" id="txtCURPNuevo" name="curp" size="25" value="SIN ASIGNAR" requiered></li>
			<li><label for="turno">*Turno:</label><input type="text" id="txtTurnoNuevo" name="turno" size="25" value="SIN ASIGNAR" requiered><label for="email">*Email:</label><input type="text" id="txtEmailNuevo" name="email" size="25" value="SIN ASIGNAR" requiered></li>
			<li><label for="telfijo">*Telefono Fijo:</label><input type="text" id="txtTelFijoNuevo" name="telfijo" size="15" value="(000)-000-00-00" requiered><label for="telmovil">*Telefono Móvil:</label><input type="text" id="txtTelMovilNuevo" name="telmovil" size="15" value="00-00-00-00-00" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalleNuevo" name="txtCalleNuevo" value="SIN ASIGNAR" requiered><label for="noExt">*Num.Ext.: </label><input type="text" id="txtNoExtNuevo" name="txtNoExtNuevo" size="5" value="00" requiered><label for="noInt">*Num.Int.: </label><input type="text" id="txtNoIntNuevo" name="txtNoIntNuevo" size="5" value="00" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColoniaNuevo" name="txtColoniaNuevo" value="SIN ASIGNAR" requiered><label for="ciudad">*Ciudad: </label><input type="text" id="txtCiudadNuevo" name="txtCiudadNuevo" size="15" value="SIN ASIGNAR" requiered><li>
			<li><label for="estado">*Estado: </label><input type="text" id="txtEstadoNuevo" name="txtEstadoNuevo" size="15" value="SIN ASIGNAR" requiered><label for="cp">*C.P: </label><input type="text" id="txtCpNuevo" name="txtCpNuevo" size="5" value="00000" requiered></li>
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
			<table id="search" class="display"cellspacing="0" width="1280px">
				
				<thead>
					<tr>
						<th style="width: 5%">Usuario</th>
						<th style="width: 5%">Contraseña</th>
						<th style="width: 5%">Perfil</th>
						<th style="width: 2%">Activo</th>
						<th style="width: 5%">Sucursal</th>
						<th style="width: 10%">Nombre</th>
						<th style="width: 10%">Apellido Paterno</th>
						<th style="width: 10%">Apellido Materno</th>
						<th style="width: 3%">Ingreso</th>
						<th style="width: 10%">RFC</th>
						<th style="width: 10%">CURP</th>
						<th style="width: 7%">Turno</th>
						<th style="width: 7%">Email</th>
						<th style="width: 5%">Telefono Fijo</th>
						<th style="width: 5%">Telefono Movil.</th>
						<th style="width: 10%">Calle</th>
						<th style="width: 3%">No.Ext.</th>
						<th style="width: 3%">No.Int.</th>
						<th style="width: 10%">Colonia</th>
						<th style="width: 10%">Ciudad</th>
						<th style="width: 5%">Estado</th>
						<th style="width: 5%">CP</th>
				    </tr>								
				</thead>
				<thead>	
				<tr>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Usuario" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Contraseña" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Perfil" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Activo" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Sucursal" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Nombre" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="ApePat" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="ApeMat" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Ingreso" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="RFC" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="CURP" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Turno" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Email" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="TelFijo" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="TelMovil" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Calle" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="No.Ext." /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="No.Int." /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Colonia" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Ciudad" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="Estado" /></th>
						<th><input class="boxinit" style="width: 30px" type="text" placeholder="CP" /></th>					
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
