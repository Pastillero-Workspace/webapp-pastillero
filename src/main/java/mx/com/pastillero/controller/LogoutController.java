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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
	private static final Logger logger = LoggerFactory.getLogger(LogoutController.class);


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
			if(request.getParameter("workout").equals("exitnr"))
			{
				String usuario = "";
				Integer idSesion = 0;
				Integer idUser = 0;
				boolean trxsession = false;
				
				int idLocalSesion = 0;
				HttpSession sesion = request.getSession(false);
				if(sesion != null && !sesion.isNew()){
						usuario  = (String)sesion.getAttribute("usuario");
						idSesion = (Integer)sesion.getAttribute("idSesion");
						idUser   = (Integer)sesion.getAttribute("iduser");
						trxsession = true;
						sesion.invalidate();
						
					}
				else{	
					if(request.getParameter("idLocalSesion")!=null && request.getParameter("usuario")!=null)
					{
						idLocalSesion = Integer.parseInt((request.getParameter("idLocalSesion")));		
						usuario   =   (String)request.getParameter("usuario");	
						trxsession = true;
					}
					else{
						response.setContentType("text/plain");          
					  	response.setCharacterEncoding("UTF-8"); 
					 	response.getWriter().write("ExitError");
					}
						
					    
				   }
			     
				if(trxsession){
					// setting time and date				
					Date date = new Date();
			        DateFormat hourFormat = new SimpleDateFormat("HH:mm:ss");
			    	String hora = hourFormat.format(date);
			    	DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
			    	String fecha = dateFormat.format(date);
			    	
					if(idUser != null && usuario !=null && !usuario.isEmpty())
					{   
						Usuario u = new Usuario();
						UsuarioDao ud = new UsuarioDao();		
						u = ud.getUniqueUsuario(usuario);		
						u.setActivo(0);
						boolean res = ud.updateUsuario(u);
						if(res)
							logger.info("Estado de usuario actualizado!");
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
							response.setContentType("text/plain");          
						  	response.setCharacterEncoding("UTF-8"); 
						 	response.getWriter().write("Exit");
						 	logger.info("Sesion de usuario cerrada con exito! "+usuario);
						}
	
					}
					else
					{						
						response.setContentType("text/plain");          
					  	response.setCharacterEncoding("UTF-8"); 
					 	response.getWriter().write("Exit");
					 	logger.info("Sesion eliminada: "+usuario);
					}
					
					
			   } // trxsession
				
				// Update data in database				
			}
			
			else if(request.getParameter("workout").equals("exitfr"))
			{
				int idLocalSesion = 0;
				if(!request.getParameter("idLocalSesion").isEmpty() && request.getParameter("idLocalSesion") != null)
					idLocalSesion = Integer.parseInt(request.getParameter("idLocalSesion"));
				
				String usuario = (String)request.getParameter("u");
				String password = (String)request.getParameter("p");
				logger.info("sesion cerrada de manera forzada id: "+idLocalSesion);
				
				// create new user
				Usuario u = new Usuario();
				UsuarioDao ud = new UsuarioDao();
				
				// setting user cajero value 0 status				
				u = ud.getUniqueUsuario(usuario, password);
				if(u != null)
				{
					    logger.info("perfil :"+u.getPerfil());			
						u.setActivo(0);
						boolean res = ud.updateUsuario(u);
						if(res)
						logger.info("Estado de usuario actualizado! "+usuario);					
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

