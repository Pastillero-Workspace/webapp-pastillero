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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);


	public LoginController() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// create session for user
		logger.info("Iniciando sesion...");
		String userName = request.getParameter("userName");
		String userPassword = request.getParameter("userPassword");
		Integer value = Integer.parseInt(request.getParameter("s"));
		
		// date and hour
		Date date = new Date();
		DateFormat hourFormat = new SimpleDateFormat("HH:mm:ss");
		String hora = hourFormat.format(date);
		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		String fecha = dateFormat.format(date);
		
		UsuarioDao usuarioDao = new UsuarioDao();
		Persona persona = new Persona();
		PersonaDao personaDao = new PersonaDao();
		Usuario usuario = new Usuario();
		
		usuario = usuarioDao.getUniqueUsuario(userName, userPassword);
		if(usuario!=null){
			persona = personaDao.readUniquePersonbyId(usuario);
			
			// salesman logic for init session
			if (usuarioDao.isNullUser(usuario, userName, userPassword) && usuarioDao.isUser(usuario, userName, userPassword)) {
				if (usuario.getPerfil().compareTo(Types.C.getStatusCode()) == 0) {
					// crea sesion para cajero: antes pregunta si hay una abierta.
					if (usuario.getActivo() != 1) {
						HttpSession sessionCajero = request.getSession(true);
						sessionCajero.setAttribute("id", 1);
						sessionCajero.setAttribute("usuario", usuario.getUsuario());
						sessionCajero.setAttribute("iduser", usuario.getIdUsuario());
						sessionCajero.setAttribute("nombre", persona.getNombre());
						sessionCajero.setAttribute("apepat", persona.getApellidoPat());
						sessionCajero.setAttribute("apemat", persona.getApellidoMat());
						sessionCajero.setAttribute("fecha", fecha);
						sessionCajero.setAttribute("hora", hora);
						sessionCajero.setAttribute("perfil", usuario.getPerfil());
						sessionCajero.setAttribute("numero", 1);
						sessionCajero.setAttribute("activo", usuario.getActivo());
						// setting up : cajero is activo
						usuario.setActivo(1);
						boolean res = usuarioDao.updateUsuario(usuario);
						if (res) {
							if (value.intValue() == 0)
								sessionCajero.setAttribute("numero", 1);
							else
								sessionCajero.setAttribute("numero", 2);
							response.sendRedirect("welcome.jsp");
							logger.info("Sesion iniciada! "+usuario.getUsuario());
						}
					} else{
						response.sendRedirect("errorsesion.jsp");
						logger.info("Error al iniciar sesion! :(");
					}
						
				}
				else if (usuario.getPerfil().compareTo(Types.V.getStatusCode()) == 0) {
					// verify if "cajero" is active.
					List<Usuario> lu = usuarioDao.readUserActive();
					if (!lu.isEmpty()) {
						int data_1 = 0;
						logger.info("Perfil:" + usuario.getPerfil() + " "	+ usuario.getIdUsuario());
						HttpSession sessionVendedor = request.getSession(true);
						sessionVendedor.setAttribute("id", 1);
						sessionVendedor.setAttribute("usuario", usuario.getUsuario());
						sessionVendedor.setAttribute("iduser", usuario.getIdUsuario());
						sessionVendedor.setAttribute("nombre", persona.getNombre());
						sessionVendedor.setAttribute("apepat", persona.getApellidoPat());
						sessionVendedor.setAttribute("apemat", persona.getApellidoMat());
						sessionVendedor.setAttribute("fechaini", fecha);
						sessionVendedor.setAttribute("hora", hora);
						sessionVendedor.setAttribute("perfil", usuario.getPerfil());
						sessionVendedor.setAttribute("numero", 1);
						sessionVendedor.setAttribute("activo", usuario.getActivo());
						// create new session if value == 0
						if (value.intValue() == 0) {
							sessionVendedor.setAttribute("numero", 1);
							Sesion sesion = new Sesion();
							sesion.setIdUsuario(usuario.getIdUsuario());
							sesion.setUsuario(usuario.getUsuario());
							sesion.setFechaIngreso(fecha);
							sesion.setHoraIngreso(hora);
							SesionDao sd = new SesionDao();
							// save session
							data_1 = sd.createSession(sesion).intValue();
							if (data_1 != 0) {
								sessionVendedor.setAttribute("idSesion", data_1);
							}
						}
						// if not, update the session only
						else {
							sessionVendedor.setAttribute("numero", 2);
							sessionVendedor.setAttribute("idSesion", value);
						}
						response.sendRedirect("welcomeusrv.jsp");
						logger.info("Sesion iniciada! "+usuario.getUsuario());
					} else{
						response.sendRedirect("errorcajero.jsp");
						logger.info("Error al iniciar sesion! :(");
					}
						
				}
				else if (usuario.getPerfil().compareTo(Types.A.getStatusCode()) == 0) {
					int data_1 = 0;
					HttpSession sessionAdmin = request.getSession(true);
					sessionAdmin.setAttribute("id", 1);
					sessionAdmin.setAttribute("usuario", usuario.getUsuario());
					sessionAdmin.setAttribute("iduser", usuario.getIdUsuario());
					sessionAdmin.setAttribute("nombre", persona.getNombre());
					sessionAdmin.setAttribute("apepat", persona.getApellidoPat());
					sessionAdmin.setAttribute("apemat", persona.getApellidoMat());
					sessionAdmin.setAttribute("fechaini", fecha);
					sessionAdmin.setAttribute("hora", hora);
					sessionAdmin.setAttribute("perfil", usuario.getPerfil());
					sessionAdmin.setAttribute("numero", 1);
					sessionAdmin.setAttribute("activo", usuario.getActivo());
					// create new session if value == 0
					if (value.intValue() == 0) {
						sessionAdmin.setAttribute("numero", 1);
						Sesion sesion = new Sesion();
						sesion.setIdUsuario(usuario.getIdUsuario());
						sesion.setUsuario(usuario.getUsuario());
						sesion.setFechaIngreso(fecha);
						sesion.setHoraIngreso(hora);
						SesionDao sd = new SesionDao();
						// save session
						data_1 = sd.createSession(sesion).intValue();
						if (data_1 != 0) {
							sessionAdmin.setAttribute("idSesion", data_1);
						}
					}
					// if not, update the session only
					else {
						sessionAdmin.setAttribute("numero", 2);
						sessionAdmin.setAttribute("idSesion", value);
					}
					response.sendRedirect("welcomeusra.jsp");
					logger.info("Sesion iniciada! "+usuario.getUsuario());
				}
			} else{
				response.sendRedirect("errorlogin.jsp");
				logger.info("Error al iniciar sesion! :(");
			}
		}else{
			logger.info("Usuario o Contraseña invalidos: Verifique sus datos de acceso");
			response.sendRedirect("index.jsp");
		}
		
		
		
			
	}
}