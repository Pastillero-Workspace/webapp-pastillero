package mx.com.pastillero.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.com.pastillero.model.dao.DevolucionesDao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;

public class ConsultaNotaController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(ConsultaNotaController.class);
	DevolucionesDao devolucion  = new DevolucionesDao();
		
	public ConsultaNotaController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(request.getParameter("tarea").equals("mostrar")){
			List<Object[]> venta = devolucion.mostrarVentas();
			Gson g = new Gson();
			String json = g.toJson(venta);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			 
			
		}
		else if(request.getParameter("tarea").equals("consultar")){
			logger.info("Buscando Notas...");
					
			//String	fechaIni = request.getParameter("txtFechaIni").trim();
			//String	fechaFin = request.getParameter("txtFechaFin").trim();
			
			String[] fechaIni1 = request.getParameter("txtFechaIni").trim().split("-");
			String fechaIni = fechaIni1[2]+"-"+fechaIni1[1]+"-"+fechaIni1[0];
			
			String[] fechaFin1 = request.getParameter("txtFechaFin").trim().split("-");
			String fechaFin = fechaFin1[2]+"-"+fechaFin1[1]+"-"+fechaFin1[0];
			
			List<Object[]> consulta = devolucion.consultarNota(fechaIni, fechaFin);
			 
			Gson g = new Gson();
			String json = g.toJson(consulta);
			
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			logger.info("Notas encontradas con Exito!");
		}
		else if(request.getParameter("tarea").equals("buscarCodigo")){
			logger.info("Buscando Recepciones por Codigo....");
			String codigo = request.getParameter("txtCodigo").trim();
			
			List<Object[]> notas = devolucion.busquedaPorCodigo(codigo);
			Gson g = new Gson();
			String json = g.toJson(notas);
			
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			logger.info("Recepciones encontradas con Exito!");
		}
		else if(request.getParameter("tarea").equals("buscarProveedor")){
			logger.info("Buscando Recepciones por Proveedor....");
			String proveedor = request.getParameter("txtProveedor").trim();
			
			List<Object[]> notas = devolucion.busquedaPorProveedor(proveedor);
			Gson g = new Gson();
			String json = g.toJson(notas);
			
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			logger.info("Recepciones encontradas con Exito!");
		}
		else if(request.getParameter("tarea").equals("buscarDocumento")){
			logger.info("Buscando Recepciones por Documento....");
			String documento = request.getParameter("txtDocumento").trim();

			List<Object[]> notas = devolucion.busquedaPorDocumento(documento);
			Gson g = new Gson();
			String json = g.toJson(notas);
			
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			logger.info("Recepciones encontradas con Exito!");
		}
	}

}
