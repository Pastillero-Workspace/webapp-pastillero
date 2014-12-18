<%@page import="java.util.List"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="mx.com.pastillero.types.Types"%>
<%@page import="mx.com.pastillero.model.dao.ProductoFamiliaDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
<head>
	<!-- The CSS Styles for forms -->
	<title>Consulta de Producto | </title>
    <link href="<c:url value="/resources/css/index.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/jquery.dataTables.css" />" rel="stylesheet"  type="text/css">
	<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
	
	<!-- The Javascript config -->
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
	<script src="<c:url value="/resources/js/blockUI/jquery.blockUI.js" />"></script>
	
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
		$(document).ready(function() 
		{			
		    // Algoritmo de filtrado
			$("#search thead input").on( 'keypress changed', function (e) 
			{  
					 table
					.column( $(this).parent().index()+':visible' )
					.search(this.value)
					.draw();
				    //alert("valor" + $(this).parent().index());					
                  
		});
			
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
		
	    $(document).ready(function (){
	    	var table = $('#search').DataTable( {
				//data:           data,
				//deferRender:    true,
				dom:            "frtiS",
				//dom:			"rtiS",
				scrollY:        500,
				"stateSave" : true,
				"bSort": false,
				scrollCollapse: true,
				pagingType: "full_numbers"
			} );
	    	$('#txtCodigo').keypress(function(event) {
				if (event.which == 13) {
					 //buscar($('#txtCodigo').val(),$('#txtDescripcion').val());
					 $('#btnBuscar').focus();
					 
				}});
			$('#txtDescripcion').keypress(function(event) {
				if (event.which == 13) {
					//buscar($('#txtCodigo').val(),$('#txtDescripcion').val());	
					$('#btnBuscar').focus();
					
				}});
			$("#btnBuscar").button().click(function(e){
				if($("#txtCodigo").val().trim() != ""){
					buscar($('#txtCodigo').val(),"");	
					$('#txtCodigo').val('');
				}else if($("#txtDescripcion").val().trim() != ""){
					buscar("",$('#txtDescripcion').val());
					$('#txtDescripcion').val('');
				}else{
					alert("Para realizar una busqueda llene alguno de los campos");
				}
				
			});
			function buscar(txtcodigo, txtdescripcion){
				blockpage();
				$.ajax({
			        url: "consulta.jr",
			        type: 'POST',
			        dataType: 'json',
			        data://txtcodigo+':'+txtdescripcion,
			        	{
			        	workout:'consulta',
			        	txtCodigo: txtcodigo,
			        	txtDescripcion: txtdescripcion
			        	},
			        contentType: 'application/json',
			        mimeType: 'application/json', 
			        success: function (listaConsulta) {
			        	
			        	// Se crea array de datos aleatorios
						  table.clear().draw();
						  
						  $.each(listaConsulta, function(i, producto){
							  table.row.add([producto[1],producto[2],producto[3],producto[4]
							  			,producto[5],producto[6],producto[7],producto[8]
							  			,producto[9],producto[10],producto[11],producto[12]
							  			,producto[13]]);
						  });
						  table.draw();
						  $.unblockUI();
			        },
			        error:function(data,status,er) {
			            alert("error: "+data+" status: "+status+" er:"+er);
			            $.unblockUI();
			        }
			    });
			}
	    });
	    
		
</script>
</head>
<body>
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
					<li><a href="#">Recargar Datos</a></li>
			</ul>  
	<!--Barra de Navegacion, contiene el contenido que se muestra de lado derecho-->
	<div id="navigatorpanel">
		<ul id="nav-right">
			<li><a id="close">Salir</a></li>
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
	<!-- Seccion de busqueda -->
	
		<div class="container">
			<section>
			<div STYLE="float: left; top:150px; left:10px; width:600px; background-color:#00cccc;  margin: 20px;">
				<form>
				<ul STYLE="list-style-type: none;">
					<li><label for="codigo"><b>Codigo:</b></label><input type="text" id="txtCodigo" name="codigo" size="50"><button type="button" id="btnBuscar">Buscar.</button><br></li>
					<li><label for="descripcion"><b>Descripcion:</b></label><input type="text" id="txtDescripcion" name="descripcion" size="50"></li>
				</ul>
				</form>
				
			</div>
			<table id="search" class="display" cellspacing="0" width="1024px">
				<thead>	
					<tr>
						<th style="width: 10%">Codigo</th>
						<th style="width: 2%">EXST</th>
						<th style="width: 28%">Descripcion</th>
						<th style="width: 10%">FAM</th>
						<th style="width: 12%">LAB</th>
						<th style="width: 4%">CLS</th>
						<th style="width: 4%">SSA</th>
						<th style="width: 2%">IVA</th>
						<th style="width: 2%" >IEPS</th>
						<th style="width: 4%" >CAT</th>
						<th style="width: 4%" >PAR</th>
						<th style="width: 8%">PRECP</th>
						<th >PRECD</th>
				    </tr>	
				   					
				</thead>
				<tbody>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
			</section>			
	 	</div>
	</div>
</body>
</html>
