<!-- Contenedor de permisos -->
<%@page import="mx.com.pastillero.model.dao.RolesDao"%>
<%@page import="mx.com.pastillero.model.formBeans.Roles"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<!-- pasar estejavascript a documento limpio este es testing -->
<script type="text/javascript" language="javascript" class="init">	
	$(document).ready(function() {
		
		$("#btnSave").button().click(function(e){			
			    jsnPermisos = [];
				$('[name="permisos"]:checked').each(function (e) {
				    var id = $(this).attr('value');
				    var checksel = {};
				    checksel["id"] = id;/*$(this).val();*/
				    jsnPermisos.push(checksel);});
				    $.post('permisos.jr',{
 									workout: 'setUser',
 									jsn: JSON.stringify(jsnPermisos),
 									user: $("#Usernamedata").text() //cambiar la validación
 								},function(data)
 								{								   
 									var obj = jQuery.parseJSON(data);
 									console.log( obj.msg1);
 									console.log( obj.msg2);
 									alert("Cambios guardados correctamente");
 									// asegurar con if la validacion de insercion de permisos
 									$("#permisos").hide();
 									$("#userpane").show();
 									removeattr();
 								});
			
		    
		});
		
		$("#btnCancel").button().click(function(e){
			 $("#permisos").hide();
			 $("#userpane").show();
			 removeattr();
		});
		var data = [];
		 <%
		 
	        RolesDao rd = new RolesDao();
	        List<Roles> datos = rd.getRoles();
			for(int i=0; i<datos.size(); i++){
			%>
			data[<%=i%>]=[  '<%=datos.get(i).getId_rol()%>',
			   	            '<%=datos.get(i).getDescripcion() %>',
			   	            '<input type='+"checkbox"+' id=rol'+"<%=datos.get(i).getId_rol()%>"+' value='+"<%=datos.get(i).getClave()%>"+' name='+"permisos"+' />'];
	
			<%}%>	

			$('#tpermiso').dataTable( {
				"scrollY":        "400px",
		        "scrollCollapse": true,
		        "paging":         false,
			    "aaData": data,
			    "aoColumns": [
			        { "mDataProp": "0" },
			        { "mDataProp": "1" },
			        { "mDataProp": "2" }

			    ]
			});

		
		
		function removeattr(){
			$('input:checkbox').removeAttr('checked');
		}	
		
		});
	
	
	/* fixed thead show correctly */
	
	
</script>
<div style="margin-bottom:5px;">
		<h3>Roles de usuario : <label id="Usernamedata"></label></h3>	
	     <div>
			<button id="btnSave">GuardarCambios</button>
			<button id="btnCancel">Cancelar</button>
         </div>
         <p></p>
         <div id="loadtable">
         		<table  id="tpermiso" class="display" width="100%" cellspacing="0" style="float:left;">
         		<thead >
					<tr style="font-size:14px">
						<th >Restricion</th>
						<th >Descripcion</th>
						<th >Estatus</th>
					</tr>
			    </thead>
			    <tbody style="font-size:14px">
			    </tbody>
         		</table>
         </div>
</div>





