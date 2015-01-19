package mx.com.pastillero.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.com.pastillero.model.dao.AntibioticoDao;
import mx.com.pastillero.model.dao.MedicoDireccionDao;
import mx.com.pastillero.model.dao.ProveedorDireccionDao;
import mx.com.pastillero.model.formBeans.Antibioticos;
import mx.com.pastillero.model.formBeans.AntibioticosCopy;

/**
 * Servlet implementation class AntibioticoController
 */
@WebServlet("/AntibioticoController")
public class AntibioticoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AntibioticoController() {
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
		AntibioticoDao antibDao = new AntibioticoDao();
		
		if(request.getParameter("tarea").equals("actualizar")){
			AntibioticosCopy antibiotico = null;//new AntibioticosCopy();
			ProveedorDireccionDao proveedorDao = new ProveedorDireccionDao();
			MedicoDireccionDao medicoDao = new MedicoDireccionDao();
			
			antibiotico = antibDao.getAntibioticoById(request.getParameter("idAnt")).get(0);
			
//			antibiotico.setIdProducto(0);
//			antibiotico.setIdProveedor(0);
			
			antibiotico.setIdMedico(medicoDao.getIdMedicoByName(request.getParameter("txtMedico")).get(0));
			
			antibiotico.setAdquiridos(Integer.parseInt(request.getParameter("txtAdquiridos")));
			antibiotico.setDocumento(request.getParameter("txtNota"));
			antibiotico.setFecha(request.getParameter("txtFecha"));
			antibiotico.setQuedan(Integer.parseInt(request.getParameter("txtQuedan")));
			antibiotico.setReceta(Integer.parseInt(request.getParameter("opcReceta")));
			antibiotico.setSello(Integer.parseInt(request.getParameter("opcSello")));
			antibiotico.setVendidos(Integer.parseInt(request.getParameter("txtVendidos")));
			antibiotico.setHabian(Integer.parseInt(request.getParameter("txtHabian")));
			
			antibDao.actualizarAntibiotico(antibiotico);
			
		}
		
	}

}
