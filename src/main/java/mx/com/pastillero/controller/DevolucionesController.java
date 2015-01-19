package mx.com.pastillero.controller;

import com.google.gson.Gson;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import mx.com.pastillero.model.dao.DevolucionesDao;
import mx.com.pastillero.model.dao.PersonaDao;
import mx.com.pastillero.model.dao.ProductosDao;
import mx.com.pastillero.model.dao.UsuarioDao;
import mx.com.pastillero.model.formBeans.DetalleDevolucionVenta;
import mx.com.pastillero.model.formBeans.DevolucionCompra;
import mx.com.pastillero.model.formBeans.DevolucionVenta;
import mx.com.pastillero.model.formBeans.ItemVenta;
import mx.com.pastillero.model.formBeans.MovimientoDevolucionCompra;
import mx.com.pastillero.model.formBeans.MovimientoDevolucionVenta;
import mx.com.pastillero.model.formBeans.Productos;
import mx.com.pastillero.model.formBeans.Usuario;
import mx.com.pastillero.utils.DevolucionVentaDet;
import mx.com.pastillero.utils.TicketServiceDevolucionVenta;

public class DevolucionesController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static int nota = 0;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doPost(request, response);
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		Date date = new Date();
		DateFormat hourFormat = new SimpleDateFormat("HH:mm:ss");
		String hora = hourFormat.format(date);
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String fecha = dateFormat.format(date);
		
		DevolucionesDao devolucion = new DevolucionesDao();
		DevolucionCompra devCompra = new DevolucionCompra();
		MovimientoDevolucionCompra movimientoDev = new MovimientoDevolucionCompra();
		MovimientoDevolucionVenta movimientoDevVenta = new MovimientoDevolucionVenta();
		ProductosDao pDao = new ProductosDao();
		if(request.getParameter("devolucion").trim().equals("verificaCompra")){
			String codigo = request.getParameter("txtCodigo").trim();
			String documento = request.getParameter("txtDocumento").trim().toUpperCase();
			List<Object[]> verificar = devolucion.verificarDevCompra(codigo, documento);
			if(verificar.isEmpty()){
				response.getWriter().write("0");
			}else{
				int cantidadDev = 0;
				for(int i = 0; i<verificar.size(); i++){
					cantidadDev += Integer.parseInt(verificar.get(i)[2].toString());
				}
				response.getWriter().write(Integer.toString(cantidadDev));
			}
		}
		else if(request.getParameter("devolucion").trim().equals("compra")){
			devCompra.setFecha(fecha);
			devCompra.setHora(hora);
			devCompra.setMotivo(request.getParameter("txtMotivo").trim().toUpperCase());
			devCompra.setEstado("COMPLETA");
			devCompra.setIdUsuario(devolucion.buscarUsuario(request.getParameter("txtUsuario").trim().toString().toUpperCase()));
			devCompra.setNotaReferencia(Integer.parseInt(request.getParameter("txtFolio").trim()));
			devCompra.setNotaActual(1);
			
			//Inserta Devolucion
			int idDev = devolucion.insertarDevolucionCompra(devCompra);
			
			movimientoDev.setTipo("DEVOLUCION S/COMPRA");
			movimientoDev.setIdNota(idDev);
			movimientoDev.setDocumento(request.getParameter("txtDocumento").trim().toUpperCase());
			movimientoDev.setClave(request.getParameter("txtCodigo").trim());
			movimientoDev.setDescripcion(request.getParameter("txtDescripcion").trim().toUpperCase());
			movimientoDev.setAdquiridos(0);
			movimientoDev.setVendidos(Integer.parseInt(request.getParameter("txtCantidad").trim()));
			movimientoDev.setValor(Float.parseFloat(request.getParameter("txtCosto").trim()));
			
			List<Productos> p = pDao.productoPorCodigo(movimientoDev.getClave());
									
			movimientoDev.setHabian(p.get(0).getExistencias());
			movimientoDev.setQuedan(p.get(0).getExistencias() - movimientoDev.getVendidos());
			movimientoDev.setFecha(fecha);
			movimientoDev.setHora(hora);
			movimientoDev.setUtilidad(0);
			
			//Inserta Detalle de movimiento
			devolucion.insertarMovimientoDevCompra(movimientoDev);
			
			p.get(0).setExistencias(movimientoDev.getQuedan());
			//Inserta existencias en Productos
			pDao.actualizarTotales(p.get(0));
			
		}
		else if(request.getParameter("devolucion").trim().equals("venta")){
			System.out.println("Devolucion venta");
			nota = Integer.parseInt(request.getParameter("nota"));
			List<Object[]> detalleDev = devolucion.mostrarVentaDetalle(Integer.parseInt(request.getParameter("nota").trim()));
			
			//Gson gson = new Gson();
			//String jsonVenta = gson.toJson(detalleDev);
			//System.out.println(jsonVenta);
			
			List<DetalleDevolucionVenta> detalles = new ArrayList<DetalleDevolucionVenta>();
	        for(int i=0; i<detalleDev.size();i++){
				DetalleDevolucionVenta dVenta = new DetalleDevolucionVenta();
				dVenta.setFecha(detalleDev.get(i)[0].toString());
				dVenta.setNota(detalleDev.get(i)[1].toString());
				dVenta.setClave(detalleDev.get(i)[2].toString());
				dVenta.setDescripcion(detalleDev.get(i)[3].toString());
				dVenta.setCantidad(Integer.parseInt(detalleDev.get(i)[4].toString()));
				dVenta.setPrecioUnitario(Float.parseFloat(detalleDev.get(i)[5].toString()));
				dVenta.setSubtotal(Float.parseFloat(detalleDev.get(i)[6].toString()));
				dVenta.setIva(Float.parseFloat(detalleDev.get(i)[7].toString()));
				dVenta.setImporte(Float.parseFloat(detalleDev.get(i)[8].toString()));
				dVenta.setDevolucion(0);
				dVenta.setTotal(0);
				
				detalles.add(dVenta);
	        }
	        DevolucionVentaDet.setDetalleVenta(detalles);
			
		
		}
		else if(request.getParameter("devolucion").trim().equals("detalleVenta")){
			System.out.println("Detalle Venta");
			
			DevolucionVenta dVenta = new DevolucionVenta();
			dVenta.setFecha(fecha);
			dVenta.setHora(hora);
			dVenta.setMotivo(request.getParameter("txtMotivo").trim().toUpperCase());
			dVenta.setEstado("COMPLETA");
			dVenta.setIdUsuario(devolucion.buscarUsuario(request.getParameter("txtUsuario").toString().toUpperCase()));
			dVenta.setNotaReferencia(nota);
			dVenta.setNotaActual(1);
			System.out.println(dVenta.toString());
			
			int idDev = devolucion.insertarDevolucionVenta(dVenta);
			
			List<ItemVenta> detalle  = new ArrayList<ItemVenta>();
			float subtotal = 0;
			float iva = 0;
			
			JSONParser parser = new JSONParser();
			Object productos;
			String tblProductos = request.getParameter("tbldatos");
			//System.out.println("Productos: "+tblProductos);
			
						
			try {
				productos = parser.parse(tblProductos);
				JSONArray arrayProductos = (JSONArray) productos;
				
				
				for(int i=0; i<arrayProductos.size();i++){
					JSONObject pr = (JSONObject)arrayProductos.get(i);
					
					ItemVenta dev = new ItemVenta();
					dev.setCodigo(pr.get("Clave").toString());
					dev.setDescripcion(pr.get("Descripcion").toString().toUpperCase());
					dev.setCantidad(Integer.parseInt(pr.get("Cantidad").toString()));
					dev.setPreciopub(Float.parseFloat(pr.get("PrecioUnit").toString()));
					//Falta reafirmar precio des
					dev.setPreciodesc(Float.parseFloat(pr.get("PrecioUnit").toString())*dev.getCantidad());
					dev.setSubtotal(Float.parseFloat(pr.get("Subtotal").toString()));
					
					subtotal += dev.getSubtotal();
					iva += Float.parseFloat(pr.get("Iva").toString());
					
					///Datos no llenados
					dev.setIdproducto(0);
					dev.setHabian(0);
					dev.setUltimocosto(0);
					
					System.out.println(dev.toString());
					detalle.add(dev);
					
					
					movimientoDevVenta.setTipo("DEVOLUCION S/VENTA");
					movimientoDevVenta.setIdNota(idDev);
					movimientoDevVenta.setDocumento("0");
					movimientoDevVenta.setClave(dev.getCodigo());
					movimientoDevVenta.setDescripcion(dev.getDescripcion().toUpperCase());
					movimientoDevVenta.setAdquiridos(dev.getCantidad());
					movimientoDevVenta.setVendidos(0);
					movimientoDevVenta.setValor(dev.getSubtotal());
					
					List<Productos> p = pDao.productoPorCodigo(movimientoDevVenta.getClave());
											
					movimientoDevVenta.setHabian(p.get(0).getExistencias());
					movimientoDevVenta.setQuedan(p.get(0).getExistencias() + movimientoDevVenta.getAdquiridos());
					movimientoDevVenta.setFecha(fecha);
					movimientoDevVenta.setHora(hora);
					movimientoDevVenta.setUtilidad(0);
					
					//Inserta Detalle de movimiento
					devolucion.insertarMovimientoDevVenta(movimientoDevVenta);
					
					p.get(0).setExistencias(movimientoDevVenta.getQuedan());
					//Inserta existencias en Productos
					pDao.actualizarTotales(p.get(0));
									
				}
				
			}catch(Exception e){
				System.out.println("Error");
				e.printStackTrace();
			}
			
			
			TicketServiceDevolucionVenta.setIdNota(idDev);
			TicketServiceDevolucionVenta.setDate(fecha);
			TicketServiceDevolucionVenta.setTime(hora);
			
			UsuarioDao usuario = new UsuarioDao();
			PersonaDao persona = new PersonaDao();
			
			int user = usuario.getUniqueUsuario(request.getParameter("txtUsuario").toString().trim()).getIdPersona();
			String nombre = persona.getPersonabyId(user).get(0).getNombre();
			
			TicketServiceDevolucionVenta.setUserPerson(nombre);
			TicketServiceDevolucionVenta.setItemsDetail(detalle);
			TicketServiceDevolucionVenta.setSubtotal(Float.toString(subtotal));
			
			TicketServiceDevolucionVenta.setIva(Float.toString(iva));
			float total = subtotal + iva;
			TicketServiceDevolucionVenta.setTotal(Float.toString(total));
			TicketServiceDevolucionVenta.setDescuento("0.00");
			
						
		}
	}

}
