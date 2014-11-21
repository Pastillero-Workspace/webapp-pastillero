package mx.com.pastillero.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mx.com.pastillero.model.dao.ProductoFamiliaDao;

/**
 * Servlet implementation class ConsultaController
 */
//@WebServlet("/ConsultaController")
public class ConsultaController extends HttpServlet {
	private static final Logger logger = LoggerFactory.getLogger(ConsultaController.class);
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConsultaController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			logger.info("Consultando Productos...");
			List<Object[]> listConsulta = null;
			ProductoFamiliaDao consulta = new ProductoFamiliaDao();
			ObjectMapper mapper = new ObjectMapper();
			
			BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
			
			if(br!=null){
//				logger.info("datos: "+br.readLine());
				String [] parametros =br.readLine().split("&");
				
				String [] codigoTemp = parametros[0].split("=");
				String [] descripcionTemp = parametros[1].split("=");		
//				en caso de venir vacio se le asigna un valor irrelevante
//				String codigo = (codigoTemp.length==2)?codigoTemp[1]:"*";
//				String descripcion = (descripcionTemp.length==2)?descripcionTemp[1]:"<";
				
//				listConsulta = consulta.buscar(codigo, descripcion);
				
				if(codigoTemp.length==2){
					listConsulta = consulta.buscarCodigo(codigoTemp[1]);
				}else if(descripcionTemp.length==2){
					listConsulta = consulta.buscarDescripcion(descripcionTemp[1]);
				}
				
				
				
				
			}
			
			response.setContentType("application/json");
			mapper.writeValue(response.getOutputStream(), listConsulta);
			logger.info("Consulta realizada con exito!");
	}

}
