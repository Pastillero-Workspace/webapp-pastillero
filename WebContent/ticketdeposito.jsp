<%@page import="mx.com.pastillero.model.formBeans.CfgSucursal"%>
<%@page import="java.util.List"%>
<%@page import="mx.com.pastillero.model.dao.ConfiguracionSucursalDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="mx.com.pastillero.utils.TicketServiceDeposito"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Impresion de Recibo Deposito</title>
    <meta charset="utf-8">
	<link href="<c:url value="/resources/css/ticket-main.css" />" rel="stylesheet">
    <script type="text/javascript">
	    function getPrint()
		{ 
	    	 window.print();
	    	 window.close();
			    <%
		    		TicketServiceDeposito tsd = new TicketServiceDeposito();
			    	
			   		ConfiguracionSucursalDao sucursal = new ConfiguracionSucursalDao();
		    		List<CfgSucursal> datosSucursal = sucursal.mostrarSucursal();	    	
		        %>		 
	    } 
    </script>
 </head>
<body onload="getPrint()">
    <form name="form1" method="post" action="#" id="form1">
    <div class="centerdiv">
        <table class="mGrid">
            <tr>
				<td><div class="divlogo"></div><p></td>
			</tr>
            <tr>
                <td><span id="lblTitulo"><%=datosSucursal.get(0).getRazonSocial() %></span></td>
            </tr>
            <tr>
                <td><span id="lblNombre" class="bold-text">DEPOSITO INICIAL</span></td>
            </tr>         
            <tr>
                <td>
					<span id="lblCalle"><%=datosSucursal.get(0).getCalle() %></span>
					<span id="lblNumero">No. <%=datosSucursal.get(0).getNumeroExt() %></span>
                </td>
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
				<td id="SegmentEnd">==================================</td>
			</tr>
        </table>
	</div>
	<div class="centerdiv">
		<table class="mGrid">
            <tr>
                <td>
                    Fecha: <span id="lblFecha"><%=tsd.getFecha()%></span>
					Hora: <span id="lblHora"><%=tsd.getHora()%></span>
                </td>
            </tr>
            <tr>
                <td>Caja: <span id="lblAtendio"><%=tsd.getCaja() %></span></td>
            </tr>
			 <tr>
                <td>Usuario: <span id="lblAtendio"><%=tsd.getUsuario()%></span></td>
            </tr>
			 <tr>
                <td>Monto: <span id="lblAtendio"><%=tsd.getMonto()%></span></td>
            </tr>
            <tr><td id="SegmentStart">==================================</td></tr>		
			<tr><td><p></td></tr>
			<tr><td><p></td></tr>
			<tr><td><p></td></tr>
			<tr><td>_________________________________</td></tr>
			<tr><td>CAJERO</td></tr>
			<tr><td><span><%=tsd.getN_usuario()+" "+tsd.getN_apellidop()+""+tsd.getN_apellidom()%></span></td></tr>
			
		</table>
	</div>
    </form>
</body>
</html>
