<%@page import="mx.com.pastillero.model.dao.UPDDao"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.SessionFactory"%>
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
					        '<%=datos.get(i)[20]%>'];
		<%}%>	
	         
			// Se establece el control de datos al destino
			var table = $('#search').DataTable( {
			scrollY:        700,
			scrollX: 		1200,
			data:	data,
			dom : "rtiS",
			"stateSave" : true,
		    "bSort": false,
			scrollY : 200,
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
					$("#txtFechaIngreso").val('01-01-14');
					$("#txtNoExtNuevo").val('0');
					$("#txtNoIntNuevo").val('0');
					$("#txtCpNuevo").val('0');
					$("#formUsuarioNuevo").dialog("open");
					$("#txtUsuario").select();
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
								$("#utxtUsuario").val(value);
								oldvalue = value;
							}
							if(date==1){
								$("#utxtContrasena").val(value);
							}
							if(date==2){
								$("#utxtPerfil").val(value);
							}
							if(date==3){
								 if(value == '1')
								 {
								  	$("#uchkActivo").prop("checked",true);
								 	$("#uchkActivo").val(value);
								 }
								 else
								 {
									$("#uchkActivo").prop("checked",false);
									$("#uchkActivo").val(value);
								 }
							}
							if(date==4){
								$("#utxtSucursal").val(value);
							}
							if(date==5){
								$("#utxtNombre").val(value);
							}
							if(date==6){
								$("#utxtApePat").val(value);
							}
							if(date==7){
								$("#utxtApeMat").val(value);
							}
							if(date==8){
								$("#utxtFechaIngreso").val(value);
							}
							if(date==9){
								$("#utxtRFC").val(value);
							}
							if(date==10){
								$("#utxtCURP").val(value);
							}
							if(date==11){
								$("#utxtTurno").val(value);
							}
							if(date==12){
								$("#utxtEmail").val(value);
							}
							if(date==13){
								$("#utxtTelFijo").val(value);
							}
							if(date==14){
								$("#utxtTelMovil").val(value);
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
								$("#txtEstado").val(value);
							}
							if(date==20){
								$("#txtCp").val(value);
							}
							
						});
						$("#formUsuario").dialog("open");
						$("#utxtUsuario").select();
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
											txtUsuario:     $('#utxtUsuario').val(),
											txtContrasena:  $('#utxtContrasena').val(),
											txtPerfil:   $('#utxtPerfil').val(),
											txtActivo:   $('#uchkActivo').val(),
											txtSucursal: $('#utxtSucursal').val(),
											txtNombre: $('#utxtNombre').val(),
											txtApePat: $('#utxtApePat').val(),
											txtApeMat: $('#utxtApeMat').val(),
											txtFechaIn: $('#utxtFechaIngreso').val(),
											txtRFC: $('#utxtRFC').val(),
											txtCURP: $('#utxtCURP').val(),
											txtTurno: $('#utxtTurno').val(),
											txtEmail: $('#utxtEmail').val(),
											txtTelFijo: $('#utxtTelFijo').val(),
											txtTelMovil: $('#utxtTelMovil').val(),
											txtCalle: $('#txtCalle').val(),
											txtNoExt: $('#txtNoExt').val(),
											txtNoInt: $('#txtNoInt').val(),
											txtColonia: $('#txtColonia').val(),
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
												$('#utxtUsuario').val(),
												$('#utxtContrasena').val(),
												$('#utxtPerfil').val(),
												$('#uchkActivo').val(),
												$('#utxtSucursal').val(),
												$('#utxtNombre').val(),
												$('#utxtApePat').val(),
												$('#utxtApeMat').val(),
												$('#utxtFechaIngreso').val(),
												$('#utxtRFC').val(),
												$('#utxtCURP').val(),
												$('#utxtTurno').val(),
												$('#utxtEmail').val(),
												$('#utxtTelFijo').val(),
												$('#utxtTelMovil').val(),
												$('#txtCalle').val(),
												$('#txtNoExt').val(),
												$('#txtNoInt').val(),
												$('#txtColonia').val(),
												$('#txtEstado').val(),
												$('#txtCp').val()	
									        ]);	
							           }																																		
						        });																			
					}
				  }
				}
			});
			$("#formUsuario").dialog("option", "width", 700);
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
							if($('#txtUsuario').val().trim()!="" && $('#txtContrasena').val().trim()!="" )
							{
									$.post('usuario.jr',{
										tarea: 'create',
										txtUsuario:   $('#txtUsuario').val(),
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
										txtCalle: $('#txtCalleNuevo').val(),
										txtNoExt: $('#txtNoExtNuevo').val(),
										txtNoInt: $('#txtNoIntNuevo').val(),
										txtColonia: $('#txtColoniaNuevo').val(),
										txtEstado: $('#txtEstadoNuevo').val(),
										txtCp: $('#txtCpNuevo').val()										
									},function(data){
										console.log(data)
										if(data == 'Create')
											{
											  alert("Usuario agregado existosamente");
											  $("#formUsuarioNuevo").dialog("close");
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
														$('#txtCalleNuevo').val(),
														$('#txtNoExtNuevo').val(),
														$('#txtNoIntNuevo').val(),
														$('#txtColoniaNuevo').val(),
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
			$("#formUsuarioNuevo").dialog("option", "width", 760);
			$("#formUsuarioNuevo").dialog("option", "height", 650);
			// cheboxes
			
			
		    $('#uchkActivo').click(function() {
		        if (!$(this).is(':checked')) 
		        {
		        	$('#uchkActivo').val('0');
		        }
		        else
		        {
		        	$('#uchkActivo').val('1');
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
			$("#utxtUsuario").keypress(function(e){
				if(e.which == 13){
					$("#utxtContrasena").select();
				}
			});
			$("#utxtContrasena").keypress(function(e){
				if(e.which == 13){
					$("#utxtPerfil").select();
				}
			});
			$("#utxtPerfil").keypress(function(e){
				if(e.which == 13){
					$("#utxtSucursal").select();
				}
			});
			$("#utxtSucursal").keypress(function(e){
				if(e.which == 13){
					$("#utxtNombre").select();
				}
			});
			
			$("#utxtNombre").keypress(function(e){
				if(e.which == 13){
					$("#utxtApePat").select();
				}
			});
			$("#utxtApePat").keypress(function(e){
				if(e.which == 13){
					$("#utxtApeMat").select();
				}
			});
			$("#utxtApeMat").keypress(function(e){
				if(e.which == 13){
					$("#utxtFechaIngreso").select();
				}
			});
			$("#utxtFechaIngreso").keypress(function(e){
				if(e.which == 13){
					$("#utxtRFC").select();
				}
			});
			$("#utxtRFC").keypress(function(e){
				if(e.which == 13){
					$("#utxtCURP").select();
				}
			});
			$("#utxtCURP").keypress(function(e){
				if(e.which == 13){
					$("#utxtTurno").select();
				}
			});
			$("#utxtTurno").keypress(function(e){
				if(e.which == 13){
					$("#utxtEmail").select();
				}
			});
			$("#utxtEmail").keypress(function(e){
				if(e.which == 13){
					$("#utxtTelFijo").select();
				}
			});
			$("#utxtTelFijo").keypress(function(e){
				if(e.which == 13){
					$("#utxtTelMovil").select();
				}
			});
			$("#utxtTelMovil").keypress(function(e){
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
					$("#btnActualizar").focus();
				}
			});
			
			// eventos del segundo formulario
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
					$("#btnAgregarNuevo").focus();
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

<div id="formUsuario" title="Actualizar Usuario" class="text-form">
	<form id="clienteActualizar">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Usuario</legend>
		<ol>
			<li><label for="usuario">*Usuario: </label><input type="text" id="utxtUsuario" name="usuario" size="20" requiered ><label for="nombre">*Contraseña: </label><input type="text" size="15" id="utxtContrasena" name="contraseña" requiered> </li>
			<li><label for="perfil">*Perfil: </label><input type="text" size="20" id="utxtPerfil" name="Perfil" requiered><label for="tel">*Usuario Activo:</label><input type="checkbox" id="uchkActivo"name="Activo" value="0"requiered>
	        <label for="sucursal">*Sucursal: </label><input type="text" size="15" id="utxtSucursal" name="sucursal" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Datos Personales</legend>
		<ol>
			<li><label for="persona">Nombre:</label><input type="text" id="utxtNombre" name="Nombre" size="25" requiered><label for="Apellido Paterno">*Apellido Paterno:</label><input type="text" id="utxtApePat" name="Apellido Paterno" size="25" requiered></li>
			<li><label for="apellidopat">*Apellido Materno:</label><input type="text" id="utxtApeMat" name="apellidopat" size="25" requiered><label for="fechaingreso">*Fecha Ingreso:</label><input type="text" id="utxtFechaIngreso" name="fechaingreso" size="25" requiered></li>
			<li><label for="rfc">*RFC:</label><input type="text" id="utxtRFC" name="rfc" size="25" requiered><label for="curp">*CURP:</label><input type="text" id="utxtCURP" name="curp" size="25" requiered></li>
			<li><label for="turno">*Turno:</label><input type="text" id="utxtTurno" name="turno" size="25" requiered><label for="email">*Email:</label><input type="text" id="utxtEmail" name="email" size="25" requiered></li>
			<li><label for="telfijo">*Telefono Fijo:</label><input type="text" id="utxtTelFijo" name="telfijo" size="15" requiered><label for="telmovil">*Telefono Móvil:</label><input type="text" id="utxtTelMovil" name="telmovil" size="15"></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalle" name="txtCalleNuevo" requiered><label for="noExt">*Num.Ext.: </label><input type="text" id="txtNoExt" name="txtNoExtNuevo" size="5" requiered><label for="noInt">*Num.Int.: </label><input type="text" id="txtNoInt" name="txtNoIntNuevo" size="5" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColonia" name="txtColoniaNuevo" requiered><label for="estado">*Estado: </label><input type="text" id="txtEstado" name="txtEstadoNuevo" size="15" requiered><li>
			<li><label for="cp">*C.P: </label><input type="text" id="txtCp" name="txtCp" size="5" requiered></li>
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
			<li><label for="usuario">*Usuario: </label><input type="text" id="txtUsuario" name="usuario" size="20" requiered autofocus><label for="contrasena">*Contraseña: </label><input type="text" size="15" id="txtContrasena" name="contrasena" requiered> </li>
			<li><label for="perfil">*Perfil: </label><input type="text" size="20" id="txtPerfil" name="Perfil" requiered><label for="tel">*Usuario Activo:</label><input type="checkbox" id="chkActivo"name="Activo" value="0" requiered>
			<label for="sucursal">*Sucursal: </label><input type="text" size="15" id="txtSucursal" name="sucursal" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Datos Personales</legend>
		<ol>
			<li><label for="persona">Nombre:</label><input type="text" id="txtNombre" name="Nombre" size="25" requiered><label for="diasCredito">*Apellido Paterno:</label><input type="text" id="txtApePat" name="Apellido Paterno" size="25" requiered></li>
			<li><label for="apellidopat">*Apellido Materno:</label><input type="text" id="txtApeMat" name="apellidopat" size="25" requiered><label for="fechaingreso">*Fecha Ingreso:</label><input type="text" id="txtFechaIngreso" name="fechaingreso" size="25" requiered></li>
			<li><label for="rfc">*RFC:</label><input type="text" id="txtRFC" name="rfc" size="25" requiered><label for="curp">*CURP:</label><input type="text" id="txtCURP" name="curp" size="25" requiered></li>
			<li><label for="turno">*Turno:</label><input type="text" id="txtTurno" name="turno" size="25" requiered><label for="email">*Email:</label><input type="text" id="txtEmail" name="email" size="25" requiered></li>
			<li><label for="telfijo">*Telefono Fijo:</label><input type="text" id="txtTelFijo" name="telfijo" size="15" requiered><label for="telmovil">*Telefono Móvil:</label><input type="text" id="txtTelMovil" name="telmovil" size="15" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalleNuevo" name="txtCalleNuevo" requiered><label for="noExt">*Num.Ext.: </label><input type="text" id="txtNoExtNuevo" name="txtNoExtNuevo" size="5" requiered><label for="noInt">*Num.Int.: </label><input type="text" id="txtNoIntNuevo" name="txtNoIntNuevo" size="5" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColoniaNuevo" name="txtColoniaNuevo" requiered><label for="estado">*Estado: </label><input type="text" id="txtEstadoNuevo" name="txtEstadoNuevo" size="15" requiered><li>
			<li><label for="cp">*C.P: </label><input type="text" id="txtCpNuevo" name="txtCpNuevo" size="5" requiered></li>
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
						<th style="width: 10%">Usuario</th>
						<th style="width: 10%">Contraseña</th>
						<th style="width: 5%">Perfil</th>
						<th style="width: 5%">Activo</th>
						<th style="width: 10%">Sucursal</th>
						<th style="width: 10%">Nombre</th>
						<th style="width: 10%">Apellido Paterno</th>
						<th style="width: 10%">Apellido Materno</th>
						<th style="width: 3%">Ingreso</th>
						<th style="width: 20%">RFC</th>
						<th style="width: 20%">CURP</th>
						<th style="width: 7%">Turno</th>
						<th style="width: 7%">Email</th>
						<th style="width: 15%">Telefono Fijo</th>
						<th style="width: 15%">Telefono Movil.</th>
						<th style="width: 20%">Calle</th>
						<th style="width: 3%">No.Int.</th>
						<th style="width: 3%">No.Ext.</th>
						<th style="width: 10%">Colonia</th>
						<th style="width: 5%">Estado</th>
						<th style="width: 5%">CP</th>
				    </tr>								
				</thead>
				<thead>	
				<tr>
						<th><input class="boxinit" style="width: 60px" type="text" placeholder="Usuario" /></th>
						<th><input class="boxinit" style="width: 60px" type="text" placeholder="Contraseña" /></th>
						<th><input class="boxinit" style="width: 60px" type="text" placeholder="Perfil" /></th>
						<th></th>
						<th></th>
						<th><input class="boxinit" style="width: 70px" type="text" placeholder="Nombre" /></th>
						<th><input class="boxinit" style="width: 70px" type="text" placeholder="ApePat" /></th>
						<th><input class="boxinit" style="width: 70px" type="text" placeholder="ApeMat" /></th>
						<th><input class="boxinit" style="width: 60px" type="text" placeholder="Ingreso" /></th>
						<th></th>
						<th></th>
						<th><input class="boxinit" style="width: 60px" type="text" placeholder="Turno" /></th>
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
