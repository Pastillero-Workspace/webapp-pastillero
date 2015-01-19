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
			$("#search thead input").on( 'keypress changed', function (e){  
					 table
					.column( $(this).parent().index()+':visible' )
					.search(this.value)
					.draw();				                  
			});			
			
		// botones adicionales para limpiar campos de textos
		/*$('<input type="button" id="refresh" style="width: 25%" value="Limpiar datos"/>').appendTo('div.dataTables_filter');
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
				});*/	
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
	    		dom : "rtiS",
				"stateSave" : true,
			    "bSort": false,
				scrollY : 900,
				scrollX : 1400,
				scrollCollapse : true
			} );
	    	
	    	// datatable configuration
		    $('#search tbody').on( 'click', 'tr', function () {
		        if ( $(this).hasClass('selected') ) {
		            $(this).removeClass('selected');
		        }
		        else {
		            table.$('tr.selected').removeClass('selected');
		            $(this).addClass('selected');
		        }
		    });	
	    	
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
			        	workout:'producto',
			        	txtCodigo: txtcodigo,
			        	txtDescripcion: txtdescripcion
			        	},
			        contentType: 'application/json',
			        mimeType: 'application/json', 
			        success: function (listaConsulta) {
			        	
			        	// Se crea array de datos aleatorios
						  table.clear().draw();
						  
						  $.each(listaConsulta, function(i, producto){
							  table.row.add([
							             producto[0],producto[1],producto[2],producto[3],producto[4],producto[5],producto[6],producto[7],producto[8],
							             producto[9],producto[10],producto[11],producto[12],producto[13],producto[14],producto[15],producto[16],producto[17],
							             producto[18],producto[19],producto[20],producto[21],producto[22],producto[23],producto[24],producto[25],producto[26],
							             producto[27],producto[28],producto[29],producto[30],producto[31],producto[32],producto[33],producto[34],producto[35],
							             producto[36],producto[37],producto[38],producto[39],producto[40]
							  ]);
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
			<table id="search" class="display" cellspacing="0" width="1400px">
				<thead>	
					<tr>
						<th style="width: 10%">Proveedor</th>
						<th style="width: 20%">Clave</th>
						<th style="width: 20%">Codigo</th>
						<th style="width: 50%">Descripcion</th>
						<th style="width: 5%">Existencias</th>
						<th style="width: 10%">Familia</th>
						<th style="width: 5%">Precio Pub</th>
						<th style="width: 5%">Precio Desc</th>
						<th style="width: 5%">Precio Farm</th>
						<th style="width: 5%" >IVA</th>
						<th style="width: 5%" >Linea</th>
						<th style="width: 5%" >Referencia</th>
						<th style="width: 5%">SSA</th>
						<th style="width: 20%">Laboratorio</th>
						<th style="width: 7%">Departamento</th>
						<th style="width: 5%">Categoria</th>
						<th style="width: 5%">Actualizable</th>
						<th style="width: 5%">Descuento</th>
						<th style="width: 10%">Costo</th>
						<th style="width: 7%">Equivalencia</th>
						<th style="width: 7%">Superfamilia</th>
						<th style="width: 7%">CLS</th>
						<th style="width: 5%">Zona</th>
						<th style="width: 5%">Pareto</th>
						<th style="width: 5%">IEPS</th>
						<th style="width: 5%">IEPS2</th>
						<th style="width: 10%">Limitado</th>
						<th style="width: 10%">Kit</th>
						<th style="width: 5%">Comision</th>
						<th style="width: 7%">Max Descuento</th>
						<th style="width: 5%">Grupo</th>
						<th style="width: 5%">Descuento Base</th>
						<th style="width: 5%">Politica Ofer</th>
						<th style="width: 5%">Antibiotico</th>
						<th style="width: 5%">Especial</th>
						<th style="width: 5%">Fam Actualizar</th>
						<th style="width: 5%">Com Inmediata</th>
						<th style="width: 10%">U. Proveedor</th>
						<th style="width: 10%">U. Costo</th>
						<th style="width: 10%">Costo Promedio</th>
						<th style="width: 10%">Costo Real</th>
				    </tr>								
				</thead>	
				<thead>	
					<tr>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
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
			</section>			
	 	</div>
	</div>
</body>
</html>
