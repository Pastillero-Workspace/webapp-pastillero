package mx.com.pastillero.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import mx.com.pastillero.model.dao.MovimientoSalidaDao;
import mx.com.pastillero.model.dao.ProductosDao;
import mx.com.pastillero.model.dao.RecepcionDao;
import mx.com.pastillero.model.dao.SalidaDao;
import mx.com.pastillero.model.formBeans.MovimientoSalida;
import mx.com.pastillero.model.formBeans.Productos;
import mx.com.pastillero.model.formBeans.Salida;

public class SalidaController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		Salida salida = new Salida();
		SalidaDao salidaDao = new SalidaDao();
		ProductosDao pDao = new ProductosDao();
		MovimientoSalidaDao movimientoSalidaDao = new MovimientoSalidaDao();
		
		Date date = new Date();
		DateFormat hora = new SimpleDateFormat("HH:mm:ss");
		
		
		// Bloque ejecutado al cargar el jsp
		if(request.getParameter("tarea").equals("cargar")){
			int idSalida;
			salida.setFecha("");
			salida.setHora("");
			salida.setMerma("");
			salida.setNumFactura("");
			salida.setFolioElectronico(0);
			salida.setSubtotal(0);
			salida.setIdUsuario(1);
			idSalida = salidaDao.guardarSalida(salida);
			
			response.getWriter().write(Integer.toString(idSalida));
		}
		
		// Bloque ejecutado cuando se busca un producto con su codigo de barras
		if(request.getParameter("tarea").equals("buscar")){
			String codigo = request.getParameter("txtCodigo");
			
			StringBuilder codigo1= new StringBuilder(codigo);
	    	int tamaño = codigo1.length();
	    	if(tamaño<16){
	    		int falta = 16 - tamaño;
	    		for(int i=0; i<falta;i++){
	    			codigo1.insert(0,'0');
	    		}
	    	}
			
			List<Object[]> producto = new ProductosDao().isProducto(codigo1.toString());
			if(producto.isEmpty()){ // Si es verdadero el Producto no existe 
				response.getWriter().write("0");
			}
			else{
				String datos = producto.get(0)[0].toString()+"~"+producto.get(0)[1].toString()+"~"+producto.get(0)[2].toString()+"~"+producto.get(0)[3].toString()+"~"+producto.get(0)[4].toString();
				System.out.println(datos);	
				response.getWriter().write(datos);
			}
			
		}
		
		// Bloque para guardar los datos de una salida
		if(request.getParameter("tarea").equals("guardar")){
					
			System.out.println(request.getParameter("tblDatos"));
			
			// Actualiza salida con datos actualizados y completos
			salida.setFecha(request.getParameter("txtFecha").toString().trim());
			salida.setHora(hora.format(date));
			salida.setMerma(request.getParameter("txtMerma").trim());
			salida.setNumFactura(request.getParameter("txtFactura").trim());
			salida.setFolioElectronico(Integer.parseInt(request.getParameter("txtFolio").trim()));
			
			
			RecepcionDao r  = new RecepcionDao();
			salida.setIdUsuario(r.idUsuario(request.getParameter("txtResponsable")));
			System.out.println(salida.toString());
			
						
			
			JSONParser parser = new JSONParser();
			Object productos;
			String tblProductos = request.getParameter("tblDatos");
			
			float subtotal = 0;
			try {
				productos = parser.parse(tblProductos);
				JSONArray arrayProductos = (JSONArray) productos;
				
				for(int i=0; i<arrayProductos.size();i++){
					JSONObject pr = (JSONObject)arrayProductos.get(i);
					
					MovimientoSalida movimientoSalida = new MovimientoSalida();
					
					movimientoSalida.setTipo("SALIDA - "+salida.getMerma().toUpperCase());
					movimientoSalida.setIdNota(Integer.parseInt(request.getParameter("txtFolio").trim()));
					movimientoSalida.setDocumento(request.getParameter("txtFactura").trim());
					movimientoSalida.setClave(pr.get("Codigo").toString());
					movimientoSalida.setDescripcion(pr.get("Descripcion").toString());
					movimientoSalida.setAdquiridos(0);
					movimientoSalida.setVendidos(Integer.parseInt(pr.get("Cant").toString()));
					movimientoSalida.setValor(Float.parseFloat(pr.get("Costo").toString()));
					
					subtotal += Float.parseFloat(pr.get("Importe").toString());
					
					List<Productos> p = pDao.productoPorCodigo(movimientoSalida.getClave());
											
					movimientoSalida.setHabian(p.get(0).getExistencias());
					movimientoSalida.setQuedan(p.get(0).getExistencias() - movimientoSalida.getVendidos());
					movimientoSalida.setFecha(salida.getFecha());
					movimientoSalida.setHora(hora.format(date));
					movimientoSalida.setUtilidad(0);
					
					//Inserta Detalle de movimiento
					System.out.println(movimientoSalida.toString());
					movimientoSalidaDao.guardarMovimientoSalida(movimientoSalida);
					
					p.get(0).setExistencias(movimientoSalida.getQuedan());
					
					//Inserta existencias en Productos
					pDao.actualizarTotales(p.get(0));
									
				}
				
			}catch(Exception e){
				System.out.println("Error");
				e.printStackTrace();
			}
			//Revisar cantidades. Se guarda depues de movimientos para calcular subtotal 
			salida.setSubtotal(subtotal);
			salidaDao.actualizarSalida(salida);
			
		}
		
	}
	

}
