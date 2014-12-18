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
	
	
	
	public ConsultaNotaController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("tarea").equals("mostrar")){
			DevolucionesDao dev = new DevolucionesDao();
			List<Object[]> venta = dev.mostrarVentas();
			Gson g = new Gson();
			String json = g.toJson(venta);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			 
			
		}
		else if(request.getParameter("tarea").equals("consultar")){
			logger.info("Buscando Notas...");
			DevolucionesDao dev  = new DevolucionesDao();
			
			String	fechaIni = request.getParameter("txtFechaIni").trim();
			String	fechaFin = request.getParameter("txtFechaFin").trim();
			
			List<Object[]> consulta = dev.consultarNota(fechaIni, fechaFin);
			 
			Gson g = new Gson();
			String json = g.toJson(consulta);
			
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			logger.info("Notas encontradas con Exito!");
		}
	}

}
