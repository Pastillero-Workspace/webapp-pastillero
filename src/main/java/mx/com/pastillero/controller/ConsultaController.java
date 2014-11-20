package mx.com.pastillero.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mx.com.pastillero.model.dao.MedicoDireccionDao;
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
		ObjectMapper mapper = new ObjectMapper();
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
		
		if(br!=null){
//			logger.info("datos: "+br.readLine());
			String [] parametros =br.readLine().split("&");
			
			String [] workout = parametros[0].split("=");
			
			if(workout.equals("getProductos")){
				List<Object[]> listConsulta = null;
				ProductoFamiliaDao consulta = new ProductoFamiliaDao();
				
				String [] codigoTemp = parametros[1].split("=");
				String [] descripcionTemp = parametros[2].split("=");		
//				en caso de venir vacio se le asigna un valor irrelevante
				
				if(codigoTemp.length==2){
					listConsulta = consulta.buscarCodigo(codigoTemp[1]);
				}else if(descripcionTemp.length==2){
					listConsulta = consulta.buscarDescripcion(descripcionTemp[1]);
				}
//				logger.info("datos: "+listConsulta.size());
				response.setContentType("application/json");
				mapper.writeValue(response.getOutputStream(), listConsulta);
			}else if(workout.equals("getMedicos")){
				List<Object> listmedico = new ArrayList<Object>();
				for (Object[] med : new MedicoDireccionDao().mostrar()) {
					listmedico.add(med[2]);
				}
				response.setContentType("application/json");
				mapper.writeValue(response.getOutputStream(), listmedico);
			}
			
		}
		
		
	}

}
