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

import mx.com.pastillero.model.dao.MovimientoRecepcionDao;
import mx.com.pastillero.model.dao.ProductoDao;
import mx.com.pastillero.model.dao.ProductosDao;
import mx.com.pastillero.model.dao.RecepcionDao;
import mx.com.pastillero.model.formBeans.MovimientoRecepcion;
import mx.com.pastillero.model.formBeans.Producto;
import mx.com.pastillero.model.formBeans.Productos;
import mx.com.pastillero.model.formBeans.Recepcion;

public class RecepcionController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
		
		System.out.println("Lista antes de limpiar: "+altaProducto.size());
		altaProducto.clear();
		System.out.println("Lista antes de limpiar: "+altaProducto.size());
		
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
		
		System.out.println(idRecepcion);
	}
	if(request.getParameter("tarea").equals("capturar")){
		System.out.println("Se presiono el boton Captura");
		
	}
	if(request.getParameter("tarea").equals("buscar")){
		String codigo = request.getParameter("txtCodigo");
		
		System.out.println(codigo);
		
		StringBuilder codigo1= new StringBuilder(codigo);
    	int tamaño = codigo1.length();
    	if(tamaño<16){
    		int falta = 16 - tamaño;
    		for(int i=0; i<falta;i++){
    			codigo1.insert(0,'0');
    		}
    	}
		
		List<Object[]> producto = new ProductosDao().isProducto(codigo1.toString());
		if(producto.isEmpty()){
			System.out.println("no existe");
			response.getWriter().write("0");
		}
		else{
			System.out.println("existe");
			String datos = producto.get(0)[0].toString()+"~"+producto.get(0)[1].toString()+"~"+producto.get(0)[2].toString();
			System.out.println(datos);	
			response.getWriter().write(datos);
		}
		
		
		///response.sendRedirect("recepcion.jsp");
		
		
		
	}
	if(request.getParameter("tarea").equals("agregar")){
		Date date = new Date();
		DateFormat hora = new SimpleDateFormat("HH:mm:ss");
		
		MovimientoRecepcion movimientoRecepcion = new MovimientoRecepcion();
		movimientoRecepcion.setTipo("RECEPCION");
		movimientoRecepcion.setIdNota(Integer.parseInt(request.getParameter("txtNota").trim()));
		movimientoRecepcion.setDocumento(request.getParameter("txtFactura").trim());
		movimientoRecepcion.setClave(request.getParameter("txtCodigo").trim());
		movimientoRecepcion.setDescripcion(request.getParameter("txtDescp").trim());
		movimientoRecepcion.setAdquiridos(Integer.parseInt(request.getParameter("txtCantidad").trim()));
		movimientoRecepcion.setVendidos(0);
		movimientoRecepcion.setValor(Float.parseFloat(request.getParameter("txtCosto").trim()));
		
		ProductosDao pDao = new ProductosDao();
		List<Productos> p = pDao.productoPorCodigo(movimientoRecepcion.getClave());
		p.get(0).getExistencias();
		movimientoRecepcion.setHabian(p.get(0).getExistencias());
		movimientoRecepcion.setQuedan(p.get(0).getExistencias()+movimientoRecepcion.getAdquiridos());
		
		
//		String[] txtFecha = request.getParameter("txtFecha").split("-");
//		StringBuilder fecha = new StringBuilder();
//		for(String f:txtFecha){		
//			fecha.insert(0, f+"-");
//		}
//		fecha.deleteCharAt(fecha.length()-1);
		//movimientoRecepcion.setFecha(fecha.toString());
		movimientoRecepcion.setFecha(request.getParameter("txtFecha").trim());
		movimientoRecepcion.setHora(hora.format(date));
		
		altaProducto.add(movimientoRecepcion);
		
		System.out.println(altaProducto.size());
		
		for(MovimientoRecepcion detalle:altaProducto)
			System.out.println(detalle.toString());
 		
	}
	if(request.getParameter("tarea").equals("guardar")){
		System.out.println("Se preciono el boton guardar");
				
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
		System.out.println("Subtotal: "+lblSubtotal);
		recepcion.setSubtotal(Float.parseFloat(lblSubtotal));
		//recepcion.setSubtotal(Float.parseFloat(request.getParameter("lblSubtotal")));
		recepcion.setEstado(1);
		RecepcionDao r = new RecepcionDao();
		recepcion.setIdUsuario(r.idUsuario(request.getParameter("txtUsuario").trim()));
		recepcion.setIdProveedor(r.idProveedor(request.getParameter("txtProveedor").trim()));
		System.out.println("Recepcion "+recepcion.toString());	
		
		r.actualizarRecepcion(recepcion);
		
		
		JSONParser parser = new JSONParser();
		Object productos;
		String tblProductos = request.getParameter("tblProductos");
		System.out.println("Productos: "+tblProductos);
		
		
		
		try {
			productos = parser.parse(tblProductos);
			JSONArray arrayProductos = (JSONArray) productos;
			
			
			
			for(int i=0; i<arrayProductos.size();i++){
				JSONObject pr = (JSONObject)arrayProductos.get(i);
				
				/*System.out.println("Codigo: "+pr.get("Codigo"));
				System.out.println("Descripcion: "+pr.get("Descripcion"));
				System.out.println("Cantidad: "+pr.get("Cant"));
				System.out.println("costo: "+pr.get("Costo"));
				*/
				
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
				
				System.out.println(altaProducto.size());
				
				for(MovimientoRecepcion detalle:altaProducto)
					System.out.println(detalle.toString());
				
				
			}
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
				
		//Se guardara a la base de datos
		MovimientoRecepcionDao movRecpDao = new MovimientoRecepcionDao();
		ProductosDao prDao = new ProductosDao();
		for(MovimientoRecepcion movimiento:altaProducto){
			List<Productos> producto = prDao.productoPorCodigo(movimiento.getClave());
			Productos prod = new Productos();
			
			prod.setIdProducto(producto.get(0).getIdProducto());
			prod.setProveedor(producto.get(0).getProveedor());
			prod.setClave(producto.get(0).getClave());
			prod.setCodBar(producto.get(0).getCodBar());
			prod.setDescripcion(producto.get(0).getDescripcion());
			prod.setIdFamilia(producto.get(0).getIdFamilia());
			prod.setPrecioPub(producto.get(0).getPrecioPub());
			prod.setPrecioDesc(producto.get(0).getPrecioDesc());
			prod.setPrecioFarmacia(producto.get(0).getPrecioFarmacia());
			prod.setIva(producto.get(0).getIva());
			prod.setLinea(producto.get(0).getLinea());
			prod.setReferencia(producto.get(0).getReferencia());
			prod.setSSA(producto.get(0).getSSA());
			prod.setLaboratorio(producto.get(0).getLaboratorio());		
			prod.setDepartamento(producto.get(0).getDepartamento());
			prod.setCategoria(producto.get(0).getCategoria());
			prod.setActualizable(producto.get(0).getActualizable());
			prod.setDescuento(producto.get(0).getDescuento());
			prod.setCosto(producto.get(0).getCosto());
			prod.setEquivalencia(producto.get(0).getEquivalencia());
			prod.setSuperfamilia(producto.get(0).getSuperfamilia());
			prod.setCls(producto.get(0).getCls());
			prod.setZona(producto.get(0).getZona());
			prod.setPareto(producto.get(0).getPareto());
			prod.setIeps(producto.get(0).getIeps());
			prod.setIeps2(producto.get(0).getIeps2());
			prod.setLimitado(producto.get(0).getLimitado());
			prod.setKit(producto.get(0).getKit());
			prod.setComision(producto.get(0).getComision());
			prod.setMaxdescuento(producto.get(0).getMaxdescuento());
			prod.setGrupo(producto.get(0).getGrupo());
			prod.setAplicadescbase(producto.get(0).getAplicadescbase());
			prod.setAplicapo(producto.get(0).getAplicapo());
			prod.setAntibiotico(producto.get(0).getAntibiotico());
			//prod.setExistencias(producto.get(0).getExistencias());
			prod.setUltimoproveedor(producto.get(0).getUltimoproveedor());
			prod.setUltimocosto(producto.get(0).getUltimocosto());
			prod.setCostopromedio(producto.get(0).getCostoreal());
			prod.setCostoreal(producto.get(0).getCostoreal());
						
			
			prod.setExistencias(movimiento.getQuedan());
			System.out.println(prod.toString());
			prDao.actualizarproducto(prod);
			System.out.println(movimiento.toString());
			movRecpDao.guardarMovimientoRecepcion(movimiento);
		}
		altaProducto.clear();
		System.out.println(altaProducto.size());
		
	}
	if(request.getParameter("tarea").equals("borrar")){
		System.out.println("Se preciono el boton borrar");
		altaProducto.clear();
		System.out.println(altaProducto.size());
		
		//RecepcionDao recepcionDao = new RecepcionDao();
		//recepcionDao.getBuildSess();
		//recepcionDao.eliminar(Integer.parseInt(request.getParameter("txtIdRecepcion")));
		
		
	}
	if(request.getParameter("tarea").equals("modificar")){
		System.out.println("Se preciono el boton modificar");
		altaProducto.get(Integer.parseInt(request.getParameter("producto"))).setAdquiridos(Integer.parseInt(request.getParameter("txtCantidad").trim()));
		altaProducto.get(Integer.parseInt(request.getParameter("producto"))).setClave(request.getParameter("txtCodigo").trim());
		altaProducto.get(Integer.parseInt(request.getParameter("producto"))).setDescripcion(request.getParameter("txtDescp").trim());
		altaProducto.get(Integer.parseInt(request.getParameter("producto"))).setValor(Integer.parseInt(request.getParameter("txtCosto").trim()));
		
		ProductoDao pDao = new ProductoDao();
		List<Producto> p = pDao.productoPorCodigo(altaProducto.get(Integer.parseInt(request.getParameter("producto"))).getClave());
		p.get(0).getExistencias();
		altaProducto.get(Integer.parseInt(request.getParameter("producto"))).setHabian(p.get(0).getExistencias());
		altaProducto.get(Integer.parseInt(request.getParameter("producto"))).setQuedan(p.get(0).getExistencias()+altaProducto.get(Integer.parseInt(request.getParameter("producto"))).getAdquiridos());
		
		for(MovimientoRecepcion detalle:altaProducto)
			System.out.println(detalle.toString());
	}
	if(request.getParameter("tarea").equals("eliminar")){
		System.out.println("Se preciono el boton eliminar");
		altaProducto.remove(Integer.parseInt(request.getParameter("producto")));
		
		System.out.println(altaProducto.size());
		for(MovimientoRecepcion detalle:altaProducto)
			System.out.println(detalle.toString());
	}
				
}

}
