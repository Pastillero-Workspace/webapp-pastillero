<%@page import="mx.com.pastillero.model.dao.MedicoDireccionDao"%>
<%@page import="java.util.List"%>
<%@page import="mx.com.pastillero.types.Types"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
<head>
	<!-- The CSS Styles for forms -->
	<title>Consulta de Medicos | </title>
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
	<script src="<c:url value="/resources/js/functions.js" />"></script>  	
	<script type="text/javascript" language="javascript" class="init">
	var op = false;
	<% HttpSession sesion = request.getSession(false);
	  String usuario = (String)sesion.getAttribute("usuario");
	   String perfil = (String)session.getAttribute("perfil");
	   Integer sesionid = (Integer)sesion.getAttribute("idSesion");
	   Integer num = (Integer)sesion.getAttribute("numero");
	   Integer permiso =(Integer)sesion.getAttribute("pv");
		if(num == null){
				response.sendRedirect("index.jsp");
		}
		else 
			if(num == 1 && perfil.equalsIgnoreCase(Types.A.getStatusCode())){
			sesion.setAttribute("numero", 2);
			}
	 %>
		$(document).ready(function() {	
			checkEnabledRestriction('<%=usuario%>','<%=permiso%>'); 
			$("#search thead input").on( 'keypress changed', function (e) {  
					 table
					.column( $(this).parent().index()+':visible' )
					.search(this.value)
					.draw();
				    //alert("valor" + $(this).parent().index());					            
			} );			
	<% 		 	
	 	MedicoDireccionDao mD = new MedicoDireccionDao();
	 	List<Object[]> datos = mD.mostrar();	 	
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
			   	            '<%=datos.get(i)[11]%>',
			   	        	'<%=datos.get(i)[12]%>',
			   	        	'<%=datos.get(i)[13]%>'];
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
							for(var i = 0; i < 13; ++i) {		
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
					var cedulaMedico;
					if(index>=0){
						$.each(registro, function(data, value){
							if(data==0){
								cedulaMedico = value;
							}
						});
						$.post('medico.jr',{
							tarea: 'eliminar',
							txtCedula: cedulaMedico
						
						}).done(function(){
							alert("Se elimino medico con exito");
						}).fail(function(xhr,textStatus, errorThrown){
							alert("Error al eliminar el medico: "+textStatus +", "+errorThrown + "," +xhr);
						});;
						table.row(index).remove().draw(true);
					}else{
						window.alert("Seleccione un medico de la lista para poder eliminarlo");
					}
				});
				$("#btnAgregar").button().click(function(e){
					$("#formMedicoNuevo").dialog("open");
					$("#txtCedulaNuevo").select();
				});
				$("#btnExcel").button().click(function(e){
					var t = $('#search').tableToJSON();
				    
					$.post('reporte.jr',{
						reporte: 'medicos',
						txtTitulo:'Reporte de Medicos',
						tblMedicos:JSON.stringify(t)					
					}, function(f){
					});
					window.open("reporte.jsp", "Impresion", "height=600,width=400");
				});
				$("#btnEditar").button().click(function(e){
					index = table.row('.selected').index();
					var registro = table.row('.selected').data();
					
					if(index >= 0){
						console.log(registro);
						$("#txtCedula").val(registro[0]);
						$("#txtNombre").val(registro[1]);
						$("#txtTelFijo").val(registro[2]);
						$("#txtTelMovil").val(registro[3]);
						$("#txtEmail").val(registro[4]);
						$("#txtCalle").val(registro[5]);
						$("#txtNoExt").val(registro[6]);
						$("#txtNoInt").val(registro[7]);
						$("#txtColonia").val(registro[8]);
						$("#txtCiudad").val(registro[9]);
						$("#txtEstado").val(registro[10]);
						$("#txtCp").val(registro[11]);
						
						$("#formMedico").dialog("open");
						$("#txtCedula").select();
					}
					else{
						window.alert("Seleccione a un Medico");
					}
				});
			});
			$("#formMedico").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				buttons:{
					"Actualizar": {
						text: "Actualizar",
						id:		"btnActualizar",
						click:	function(){
							if($('#txtCedula').val().trim()!=""&&$('#txtNombre').val().trim()!=""&&$('#txtTelFijo').val().trim()!=""&&
									$('#txtTelMovil').val().trim()!=""&&$('#txtEmail').val().trim()!=""&&$('#txtCalle').val().trim()!=""&&
									$('#txtNoInt').val().trim()!=""&&$('#txtNoExt').val().trim()!=""&&$('#txtColonia').val().trim()!=""&&
									$('#txtEstado').val().trim()!=""&&$('#txtCiudad').val().trim()!=""&&$('#txtCp').val().trim()!=""){
									$.post('medico.jr',{
										tarea: 'actualizar',
										txtCedula: $('#txtCedula').val(),
										txtNombre: $('#txtNombre').val(),
										txtTelFijo: $('#txtTelFijo').val(),
										txtTelMovil: $('#txtTelMovil').val(),
										txtEmail: $('#txtEmail').val(),
										txtCalle: $('#txtCalle').val(),
										txtNoInt: $('#txtNoInt').val(),
										txtNoExt: $('#txtNoExt').val(),
										txtColonia: $('#txtColonia').val(),
										txtCiudad: $('#txtCiudad').val(),
										txtEstado: $('#txtEstado').val(),
										txtCp: $('#txtCp').val()
									}).done(function(){
										alert("Se ha actualizado el medico correctamente");
									}).fail(function(xhr,textStatus, errorThrown){
										alert("Error al actualizar el medico: "+textStatus +", "+errorThrown + "," +xhr);
									});
									
									table.row(index).data([
										$('#txtCedula').val(),
										$('#txtNombre').val(),
										$('#txtTelFijo').val(),						
										$('#txtTelMovil').val(),
										$('#txtEmail').val(),
										$('#txtCalle').val(),
										$('#txtNoExt').val(),
										$('#txtNoInt').val(),						
										$('#txtColonia').val(),
										$('#txtCiudad').val(),
										$('#txtEstado').val(),
										$('#txtCp').val()
									]);	
									
									$(this).dialog("close");
									$('#txtCedula').val('');
									$('#txtNombre').val('');
									$('#txtTelFijo').val('');
									$('#txtTelMovil').val('');
									$('#txtEmail').val('');
									$('#txtCalle').val('');
									$('#txtNoInt').val('');
									$('#txtNoExt').val('');
									$('#txtColonia').val('');
									$('#txtColonia').val(''),
									$('#txtEstado').val('');
									$('#txtCp').val('');
									
								}else{
									window.alert("No puede dejar campos vacios");
								}							
						}

					}
				}
			});
			$("#formMedico").dialog("option", "width", 760);
			$("#formMedico").dialog("option", "height", 600);
	
			$("#formMedicoNuevo").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				buttons:{
					"Agregar": {
						text: "Agregar",
						id:		"btnAgregarNuevo",
						click:	function(){
							if($('#txtCedulaNuevo').val().trim()!=""&&$('#txtNombreNuevo').val().trim()!=""&&$('#txtTelFijoNuevo').val().trim()!=""&&
									$('#txtTelMovilNuevo').val().trim()!=""&&$('#txtEmailNuevo').val().trim()!=""&&$('#txtCalleNuevo').val().trim()!=""&&
									$('#txtNoIntNuevo').val().trim()!=""&&$('#txtNoExtNuevo').val().trim()!=""&&$('#txtColoniaNuevo').val().trim()!=""&&
									$('#txtEstadoNuevo').val().trim()!=""&&$('#txtCiudadNuevo').val().trim()!=""&&$('#txtCpNuevo').val().trim()!=""){
									$.post('medico.jr',{
										tarea: 'agregar',
										txtCedula: $('#txtCedulaNuevo').val(),
										txtNombre: $('#txtNombreNuevo').val(),
										txtTelFijo: $('#txtTelFijoNuevo').val(),
										txtTelMovil: $('#txtTelMovilNuevo').val(),
										txtEmail: $('#txtEmailNuevo').val(),
										txtCalle: $('#txtCalleNuevo').val(),
										txtNoInt: $('#txtNoIntNuevo').val(),
										txtNoExt: $('#txtNoExtNuevo').val(),
										txtColonia: $('#txtColoniaNuevo').val(),
										txtCiudad: $('#txtCiudadNuevo').val(),
										txtEstado: $('#txtEstadoNuevo').val(),
										txtCp: $('#txtCpNuevo').val()
									}).done(function(){
										alert("Se ha agregado el medico correctamente");
									}).fail(function(xhr,textStatus, errorThrown){
										alert("Error al agregar el medico: "+textStatus +", "+errorThrown + "," +xhr);
									});
									
									table.row.add([
											            
										$('#txtCedulaNuevo').val(),
										$('#txtNombreNuevo').val(),
										$('#txtTelFijoNuevo').val(),						
										$('#txtTelMovilNuevo').val(),
										$('#txtEmailNuevo').val(),
										$('#txtCalleNuevo').val(),
										$('#txtNoExtNuevo').val(),
										$('#txtNoIntNuevo').val(),						
										$('#txtColoniaNuevo').val(),
										$('#txtCiudadNuevo').val(),
										$('#txtEstadoNuevo').val(),
										$('#txtCpNuevo').val()
									]).draw();
									
									$(this).dialog("close");
									$('#txtCedulaNuevo').val('');
									$('#txtNombreNuevo').val('');
									$('#txtTelFijoNuevo').val('');
									$('#txtTelMovilNuevo').val('');
									$('#txtEmailNuevo').val('');
									$('#txtCalleNuevo').val('');
									$('#txtNoIntNuevo').val('');
									$('#txtNoExtNuevo').val('');
									$('#txtColoniaNuevo').val('');
									$('#txtCiudadNuevo').val('');
									$('#txtEstadoNuevo').val('');
									$('#txtCpNuevo').val('');
									
									
								}else{
									window.alert("No puede dejar campos vacios");
								}	
						}
					}
				}
			});
			$("#formMedicoNuevo").dialog("option", "width", 760);
			$("#formMedicoNuevo").dialog("option", "height", 600);
	
			//Tecla enter en todos los campos
			$("#txtCedula").keypress(function(e){
				if(e.which == 13){
					$("#txtNombre").select();
				}
			});
			$("#txtNombre").keypress(function(e){
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
					$("#txtEmail").select();
				}
			});
			
			$("#txtEmail").keypress(function(e){
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
			
			$("#txtCedulaNuevo").keypress(function(e){
				if(e.which == 13){
					console.log("enter");
					$("#txtNombreNuevo").select();
				}
			});
			$("#txtNombreNuevo").keypress(function(e){
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
					$("#txtEmailNuevo").select();
				}
			});
			
			$("#txtEmailNuevo").keypress(function(e){
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
			
			/*Funcion que muestra el formulario de "Alta Medico"*/
			$(document).ready(function () {
		        	$("#openFormAltaMedico").click(
		            function () {
		            $("#formAltaMedico").dialog('open');
		             return false;
		            }
					
	        	);
		    });
		    /*Salir*/
		    $(document).ready(function (){
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
	<c:url value="Templates/formmedico.jsp" var="myURL"></c:url> <c:import url="${myURL}"/>
<div>
	<div id="header">
		<!--div id="logo"></div-->
	</div>	
	<div id="sucursal">
	    <p><c:out value="${sessionScope.perfil}"/> : <label id="lblname"><c:out value="${sessionScope.nombre}"/>
	    <c:out value="${sessionScope.apepat}" /><c:out value="${sessionScope.apemat}" /></label></p>
        <p>Usuario : <label id="lbluser"><%=usuario%></label><label> | Sucursal: <c:out value="${sessionScope.scr}" /></label></p>
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
						<th style="width: 10%">Cedula</th>
						<th style="width: 20%">Nombre</th>
						<th style="width: 10%">Tel. Fijo</th>
						<th style="width: 10%">Tel. Movil</th>
						<th style="width: 10%">Email</th>
						<th style="width: 25%" >Calle</th>
						<th style="width: 5%" >No.Ext.</th>
						<th style="width: 5%" >No.Int.</th>
						<th style="width: 15%">Colonia</th>
						<th style="width: 15%">Ciudad</th>
						<th style="width: 10%">Estado</th>
						<th style="width: 10%">CP</th>
				    </tr>
				    </thead>
				    <thead>							
				    <tr>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Cedula" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Nombre" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Tel. Fijo" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Tel. Movil" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Email" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Calle" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="No.Ext" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="No.Int" /></th>
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
