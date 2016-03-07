package mx.com.pastillero.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;

import mx.com.pastillero.model.dao.TemporalesDao;
import mx.com.pastillero.model.formBeans.TemporalNotaVenta;
import mx.com.pastillero.model.formBeans.TemporalProductoVenta;
import mx.com.pastillero.model.formBeans.TemporalTotalesVenta;

/**
 * Servlet implementation class TemporalesController
 */

public class TemporalesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(TemporalesController.class);
	
	TemporalesDao temporal = new TemporalesDao();
	TemporalNotaVenta notaVenta = new TemporalNotaVenta();
	TemporalProductoVenta productoVenta = new TemporalProductoVenta();
    TemporalTotalesVenta totalesVenta = new TemporalTotalesVenta();   
    List<TemporalTotalesVenta> listTotalesVenta = new ArrayList<TemporalTotalesVenta>();
    List<TemporalNotaVenta> listNotaVenta = new ArrayList<TemporalNotaVenta>();
    List<TemporalProductoVenta> productos = new ArrayList<TemporalProductoVenta>();
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TemporalesController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		if(request.getParameter("tarea").equals("notaVentaTemp")){
			
			notaVenta.setFolio(Integer.parseInt(request.getParameter("txtFolio").trim()));
			notaVenta.setCaja(request.getParameter("txtCaja").trim());
			notaVenta.setCajero(request.getParameter("txtCajero").trim());
			notaVenta.setUsuario(request.getParameter("txtUsuario").trim());
			notaVenta.setCliente(0);
			notaVenta.setDescripcion("NINGUNO");
			
			temporal.guardarNotaVentaTemporal(notaVenta);
			
		}
		else if(request.getParameter("tarea").equals("actNotaVentaTemp")){
			notaVenta.setFolio(Integer.parseInt(request.getParameter("txtFolio").trim()));
			notaVenta.setCliente(Integer.parseInt(request.getParameter("txtCliente").trim()));
			notaVenta.setDescripcion(request.getParameter("txtDescripcion").trim());
			
			temporal.actualizarNotaVentaTemporal(notaVenta);
		}
		else if(request.getParameter("tarea").equals("productoVentaTemp")){
			productoVenta.setNota(Integer.parseInt(request.getParameter("txtFolio").trim()));
			productoVenta.setCodigo(request.getParameter("txtCodigo").trim());
			productoVenta.setDescripcion(request.getParameter("txtDescripcion").trim());
			productoVenta.setCantidad(Integer.parseInt(request.getParameter("txtCantidad").trim()));
			productoVenta.setPrecioPub(Float.parseFloat(request.getParameter("txtPrecioPub").trim()));
			productoVenta.setPrecioDesc(Float.parseFloat(request.getParameter("txtPrecioDesc").trim()));
			productoVenta.setSubtotal(Float.parseFloat(request.getParameter("txtSubtotal").trim()));
			
			temporal.guardarProductoVentaTemporal(productoVenta);
		
			
		}
		else if(request.getParameter("tarea").equals("totalesVentaTemp")){
			totalesVenta.setNota(Integer.parseInt(request.getParameter("txtNota").trim()));
			totalesVenta.setPrecioTotal(Float.parseFloat(request.getParameter("txtPrecioTotal").trim()));
			totalesVenta.setDescuentoTotal(Float.parseFloat(request.getParameter("txtDescuentoTotal").trim()));
			totalesVenta.setIva(Float.parseFloat(request.getParameter("txtIva").trim()));
			totalesVenta.setSubtotal(Float.parseFloat(request.getParameter("txtSubtotal").trim()));
			totalesVenta.setTotal(Float.parseFloat(request.getParameter("txtTotal").trim()));
			
			temporal.guardarTotalesVentaTemporal(totalesVenta);
		}
		else if(request.getParameter("tarea").equals("obtenerNotaVentaTemp")){
			listNotaVenta = temporal.getNota(request.getParameter("txtUsuario").trim());
			
			if(!listNotaVenta.isEmpty()){
				notaVenta = listNotaVenta.get(0);
				Gson g = new Gson();
				String json = g.toJson(notaVenta);
				
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(json);
			}else{
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write("{\"valor\":\"vacio\"}");
			}
		}
		else if(request.getParameter("tarea").equals("obtenerProductosVentaTemp")){
			productos = temporal.getProductos(Integer.parseInt(request.getParameter("txtNota").trim()));

			if(!productos.isEmpty()){
				Gson g = new Gson();
				String json = g.toJson(productos);

				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(json);
			}else{
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write("{\"valor\":\"vacio\"}");
			}
		}
		else if(request.getParameter("tarea").equals("obtenerTotalesVentaTemp")){
			try{
				listTotalesVenta = temporal.getTotales(Integer.parseInt(request.getParameter("txtNota").trim()));
				
				if(!listTotalesVenta.isEmpty()){
					totalesVenta = listTotalesVenta.get(0);
					Gson g = new Gson();
					String json = g.toJson(totalesVenta);
					
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(json);
				}else{
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write("{\"valor\":\"vacio\"}");
				}
			}catch(Exception e){
				e.printStackTrace();
				logger.info("Ocurrio un error: "+e);
			}
			
		}
		else if(request.getParameter("tarea").equals("borrarVentaTemp")){
			int nota = Integer.parseInt(request.getParameter("txtNota").trim());
						
			temporal.eliminarNotaVentaTemporal(nota);
			temporal.eliminarTotalesVentaTemporal(nota);
			temporal.eliminarProductoVentaTemporal(nota);
			logger.info("Se han eliminado datos temporales con exito, nota: "+nota);
			
		}
		else if(request.getParameter("tarea").equals("borrarProductoVentaTemp")){
			TemporalProductoVenta productoVenta = new TemporalProductoVenta();
			productoVenta.setNota(Integer.parseInt(request.getParameter("txtNota").trim()));
			productoVenta.setCodigo(request.getParameter("txtCodigo").trim());
			productoVenta.setCantidad(Integer.parseInt(request.getParameter("txtCantidad").trim()));
			
			productos = temporal.getProductoEliminar(productoVenta);
			
			if(!productos.isEmpty()){
				if(temporal.eliminarProductoVentaTemporal(productos.get(0))){
					logger.info("Se elimino producto de venta: "+productos.toString());
				}
			}
			
		}
	}

}
