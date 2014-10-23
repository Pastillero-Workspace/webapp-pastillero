<%@page import="mx.com.pastillero.model.formBeans.CfgSucursal"%>
<%@page import="mx.com.pastillero.model.dao.ConfiguracionSucursalDao"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="mx.com.pastillero.types.Types"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page session="true" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="es">
<head>
	<title>Panel de configuraciones |</title>    
	
	<link href="<c:url value="/resources/css/index-cfg.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/jquery.dataTables.css" />"rel="stylesheet">
	<link href="<c:url value="/resources/css/demo-cfg.css" />" rel="stylesheet">
	 <link href="<c:url value="/resources/css/edit.css" />" rel="stylesheet">
	
	<!-- JS Script -->
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
    <script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
    <script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script>   
    
    <script type="text/javascript">   
    <%  HttpSession sesion = request.getSession(false);
		String usuario = (String)sesion.getAttribute("usuario");
		String nombre = (String)sesion.getAttribute("nombre");
		String apepat = (String)sesion.getAttribute("apepat");
		String apemat = (String)sesion.getAttribute("apemat");
		String perfil = (String)session.getAttribute("perfil");
		Integer num =   (Integer) sesion.getAttribute("numero");
		
		boolean res=false;	
		
		if(num == null)
		{
			response.sendRedirect("index.jsp");
		}
		else 
		{
			if(num == 1 && perfil.equalsIgnoreCase(Types.A.getStatusCode()))
			{
				sesion.setAttribute("numero", 2);
			    res = true;
			}
		}
		
		ConfiguracionSucursalDao sucursal = new ConfiguracionSucursalDao();
   	 	List<CfgSucursal> datosSucursal = sucursal.mostrarSucursal();	 
		     
	   %>	
       var op = <%=res%>      
// close function

 /*Salir*/

	// FUNCTIONS
	
	function info( x)
	{
		if(x == '1')
			alert("Función: Corte aún no implementada");
		if(x == '2')
			alert("Función: Medico en desarrollo");
	}
	
	$(document).ready(function () {
		$("#submit").button();
		$("#name_rs").select();
			
	});
	
	
</script>   	   
</head>
<body>	

<div>
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
    </ul>
	</div>
	<!--Barra de Navegacion, contiene el contenido que se muestra de lado derecho-->
	<div>
		<ul id="nav-right">
			<li><a id="close" onClick="javascript:window.close();">Salir</a></li>
		</ul>
		
	</div>
	<!--Insersion de la imagen de marca de agua en la parte del centro del sistema-->
	
	<div id="form_action">
		 <form id="cfg" method="post" action="cfg.jr">
		 <table>
		 <tr>
		 	<td><label for="name">Nombre o razón social: <span class="required">*</span></label> </td>
		 	<td><input type="text" id="name_rs" name="name_rs" value="<%=datosSucursal.get(0).getRazonSocial() %>" required="required" autofocus="autofocus" /></td>		 	
		 </tr>
		  <tr>
		 	<td><label for="rfc">RFC:<span class="required">*</span></label></td>
		 	<td><input type="text" id="rfc" name="rfc" value="<%=datosSucursal.get(0).getRfc() %>"  required="required" /></td>		 	
		 </tr>
		  <tr>
		 	<td><label for="sucursal">Sucursal:<span class="required">*</span></label></td>
		 	<td><input type="text" id="sucursal" name="sucursal" value="<%=datosSucursal.get(0).getSucursal() %>"  required="required" /></td>		 	
		 </tr>
		  <tr>
		 	<td><label for="street_data">Calle: <span class="required">*</span></label> </td>
		 	<td><input type="text" id="street_data" name="street_data" value="<%=datosSucursal.get(0).getCalle() %>" required="required" autofocus="autofocus" /></td>		 	
		 </tr>
		 	<tr>
		 	<td><label for="place_data">Colonia: <span class="required">*</span></label> </td>
		 	<td><input type="text" id="place_data" name="place_data" value="<%=datosSucursal.get(0).getColonia() %>" required="required" autofocus="autofocus" /></td>		 	
		 </tr>
		 <tr>
		 	<td><label for="numext_data">Numero_Exterior: <span class="required">*</span></label> </td>
		 	<td><input type="text" id="numext_data" name="numext_data" value="<%=datosSucursal.get(0).getNumeroExt() %>" required="required" autofocus="autofocus" /></td>		 	
		 </tr>
		 <tr>
		 	<td><label for="numint_data">Numero Interior: <span class="required">*</span></label> </td>
		 	<td><input type="text" id="numint_data" name="numint_data" value="<%=datosSucursal.get(0).getNumeroInt() %>" required="required" autofocus="autofocus" /></td>		 	
		 </tr>
		 <tr>
		 	<td><label for="mtown_data">Municipio: <span class="required">*</span></label> </td>
		 	<td><input type="text" id="mtown_data" name="mtown_data" value="<%=datosSucursal.get(0).getMunicipio() %>" required="required" autofocus="autofocus" /></td>		 	
		 </tr>
		 	<tr>
		 	<td><label for="state_data">Estado: <span class="required">*</span></label> </td>
		 	<td><input type="text" id="state_data" name="state_data" value="<%=datosSucursal.get(0).getEstado() %>" required="required" autofocus="autofocus" /></td>		 	
		 </tr>	
		 <tr>
		 	<td><label for="cp_data">C.P.:<span class="required">*</span></label></td>
		 	<td><input type="text" id="cp_data" name="cp_data" value="<%=datosSucursal.get(0).getCp() %>" required="required" autofocus="autofocus" /></td>
		 </tr>	
		 <tr>
		 	<td><label for="tel_data">Tel.:<span class="required">*</span></label></td>
		 	<td><input type="text" id="tel_data" name="tel_data" value="<%=datosSucursal.get(0).getTelefono() %>" required="required" autofocus="autofocus" /></td>
		 </tr>	
		 <tr>
		 	<td><label for="email_data">Email:<span class="required">*</span></label></td>
		 	<td><input type="text" id="email_data" name="email_data" value="<%=datosSucursal.get(0).getEmail() %>" required="required" autofocus="autofocus" /></td>
		 </tr>	
		 <tr>
		 	<td><label for="web_data">web:<span class="required">*</span></label></td>
		 	<td><input type="text" id="web_data" name="web_data" value="<%=datosSucursal.get(0).getWeb() %>" required="required" autofocus="autofocus" /></td>
		 </tr>		 			 
		 </table>                    
     
      <button type="submit" id="submit">Guardar Datos</button>
   </form>
  
</div>
</div>
</body>
</html>
