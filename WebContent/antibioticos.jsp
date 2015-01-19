<%@page import="mx.com.pastillero.model.dao.AntibioticoDao"%>
<%@page import="java.util.List"%>
<%@page import="mx.com.pastillero.types.Types"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
<head>
	<!-- The CSS Styles for forms -->
	<title>Consulta de Antibioticos</title>
    <link href="<c:url value="/resources/css/edit.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/jquery.dataTables.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
	
	<!-- The Javascript config -->
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
	
	<script src="<c:url value="/resources/js/jquery.dataTables.min.js" />"></script>
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
		AntibioticoDao antDao = new AntibioticoDao();
	 	List<Object[]> datos = antDao.mostrar();
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
			   	         	'<%=datos.get(i)[11]%>'];
		<%}%>	
	         
			// Se establece el control de datos al destino
			var table = $('#search').DataTable({
				data:	data,
				dom : "rtiS",
				"stateSave" : true,
			    "bSort": false,
			    scrollY : 300,
				scrollCollapse : true,
				"columnDefs": [{
								"targets": [ 11 ],
				                "visible": false
				              }]				
			});
			
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
					//implementar funcionalidad.
				});
				
				$("#btnExcel").button().click(function(e){
					var t = $('#search').tableToJSON();
				    
					$.post('reporte.jr',{
						reporte: 'antibioticos',
						txtTitulo: 'Reporte de Antibioticos',
						tblAntibioticos: JSON.stringify(t)					
					}, function(f){
					});
					window.open("reporte.jsp", "Impresion", "height=600,width=400");
				});
				$("#btnEditar").button().click(function(e){
					index = table.row('.selected').index();
					var registro = table.row('.selected').data();
					
					$.post('medico.jr', {
						tarea : 'mostrar'
					}, function(data) {
						var medicos = data.split(',');
						$("#txtMedico" ).autocomplete({
							source: medicos
						});
					});
					
					if(index>=0){
						console.log('antb: '+registro[0]);
						
						$('#txtAntibiotico').val(registro[0]);						
						$('#txtFecha').val(registro[1]);
						$('#txtNota').val(registro[2]);
						$('#opcReceta').val(registro[3]);
						$('#opcSello').val(registro[4]);
						$('#txtAdquiridos').val(registro[5]);
						$('#txtVendidos').val(registro[6]);
						$('#txtHabian').val(registro[7]);
						$('#txtQuedan').val(registro[8]);
						$('#txtMedico').val(registro[9]);
						$('#txtProveedor').val(registro[10]);
						$('#idAnt').val(registro[11]);
						
						$("#formAntibiotico").dialog("open");
						$("#txtAntibiotico").select();
					}
					else{
						window.alert("Seleccione a un Antibiotico");
					}
				});
			});
			$("#formAntibiotico").dialog({
				modal:true,
				autoOpen: false,
				closeOnEscape: true,
				width: 700,
				height: 370,
				buttons:{
					"Actualizar": {
						text: "Actualizar",
						id:		"btnActualizar",
						click:	function(){
							if($('#txtAntibiotico').val().trim()!=""&&$('#txtMedico').val().trim()!=""&&$('#txtProveedor').val().trim()!=""&&
									$('#txtNota').val().trim()!=""&&$('#txtFecha').val().trim()!=""&&
									$('#txtAdquiridos').val().trim()!=""&&$('#txtVendidos').val().trim()!=""&&
									$('#txtHabian').val().trim()!=""&&$('#txtQuedan').val().trim()!=""){
								    
									$.post('antibiotico.jr',{
										tarea: 'actualizar',
										//parametro que permitiran la actualizacion.
										idAnt:$('#idAnt').val(),
										txtAntibiotico: $('#txtAntibiotico').val(),
										txtMedico: $('#txtMedico').val(),
										txtProveedor: $('#txtProveedor').val(),
										txtNota: $('#txtNota').val(),
										txtFecha: $('#txtFecha').val(),
										opcSello: $('#opcSello option:selected').val(),
										opcReceta: $('#opcReceta option:selected').val(),
										txtAdquiridos: $('#txtAdquiridos').val(),
										txtHabian: $('#txtHabian').val(),
										txtVendidos: $('#txtVendidos').val(),
										txtQuedan: $('#txtQuedan').val()
									},function(){});
									
									table.row(index).data([											            
										$('#txtAntibiotico').val(),
										$('#txtNota').val(),
										$('#txtFecha').val(),
										$('#opcSello option:selected').val(),
										$('#opcReceta option:selected').val(),
										$('#txtAdquiridos').val(),						
										$('#txtVendidos').val(),
										$('#txtHabian').val(),
										$('#txtQuedan').val(),
										$('#txtMedico').val(),
										$('#txtProveedor').val(),
										$('#idAnt').val()
									]);
									
									$(this).dialog("close");
									$('#txtAntibiotico').val('');
									$('#txtMedico').val('');
									$('#txtProveedor').val('');						
									$('#txtNota').val('');
									$('#txtFecha').val('');
									$('#opcSello option[value="0"]:selected');
									$('#txtReceta').val('');
									$('#txtAdquiridos').val('');
									$('#txtHabian').val('');
									$('#txtVendidos').val('');
									$('#txtQuedan').val('');
									
								}else{
									window.alert("No puede dejar campos vacios");
								}			
						}
					}
				}
			});
			
			//Tecla enter en todos los campos
			$("#txtAntibiotico").keypress(function(e){
				if(e.which == 13){
					$("#txtMedico").select();
				}
			});
			$("#txtMedico").keypress(function(e){
				if(e.which == 13){
					$("#txtProveedor").select();
				}
			});
			$("#txtProveedor").keypress(function(e){
				if(e.which == 13){
					$("#txtNota").select();
				}
			});
			$("#txtNota").keypress(function(e){
				if(e.which == 13){
					$("#txtFecha").select();
				}
			});
			
			$("#txtFecha").keypress(function(e){
				if(e.which == 13){
					$("#opcSello").select();
				}
			});
			$("#opcSello").keypress(function(e){
				if(e.which == 13){
					$("#opcReceta").select();
				}
			});
			$("#opcReceta").keypress(function(e){
				if(e.which == 13){
					$("#txtAdquiridos").select();
				}
			});
			$("#txtAdquiridos").keypress(function(e){
				if(e.which == 13){
					$("#txtVendidos").select();
				}
			});
			$("#txtVendidos").keypress(function(e){
				if(e.which == 13){
					$("#txtHabian").select();
				}
			});
			$("#txtHabian").keypress(function(e){
				if(e.which == 13){
					$("#txtQuedan").select();
				}
			});
			
			$(function() {
			    $("#txtFecha").datepicker();
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

<div id="formAntibiotico" title="Editar Antibiotico" class="text-form">
	<form id="antibiotico">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Antibiotico</legend>
		<ol>
			<label id="idAnt" hidden="true">x</label>
			<li><label for="antibiotico">*Antibiotico: </label><input type="text" size="45" id="txtAntibiotico" name="txtAntibiotico" requiered autofocus></li>
			<li><label for="proveedor">*Proveedor: </label><input type="text" size="15" id="txtProveedor" name="txtProveedor" requiered><label for="medico">*Medico: </label><input type="text" size="15" id="txtMedico" name="txtMedico" requiered></li>
			<li><label for="nota">*Num. de Nota: </label><input type="text" size="15" id="txtNota" name="txtNota" requiered><label for="fecha">*Fecha: </label><input type="text" size="15" id="txtFecha" name="txtFecha" requiered></li>
			<li><!--label for="receta">*Receta: </label><input type="text" size="15" id="txtReceta" name="txtReceta" requiered-->
			<label for="receta">*Receta: </label><select name="opcReceta" id="opcReceta">
													<option value='0'>NO</option>
													<option value='1'>SI</option>
												</select>
			<label for="sello">*Sello: </label><select name="opcSello" id="opcSello">
							<option value="0">0</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>
							<option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option>
					</select></li>
			<li><label for="adquiridos">*Adquiridos: </label><input type="text" size="15" id="txtAdquiridos" name="txtAdquiridos" requiered><label for="vendidos">*Vendidos: </label><input type="text" size="15" id="txtVendidos" name="txtVendidos" requiered></li>
			<li><label for="habian">*Habian: </label><input type="text" size="15" id="txtHabian" name="txtHabian" requiered><label for="quedan">*Quedan: </label><input type="text" size="15" id="txtQuedan" name="txtQuedan" requiered></li>
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
				<button id="btnExcel">Excel</button>
			</div>
			<table id="search" class="display" cellspacing="0" width="1024px">
				<thead>	
					<tr>
						<th style="width: 20%">Antibiotico</th>
						<th style="width: 10%">Fecha</th>
						<th style="width: 10%">Nota</th>
						<th style="width: 10%">Receta</th>
						<th style="width: 10%">Sello</th>
						<th style="width: 10%">Adquiridos</th>
						<th style="width: 10%">Vendidos</th>
						<th style="width: 10%">Habian</th>
						<th style="width: 10%">Quedan</th>
						<th style="width: 20%">Medico</th>
						<th style="width: 20%">Proveedor</th>
						<th style="width: 10%">numAnt</th>
				    </tr>
				    </thead>
				    <thead>							
				    <tr>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Antibiotico" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Fecha" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Nota" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Receta" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Sello" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Adquiridos" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Vendidos" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Habian" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Quedan" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Medico" /></th>
						<th><input class="boxinit" style="width: 90%" type="text" placeholder="Proveedor" /></th>
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
