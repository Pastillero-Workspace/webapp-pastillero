package mx.com.pastillero.controller;

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
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mx.com.pastillero.model.dao.MovimientoRecepcionDao;
import mx.com.pastillero.model.dao.ProductosDao;
import mx.com.pastillero.model.dao.RecepcionDao;
import mx.com.pastillero.model.formBeans.MovimientoRecepcion;
import mx.com.pastillero.model.formBeans.Productos;
import mx.com.pastillero.model.formBeans.Recepcion;

public class RecepcionController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(RecepcionController.class);

	List<MovimientoRecepcion> altaProducto = new ArrayList<MovimientoRecepcion>();
		
	public RecepcionController(){
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
}

/**
 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
 */
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	/*Verificar primero que exista usuario y que este activo */
	
	
	if(request.getParameter("tarea").equals("cargar")){
		int idRecepcion;
		
		//System.out.println("Lista antes de limpiar: "+altaProducto.size());
		altaProducto.clear();
		//System.out.println("Lista antes de limpiar: "+altaProducto.size());
		
		Recepcion r = new Recepcion();
		RecepcionDao rDao= new RecepcionDao();
		r.setNumFactura("");
		r.setFecha("");
		r.setHora("");
		r.setDesc1((float) 0);
		r.setDesc2((float)0);
		r.setFolioElectronico(0);
		r.setNotaFactura(0);
		r.setSubtotal((float)0);
		r.setEstado(0);
		r.setIdUsuario(2);
		r.setIdProveedor(1);
		
		idRecepcion = rDao.guardarRecepcion(r);
		response.getWriter().write(Integer.toString(idRecepcion));
		
		logger.info("No. de Recepcion obtenida con Exito!: "+idRecepcion);
	}
	
	else if(request.getParameter("tarea").equals("buscar")){
		//String codigo = request.getParameter("txtCodigo");
		StringBuilder codigo = new StringBuilder(request.getParameter("txtCodigo").trim());
		int tamaño = codigo.length();
    	if(tamaño < 16){
    		int falta = 16 - tamaño;
    		for(int i = 0; i < falta; i++){
    			codigo.insert(0,'0');
    		}
    	}
    	logger.info("Buscando producto "+codigo+"...");
		List<Object[]> producto = new ProductosDao().isProducto(codigo.toString());
		if(producto.isEmpty()){
			logger.info("El producto no existe");
			response.getWriter().write("0");
		}
		else{
			String datos = null;
			datos = producto.get(0)[0].toString()+"~"+producto.get(0)[1].toString()+"~"+producto.get(0)[2].toString();
			logger.info("Producto encontrado!: "+datos);	
			response.getWriter().write(datos);
		}
		
		///response.sendRedirect("recepcion.jsp");
	}
	
	else if(request.getParameter("tarea").equals("guardar")){
		logger.info("Guardando recepcion...");
				
		Date date = new Date();
		DateFormat hora = new SimpleDateFormat("HH:mm:ss");
		Recepcion recepcion = new Recepcion();
		recepcion.setNumFactura(request.getParameter("txtFactura").trim());
		recepcion.setFecha(request.getParameter("txtFecha").trim());
		recepcion.setHora(hora.format(date));
		recepcion.setDesc1(Float.parseFloat(request.getParameter("txtDescuento1").trim()));
		recepcion.setDesc2(Float.parseFloat(request.getParameter("txtDescuento2").trim()));
		recepcion.setFolioElectronico(Integer.parseInt(request.getParameter("txtFolioE").trim()));
		recepcion.setNotaFactura(Integer.parseInt(request.getParameter("chBoxNota")));
		String lblSubtotal = request.getParameter("lblSubtotal");
		//String lblSubtotal = lblSubtotal1.substring(2);
		recepcion.setSubtotal(Float.parseFloat(lblSubtotal));
		//recepcion.setSubtotal(Float.parseFloat(request.getParameter("lblSubtotal")));
		recepcion.setEstado(1);
		RecepcionDao r = new RecepcionDao();
		recepcion.setIdUsuario(r.idUsuario(request.getParameter("txtUsuario").trim()));
		recepcion.setIdProveedor(r.idProveedor(request.getParameter("txtProveedor").trim()));
			
		r.actualizarRecepcion(recepcion);
		logger.info("Recepcion Guardada!");
		
		JSONParser parser = new JSONParser();
		Object productos;
		String tblProductos = request.getParameter("tblProductos");
				
		
		try {
			productos = parser.parse(tblProductos);
			JSONArray arrayProductos = (JSONArray) productos;
			MovimientoRecepcionDao movRecpDao = new MovimientoRecepcionDao();
			ProductosDao prDao = new ProductosDao();
			
			for(int i=0; i<arrayProductos.size();i++){
				JSONObject pr = (JSONObject)arrayProductos.get(i);
				
				MovimientoRecepcion movimientoRecepcion = new MovimientoRecepcion();
				ProductosDao pDao = new ProductosDao();

				movimientoRecepcion.setTipo("RECEPCION");
				movimientoRecepcion.setIdNota(Integer.parseInt(request.getParameter("txtNota").trim()));
				movimientoRecepcion.setDocumento(request.getParameter("txtFactura").trim());
				movimientoRecepcion.setClave(pr.get("Codigo").toString().trim());
				movimientoRecepcion.setDescripcion(pr.get("Descripcion").toString().trim());
				movimientoRecepcion.setAdquiridos(Integer.parseInt(pr.get("Cant").toString().trim()));
				movimientoRecepcion.setVendidos(0);
				movimientoRecepcion.setValor(Float.parseFloat(pr.get("Costo").toString().trim()));
				
				List<Productos> p = pDao.productoPorCodigo(movimientoRecepcion.getClave());
				p.get(0).getExistencias();
				movimientoRecepcion.setHabian(p.get(0).getExistencias());
				movimientoRecepcion.setQuedan(p.get(0).getExistencias()+movimientoRecepcion.getAdquiridos());
				
				movimientoRecepcion.setFecha(request.getParameter("txtFecha").trim());
				movimientoRecepcion.setHora(hora.format(date));
				movimientoRecepcion.setUtilidad((float)(0));
				
				altaProducto.add(movimientoRecepcion);
				
				//Se guardara a la base de datos
				List<Productos> producto = prDao.productoPorCodigo(movimientoRecepcion.getClave());
				Productos prod = new Productos();
				
				prod.setIdProducto(producto.get(0).getIdProducto());
				prod.setExistencias(movimientoRecepcion.getQuedan());
				prDao.actualizarExistencias(prod);
				logger.info("Existencias Actualizadas!");
				movRecpDao.guardarMovimientoRecepcion(movimientoRecepcion);
				logger.info("Movimiento guardado!");
				prod = null;
				producto = null;
				movimientoRecepcion = null;
				
								
			}
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
				
		//Se guardara a la base de datos
		/*MovimientoRecepcionDao movRecpDao = new MovimientoRecepcionDao();
		ProductosDao prDao = new ProductosDao();
		for(MovimientoRecepcion movimiento:altaProducto){
			List<Productos> producto = prDao.productoPorCodigo(movimiento.getClave());
			Productos prod = new Productos();
			
			prod.setIdProducto(producto.get(0).getIdProducto());
			prod.setExistencias(movimiento.getQuedan());
			System.out.println(prod.toString());
			prDao.actualizarproducto(prod);
			System.out.println(movimiento.toString());
			movRecpDao.guardarMovimientoRecepcion(movimiento);
			prod = null;
			producto = null;
		}*/
		altaProducto.clear();
		
		
	}
	
	}

}
