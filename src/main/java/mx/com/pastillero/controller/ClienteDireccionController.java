package mx.com.pastillero.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import mx.com.pastillero.model.dao.ClienteDireccionDao;
import mx.com.pastillero.model.formBeans.Cliente;
import mx.com.pastillero.model.formBeans.Direccion;

public class ClienteDireccionController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(ClienteDireccionController.class);
	ClienteDireccionDao clienteDireccion = new ClienteDireccionDao();
	Cliente c = new Cliente();
	Direccion d = new Direccion();
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{

		if(request.getParameter("tarea").equals("verifica")){
			try{
				List<Object[]> cliente = clienteDireccion.getIdCliente(request.getParameter("txtClave").trim());
				
				response.getWriter().write(!cliente.isEmpty()?cliente.get(0)[2].toString():"noExiste");
			}catch(Exception e){
				logger.info("Error: "+e);
			}
			
		}
		if(request.getParameter("tarea").equals("agregar")){
			try{
				d.setCalle(request.getParameter("txtCalle").trim().toUpperCase());
				d.setNoInt(request.getParameter("txtNoInt").trim().toUpperCase());
				d.setNoExt(request.getParameter("txtNoExt").trim().toUpperCase());
				d.setColonia(request.getParameter("txtColonia").trim().toUpperCase());
				d.setCiudad(request.getParameter("txtCiudad").trim().toUpperCase());
				d.setEstado(request.getParameter("txtEstado").trim().toUpperCase());
				d.setCp(Integer.parseInt(request.getParameter("txtCp").trim()));
				
				int idDireccion = clienteDireccion.guardarDireccion(d);
				
				c.setClave(request.getParameter("txtClave").trim().toUpperCase());
				c.setNombre(request.getParameter("txtNombre").trim().toUpperCase());
				c.setEmail(request.getParameter("txtEmail").trim());
				c.setRfc(request.getParameter("txtRfc").trim().toUpperCase());
				c.setCredito(Integer.parseInt(request.getParameter("txtCredito").trim()));
				c.setDiasCredito(Integer.parseInt(request.getParameter("txtDiasCred")));
				c.setLimiteCredito(Float.parseFloat(request.getParameter("txtLimiteCred")));
				c.setVentaAnual(Float.parseFloat(request.getParameter("txtVentaAnual")));
				c.setSaldo(Float.parseFloat(request.getParameter("txtSaldo")));
				//c.setDescuentoExtra(Float.parseFloat(request.getParameter("txtDescExtra")));
				c.setVentaMensual(Float.parseFloat(request.getParameter("txtVentaMensual")));
				c.setIdDireccion(idDireccion);
				
				//float opcDesc = Float.parseFloat(request.getParameter("opcDesc"));
				int opcDesc = Integer.parseInt(request.getParameter("opcDesc"));
				float clienteFrec = Float.parseFloat(request.getParameter("txtClienteFrec").trim());
				/*if(opcDesc == 5){
					c.setDescuentoExtra(opcDesc);
					c.setInsen(0);
				}else{
					c.setInsen(opcDesc);
					c.setDescuentoExtra(0);
				}*/
				
				float insen=0.00f, cltefrec=0.00f;
				
				switch(opcDesc){
				    case 1:cltefrec = clienteFrec;break;
				    case 2:insen = 2.00f;break;
				    case 3:insen = 3.00f;break;
				    case 4:insen = 4.00f;break;
				    case 5:insen = 5.00f;break;
				    default: cltefrec = 0.00f;insen = 0.00f;break;
				}
				
				c.setDescuentoExtra(cltefrec);
				c.setInsen(insen);
				
				clienteDireccion.guardarCliente(c);
		
			}catch(Exception e ){
				logger.info("Error: "+e);
			}
			
		}
		
		if(request.getParameter("tarea").equals("actualizar")){
			try{
				List<Object[]> idCliente = clienteDireccion.getIdCliente(request.getParameter("claveRespaldo").trim());
				
				c.setClave(request.getParameter("txtClave").trim());
				c.setNombre(request.getParameter("txtNombre").trim().toUpperCase());
				c.setEmail(request.getParameter("txtEmail").trim());
				c.setRfc(request.getParameter("txtRfc").trim().toUpperCase());
				c.setCredito(Integer.parseInt(request.getParameter("txtCredito").trim()));
				c.setDiasCredito(Integer.parseInt(request.getParameter("txtDiasCred")));
				c.setLimiteCredito(Float.parseFloat(request.getParameter("txtLimiteCred")));
				c.setVentaAnual(Float.parseFloat(request.getParameter("txtVentaAnual")));
				c.setSaldo(Float.parseFloat(request.getParameter("txtSaldo")));
				//c.setDescuentoExtra(Float.parseFloat(request.getParameter("txtDescExtra")));
				c.setVentaMensual(Float.parseFloat(request.getParameter("txtVentaMensual")));
				c.setIdCliente(Integer.parseInt(idCliente.get(0)[0].toString()));
				c.setIdDireccion(Integer.parseInt(idCliente.get(0)[1].toString()));
				
				//float opcDesc = Float.parseFloat(request.getParameter("opcDesc"));
				int opcDesc = Integer.parseInt(request.getParameter("opcDesc"));
				float clienteFrec = Float.parseFloat(request.getParameter("txtClienteFrec").trim());
				
				/*if(opcDesc == 5){
					c.setDescuentoExtra(opcDesc);
					c.setInsen(0);
				}else{
					c.setInsen(opcDesc);
					c.setDescuentoExtra(0);
				}*/
				
				float insen=0.00f, cltefrec=0.00f;
				
				switch(opcDesc){
				    case 1:cltefrec = clienteFrec;break;
				    case 2:insen = 2.00f;break;
				    case 3:insen = 3.00f;break;
				    case 4:insen = 4.00f;break;
				    case 5:insen = 5.00f;break;
				    default: cltefrec = 0.00f;insen = 0.00f;break;
				}
				
				c.setDescuentoExtra(cltefrec);
				c.setInsen(insen);
				
				d.setIdDireccion(Integer.parseInt(idCliente.get(0)[1].toString()));
				d.setCalle(request.getParameter("txtCalle").trim().toUpperCase());
				d.setNoExt(request.getParameter("txtNoExt").trim().toUpperCase());
				d.setNoInt(request.getParameter("txtNoInt").trim().toUpperCase());
				d.setColonia(request.getParameter("txtColonia").trim().toUpperCase());
				d.setCiudad(request.getParameter("txtCiudad").trim().toUpperCase());
				d.setEstado(request.getParameter("txtEstado").trim().toUpperCase());
				d.setCp(Integer.parseInt(request.getParameter("txtCp").trim()));
				
				clienteDireccion.actualizarCliente(c, d);

			}catch(Exception e){
				logger.info("Error: "+e);
			}
		}
		if(request.getParameter("tarea").equals("eliminar")){
			try{
				c.setClave(request.getParameter("txtClave").trim());			
				//List<Object[]> cliente = clienteDireccion.getIdCliente(c.getClave());
			}catch(Exception e){
				logger.info("Error: "+e);
			}
		}
	}
	
}
