package mx.com.pastillero.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

			d.setCalle(request.getParameter("txtCalle").trim());
			d.setNoInt(Integer.parseInt(request.getParameter("txtNoInt").trim()));
			d.setNoExt(Integer.parseInt(request.getParameter("txtNoExt").trim()));
			d.setColonia(request.getParameter("txtColonia").trim());
			d.setEstado(request.getParameter("txtEstado").trim());
			d.setCp(Integer.parseInt(request.getParameter("txtCp").trim()));
			
			int idDireccion = proveedorDireccion.guardarDireccion(d);
			
			p.setNombre(request.getParameter("txtNombre").trim());
			p.setEmail(request.getParameter("txtEmail").trim());
			p.setFax(request.getParameter("txtFax").trim());
			p.setRfc(request.getParameter("txtRfc").trim());
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
			p.setNombre(request.getParameter("txtNombre").trim());
			p.setEmail(request.getParameter("txtEmail").trim());
			p.setFax(request.getParameter("txtFax").trim());
			p.setRfc(request.getParameter("txtRfc").trim());
			p.setDiasCredito(Integer.parseInt(request.getParameter("txtDiasCredito").trim()));
			p.setIdDireccion(Integer.parseInt(IdProveedor.get(0)[1].toString()));
			p.setDescGeneral(Integer.parseInt(request.getParameter("txtDescGeneral").trim()));
			p.setDesc2(Integer.parseInt(request.getParameter("txtDesc2").trim()));
			p.setDesc3(Integer.parseInt(request.getParameter("txtDesc3").trim()));
			
			d.setIdDireccion(p.getIdDireccion());
			d.setCalle(request.getParameter("txtCalle").trim());
			d.setNoInt(Integer.parseInt(request.getParameter("txtNoInt").trim()));
			d.setNoExt(Integer.parseInt(request.getParameter("txtNoExt").trim()));
			d.setColonia(request.getParameter("txtColonia").trim());
			d.setEstado(request.getParameter("txtEstado").trim());
			d.setCp(Integer.parseInt(request.getParameter("txtCp").trim()));
			
			proveedorDireccion.actualizarProveedor(p, d);
						
		}
		
		if(request.getParameter("tarea").equals("eliminar")){
			p.setNombre(request.getParameter("txtNombre").trim());
			
			List<Object[]> proveedor = proveedorDireccion.getIdProveedor(p.getNombre());
			boolean eliminar = proveedorDireccion.eliminarProveedor(Integer.parseInt(proveedor.get(0)[0].toString()));
			System.out.println("Eliminado: "+eliminar);
		}
		
		
		if(request.getParameter("tarea").equals("actualizar")){
					
			List<Object[]> IdProveedor = proveedorDireccion.getIdProveedor(request.getParameter("txtNombre").trim());
			
			p.setIdProveedor(Integer.parseInt(IdProveedor.get(0)[0].toString()));
			p.setNombre(request.getParameter("txtNombre").trim());
			p.setEmail(request.getParameter("txtEmail").trim());
			p.setFax(request.getParameter("txtFax").trim());
			p.setRfc(request.getParameter("txtRfc").trim());
			p.setDiasCredito(Integer.parseInt(request.getParameter("txtDiasCredito").trim()));
			p.setIdDireccion(Integer.parseInt(IdProveedor.get(0)[1].toString()));
			p.setDescGeneral(Integer.parseInt(request.getParameter("txtDescGeneral").trim()));
			p.setDesc2(Integer.parseInt(request.getParameter("txtDesc2").trim()));
			p.setDesc3(Integer.parseInt(request.getParameter("txtDesc3").trim()));
			
			d.setIdDireccion(p.getIdDireccion());
			d.setCalle(request.getParameter("txtCalle").trim());
			d.setNoInt(Integer.parseInt(request.getParameter("txtNoInt").trim()));
			d.setNoExt(Integer.parseInt(request.getParameter("txtNoExt").trim()));
			d.setColonia(request.getParameter("txtColonia").trim());
			d.setEstado(request.getParameter("txtEstado").trim());
			d.setCp(Integer.parseInt(request.getParameter("txtCp").trim()));
			
			proveedorDireccion.actualizarProveedor(p, d);
						
		}
		
		if(request.getParameter("tarea").equals("eliminar")){
			p.setNombre(request.getParameter("txtNombre").trim());
			
			List<Object[]> proveedor = proveedorDireccion.getIdProveedor(p.getNombre());
			boolean eliminar = proveedorDireccion.eliminarProveedor(Integer.parseInt(proveedor.get(0)[0].toString()));
			System.out.println("Eliminado: "+eliminar);
		}


	}
}
