package mx.com.pastillero.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.com.pastillero.model.dao.ClienteDireccionDao;
import mx.com.pastillero.model.formBeans.Cliente;
import mx.com.pastillero.model.formBeans.Direccion;

public class ClienteDireccionController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	ClienteDireccionDao clienteDireccion = new ClienteDireccionDao();
	Cliente c = new Cliente();
	Direccion d = new Direccion();
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{

		
		if(request.getParameter("tarea").equals("agregar")){
			d.setCalle(request.getParameter("txtCalle").trim());
			d.setNoInt(request.getParameter("txtNoInt").trim());
			d.setNoExt(request.getParameter("txtNoExt").trim());
			d.setColonia(request.getParameter("txtColonia").trim());
			d.setCiudad(request.getParameter("txtCiudad").trim());
			d.setEstado(request.getParameter("txtEstado").trim());
			d.setCp(Integer.parseInt(request.getParameter("txtCp").trim()));
			
			int idDireccion = clienteDireccion.guardarDireccion(d);
			
			c.setClave(request.getParameter("txtClave").trim());
			c.setNombre(request.getParameter("txtNombre").trim());
			c.setEmail(request.getParameter("txtEmail").trim());
			c.setRfc(request.getParameter("txtRfc").trim());
			c.setCredito(Integer.parseInt(request.getParameter("txtCredito").trim()));
			c.setDiasCredito(Integer.parseInt(request.getParameter("txtDiasCred")));
			c.setLimiteCredito(Float.parseFloat(request.getParameter("txtLimiteCred")));
			c.setVentaAnual(Float.parseFloat(request.getParameter("txtVentaAnual")));
			c.setSaldo(Float.parseFloat(request.getParameter("txtSaldo")));
			//c.setDescuentoExtra(Float.parseFloat(request.getParameter("txtDescExtra")));
			c.setVentaMensual(Float.parseFloat(request.getParameter("txtVentaMensual")));
			c.setIdDireccion(idDireccion);
			
			float opcDesc = Float.parseFloat(request.getParameter("opcDesc"));
			
			if(opcDesc == 5){
				c.setDescuentoExtra(opcDesc);
				c.setInsen(0);
			}else{
				c.setInsen(opcDesc);
				c.setDescuentoExtra(0);
			}
			
			clienteDireccion.guardarCliente(c);
			
			System.out.println(d.toString());
			System.out.println(c.toString());
		}
		
		if(request.getParameter("tarea").equals("actualizar")){
			List<Object[]> idCliente = clienteDireccion.getIdCliente(request.getParameter("txtClave").trim());
			
			c.setClave(request.getParameter("txtClave").trim());
			c.setNombre(request.getParameter("txtNombre").trim());
			c.setEmail(request.getParameter("txtEmail").trim());
			c.setRfc(request.getParameter("txtRfc").trim());
			c.setCredito(Integer.parseInt(request.getParameter("txtCredito").trim()));
			c.setDiasCredito(Integer.parseInt(request.getParameter("txtDiasCred")));
			c.setLimiteCredito(Float.parseFloat(request.getParameter("txtLimiteCred")));
			c.setVentaAnual(Float.parseFloat(request.getParameter("txtVentaAnual")));
			c.setSaldo(Float.parseFloat(request.getParameter("txtSaldo")));
			//c.setDescuentoExtra(Float.parseFloat(request.getParameter("txtDescExtra")));
			c.setVentaMensual(Float.parseFloat(request.getParameter("txtVentaMensual")));
			c.setIdCliente(Integer.parseInt(idCliente.get(0)[0].toString()));
			c.setIdDireccion(Integer.parseInt(idCliente.get(0)[1].toString()));
			
			float opcDesc = Float.parseFloat(request.getParameter("opcDesc"));
			
			if(opcDesc == 5){
				c.setDescuentoExtra(opcDesc);
				c.setInsen(0);
			}else{
				c.setInsen(opcDesc);
				c.setDescuentoExtra(0);
			}
			
			d.setIdDireccion(Integer.parseInt(idCliente.get(0)[1].toString()));
			d.setCalle(request.getParameter("txtCalle"));
			d.setNoExt(request.getParameter("txtNoExt"));
			d.setNoInt(request.getParameter("txtNoInt"));
			d.setColonia(request.getParameter("txtColonia"));
			d.setCiudad(request.getParameter("txtCiudad").trim());
			d.setEstado(request.getParameter("txtEstado"));
			d.setCp(Integer.parseInt(request.getParameter("txtCp")));
			
			clienteDireccion.actualizarCliente(c, d);
			System.out.println(c.toString());
			System.out.println(d.toString());
		
		}
		if(request.getParameter("tarea").equals("eliminar")){
			c.setClave(request.getParameter("txtClave").trim());
			
			List<Object[]> cliente = clienteDireccion.getIdCliente(c.getClave());
			boolean eliminar = clienteDireccion.eliminarCliente(Integer.parseInt(cliente.get(0)[0].toString()));
			System.out.println("Eliminado: "+eliminar);
		}
		
	}
	

}
