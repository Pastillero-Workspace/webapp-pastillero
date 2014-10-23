package mx.com.pastillero.controller;
import java.io.IOException;






import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mx.com.pastillero.types.Types;
import mx.com.pastillero.model.dao.SesionDao;
import mx.com.pastillero.model.dao.UsuarioDao;
import mx.com.pastillero.model.formBeans.Sesion;
import mx.com.pastillero.model.formBeans.Usuario;


//@WebServlet("/altaMedico.jr")
public class LogoutController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2110621566329197780L;

	/**
	 * 
	 */
	
	public LogoutController(){
		
	}
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
}

/**
 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
 */
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
	        // close sesión normally
			if(request.getParameter("workout").equals("exits"))
			{
				HttpSession sesion = request.getSession(false);				
				// Getting data from user:					
				String usuario = (String)sesion.getAttribute("usuario");
			//	String nombre = (String)sesion.getAttribute("nombre");
				Integer idSesion = (Integer)sesion.getAttribute("idSesion");
			//	String perfil = (String)sesion.getAttribute("perfil");
				Integer iduser    = (Integer)sesion.getAttribute("iduser");
				
				int idLocalSesion = Integer.parseInt(request.getParameter("idLocalSesion"));
				System.out.println("sesion id: "+idLocalSesion);
				Usuario u = new Usuario();
				UsuarioDao ud = new UsuarioDao();
				
				// setting user cajero value 0 status				
				u = ud.getUniqueUsuario(usuario);
				if(u.getPerfil().compareTo(Types.C.getStatusCode())== 0)
				{
					u.setActivo(0);
					boolean res = ud.updateUsuario(u);
					if(res)
						System.out.println("Update user status successfull");
				}
				
				// setiing time and date				
				Date date = new Date();
		        DateFormat hourFormat = new SimpleDateFormat("HH:mm:ss");
		    	String hora = hourFormat.format(date);
		    	DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		    	String fecha = dateFormat.format(date);
		    	
				if(iduser != null && usuario !=null)
				{
					Sesion ss = new Sesion();
					SesionDao sd = new SesionDao();                 

					// get object from db
					if(idSesion != null && idSesion.intValue() > 0)			    	
						ss = sd.readSesion(idSesion.intValue());			    	
					else
						ss = sd.readSesion(idLocalSesion);
					
					if(ss.getIdSesion() != 0)
					{
						ss.setFechaSalida(fecha);
						ss.setHoraSalida(hora);
						sd.updateSession(ss);					
						sesion.invalidate();	
						response.setContentType("text/plain");          
					  	response.setCharacterEncoding("UTF-8"); 
					 	response.getWriter().write("Exit");
					}

				}
				
				// Update data in database				
			}
			
			if(request.getParameter("workout").equals("exitws"))
			{
				
				int idLocalSesion = Integer.parseInt(request.getParameter("idLocalSesion"));
				String usuario = (String)request.getParameter("user");
				String password = (String)request.getParameter("password");
				System.out.println("sesion id: "+idLocalSesion);
				
				// create new user
				Usuario u = new Usuario();
				UsuarioDao ud = new UsuarioDao();
				
				// setting user cajero value 0 status				
				u = ud.getUniqueUsuario(usuario, password);
				if(u.getIdUsuario() > 0 && u != null)
				{
					System.out.println("perfil :"+u.getPerfil());
					if(u.getPerfil().compareTo(Types.C.getStatusCode())== 0)
					{
						u.setActivo(0);
						boolean res = ud.updateUsuario(u);
						if(res)
							System.out.println("Update user status successfull");
					}					
					// setiing time and date				
					   Date date = new Date();
			           DateFormat hourFormat = new SimpleDateFormat("HH:mm:ss");
			    	   String hora = hourFormat.format(date);
			    	   DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			    	   String fecha = dateFormat.format(date);
			    	
		                Sesion ss = new Sesion();
						SesionDao sd = new SesionDao();                 
						
						// get object from db
						if(idLocalSesion > 0)			    	
							ss = sd.readSesion(idLocalSesion);
						
						if(ss.getIdSesion() != 0)
						{
							ss.setFechaSalida(fecha);
							ss.setHoraSalida(hora);
							sd.updateSession(ss);						
							response.setContentType("text/plain");          
						  	response.setCharacterEncoding("UTF-8"); 
						 	response.getWriter().write("Exit");
						}
				}
				else
				{
					response.setContentType("text/plain");          
				  	response.setCharacterEncoding("UTF-8"); 
				 	response.getWriter().write("NS");
				}
				// Update data in database				
			}
	}
	
}

