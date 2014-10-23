package mx.com.pastillero.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.com.pastillero.model.dao.ConfiguracionSucursalDao;
import mx.com.pastillero.model.formBeans.CfgSucursal;

/**
 * Servlet implementation class CfgController
 */
@WebServlet("/CfgController")
public class CfgController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CfgController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		CfgSucursal sucursal = new CfgSucursal();
		ConfiguracionSucursalDao configuracionSucursal = new ConfiguracionSucursalDao();
		
		System.out.println("Access method succesful");
		 
		sucursal.setIdSistema(1);
		sucursal.setRazonSocial(request.getParameter("name_rs").trim().toUpperCase());
		sucursal.setRfc(request.getParameter("rfc").trim());
		sucursal.setSucursal(request.getParameter("sucursal").trim());
		sucursal.setCalle(request.getParameter("street_data").trim());
		sucursal.setColonia(request.getParameter("place_data").trim());
		sucursal.setNumeroExt(request.getParameter("numext_data").trim());
		sucursal.setNumeroInt(request.getParameter("numint_data").trim());
		sucursal.setMunicipio(request.getParameter("mtown_data").trim());
		sucursal.setEstado(request.getParameter("state_data").trim());
		sucursal.setCp(request.getParameter("cp_data").trim());
		sucursal.setTelefono(request.getParameter("tel_data").trim());
		sucursal.setEmail(request.getParameter("email_data").trim());
		sucursal.setWeb(request.getParameter("web_data").trim());
		
		
		System.out.println(sucursal.toString());
		
		configuracionSucursal.guardarSucursal(sucursal);
		
		List<CfgSucursal> datosSucursal = configuracionSucursal.mostrarSucursal();
		System.out.println("Sucursal "+datosSucursal.get(0).toString());
		
		
		response.setContentType("text/plain");          
	  	response.setCharacterEncoding("UTF-8"); 
	  	
	  	
	  	// set confirmation page 
	  	
	  	String message = "Registro agregado con éxito:";
        request.setAttribute("message", message); // This will be available as ${message}
        request.getRequestDispatcher("confirmacion.jsp").forward(request, response);

		
	}
	


}
