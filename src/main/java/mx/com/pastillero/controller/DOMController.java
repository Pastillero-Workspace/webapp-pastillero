package mx.com.pastillero.controller;


import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



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
	
		/*if(request.getParameter("uses").equals("page"))			
		{ 
			HttpSession sesion = request.getSession(false);
			String usuario = (String)sesion.getAttribute("usuario");
			Integer num = (Integer) sesion.getAttribute("numero");
			sesion.setAttribute("sessionid",1);
			Integer a = (Integer) sesion.getAttribute("sessionid");
			response.setContentType("text/plain");          
		  	response.setCharacterEncoding("UTF-8"); 
	 	response.getWriter().write("done");

		}*/

	}

}
