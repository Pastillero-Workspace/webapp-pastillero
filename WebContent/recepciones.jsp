<%@page import="mx.com.pastillero.model.dao.RecepcionDao"%>
<%@page import="mx.com.pastillero.types.Types"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.SessionFactory"%>


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
	<script src="<c:url value="/resources/js/jquery.tabletojson.min.js" />"></script>
	
	<!-- The Javascript config datatables-->
	<script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
	<script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script>
	<script src="<c:url value="/resources/js/demo.js" />"></script>
	
	
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
		RecepcionDao recepcion = new RecepcionDao(); 
	 	List<Object[]>datos = recepcion.muestraRecepciones();	 	
	%>
		// Setting array data from clientedireccion
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
					        '<%=datos.get(i)[11]%>'
					        ];
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
			scrollY : 200,
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
		
		$(function(){
				$("#btnAgregar").button().click(function(e){
					$(location).attr('href', '${pageContext.request.contextPath}/recepcion.jsp');
					
				});
				
				$("#btnExcel").button().click(function(e){
					var t = $('#search').tableToJSON();
								    
					$.post('reporte.jr',{
						reporte: 'recepciones',
						txtTitulo:'Reporte de Recepciones',
						tblRecepciones:JSON.stringify(t)					
					}, function(f){
					});
					
					//$(location).attr('href', '${pageContext.request.contextPath}/reporte.jsp');
					//window.alert("Módulo en desarrollo");
					window.open("reporte.jsp", "Impresion", "height=600,width=400");
				});
				$("#btnDevolucion").button().click(function (e){
					window.open("listadevolrecepciones.jsp", "_blank");
				});
			
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
				<button id="btnAgregar">Nueva</button>
				<button id="btnExcel">Excel</button>
				<button id="btnDevolucion">Devolucion</button>
			</div>
				
			<table id="search" class="display" cellspacing="0" width="1200px">
				<thead>
					<tr>
						<th style="width: 10%">Recepcion</th>
						<th style="width: 10%">Factura</th>
						<th style="width: 10%">Fecha</th>
						<th style="width: 10%">Hora</th>
						<th style="width: 10%">Desc1</th>
						<th style="width: 10%">Desc2</th>
						<th style="width: 10%">FolioE</th>
						<th style="width: 10%">NotaFactura</th>
						<th style="width: 10%">Subtotal</th>
						<th style="width: 10%">Estado</th>
						<th style="width: 20%">Usuario</th>
						<th style="width: 30%" >Proveedor</th>
				    </tr>								
				</thead>
				<thead>	
					<tr>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
						<th><input class="boxinit" style="width: 100%" type="text" /></th>
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
