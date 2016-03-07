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
import mx.com.pastillero.model.dao.MovimientoRecepcionDao;
import mx.com.pastillero.model.dao.ProductosDao;
import mx.com.pastillero.model.dao.ProveedorDireccionDao;
import mx.com.pastillero.model.dao.RecepcionDao;
import mx.com.pastillero.model.formBeans.Antibioticos;
import mx.com.pastillero.model.formBeans.AntibioticosCopy;
import mx.com.pastillero.model.formBeans.MovimientoRecepcion;
import mx.com.pastillero.model.formBeans.Productos;
import mx.com.pastillero.model.formBeans.Recepcion;

public class RecepcionController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(RecepcionController.class);
	
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
		try{
			int idRecepcion;
			
			Recepcion r = new Recepcion();
			RecepcionDao rDao= new RecepcionDao();
			r.setNumFactura("");
			r.setFecha("2000-01-01");
			r.setHora("");
			r.setDesc1((float) 0);
			r.setDesc2((float)0);
			r.setFolioElectronico(0);
			r.setNotaFactura(0);
			r.setSubtotal((float)0);
			r.setIva((float)0);
			r.setIeps((float)0);
			r.setIeps2((float)0);
			r.setTotal((float)0);
			r.setEstado(0);
			r.setIdUsuario(rDao.idUsuario(request.getParameter("txtUsuario").trim()));
			r.setIdProveedor(1);
			
			idRecepcion = rDao.guardarRecepcion(r);
			response.getWriter().write(Integer.toString(idRecepcion));
			
			logger.info("No. de Recepcion obtenida con Exito!: "+idRecepcion);
		}catch(Exception e){
			logger.info("Error_al cargar datos de recepcion. "+e);
			e.printStackTrace();
		}
	}
	
	else if(request.getParameter("tarea").equals("buscar")){
		try{
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
				         // descripcion,                        iva,                             ieps,                             ieps2,                              costo
				datos = producto.get(0)[0].toString()+"~"+producto.get(0)[1].toString()+"~"+producto.get(0)[2].toString()+"~"+producto.get(0)[3].toString()+"~"+producto.get(0)[4].toString();
							
				logger.info("Producto encontrado!: "+datos);	
				response.getWriter().write(datos);
			}
		}catch(Exception e){
			logger.info("Error al buscar producto "+e);
		}
		
	}
	
	else if(request.getParameter("tarea").equals("guardar")){
		try{
			logger.info("Guardando recepcion...");
			
			Date date = new Date();
			DateFormat hora = new SimpleDateFormat("HH:mm:ss");
			Recepcion recepcion = new Recepcion();
			
			String[] fecha1 = request.getParameter("txtFecha").trim().split("-");
			String fecha = fecha1[2]+"-"+fecha1[1]+"-"+fecha1[0];
			
			recepcion.setNumFactura(request.getParameter("txtFactura").trim().toUpperCase());
			recepcion.setFecha(fecha);
			recepcion.setHora(hora.format(date));
			recepcion.setDesc1(Float.parseFloat(request.getParameter("txtDescuento1").trim()));
			recepcion.setDesc2(Float.parseFloat(request.getParameter("txtDescuento2").trim()));
			recepcion.setFolioElectronico(Integer.parseInt(request.getParameter("txtFolioE").trim()));
			recepcion.setNotaFactura(Integer.parseInt(request.getParameter("chBoxNota")));
			//String lblSubtotal = request.getParameter("lblSubtotal").trim();
			//recepcion.setSubtotal(Float.parseFloat(lblSubtotal));
			recepcion.setSubtotal(Float.parseFloat(request.getParameter("lblSubtotal").trim()));
			recepcion.setIva(Float.parseFloat(request.getParameter("lblIva").trim()));
			recepcion.setIeps(Float.parseFloat(request.getParameter("lblIeps1").trim()));
			recepcion.setIeps2(Float.parseFloat(request.getParameter("lblIeps2").trim()));
			recepcion.setTotal(Float.parseFloat(request.getParameter("lblTotal").trim()));
			recepcion.setEstado(1);
			RecepcionDao r = new RecepcionDao();
			recepcion.setIdUsuario(r.idUsuario(request.getParameter("txtUsuario").trim()));
			//recepcion.setIdProveedor(r.idProveedor(request.getParameter("txtProveedor").trim().toUpperCase()));
			int proveedor = Integer.parseInt(request.getParameter("txtProveedor").trim());
			recepcion.setIdProveedor(proveedor);
			
			//Guarda datos de recepcion actualizados
			r.actualizarRecepcion(recepcion);
			logger.info("Recepcion Guardada!");
			
			JSONParser parser = new JSONParser();
			Object productos;
			String tblProductos = request.getParameter("tblProductos");
			
			productos = parser.parse(tblProductos);
			JSONArray arrayProductos = (JSONArray) productos;
			MovimientoRecepcionDao movRecpDao = new MovimientoRecepcionDao();
			ProductosDao prDao = new ProductosDao();
			AntibioticoDao antibDao = new AntibioticoDao();
			
			//Parsea cada producto y lo guarda en tabla de movimientos
			for(int i=0; i<arrayProductos.size();i++){
				JSONObject pr = (JSONObject)arrayProductos.get(i);
				
				MovimientoRecepcion movimientoRecepcion = new MovimientoRecepcion();
				ProductosDao pDao = new ProductosDao();

				movimientoRecepcion.setTipo("RECEPCION");
				movimientoRecepcion.setIdNota(Integer.parseInt(request.getParameter("txtNota").trim()));
				movimientoRecepcion.setDocumento(request.getParameter("txtFactura").trim().toUpperCase());
				movimientoRecepcion.setClave(pr.get("Codigo").toString().trim());
				//movimientoRecepcion.setDescripcion(pr.get("Descripcion").toString().trim().toUpperCase());
				movimientoRecepcion.setAdquiridos(Integer.parseInt(pr.get("Cant").toString().trim()));
				movimientoRecepcion.setVendidos(0);
				movimientoRecepcion.setValor(0); //Se actualiza mas adelante con el costo total del producto
				
				List<Productos> p = pDao.productoPorCodigo(movimientoRecepcion.getClave());
				movimientoRecepcion.setHabian(p.get(0).getExistencias());
				movimientoRecepcion.setQuedan(p.get(0).getExistencias() + movimientoRecepcion.getAdquiridos());
				
				movimientoRecepcion.setFecha(fecha);
				movimientoRecepcion.setHora(hora.format(date));
				movimientoRecepcion.setUtilidad((float)(0));
				
				//Se guardara a la base de datos
				List<Productos> producto = prDao.productoPorCodigo(movimientoRecepcion.getClave());
				Productos prod = new Productos();
				
				int isIva = 0;
				int isIeps = 0;
				int isIeps2 = 0;
				
				isIva = Integer.parseInt(pr.get("IVA").toString().trim());
				isIeps =  Integer.parseInt(pr.get("IEPS1").toString().trim());
				isIeps2 = Integer.parseInt(pr.get("IEPS2").toString().trim());
				
				float costo = Float.parseFloat(pr.get("Costo").toString().trim());
				float ultimoCosto = 0;
				float iva = 0;
				float ieps = 0;
				float ieps2 = 0;
				
				if(isIva == 1){
					iva = (float) (costo * 0.16);		
				}
				if(isIeps == 1){
					ieps = (float) (costo * 0.25);
					iva += (costo * 0.25) * 0.16;
				}
				if(isIeps2 == 1){
					ieps2 = (float) (costo * 0.08);
				}
				ultimoCosto = costo + iva + ieps + ieps2;
				
				movimientoRecepcion.setValor(ultimoCosto); //Verificar mas adelante si es correcto, ya que de esta manera cada vez que se agrega su costo incrementa
				movRecpDao.guardarMovimientoRecepcion(movimientoRecepcion);
				logger.info("Movimiento guardado!");
				
				ProveedorDireccionDao proveDao = new ProveedorDireccionDao();
				prod.setIdProducto(producto.get(0).getIdProducto());
				prod.setExistencias(movimientoRecepcion.getQuedan());
				prod.setUltimocosto(ultimoCosto);
				prod.setCosto(costo);
				prod.setUltimoproveedor(proveDao.getNombreProveedor(proveedor).get(0).getNombre().toUpperCase());
				
				logger.info("Actualizando Existencias...");
				logger.info("Codigo: "+producto.get(0).getCodBar()+" Habian: "+producto.get(0).getExistencias());
				prDao.actualizarExistencias(prod);
				producto = prDao.productoPorCodigo(movimientoRecepcion.getClave());
				logger.info("Codigo: "+producto.get(0).getCodBar()+" Quedan: "+producto.get(0).getExistencias());
				logger.info("Existencias Actualizadas!");
				
				//Verifica si producto es antibiotico, si es antibiotico guarda el producto en tabla antibioticos
				if (antibDao.isAntibiotico(movimientoRecepcion.getClave())) {
					AntibioticosCopy antibioticoCopy = new AntibioticosCopy();
					Antibioticos antibiotico = new Antibioticos();
					antibioticoCopy.setAdquiridos(movimientoRecepcion.getAdquiridos());
					antibioticoCopy.setDocumento(Integer.toString(movimientoRecepcion.getIdNota())); // id de la nota
					antibioticoCopy.setFecha(movimientoRecepcion.getFecha());
					antibioticoCopy.setIdMedico(1);													// id por default *temporal
					antibioticoCopy.setIdProducto(p.get(0).getIdProducto());
					antibioticoCopy.setQuedan(movimientoRecepcion.getQuedan());
					antibioticoCopy.setReceta(0);
					antibioticoCopy.setSello(0);
					antibioticoCopy.setVendidos(0);
					antibioticoCopy.setHabian(movimientoRecepcion.getHabian());
					antibioticoCopy.setIdProveedor(recepcion.getIdProveedor());
					
					antibiotico.setAdquiridos(movimientoRecepcion.getAdquiridos());
					antibiotico.setDocumento(Integer.toString(movimientoRecepcion.getIdNota())); // id de la nota
					antibiotico.setFecha(movimientoRecepcion.getFecha());
					antibiotico.setIdMedico(1);													// id por default *temporal
					antibiotico.setIdProducto(p.get(0).getIdProducto());
					antibiotico.setQuedan(movimientoRecepcion.getQuedan());
					antibiotico.setReceta(0);
					antibiotico.setSello(0);
					antibiotico.setVendidos(0);
					antibiotico.setHabian(movimientoRecepcion.getHabian());
					antibiotico.setIdProveedor(recepcion.getIdProveedor());

					antibDao.guardarAntibiotico(antibiotico,antibioticoCopy);
					
					logger.info("Antibiotico guardado: "+antibiotico.getIdProducto());
					antibiotico = null;
				}
				
				prod = null;
				producto = null;
				movimientoRecepcion = null;
			}
		}catch(Exception e){
			logger.info("Error al guardar recepcion "+e);
			e.printStackTrace();
		}
	 }
  }
}
