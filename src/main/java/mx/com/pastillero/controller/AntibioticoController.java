package mx.com.pastillero.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.com.pastillero.model.dao.AntibioticoDao;
import mx.com.pastillero.model.dao.MedicoDireccionDao;
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
			AntibioticosCopy antibiotico = new AntibioticosCopy();//new AntibioticosCopy();
			MedicoDireccionDao medicoDao = new MedicoDireccionDao();
			
			//antibiotico = antibDao.getAntibioticoById(request.getParameter("idAnt")).get(0);
			
//			antibiotico.setIdProducto(0);
//			antibiotico.setIdProveedor(0);
			String[] fecha1 = request.getParameter("txtFecha").trim().split("-");
			String fecha = fecha1[2]+"-"+fecha1[1]+"-"+fecha1[0];
			
			antibiotico.setIdAntibiotico(Integer.parseInt(request.getParameter("idAnt").trim()));
			antibiotico.setIdMedico(medicoDao.getIdMedicoByName(request.getParameter("txtMedico").trim()).get(0));
			
			antibiotico.setAdquiridos(Integer.parseInt(request.getParameter("txtAdquiridos").trim()));
			antibiotico.setDocumento(request.getParameter("txtNota").trim());
			antibiotico.setFecha(fecha);
			antibiotico.setQuedan(Integer.parseInt(request.getParameter("txtQuedan").trim()));
			antibiotico.setReceta(Integer.parseInt(request.getParameter("opcReceta").trim()));
			antibiotico.setSello(Integer.parseInt(request.getParameter("opcSello").trim()));
			antibiotico.setVendidos(Integer.parseInt(request.getParameter("txtVendidos").trim()));
			antibiotico.setHabian(Integer.parseInt(request.getParameter("txtHabian").trim()));
			
			antibDao.actualizarAntibiotico(antibiotico);
			
		}
		
	}

}
