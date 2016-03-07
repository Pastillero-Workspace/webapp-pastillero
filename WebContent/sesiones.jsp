<%@page import="mx.com.pastillero.model.formBeans.Usuario"%>
<%@page import="mx.com.pastillero.model.dao.UPDDao"%>
<%@page import="java.util.List"%>
<%@page import="mx.com.pastillero.types.Types"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
<head>
	<!-- The CSS Styles for forms -->
	<title>Consulta de Sesiones | </title>
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
	<% HttpSession sesion = request.getSession(false);
	  String usuario = (String)sesion.getAttribute("usuario");
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
			$("#enabled-tier").attr("disabled", "disabled");
			$( "#active" ).prop( "checked", false );
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
	 	UPDDao userDao = new UPDDao();
	 	List<Usuario> usuarios = userDao.mostrarUsuarios();   	 	
	%>
		// Se crea array de datos aleatorios
		var data = [];
		<%for(int i=0; i<usuarios.size(); i++){%>
			<%if(usuarios.get(i).getActivo()==1){%>
			data[<%=i%>]=[  '<%=usuarios.get(i).getIdUsuario()%>',
			                '<%=usuarios.get(i).getUsuario()%>',
			   	            '<%=usuarios.get(i).getPerfil()%>',
			   	            '<%=usuarios.get(i).getActivo()%>',
			   	            '<button id='+<%=i%>+'>Cerrar Sesion</button>'];
			<%}
			else{%>
				data[<%=i%>]=[  '<%=usuarios.get(i).getIdUsuario()%>',
				                '<%=usuarios.get(i).getUsuario()%>',
				   	            '<%=usuarios.get(i).getPerfil()%>',
				   	            '<%=usuarios.get(i).getActivo()%>',
				   	            '<button id='+<%=i%>+' disabled="disabled">Sesion Cerrada</button>'];
			<%}
		}%>		         
			// Se establece el control de datos al destino
			var table = $('#search').DataTable( {
			data:	data,
			dom : "rtiS",
			"stateSave" : true,
		    "bSort": false,
		    scrollY : 350,
			
			scrollCollapse : false
			
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
		// botones adicionales para limpiar campos de textos
		$('<input type="button" id="refresh" style="width: 25%" value="Limpiar datos"/>').appendTo('div.dataTables_filter');
			$('#refresh').click(function(e) 
				{		
					var elem = document.getElementsByClassName("boxinit");
						var names = [];
							for(var i = 0; i < 13; ++i) 
							{		
								if(elem[i].value.length != 0){
									names.push(elem[i].value);
									elem[i].value = '';
									elem[i].focus();									
								}
							}					     			
				});
		/** close windows**/
		   	$("#close").click(
		            function () 
		             {               
		            	var r = confirm("Desea cerrar el panel ?");
		            	if (r == true) 
		            	{
		            	    window.close();
		            	} 
		             });
	  /**Habilitar boton de control de permisos**/
			$("#active").click(
		            function () 
		             {               
		            	$("#enabled-tier").removeAttr("disabled");
		             });
			
	});
	$(function(){
		<%for(int i=0; i<usuarios.size(); i++){%>
			var obj=[];
			$("#"+<%=i%>).button().click(function(){
				console.log("Se presiono boton");
				var t = $('#search').DataTable();
				$('#search tbody').on('click','button',function(){
					
		  			obj = t.row( $(this).parents('tr') ).data();
				});
				setTimeout(function() {
					$.post('usuario.jr',{
						tarea: 'session',
						user : obj[0]
					},function(){
						
					});
				},100);
				setTimeout(function() {
					location.reload();
				},400);
				
			});
		<%}%>
	});
	/**funciones de js inicial**/
	function updateUser(){	
			$.post("permisos.jr",
				    {
				        workout: "control-enabled",
				    },
				    function(data, status){
				        alert("Cambios guardado correctamente");
				        $("#enabled-tier").attr("disabled", "disabled");
				    });	
	}
	</script>	
</head>
<body>

<div>
	<div id="header">
		<!--div id="logo"></div-->
	</div>
	<div id="sucursal">
	    <p><c:out value="${sessionScope.perfil}"/> : <label id="lblname"><c:out value="${sessionScope.nombre}"/>
	    <c:out value="${sessionScope.apepat}" /><c:out value="${sessionScope.apemat}" /></label></p>
        <p>Usuario : <label id="lbluser"><c:out value="${sessionScope.usuario}"/></label><label> | Sucursal: <c:out value="${sessionScope.scr}" /></label></p>
	</div>
	<!--Barra de Navegacion de la pagina principal-->
			<ul id="nav">				
			</ul>  
	<!--Barra de Navegacion, contiene el contenido que se muestra de lado derecho-->
	<div id="navigatorpanel">
		<ul id="nav-right">
			<li><a id="close" onClick="javascript:window.close();">Salir</a></li>
		</ul>	
	</div>	
		<div class="container">
			<div>
				<h3>Los usuarios activos son aquellos que iniciaron y aún no han cerrado sesión en el sistema,
				 los valores de la columna Activo son: 1 = Sesión Abierta, 0 = Sesión Cerrada.<br>
				 Si en alguna parte del sistema le aparece el mensaje de Sesión duplicada, cierre la sesión del usuario
				 para poder ingresar nuevamente.<br>¡IMPORTANTE! Tenga cuidado al cerrar sesiones.</h3>
			</div>		
			<table id="search" class="display"cellspacing="0"  width="760px">
				<thead>	
					<tr>
						<th style="width: 5%">Id</th>
						<th style="width: 5%">Usuario</th>
						<th style="width: 5%">Perfil</th>
						<th style="width: 5%">Activo</th>
						<th style="width: 5%"></th>
					 </tr>
				    </thead>			    
				<tbody>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
			<div>
				<h3>Esta opci&oacute;n solo se utilizar&aacute; para pruebas.(Posteriormente se migrará a creacion de usuario)</h3>
  					<input id="active" type="checkbox" name="restrictions" value="1">Habilitar control de permisos de usuario<br>
  					<br><input id="enabled-tier" type="button" value="Habilitar" onclick="updateUser()">
			</div>		
	 	</div>
	 	
	</div>
</body>
</html>
