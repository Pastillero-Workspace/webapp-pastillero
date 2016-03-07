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

import mx.com.pastillero.model.dao.PersonaDao;
import mx.com.pastillero.model.dao.RolesDao;
import mx.com.pastillero.model.dao.SesionDao;
import mx.com.pastillero.model.dao.UserChangeDao;
import mx.com.pastillero.model.dao.UserRolDao;
import mx.com.pastillero.model.dao.UsuarioDao;
import mx.com.pastillero.model.formBeans.Persona;
import mx.com.pastillero.model.formBeans.Sesion;
import mx.com.pastillero.model.formBeans.Usuario;
import mx.com.pastillero.types.Types;

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
		logger.info("Iniciando sesion...");
		String userName = request.getParameter("userName");
		String userPassword = request.getParameter("userPassword");
		Integer value = Integer.parseInt(request.getParameter("s"));
	    /**Create objects and user **/
		Date date = new Date();
		DateFormat hourFormat = new SimpleDateFormat("HH:mm:ss");
		String hora = hourFormat.format(date);
		DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		String fecha = dateFormat.format(date);
		/**Create object **/
		UsuarioDao usuarioDao = new UsuarioDao();
		Persona persona = new Persona();
		PersonaDao personaDao = new PersonaDao();
		Usuario usuario = new Usuario();
		usuario = usuarioDao.getUniqueUsuario(userName, userPassword);
		if(usuario!=null){
			persona = personaDao.readUniquePersonbyId(usuario);		
			// logica para obtener los permisos de usuario			
			UserRolDao rsd = new UserRolDao();		
			RolesDao rdao = new RolesDao();
			String a = rdao.getListaRolesFilter(rsd.getPermisosbyUser(usuario,0)); // obtiene los permisos efectivos de usuario
			String b = rdao.getListaRoles(); // obtiene la lista de todos los permisos para el usuario					
			if (usuarioDao.isNullUser(usuario, userName, userPassword) && usuarioDao.isUser(usuario, userName, userPassword)) 
			{	
				List<Usuario> lu = usuarioDao.readUserActive(usuario.getPerfil());
				List<Usuario> l = usuarioDao.readUserActive();
				boolean choice = false;
				if(!usuario.getPerfil().isEmpty() && !lu.isEmpty() && value == 0) { 	
				   request.setAttribute("u", usuario.getUsuario());
				   request.getRequestDispatcher("errorsesion.jsp").forward(request, response);
				   logger.info("Error al iniciar sesion! :(");	
				}
				else {
					if(l.isEmpty() && usuario.getPerfil().compareTo(Types.V.getStatusCode())==0){
						logger.info("Aviso de sesion cajero !!!");
						response.sendRedirect("errorcajero.jsp");	
					}				
					else
					    choice = true;
				}				
				if(choice){
					int data_1 = 0;
					HttpSession sessionBean = request.getSession(true);
					sessionBean.setAttribute("id", 1);
					sessionBean.setAttribute("usuario",usuario.getUsuario());
					sessionBean.setAttribute("iduser", usuario.getIdUsuario());
					sessionBean.setAttribute("nombre", persona.getNombre());
					sessionBean.setAttribute("apepat", persona.getApellidoPat());
					sessionBean.setAttribute("apemat", persona.getApellidoMat());
					sessionBean.setAttribute("fecha", fecha);
					sessionBean.setAttribute("hora", hora);
					sessionBean.setAttribute("perfil", usuario.getPerfil());
					sessionBean.setAttribute("numero", 1);
					sessionBean.setAttribute("scr", usuario.getSucursal());	
					sessionBean.setAttribute("a",a);
					sessionBean.setAttribute("b",b);				
					sessionBean.setAttribute("activo", 1);
					/** logica para limpiar control de permiso : Evita que aparezca el popup al inicio de sesion**/
					UserChangeDao usc = new UserChangeDao();
					boolean r = usc.setChange(usuario.getIdUsuario(),0);
				    if(r){
				    	if(sessionBean != null){	    		
				    		sessionBean.setAttribute("pv", 0);
					    	logger.info("Control de permisos actualizado !!!");	
				    	}
				    }				
					usuario.setActivo(usuario.getActivo()+1);			
					boolean res = usuarioDao.updateUsuario(usuario);
						if (res) {
							if (value.intValue() == 0) {
								sessionBean.setAttribute("numero", 1);
								Sesion sesion = new Sesion();
								sesion.setIdUsuario(usuario.getIdUsuario());
								sesion.setUsuario(usuario.getUsuario());
								sesion.setFechaIngreso(fecha);
								sesion.setHoraIngreso(hora);
								SesionDao sd = new SesionDao();
								// save session
								data_1 = sd.createSession(sesion).intValue();
								if (data_1 != 0) 
								sessionBean.setAttribute("idSesion", data_1);
								response.sendRedirect("welcome.jsp");
								logger.info("Sesion iniciada! "+usuario.getUsuario());
							}
							else {
								sessionBean.setAttribute("numero", 2);
								sessionBean.setAttribute("idSesion", value);
								response.sendRedirect("welcome.jsp");
							}
							
						} // end create sesion					
			 } // end choice

			} 
			else{
				response.sendRedirect("errorlogin.jsp");
				logger.info("Error al iniciar sesion! :(");
			}
					
		} // user null
		else{
			response.sendRedirect("errorlogin.jsp");
			logger.info("Error al iniciar sesion! :(");
		}
	
	}
}
