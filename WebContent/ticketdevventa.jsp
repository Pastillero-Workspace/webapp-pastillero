<%@page import="mx.com.pastillero.utils.TicketServiceDevolucionVenta"%>
<%@page import="mx.com.pastillero.model.formBeans.CfgSucursal"%>
<%@page import="mx.com.pastillero.model.dao.ConfiguracionSucursalDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="mx.com.pastillero.utils.TicketServiceCobro"%>
<%@page import="mx.com.pastillero.model.formBeans.ItemVenta"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>Impresion de Ticket</title>
    <meta charset="utf-8">
	<link href="<c:url value="/resources/css/ticket-main.css" />" rel="stylesheet">
	<!--  Java Script Library -->
	
    <script type="text/javascript">
	    function getPrint()
		{ 
			
			if (window.opener != null && !window.opener.closed) 
	        {
	            window.opener.close();
	        }
			
			window.print();
			window.close();
	    } 	    
	    <%
	   		 HttpSession sesion = request.getSession(false);
		     Integer num =   (Integer) sesion.getAttribute("numero");
		     
		 		if(num == null)
				{
						response.sendRedirect("index.jsp");
				}
				else 
				{
					if(num == 1)
						sesion.setAttribute("numero", 2);

				}
		 		
		 	TicketServiceDevolucionVenta tsc = new TicketServiceDevolucionVenta();
	    	 int nota = TicketServiceDevolucionVenta.getIdNota();
	    	 List<ItemVenta> mapItems = TicketServiceDevolucionVenta.getItemsDetail();
	    	 
	    	 ConfiguracionSucursalDao sucursal = new ConfiguracionSucursalDao();
	    	 List<CfgSucursal> datosSucursal = sucursal.mostrarSucursal();	    	 
	    	 
	    %>
    </script>

 </head>
<body onload="getPrint()">
    <form name="form1" method="post" action="#" id="form1">
	<div class="print-area">
		<div class="centerdiv">
			<table>
				<tr>
					<td><div class="divlogo"></div><p></td>
				</tr>
				<tr>
					<td><span id="lblTitulo"><%=datosSucursal.get(0).getRazonSocial() %></span></td>
				</tr>
				<tr>
					<td><span id="lblNombre">Sucursal: <%=datosSucursal.get(0).getSucursal() %></span></td>
				</tr>
				<!-- <tr>
					<td><span id="lblConcepto">Concepto de Compras El Pastillero S.A.</span></td>
				</tr> -->            
				<tr>
					<td>
						<span id="lblCalle"><%=datosSucursal.get(0).getCalle() %></span>
						<span id="lblNumero">No. <%=datosSucursal.get(0).getNumeroExt() %></span>
					</td>
				</tr>
			
				<tr>
					<td >
						<span id="lblColonia"><%=datosSucursal.get(0).getColonia() %></span>,
						<span id="lblEstado"><%=datosSucursal.get(0).getMunicipio() %></span>				
					</td>
				</tr>
				<tr>
				<td><span id="lblCodigoPostal">C.P : <%=datosSucursal.get(0).getCp() %></span></td>
				</tr>
				<tr>
					<td><span id="lblRFC"> R.F.C: <%=datosSucursal.get(0).getRfc() %></span></td>
				</tr>
				<tr>
					<td>Folio de Devolucion: <span id="lblIDNota"><%=TicketServiceDevolucionVenta.getIdNota() %></span></td>
				</tr>
				<tr>
					<td>
						Fecha: <span id="lblFecha"><%=TicketServiceDevolucionVenta.getDate() %></span>
						Hora: <span id="lblHora"><%=TicketServiceDevolucionVenta.getTime() %></span>
					</td>
				</tr>
				<tr>
					<td>Atendido por: <span id="lblAtendio"><%=TicketServiceDevolucionVenta.getUserPerson()%></span></td>
				</tr>
				<tr>
					<td id="SegmentStart">==================================</td></tr>
				<tr>
					<td>               
						<div>
							<table class="mGrid detail" cellspacing="0" border="0" id="gvApp">
							<thead class="light-text">							
								<tr >
									<th scope="col">Cant</th>
									<th scope="col" style="width:200px;">DESCRIP</th>
									<th scope="col">P.PUB</th>
									<th scope="col">PRECIO</th>
								</tr>
							</thead>
								<!-- Se insertan filas dinamicas-->
							 <tbody class="bold-text">
								<% for(ItemVenta p: mapItems )
									{
									   out.println("<tr>");
										   out.println("<td>-"+p.getCantidad()+"</td>"); //quantity
										   out.println("<td>"+p.getDescripcion()+"</td>"); // descripcion
										   out.println("<td>-"+p.getPreciopub()+"</td>"); // precipp
										   out.println("<td>-"+p.getPreciodesc()+"</td>"); // preciod
									   out.println("</tr>");
									
									}
									%>
							 </tbody>														
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<td id="SegmentEnd">==================================</td>
				</tr>
			
			</table>
		</div>
		<div class="rightdiv">
		<table class="mGrid">	
				<tr>
					<td>SubTotal: -<span id="lblSubTotal" class="bold-text"><%=TicketServiceDevolucionVenta.getSubtotal() %></span></td>
				</tr>
				<tr>
					<td>IVA: -<span id="lblTotalIva" class="bold-text"><%=TicketServiceDevolucionVenta.getIva() %></span></td>
				</tr>
				<tr>
					<td>--------------</td>
				</tr>
				<tr>
					<td>Total: $ -<span id="lblTotalVenta" class="bold-text"><%=TicketServiceDevolucionVenta.getTotal()%></span></td>
				</tr>
				<tr>
					<td>
						<span id="lblPagoTipo">Tipo Pago:</span>: 
						<span id="lblTotalPago">Efectivo</span>
					</td>
				</tr>
								
				<tr><td>------------------------------------------------</td></tr>
			</table>
			</div>
			<div class="centerdiv">
			<table class="mGrid">
				<tr>
					<td>
						<span id="lblMensajeAhorro"></span> 
						<span id="lblTotalAhorro" class="bold-text"></span>
					</td>
				</tr>
				<tr>
					<td >
						<span id="lblMensajeGracias1"></span> 					
					</td>
				</tr>
				<tr>
					<td>
						<span id="lblMensajeGracias2">¡¡¡FUE UN PLACER ATENDERLE !!!</span>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td align="center">CONTÁCTANOS</td></tr>
				<tr>
					<td align="center">
						Telefono: <span id="lblTelefono"><%=datosSucursal.get(0).getTelefono() %></span>
					</td>
				</tr>
				<tr>
					<td align="center">
						e-mail: <span id="lblEmail"><%=datosSucursal.get(0).getEmail() %></span>
					</td>
				</tr>
				<tr>
					<td align="center">
						Visita: <span id="lblLink"><%=datosSucursal.get(0).getWeb() %></span>
					</td>
				</tr>
				<tr>
					<td align="center">
						<span id="lblInfo"></span>
					</td>
				</tr>
			</table>
		</div>
		<div>
		<p>............................................................</p>
		</div>
	</div>
    </form>
</body>
</html>
