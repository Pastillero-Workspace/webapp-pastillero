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
			/*$("#search thead input").on( 'keypress changed', function (e){  
					 table
					.column( $(this).parent().index()+':visible' )
					.search(this.value)
					.draw();				                  
			});*/
			
			$("#filtros input").on( 'keypress changed', function (e){  
				 table
				//.column(5)
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
	    		dom : "plrti",
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
							             producto[36],producto[37],producto[38],producto[39],producto[40],producto[41],producto[42],producto[43],producto[44]
							  ]);
						  });
						  table.draw();
						  $.unblockUI();
			        },
			        error:function(data,status,er) {
			        	 $.unblockUI();
			            alert("error: "+data+" status: "+status+" er:"+er);
			         }
			    });
			}
			
			$("#btnQuitarFiltros").hide();
			
			$("#btnFiltros").button().click(function(){
				$("#filtros").fadeIn(600);
				$("#btnFiltros").hide();
				$("#btnQuitarFiltros").show();
			});
			$("#btnQuitarFiltros").button().click(function(){
				$("#filtros").fadeOut(600);
				$("#btnQuitarFiltros").hide();
				$("#btnFiltros").show();
			});
			
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
					<li><label for="descripcion"><b>Descripcion:</b></label><input type="text" id="txtDescripcion" name="descripcion" size="50"><button type="button" id="btnFiltros">mas filtros.</button><button type="button" id="btnQuitarFiltros">quitar filtros.</button></li>
				</ul>
				</form>
			</div>
			
			<div id="filtros" style="-webkit-column-count: 5; -moz-column-count: 5; column-count: 5;  display: none; width:1100px; background-color:#00cccc; float: left; left:10px;margin: 5px;">
				<ul style="list-style-type: none;">
					<li><input type="text" class="boxinit" placeholder="Proveedor" ></li>
					<li><input type="text" class="boxinit" placeholder="Proveedor2" ></li>
					<li><input type="text" class="boxinit" placeholder="Proveedor3" ></li>
					<li><input type="text" class="boxinit" placeholder="Clave" ></li>
					<li><input type="text" class="boxinit" placeholder="Codigo" ></li>
					<li><input type="text" class="boxinit" placeholder="Descripcion" ></li>
					<li><input type="text" class="boxinit" placeholder="Existencias" ></li>
					<li><input type="text" class="boxinit" placeholder="Familia" ></li>
					<li><input type="text" class="boxinit" placeholder="PrecioPub" ></li>
					<li><input type="text" class="boxinit" placeholder="PrecioDesc" ></li>
					<li><input type="text" class="boxinit" placeholder="PrecioFarm" ></li>
					<li><input type="text" class="boxinit" placeholder="FechaPcio" ></li>
					<li><input type="text" class="boxinit" placeholder="IVA" ></li>
					<li><input type="text" class="boxinit" placeholder="Linea" ></li>
					<li><input type="text" class="boxinit" placeholder="Referencia" ></li>
					<li><input type="text" class="boxinit" placeholder="SSA" ></li>
					<li><input type="text" class="boxinit" placeholder="Laboratorio" ></li>
					<li><input type="text" class="boxinit" placeholder="Departamento" ></li>
					<li><input type="text" class="boxinit" placeholder="Categoria" ></li>
					<li><input type="text" class="boxinit" placeholder="Actualizable" ></li>
					<li><input type="text" class="boxinit" placeholder="Descuento" ></li>
					<li><input type="text" class="boxinit" placeholder="Costo" ></li>
					<li><input type="text" class="boxinit" placeholder="Equivalencia" ></li>
					<li><input type="text" class="boxinit" placeholder="Superfamilia" ></li>
					<li><input type="text" class="boxinit" placeholder="CLS" ></li>
					<li><input type="text" class="boxinit" placeholder="Zona" ></li>
					<li><input type="text" class="boxinit" placeholder="Pareto" ></li>
					<li><input type="text" class="boxinit" placeholder="Pareto2" ></li>
					<li><input type="text" class="boxinit" placeholder="IEPS" ></li>
					<li><input type="text" class="boxinit" placeholder="IEPS2" ></li>
					<li><input type="text" class="boxinit" placeholder="Limitado" ></li>
					<li><input type="text" class="boxinit" placeholder="Kit" ></li>
					<li><input type="text" class="boxinit" placeholder="Comision" ></li>
					<li><input type="text" class="boxinit" placeholder="MaxDescuento" ></li>
					<li><input type="text" class="boxinit" placeholder="Grupo" ></li>
					<li><input type="text" class="boxinit" placeholder="DescuentoBase" ></li>
					<li><input type="text" class="boxinit" placeholder="PoliticaOfer" ></li>
					<li><input type="text" class="boxinit" placeholder="Antibiotico" ></li>
					<li><input type="text" class="boxinit" placeholder="Especial" ></li>
					<li><input type="text" class="boxinit" placeholder="FamActualiz" ></li>
					<li><input type="text" class="boxinit" placeholder="ComInmediata" ></li>
					<li><input type="text" class="boxinit" placeholder="U.Proveedor" ></li>
					<li><input type="text" class="boxinit" placeholder="U.Costo"></li>
					<li><input type="text" class="boxinit" placeholder="CostoPromedio"></li>
					<li><input type="text" class="boxinit" placeholder="CostoReal"></li>
				</ul>
			</div>
			
			<table id="search" class="display" cellspacing="0" width="1400px">
				<thead>	
					<tr>
						<th style="width: 10%">Proveedor</th>
						<th style="width: 10%">Proveedor2</th>
						<th style="width: 10%">Proveedor3</th>
						<th style="width: 20%">Clave</th>
						<th style="width: 20%">Codigo</th>
						<th style="width: 50%">Descripcion</th>
						<th style="width: 5%">Existencias</th>
						<th style="width: 10%">Familia</th>
						<th style="width: 5%">Precio Pub</th>
						<th style="width: 5%">Precio Desc</th>
						<th style="width: 5%">Precio Farm</th>
						<th style="width: 5%">Fecha Pcio</th>
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
						<th style="width: 5%">Pareto2</th>
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
<!-- 				<thead>	 -->
<!-- 					<tr> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 						<th></th> -->
<!-- 					</tr>				 -->
<!-- 				</thead> -->
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
