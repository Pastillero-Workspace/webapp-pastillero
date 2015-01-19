<%@page import="mx.com.pastillero.utils.ReporteExcel"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reporte</title>
</head>
<body>
	<h1><%=ReporteExcel.getReporte() %> </h1>
	<table cellpadding="1"  cellspacing="1" border="1" bordercolor="gray">
		<%
								
				response.setContentType("application/vnd.ms-excel");
    			response.setHeader("Content-Disposition", "inline; filename="+ "reporte.xls");
    			
				String datos = ReporteExcel.getDatos();
				JSONParser parser = new JSONParser();
				Object tblDatos;
				
				try {
					tblDatos = parser.parse(datos);
					JSONArray arrayDatos = (JSONArray) tblDatos;
					
					if(ReporteExcel.getReporte().equals("Reporte de Recepciones")){
						out.println("<tr>");
						out.println("<td>Recepcion</td>");
						out.println("<td>Factura</td>");
						out.println("<td>Fecha</td>");
						out.println("<td>Hora</td>");
						out.println("<td>Desc1</td>");
						out.println("<td>Desc2</td>");
						out.println("<td>FolioE</td>");
						out.println("<td>NotaFactura</td>");
						out.println("<td>Subtotal</td>");
						out.println("<td>Estado</td>");
						out.println("<td>Usuario</td>");
						out.println("<td>Proveedor</td>");
						out.println("</tr>");
						
						for(int i=0; i<arrayDatos.size();i++){
							JSONObject pr = (JSONObject)arrayDatos.get(i);
							
							out.println("<tr>");
							out.println("<td>"+pr.get("Recepcion")+"</td>");
							out.println("<td>"+pr.get("Factura")+"</td>");
							out.println("<td>"+pr.get("Fecha")+"</td>");
							out.println("<td>"+pr.get("Hora")+"</td>");
							out.println("<td>"+pr.get("Desc1")+"</td>");
							out.println("<td>"+pr.get("Desc2")+"</td>");
							out.println("<td>"+pr.get("FolioE")+"</td>");
							out.println("<td>"+pr.get("NotaFactura")+"</td>");
							out.println("<td>"+pr.get("Subtotal")+"</td>");
							out.println("<td>"+pr.get("Estado")+"</td>");
							out.println("<td>"+pr.get("Usuario")+"</td>");
							out.println("<td>"+pr.get("Proveedor")+"</td>");
							out.println("</tr>");
						}	
					}
					if(ReporteExcel.getReporte().equals("Reporte de Clientes")){
						out.println("<tr>");
						out.println("<td>Clave</td>");
						out.println("<td>Nombre</td>");
						out.println("<td>Email</td>");
						out.println("<td>RFC</td>");
						out.println("<td>Credito</td>");
						out.println("<td>Dias Credito</td>");
						out.println("<td>Limite Credito</td>");
						out.println("<td>Venta Anual</td>");
						out.println("<td>Saldo</td>");
						out.println("<td>Desc.Extra</td>");
						out.println("<td>Venta Mensual</td>");
						out.println("<td>Calle</td>");
						out.println("<td>No.Ext</td>");
						out.println("<td>No.Int</td>");
						out.println("<td>Colonia</td>");
						out.println("<td>Estado</td>");
						out.println("<td>CP</td>");
						out.println("</tr>");
						
						for(int i=0; i<arrayDatos.size();i++){
							JSONObject pr = (JSONObject)arrayDatos.get(i);
							
							out.println("<tr>");
							out.println("<td>"+pr.get("Clave")+"</td>");
							out.println("<td>"+pr.get("Nombre")+"</td>");
							out.println("<td>"+pr.get("Email")+"</td>");
							out.println("<td>"+pr.get("RFC")+"</td>");
							out.println("<td>"+pr.get("Credito")+"</td>");
							out.println("<td>"+pr.get("Dias Credito")+"</td>");
							out.println("<td>"+pr.get("Limite Credito")+"</td>");
							out.println("<td>"+pr.get("Venta Anual")+"</td>");
							out.println("<td>"+pr.get("Saldo")+"</td>");
							out.println("<td>"+pr.get("Desc.Extra")+"</td>");
							out.println("<td>"+pr.get("Venta Mensual")+"</td>");
							out.println("<td>"+pr.get("Calle")+"</td>");
							out.println("<td>"+pr.get("No.Ext.")+"</td>");
							out.println("<td>"+pr.get("No.Int.")+"</td>");
							out.println("<td>"+pr.get("Colonia")+"</td>");
							out.println("<td>"+pr.get("Estado")+"</td>");
							out.println("<td>"+pr.get("CP")+"</td>");
							out.println("</tr>");
						}
					}
					if(ReporteExcel.getReporte().equals("Reporte de Proveedores")){
						out.println("<tr>");
						out.println("<td>Nombre</td>");
						out.println("<td>Email</td>");
						out.println("<td>Fax</td>");
						out.println("<td>RFC</td>");
						out.println("<td>Dias Credito</td>");
						out.println("<td>Desc General</td>");
						out.println("<td>Desc2</td>");
						out.println("<td>Desc3</td>");
						out.println("<td>Calle</td>");
						out.println("<td>No.Ext.</td>");
						out.println("<td>No.Int.</td>");
						out.println("<td>Colonia</td>");
						out.println("<td>Estado</td>");
						out.println("<td>CP</td>");
						out.println("</tr>");
						
						for(int i=0; i<arrayDatos.size();i++){
							JSONObject pr = (JSONObject)arrayDatos.get(i);
							
							out.println("<tr>");
							out.println("<td>"+pr.get("Nombre")+"</td>");
							out.println("<td>"+pr.get("Email")+"</td>");
							out.println("<td>"+pr.get("Fax")+"</td>");
							out.println("<td>"+pr.get("RFC")+"</td>");
							out.println("<td>"+pr.get("Dias Credito")+"</td>");
							out.println("<td>"+pr.get("Desc General")+"</td>");
							out.println("<td>"+pr.get("Desc2")+"</td>");
							out.println("<td>"+pr.get("Desc3")+"</td>");
							out.println("<td>"+pr.get("Calle")+"</td>");
							out.println("<td>"+pr.get("No.Ext.")+"</td>");
							out.println("<td>"+pr.get("No.Int.")+"</td>");
							out.println("<td>"+pr.get("Colonia")+"</td>");
							out.println("<td>"+pr.get("Estado")+"</td>");
							out.println("<td>"+pr.get("CP")+"</td>");
							out.println("</tr>");
						}
					}
					if(ReporteExcel.getReporte().equals("Reporte de Movimientos")){
						out.println("<tr>");
						out.println("<td>Movimiento</td>");
						out.println("<td>Folio</td>");
						out.println("<td>Documento</td>");
						out.println("<td>Clave</td>");
						out.println("<td>Descripcion</td>");
						out.println("<td>Adq</td>");
						out.println("<td>Vendidos</td>");
						out.println("<td>Valor</td>");
						out.println("<td>Habian</td>");
						out.println("<td>Quedan</td>");
						out.println("<td>Utilidad</td>");
						out.println("<td>Fecha</td>");
						out.println("<td>Hora</td>");
						out.println("</tr>");
						
						for(int i=0; i<arrayDatos.size();i++){
							JSONObject pr = (JSONObject)arrayDatos.get(i);
							
							out.println("<tr>");
							out.println("<td>"+pr.get("Movimiento")+"</td>");
							out.println("<td>"+pr.get("Folio")+"</td>");
							out.println("<td>"+pr.get("Documento")+"</td>");
							out.println("<td>"+pr.get("Clave")+"</td>");
							out.println("<td>"+pr.get("Descripcion")+"</td>");
							out.println("<td>"+pr.get("Adq")+"</td>");
							out.println("<td>"+pr.get("Vendidos")+"</td>");
							out.println("<td>"+pr.get("Valor")+"</td>");
							out.println("<td>"+pr.get("Habian")+"</td>");
							out.println("<td>"+pr.get("Quedan")+"</td>");
							out.println("<td>"+pr.get("Utilidad")+"</td>");
							out.println("<td>"+pr.get("Fecha")+"</td>");
							out.println("<td>"+pr.get("Hora")+"</td>");
							out.println("</tr>");
						}
					}
					if(ReporteExcel.getReporte().equals("Reporte de Usuarios")){
						out.println("<tr>");
						out.println("<td>Usuario</td>");
						out.println("<td>Contraseña</td>");
						out.println("<td>Perfil</td>");
						out.println("<td>Activo</td>");
						out.println("<td>Sucursal</td>");
						out.println("<td>Nombre</td>");
						out.println("<td>Apellido Paterno</td>");
						out.println("<td>Apellio Materno</td>");
						out.println("<td>Ingreso</td>");
						out.println("<td>RFC</td>");
						out.println("<td>CURP</td>");
						out.println("<td>Turno</td>");
						out.println("<td>Email</td>");
						out.println("<td>Telefono Fijo</td>");
						out.println("<td>Telefono Movil.</td>");
						out.println("<td>Calle</td>");
						out.println("<td>No.Ext.</td>");
						out.println("<td>No.Int.</td>");
						out.println("<td>Colonia</td>");
						out.println("<td>Estado</td>");
						out.println("<td>CP</td>");
						out.println("</tr>");
						
						for(int i=0; i<arrayDatos.size();i++){
							JSONObject pr = (JSONObject)arrayDatos.get(i);
							
							out.println("<tr>");
							out.println("<td>"+pr.get("Usuario")+"</td>");
							out.println("<td>"+pr.get("Contraseña")+"</td>");
							out.println("<td>"+pr.get("Perfil")+"</td>");
							out.println("<td>"+pr.get("Activo")+"</td>");
							out.println("<td>"+pr.get("Sucursal")+"</td>");
							out.println("<td>"+pr.get("Nombre")+"</td>");
							out.println("<td>"+pr.get("Apellido Paterno")+"</td>");
							out.println("<td>"+pr.get("Apellido Materno")+"</td>");
							out.println("<td>"+pr.get("Ingreso")+"</td>");
							out.println("<td>"+pr.get("RFC")+"</td>");
							out.println("<td>"+pr.get("CURP")+"</td>");
							out.println("<td>"+pr.get("Turno")+"</td>");
							out.println("<td>"+pr.get("Email")+"</td>");
							out.println("<td>"+pr.get("Telefono Fijo")+"</td>");
							out.println("<td>"+pr.get("Telefono Movil.")+"</td>");
							out.println("<td>"+pr.get("Calle")+"</td>");
							out.println("<td>"+pr.get("No.Ext.")+"</td>");
							out.println("<td>"+pr.get("No.Int.")+"</td>");
							out.println("<td>"+pr.get("Colonia")+"</td>");
							out.println("<td>"+pr.get("Estado")+"</td>");
							out.println("<td>"+pr.get("CP")+"</td>");
							out.println("</tr>");
						}
					}
					if(ReporteExcel.getReporte().equals("Reporte de Medicos")){
						out.println("<tr>");
						out.println("<td>Cedula</td>");
						out.println("<td>Nombre</td>");
						out.println("<td>Tel. Fijo</td>");
						out.println("<td>Tel. Movil</td>");
						out.println("<td>Email</td>");
						out.println("<td>Calle</td>");
						out.println("<td>No.Ext.</td>");
						out.println("<td>No.Int.o</td>");
						out.println("<td>Colonia</td>");
						out.println("<td>Estado</td>");
						out.println("<td>CP</td>");
						out.println("</tr>");
						
						for(int i=0; i<arrayDatos.size();i++){
							JSONObject pr = (JSONObject)arrayDatos.get(i);
							
							out.println("<tr>");
							out.println("<td>"+pr.get("Cedula")+"</td>");
							out.println("<td>"+pr.get("Nombre")+"</td>");
							out.println("<td>"+pr.get("Tel. Fijo")+"</td>");
							out.println("<td>"+pr.get("Tel. Movil")+"</td>");
							out.println("<td>"+pr.get("Email")+"</td>");
							out.println("<td>"+pr.get("Calle")+"</td>");
							out.println("<td>"+pr.get("No.Ext.")+"</td>");
							out.println("<td>"+pr.get("No.Int.")+"</td>");
							out.println("<td>"+pr.get("Colonia")+"</td>");
							out.println("<td>"+pr.get("Estado")+"</td>");
							out.println("<td>"+pr.get("CP")+"</td>");
							out.println("</tr>");
						}
					}
					
					if(ReporteExcel.getReporte().equals("Reporte de Productos")){
						out.println("<tr>");
						out.println("<td>Proveedor</td>");
						out.println("<td>Clave</td>");
						out.println("<td>Codigo</td>");
						out.println("<td>Descripcion</td>");
						out.println("<td>Familia</td>");
						out.println("<td>Precio Pub</td>");
						out.println("<td>Precio Desc</td>");
						out.println("<td>Precio Farm</td>");
						out.println("<td>IVA</td>");
						out.println("<td>Linea</td>");
						out.println("<td>Referencia</td>");
						out.println("<td>SSA</td>");
						out.println("<td>Laboratorio</td>");
						out.println("<td>Departamento</td>");
						out.println("<td>Categoria</td>");
						out.println("<td>Actualizable</td>");
						out.println("<td>Descuento</td>");
						out.println("<td>Costo</td>");
						out.println("<td>Equivalencia</td>");
						out.println("<td>Superfamilia</td>");
						out.println("<td>CLS</td>");
						out.println("<td>Zona</td>");
						out.println("<td>Pareto</td>");
						out.println("<td>IEPS</td>");
						out.println("<td>IEPS2</td>");
						out.println("<td>Limitado</td>");
						out.println("<td>Kit</td>");
						out.println("<td>Comision</td>");
						out.println("<td>Max Descuento</td>");
						out.println("<td>Grupo</td>");
						out.println("<td>Descuento Base</td>");
						out.println("<td>Politica Ofer</td>");
						out.println("<td>Antibiotico</td>");
						out.println("<td>Existencias</td>");
						out.println("<td>U. Proveedor</td>");
						out.println("<td>U. Costo</td>");
						out.println("<td>Costo Promedio</td>");
						out.println("<td>Costo Real</td>");
						out.println("</tr>");
						
						for(int i=0; i<arrayDatos.size();i++){
							JSONObject pr = (JSONObject)arrayDatos.get(i);
							
							out.println("<tr>");
							out.println("<td>"+pr.get("Proveedor")+"</td>");
							out.println("<td>"+pr.get("Clave")+"</td>");
							out.println("<td>"+pr.get("Codigo")+"</td>");
							out.println("<td>"+pr.get("Descripcion")+"</td>");
							out.println("<td>"+pr.get("Familia")+"</td>");
							out.println("<td>"+pr.get("Precio Pub")+"</td>");
							out.println("<td>"+pr.get("Precio Desc")+"</td>");
							out.println("<td>"+pr.get("Precio Farm")+"</td>");
							out.println("<td>"+pr.get("IVA")+"</td>");
							out.println("<td>"+pr.get("Linea")+"</td>");
							out.println("<td>"+pr.get("Referencia")+"</td>");
							out.println("<td>"+pr.get("SSA")+"</td>");
							out.println("<td>"+pr.get("Laboratorio")+"</td>");
							out.println("<td>"+pr.get("Departamento")+"</td>");
							out.println("<td>"+pr.get("Categoria")+"</td>");
							out.println("<td>"+pr.get("Actualizable")+"</td>");
							out.println("<td>"+pr.get("Descuento")+"</td>");
							out.println("<td>"+pr.get("Costo")+"</td>");
							out.println("<td>"+pr.get("Equivalencia")+"</td>");
							out.println("<td>"+pr.get("Superfamilia")+"</td>");
							out.println("<td>"+pr.get("CLS")+"</td>");
							out.println("<td>"+pr.get("Zona")+"</td>");
							out.println("<td>"+pr.get("Pareto")+"</td>");
							out.println("<td>"+pr.get("IEPS")+"</td>");
							out.println("<td>"+pr.get("IEPS2")+"</td>");
							out.println("<td>"+pr.get("Limitado")+"</td>");
							out.println("<td>"+pr.get("Kit")+"</td>");
							out.println("<td>"+pr.get("Comision")+"</td>");
							out.println("<td>"+pr.get("Max Descuento")+"</td>");
							out.println("<td>"+pr.get("Grupo")+"</td>");
							out.println("<td>"+pr.get("Descuento Base")+"</td>");
							out.println("<td>"+pr.get("Politica Ofer")+"</td>");
							out.println("<td>"+pr.get("Antibiotico")+"</td>");
							out.println("<td>"+pr.get("Existencias")+"</td>");
							out.println("<td>"+pr.get("U. Proveedor")+"</td>");
							out.println("<td>"+pr.get("U. Costo")+"</td>");
							out.println("<td>"+pr.get("Costo Promedio")+"</td>");
							out.println("<td>"+pr.get("Costo Real")+"</td>");
							out.println("</tr>");
						}
					}
					
					if(ReporteExcel.getReporte().equals("Reporte de Antibioticos")){
						out.println("<tr>");
						out.println("<td>Antibiotico</td>");
						out.println("<td>Fecha</td>");
						out.println("<td>Nota</td>");
						out.println("<td>Receta</td>");
						out.println("<td>Sello</td>");
						out.println("<td>Adquiridos</td>");
						out.println("<td>Vendidos</td>");
						out.println("<td>Quedan</td>");
						out.println("<td>Medico</td>");
						out.println("<td>Proveedor</td>");
						out.println("</tr>");
						
						for(int i=0; i<arrayDatos.size();i++){
							JSONObject pr = (JSONObject)arrayDatos.get(i);
							
							out.println("<tr>");
							out.println("<td>"+pr.get("Antibiotico")+"</td>");
							out.println("<td>"+pr.get("Fecha")+"</td>");
							out.println("<td>"+pr.get("Nota")+"</td>");
							out.println("<td>"+pr.get("Receta")+"</td>");
							out.println("<td>"+pr.get("Sello")+"</td>");
							out.println("<td>"+pr.get("Adquiridos")+"</td>");
							out.println("<td>"+pr.get("Vendidos")+"</td>");
							out.println("<td>"+pr.get("Quedan")+"</td>");
							out.println("<td>"+pr.get("Medico")+"</td>");
							out.println("<td>"+pr.get("Proveedor")+"</td>");
							out.println("</tr>");
						}
					}
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
		%>
				
		
		
					
	</table>



</body>
</html>