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
	<script src="<c:url value="/resources/js/functions.js" />"></script>  
	<script type="text/javascript" language="javascript" class="init">
	var op = false;
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
		$(document).ready(function() {
			checkEnabledRestriction('<%=usuario%>','<%=permiso%>');
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
		
		<%for(int i=0; i<datos.size(); i++){
			String[] fecha1 = datos.get(i)[1].toString().split("-");
			String fecha = fecha1[2]+"-"+fecha1[1]+"-"+fecha1[0];
		%>
			
			data[<%=i%>]=[  '<%=datos.get(i)[0]%>',
			                '<%=fecha%>',
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
						$("#txtMedico").select();
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
				height: 470,
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
										$('#txtFecha').val(),
										$('#txtNota').val(),
										$('#opcReceta option:selected').val(),
										$('#opcSello option:selected').val(),
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
			$("#txtMedico").keypress(function(e){
				if(e.which == 13){
					$("#txtNota").select();
				}
			});
			$("#txtNota").keypress(function(e){
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
			$("#txtQuedan").keypress(function(e){
				if(e.which == 13){
					$("#btnActualizar").focus();
				}
			});
			
			$(function() {
			    $("#txtFecha").datepicker({ dateFormat: "dd-mm-yy"});
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
	<c:url value="Templates/formantibiotico.jsp" var="myURL"></c:url> <c:import url="${myURL}"/>
<div>
			<div id="header">
				<!--div id="logo"></div-->
			</div>
	
			<div id="sucursal">
			    <p><c:out value="${sessionScope.perfil}"/> : <label id="lblname"><c:out value="${sessionScope.nombre}"/>
			    <c:out value="${sessionScope.apepat}"/> <c:out value="${sessionScope.apemat}"/></label></p>
		        <p>Usuario : <label id="lbluser"><%=usuario%></label><label> | Sucursal: <c:out value="${sessionScope.scr}"/></label></p>
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
