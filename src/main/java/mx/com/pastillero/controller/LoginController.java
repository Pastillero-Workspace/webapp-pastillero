package mx.com.pastillero.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mx.com.pastillero.types.Types;
import mx.com.pastillero.model.dao.PersonaDao;
import mx.com.pastillero.model.dao.SesionDao;
import mx.com.pastillero.model.dao.UsuarioDao;
import mx.com.pastillero.model.formBeans.Persona;
import mx.com.pastillero.model.formBeans.Sesion;
import mx.com.pastillero.model.formBeans.Usuario;

//@WebServlet("/login.jr")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginController() {
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// create session for user
		System.out.println("Login");
		String userName = request.getParameter("userName");
		String userPassword = request.getParameter("userPassword");
		Integer value = Integer.parseInt(request.getParameter("s"));
		// date and hour
		Date date = new Date();
		DateFormat hourFormat = new SimpleDateFormat("HH:mm:ss");
		String hora = hourFormat.format(date);
		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		String fecha = dateFormat.format(date);
		UsuarioDao ud = new UsuarioDao();
		Persona p = new Persona();
		PersonaDao pd = new PersonaDao();
		Usuario u = new Usuario();
		u = ud.getUniqueUsuario(userName, userPassword);
		p = pd.readUniquePersonbyId(u);
		// salesman logic for init session
		if (ud.isNullUser(u, userName, userPassword)
				&& ud.isUser(u, userName, userPassword)) {
			if (u.getPerfil().compareTo(Types.C.getStatusCode()) == 0) {
				// crea sesion para cajero: antes pregunta si hay una abierta.
				if (u.getActivo() != 1) {
					HttpSession session = request.getSession(true);
					session.setAttribute("id", 1);
					session.setAttribute("usuario", u.getUsuario());
					session.setAttribute("iduser", u.getIdUsuario());
					session.setAttribute("nombre", p.getNombre());
					session.setAttribute("apepat", p.getApellidoPat());
					session.setAttribute("apemat", p.getApellidoMat());
					session.setAttribute("fecha", fecha);
					session.setAttribute("hora", hora);
					session.setAttribute("perfil", u.getPerfil());
					session.setAttribute("numero", 1);
					session.setAttribute("activo", u.getActivo());
					// setting up : cajero is activo
					u.setActivo(1);
					boolean res = ud.updateUsuario(u);
					if (res) {
						if (value.intValue() == 0)
							session.setAttribute("numero", 1);
						else
							session.setAttribute("numero", 2);
						response.sendRedirect("welcome.jsp");
					}
				} else
					response.sendRedirect("errorsesion.jsp");
			}
			if (u.getPerfil().compareTo(Types.V.getStatusCode()) == 0) {
				// verify if "cajero" is active.
				List<Usuario> lu = ud.readUserActive();
				if (!lu.isEmpty()) {
					int data_1 = 0;
					System.out.println("Perfil:" + u.getPerfil() + " "
							+ u.getIdUsuario());
					HttpSession session = request.getSession(true);
					session.setAttribute("id", 1);
					session.setAttribute("usuario", u.getUsuario());
					session.setAttribute("iduser", u.getIdUsuario());
					session.setAttribute("nombre", p.getNombre());
					session.setAttribute("apepat", p.getApellidoPat());
					session.setAttribute("apemat", p.getApellidoMat());
					session.setAttribute("fechaini", fecha);
					session.setAttribute("hora", hora);
					session.setAttribute("perfil", u.getPerfil());
					session.setAttribute("numero", 1);
					session.setAttribute("activo", u.getActivo());
					// create new session if value == 0
					if (value.intValue() == 0) {
						session.setAttribute("numero", 1);
						Sesion ss = new Sesion();
						ss.setIdUsuario(u.getIdUsuario());
						ss.setUsuario(u.getUsuario());
						ss.setFechaIngreso(fecha);
						ss.setHoraIngreso(hora);
						SesionDao sd = new SesionDao();
						// save session
						data_1 = sd.createSession(ss).intValue();
						if (data_1 != 0) {
							session.setAttribute("idSesion", data_1);
						}
					}
					// if not, update the session only
					else {
						session.setAttribute("numero", 2);
						session.setAttribute("idSesion", value);
					}
					response.sendRedirect("welcomeusrv.jsp");
				} else
					response.sendRedirect("errorcajero.jsp");
			}
			if (u.getPerfil().compareTo(Types.A.getStatusCode()) == 0) {
				int data_1 = 0;
				HttpSession session = request.getSession(true);
				session.setAttribute("id", 1);
				session.setAttribute("usuario", u.getUsuario());
				session.setAttribute("iduser", u.getIdUsuario());
				session.setAttribute("nombre", p.getNombre());
				session.setAttribute("apepat", p.getApellidoPat());
				session.setAttribute("apemat", p.getApellidoMat());
				session.setAttribute("fechaini", fecha);
				session.setAttribute("hora", hora);
				session.setAttribute("perfil", u.getPerfil());
				session.setAttribute("numero", 1);
				session.setAttribute("activo", u.getActivo());
				// create new session if value == 0
				if (value.intValue() == 0) {
					session.setAttribute("numero", 1);
					Sesion ss = new Sesion();
					ss.setIdUsuario(u.getIdUsuario());
					ss.setUsuario(u.getUsuario());
					ss.setFechaIngreso(fecha);
					ss.setHoraIngreso(hora);
					SesionDao sd = new SesionDao();
					// save session
					data_1 = sd.createSession(ss).intValue();
					if (data_1 != 0) {
						session.setAttribute("idSesion", data_1);
					}
				}
				// if not, update the session only
				else {
					session.setAttribute("numero", 2);
					session.setAttribute("idSesion", value);
				}
				response.sendRedirect("welcomeusra.jsp");
			}
		} else
			response.sendRedirect("errorlogin.jsp");
	}
}