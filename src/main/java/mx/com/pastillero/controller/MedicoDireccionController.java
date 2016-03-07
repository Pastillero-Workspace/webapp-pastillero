package mx.com.pastillero.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.com.pastillero.model.dao.MedicoDireccionDao;
import mx.com.pastillero.model.formBeans.Direccion;
import mx.com.pastillero.model.formBeans.Medico;

public class MedicoDireccionController extends HttpServlet {
	/**
*
*/
	private static final long serialVersionUID = 1L;

	public MedicoDireccionController() {
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		/* Verificar primero que exista usuario y que este activo */
		MedicoDireccionDao medicoDireccion = new MedicoDireccionDao();
		Medico m = new Medico();
		Direccion d = new Direccion();
		if (request.getParameter("tarea").equals("agregar")) {
			d.setCalle(request.getParameter("txtCalle").trim().toUpperCase());
			d.setNoInt(request.getParameter("txtNoInt").trim().toUpperCase());
			d.setNoExt(request.getParameter("txtNoExt").trim().toUpperCase());
			d.setColonia(request.getParameter("txtColonia").trim().toUpperCase());
			d.setCiudad(request.getParameter("txtCiudad").trim().toUpperCase());
			d.setEstado(request.getParameter("txtEstado").trim().toUpperCase());
			d.setCp(Integer.parseInt(request.getParameter("txtCp").trim()));
			int idDireccion = medicoDireccion.guardarDireccion(d);
			m.setCedula(request.getParameter("txtCedula").trim());
			m.setNombre(request.getParameter("txtNombre").trim().toUpperCase());
			m.setTelFijo(request.getParameter("txtTelFijo").trim());
			m.setTelMovil(request.getParameter("txtTelMovil").trim());
			m.setEmail(request.getParameter("txtEmail").trim());
			m.setIdDireccion(idDireccion);
			medicoDireccion.guardarMedico(m);
		}
		else if (request.getParameter("tarea").equals("actualizar")) {
			List<Object[]> IdMedico = medicoDireccion.getIdMedico(request.getParameter("txtCedula").trim());
			
			m.setIdMedico(Integer.parseInt(IdMedico.get(0)[0].toString()));
			m.setIdDireccion(Integer.parseInt(IdMedico.get(0)[1].toString()));
			m.setCedula(request.getParameter("txtCedula").trim());
			m.setNombre(request.getParameter("txtNombre").trim().toUpperCase());
			m.setTelFijo(request.getParameter("txtTelFijo").trim());
			m.setTelMovil(request.getParameter("txtTelMovil").trim());
			m.setEmail(request.getParameter("txtEmail").trim());
						
			d.setIdDireccion(m.getIdDireccion());
			d.setCalle(request.getParameter("txtCalle").trim().toUpperCase());
			d.setNoInt(request.getParameter("txtNoInt").trim().toUpperCase());
			d.setNoExt(request.getParameter("txtNoExt").trim().toUpperCase());
			d.setColonia(request.getParameter("txtColonia").trim().toUpperCase());
			d.setCiudad(request.getParameter("txtCiudad").trim().toUpperCase());
			d.setEstado(request.getParameter("txtEstado").trim().toUpperCase());
			d.setCp(Integer.parseInt(request.getParameter("txtCp").trim()));
			
			medicoDireccion.actualizarMedico(m, d);
		}
		else if (request.getParameter("tarea").equals("eliminar")) {
			m.setCedula(request.getParameter("txtCedula").trim());
			List<Object[]> medico = medicoDireccion.getIdMedico(m.getCedula());
			medicoDireccion.eliminarMedico(Integer.parseInt(medico.get(0)[0].toString()));
			
		}
		// obtener los medicos de la base de datos
		else if (request.getParameter("tarea").equals("mostrar")) {
			List<Object[]> listmedico = medicoDireccion.mostrar();
			StringBuilder medico = new StringBuilder();
			for (Object[] med : listmedico) {
				medico.append(""+med[2]+",");
			}
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			String data = medico.toString();
			response.getWriter().write(data);
		}
	}
}
