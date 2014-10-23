package mx.com.pastillero.controller;

import java.io.IOException;



import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



//@WebServlet("/altaMedico.jr")
public class AltaMedicoController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2110621566329197780L;

	/**
	 * 
	 */
	
	public AltaMedicoController(){
		
	}
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
}

/**
 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
 */
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	String clave = request.getParameter("clave");
	String nombre = request.getParameter("nombre");
	String cedula = request.getParameter("cedula");
	String calle = request.getParameter("calle");
	//int numero = Integer.parseInt(request.getParameter("numero"));
	String municipio = request.getParameter("municipio");
	String estado = request.getParameter("estado");
	//int cp = Integer.parseInt(request.getParameter("cp"));
	String telefono = request.getParameter("telefono");
	String email = request.getParameter("email");
	
	/**/
	
	System.out.println("Clave: "+clave);
	System.out.println("Nombre: "+nombre);
	System.out.println("Cedula: "+cedula);
	System.out.println("Calle: "+calle);
	//System.out.println("Numero: "+numero);
	System.out.println("Municipio: "+municipio);
	System.out.println("Estado: "+estado);
	//System.out.println("CP: "+cp);
	System.out.println("Telefono: "+telefono);
	System.out.println("email: "+email);
	
	
	
	
		//LoginForm login = new LoginForm();
		//login.setUserName(userName);
		//login.setUserPassword(userPassword);
		
					
		//SessionFactory sessionFactory = new LoginFormDao().getBuildSess();
		//System.out.println(sessionFactory);
		//boolean res = new LoginFormDao().guardarLogin(login);
		//System.out.println("termino de guardado");
		response.sendRedirect("pages/welcome.jsp");
		
	}
	
}

