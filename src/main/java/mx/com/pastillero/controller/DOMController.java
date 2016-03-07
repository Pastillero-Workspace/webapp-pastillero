package mx.com.pastillero.controller;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mx.com.pastillero.model.dao.RolesDao;
import mx.com.pastillero.model.dao.UserChangeDao;
import mx.com.pastillero.model.dao.UserRolDao;
import mx.com.pastillero.model.dao.UsuarioDao;
import mx.com.pastillero.model.formBeans.Usuario;



public class DOMController  extends HttpServlet{
	
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{	
		doPost(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
		if(request.getParameter("workout").equals("upd"))			
		{ 
			HttpSession sesion = request.getSession(false);
			String user = (String)sesion.getAttribute("usuario");
			Integer iduser = (Integer) sesion.getAttribute("iduser");
			Usuario usuario = new Usuario();
			UsuarioDao usd = new UsuarioDao();
			usuario = usd.getUniqueUsuario(user);
			
			String msg = "";
            if(usuario != null )
            {
				UserRolDao rsd = new UserRolDao();		
				RolesDao rdao = new RolesDao();
				String a = rdao.getListaRolesFilter(rsd.getPermisosbyUser(usuario, 0));
                if(sesion!=null && !a.isEmpty())
                {              	
                	 sesion.removeAttribute("a");
                	 sesion.setAttribute("a", a);
                	 
                	 /** Se actualiza es estatus del control de permisos**/
                	 sesion.removeAttribute("pv");
                	 sesion.setAttribute("pv", 0);
                	 
                		UserChangeDao usc = new UserChangeDao();
        				boolean r = usc.setChange(iduser.intValue(),0);
        			    if(r)
        			    	System.out.println("Control de permisos activado !!!");
        			    
                	 msg = "Done";
                }				
			}
            else
            {
            	msg ="Error";
            }
						
			response.setContentType("text/plain");          
		  	response.setCharacterEncoding("UTF-8");  	
		  	response.getWriter().write(msg);

		}

	}

}
