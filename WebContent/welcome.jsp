<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="mx.com.pastillero.types.Types"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="es">
<head>
	<title> | Sesion : <c:out value="${sessionScope.perfil}"/></title>    	
	<link href="<c:url value="/resources/css/index.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet" type="text/css">
	<link href="<c:url value="/resources/css/jquery.dataTables.css" />" rel="stylesheet">  
	<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
	<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
    <script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
    <c:set var="profile" scope="session" value="${perfil}"/>    
	<c:if test="${profile == 'CAJERO'}">	     
		<script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
   		<script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script>   
	</c:if>   	
    <!--   Custom javascript user  -->
    <script src="<c:url value="/resources/js/welcomefnc.js" />"></script>
    <script src="<c:url value="/resources/js/functions.js" />"></script>   
    <script type="text/javascript">   
    <% HttpSession sesion = request.getSession(false);   
		   String usuario = (String)sesion.getAttribute("usuario");
		   String perfil = (String)session.getAttribute("perfil");
		   String a  = (String)sesion.getAttribute("a");
		   String b  = (String)sesion.getAttribute("b");
		   Integer sesionid = (Integer)sesion.getAttribute("idSesion");
		   Integer num = (Integer)sesion.getAttribute("numero");
		   Integer permiso =(Integer)sesion.getAttribute("pv");		   
		boolean res = false;	
		if(num == null){
			response.sendRedirect("index.jsp");
		}
		else {
			if(num == 1 && perfil.equalsIgnoreCase(Types.C.getStatusCode()) || perfil.equalsIgnoreCase(Types.V.getStatusCode()))
			{
				sesion.setAttribute("numero", 2);
			    res = true;
			}
			if(num == 2){
				sesion.setAttribute("numero", 2);
			}
		}	     
	   %>
	   /** variables declarativas **/
	   var op = <%=res%>
       $(document).ready(function(){	 
    	     rstPreferences('<%=b%>');
             saveEstatus('<%=usuario%>','<%=perfil%>','<%=sesionid%>');      
             loadPreferences('<%=a%>');
             checkConstraintRestriction('<%=permiso%>');
             loadcjnotes('<%=perfil%>');
     	}); 	   	
	</script>   	   
</head>
<body >
<div>
	<c:if test="${profile == 'CAJERO'}">
		<c:url value="Templates/formdeposito.jsp" var="myURL"></c:url>
	    <c:import url="${myURL}"/>
	</c:if>
</div>
<div>
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
	<ul id ="nav">
			<li id="ME01"><a href="${pageContext.request.contextPath}/consulta.jsp"  target="_blank">Consulta</a></li>
			<li id="ME02"><a href="javascript:isTicket();">Cobro</a></li>
			<li id="ME03"><a href="${pageContext.request.contextPath}/clientes.jsp" target="_blank">Clientes</a></li>
			<li id="ME04"><a href="${pageContext.request.contextPath}/medicos.jsp" target="_blank">Medicos</a></li>
			<li id="ME05"><a href="${pageContext.request.contextPath}/construction.jsp" target="_blank">Corte de Caja</a></li>
			<li id="ME06"><a href="${pageContext.request.contextPath}/recepciones.jsp"  target="_blank">Recepción</a></li>
			<li id="ME07"><a href="${pageContext.request.contextPath}/proveedores.jsp" target="_blank">Proveedores</a></li>	
			<li id="ME08"><a href="${pageContext.request.contextPath}/productos.jsp"  target="_blank">Productos</a></li>
			<li id="ME09"><a href="${pageContext.request.contextPath}/usuario.jsp"  target="_blank">Usuarios</a></li>
			<li id="ME10"><a href="${pageContext.request.contextPath}/movimientos.jsp"  target="_blank">Movimientos</a></li>
			<li id="UNDEF"><a href="${pageContext.request.contextPath}/antibioticos.jsp"  target="_blank">Antibioticos</a></li>
			<li id="ME11"><a href="${pageContext.request.contextPath}/salidas.jsp"  target="_blank">Salidas</a></li>
    </ul>
	</div>
	<!--Barra de Navegacion, contiene el contenido que se muestra de lado derecho-->
	<div>
		<ul id="nav-right">
			<li><a id="close" runat="server">Salir</a></li>
			<li id="ME12">
				<span id="menu">
					<select id="menuSecond">
						<option value="">Barra de Acceso Rápido...</option>
						<option id="ME13" value="${pageContext.request.contextPath}/configuraciones.jsp">Configuraciones</option>
						<option id="ME14" value="${pageContext.request.contextPath}/sesiones.jsp">Sesiones de Usuarios</option>		
				</select>
				</span>
			</li>
		</ul>		
	</div>
	<!--Insersion de la imagen de marca de agua en la parte del centro del sistema-->	
	<div id="newPage">	
	<div id="update-restrictions">
	<div><label> Por favor actualize los permisos que ha cambiado</label></div>
	      <input type="button" value="Actualizar permisos" onclick="updateConstraintRestriction()"> 
	</div>
	<c:if test="${profile == 'CAJERO'}">
	<div class="infobox">
	     <section>				
			<table id="example"  class="display" cellspacing="0" width="300px">
				<thead>
					<tr>					
						<th style="width: 15%">Folio</th>
						<th style="width: 15%">Usuario</th>
						<th style="width: 15%">-</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
				<tfoot>
				</tfoot>
			</table>											
		</section>
	  </div>
	  </c:if>  
	</div>
</div>
</body>
</html>
