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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mx.com.pastillero.model.dao.AntibioticoDao;
import mx.com.pastillero.model.dao.MovimientoSalidaDao;
import mx.com.pastillero.model.dao.ProductosDao;
import mx.com.pastillero.model.dao.RecepcionDao;
import mx.com.pastillero.model.dao.SalidaDao;
import mx.com.pastillero.model.formBeans.Antibioticos;
import mx.com.pastillero.model.formBeans.AntibioticosCopy;
import mx.com.pastillero.model.formBeans.MovimientoSalida;
import mx.com.pastillero.model.formBeans.Productos;
import mx.com.pastillero.model.formBeans.Salida;

public class SalidaController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(SalidaController.class);
	
	
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
			salida.setFecha("2000-01-01");
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
				String datos = producto.get(0)[0].toString()+"~"+producto.get(0)[1].toString()+"~"+producto.get(0)[2].toString()+"~"+producto.get(0)[3].toString()+"~"+producto.get(0)[4].toString()+"~"+producto.get(0)[5].toString();
				//System.out.println(datos);	
				response.getWriter().write(datos);
			}
			
		}
		
		// Bloque para guardar los datos de una salida
		if(request.getParameter("tarea").equals("guardar")){
					
			
			// Actualiza salida con datos actualizados y completos
			String[] fecha1 = request.getParameter("txtFecha").toString().trim().split("-");
			String fecha = fecha1[2]+"-"+fecha1[1]+"-"+fecha1[0];
			
			salida.setFecha(fecha);
			salida.setHora(hora.format(date));
			salida.setMerma(request.getParameter("txtMerma").trim().toUpperCase());
			salida.setNumFactura(request.getParameter("txtFactura").trim().toUpperCase());
			salida.setFolioElectronico(Integer.parseInt(request.getParameter("txtFolio").trim()));
			
			
			RecepcionDao r  = new RecepcionDao();
			salida.setIdUsuario(r.idUsuario(request.getParameter("txtResponsable").trim()));
					
			
			JSONParser parser = new JSONParser();
			Object productos;
			String tblProductos = request.getParameter("tblDatos");
			
			float subtotal = 0;
			try {
				productos = parser.parse(tblProductos);
				JSONArray arrayProductos = (JSONArray) productos;
				AntibioticoDao antibDao = new AntibioticoDao();
				
				for(int i=0; i<arrayProductos.size();i++){
					JSONObject pr = (JSONObject)arrayProductos.get(i);
					
					MovimientoSalida movimientoSalida = new MovimientoSalida();
					
					movimientoSalida.setTipo("SALIDA - "+salida.getMerma().toUpperCase());
					movimientoSalida.setIdNota(Integer.parseInt(request.getParameter("txtFolio").trim()));
					movimientoSalida.setDocumento(request.getParameter("txtFactura").trim().toUpperCase());
					movimientoSalida.setClave(pr.get("Codigo").toString());
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
					
					
					
					if (antibDao.isAntibiotico(movimientoSalida.getClave())) {
						AntibioticosCopy antibioticoCopy = new AntibioticosCopy();
						Antibioticos antibiotico = new Antibioticos();
						antibioticoCopy.setAdquiridos(0);
						antibioticoCopy.setDocumento(Integer.toString(movimientoSalida.getIdNota())); // id de la nota
						antibioticoCopy.setFecha(movimientoSalida.getFecha());
						antibioticoCopy.setIdMedico(1);													// id por default *temporal
						antibioticoCopy.setIdProducto(p.get(0).getIdProducto());
						antibioticoCopy.setQuedan(movimientoSalida.getQuedan());
						antibioticoCopy.setReceta(0);
						antibioticoCopy.setSello(0);
						antibioticoCopy.setVendidos(movimientoSalida.getVendidos());
						antibioticoCopy.setHabian(movimientoSalida.getHabian());
						antibioticoCopy.setIdProveedor(1);
						
						antibiotico.setAdquiridos(0);
						antibiotico.setDocumento(Integer.toString(movimientoSalida.getIdNota())); // id de la nota
						antibiotico.setFecha(movimientoSalida.getFecha());
						antibiotico.setIdMedico(1);													// id por default *temporal
						antibiotico.setIdProducto(p.get(0).getIdProducto());
						antibiotico.setQuedan(movimientoSalida.getQuedan());
						antibiotico.setReceta(0);
						antibiotico.setSello(0);
						antibiotico.setVendidos(movimientoSalida.getVendidos());
						antibiotico.setHabian(movimientoSalida.getHabian());
						antibiotico.setIdProveedor(1);

						antibDao.guardarAntibiotico(antibiotico,antibioticoCopy);
						
						logger.info("Antibiotico guardado: "+antibiotico.getIdProducto());
						antibiotico = null;
					}
					
					//Inserta Detalle de movimiento
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
