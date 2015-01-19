package mx.com.pastillero.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ch.qos.logback.classic.Logger;
import mx.com.pastillero.model.dao.ProveedorDireccionDao;
import mx.com.pastillero.model.formBeans.Direccion;
import mx.com.pastillero.model.formBeans.Proveedor;

public class ProveedorDireccionController extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ProveedorDireccionController(){
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
}

/**
 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
 */
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	/*Verificar primero que exista usuario y que este activo */
	
		ProveedorDireccionDao proveedorDireccion = new ProveedorDireccionDao();
		Proveedor p = new Proveedor();
		Direccion d = new Direccion();
		
		if(request.getParameter("tarea").equals("agregar")){

			d.setCalle(request.getParameter("txtCalle").trim().toUpperCase());
			d.setNoInt(request.getParameter("txtNoInt").trim().toUpperCase());
			d.setNoExt(request.getParameter("txtNoExt").trim().toUpperCase());
			d.setColonia(request.getParameter("txtColonia").trim().toUpperCase());
			d.setCiudad(request.getParameter("txtCiudad").trim().toUpperCase());
			d.setEstado(request.getParameter("txtEstado").trim().toUpperCase());
			d.setCp(Integer.parseInt(request.getParameter("txtCp").trim()));
			
			int idDireccion = proveedorDireccion.guardarDireccion(d);
			
			p.setNombre(request.getParameter("txtNombre").trim().toUpperCase());
			p.setRazonSocial(request.getParameter("txtRazonSocial").trim().toUpperCase());
			p.setEmail(request.getParameter("txtEmail").trim());
			p.setFax(request.getParameter("txtFax").trim());
			p.setRfc(request.getParameter("txtRfc").trim().toUpperCase());
			p.setDiasCredito(Integer.parseInt(request.getParameter("txtDiasCredito").trim()));
			p.setIdDireccion(idDireccion);
			p.setDescGeneral(Integer.parseInt(request.getParameter("txtDescGeneral").trim()));
			p.setDesc2(Integer.parseInt(request.getParameter("txtDesc2").trim()));
			p.setDesc3(Integer.parseInt(request.getParameter("txtDesc3").trim()));
			
			proveedorDireccion.guardarProveedor(p);
			
			
		}
		
		if(request.getParameter("tarea").equals("actualizar")){
					
			List<Object[]> IdProveedor = proveedorDireccion.getIdProveedor(request.getParameter("nombreRespaldo").trim());
			
			p.setIdProveedor(Integer.parseInt(IdProveedor.get(0)[0].toString()));
			p.setNombre(request.getParameter("txtNombre").trim().toUpperCase());
			p.setRazonSocial(request.getParameter("txtRazonSocial").trim().toUpperCase());
			p.setEmail(request.getParameter("txtEmail").trim());
			p.setFax(request.getParameter("txtFax").trim());
			p.setRfc(request.getParameter("txtRfc").trim().toUpperCase());
			p.setDiasCredito(Integer.parseInt(request.getParameter("txtDiasCredito").trim()));
			p.setIdDireccion(Integer.parseInt(IdProveedor.get(0)[1].toString()));
			p.setDescGeneral(Integer.parseInt(request.getParameter("txtDescGeneral").trim()));
			p.setDesc2(Integer.parseInt(request.getParameter("txtDesc2").trim()));
			p.setDesc3(Integer.parseInt(request.getParameter("txtDesc3").trim()));
			
			d.setIdDireccion(p.getIdDireccion());
			d.setCalle(request.getParameter("txtCalle").trim().toUpperCase());
			d.setNoInt(request.getParameter("txtNoInt").trim().toUpperCase());
			d.setNoExt(request.getParameter("txtNoExt").trim().toUpperCase());
			d.setColonia(request.getParameter("txtColonia").trim().toUpperCase());
			d.setCiudad(request.getParameter("txtCiudad").trim().toUpperCase());
			d.setEstado(request.getParameter("txtEstado").trim().toUpperCase());
			d.setCp(Integer.parseInt(request.getParameter("txtCp").trim()));
			
			proveedorDireccion.actualizarProveedor(p, d);
						
		}
		
		if(request.getParameter("tarea").equals("eliminar")){
			p.setNombre(request.getParameter("txtNombre").trim().toUpperCase());
			
			List<Object[]> proveedor = proveedorDireccion.getIdProveedor(p.getNombre().toUpperCase());
			boolean eliminar = proveedorDireccion.eliminarProveedor(Integer.parseInt(proveedor.get(0)[0].toString()));
		}

	}
}
