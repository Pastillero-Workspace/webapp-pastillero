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

import org.json.simple.JSONObject;

import mx.com.pastillero.model.dao.ReporteCajaDao;
import mx.com.pastillero.model.dao.SesionDao;
import mx.com.pastillero.model.dao.UsuarioDao;
import mx.com.pastillero.model.dao.PersonaDao;
import mx.com.pastillero.model.formBeans.Persona;
import mx.com.pastillero.model.formBeans.ReporteCaja;
import mx.com.pastillero.model.formBeans.Sesion;
import mx.com.pastillero.model.formBeans.Usuario;
import mx.com.pastillero.utils.TicketServiceDeposito;





public class TicketController extends HttpServlet{ 

	private static final long serialVersionUID = 1L;

	JSONObject obj=new JSONObject();

		
	public TicketController(){
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	 
		doPost(request,response);	
	}
	
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	    if(request.getParameter("workout").equals("saveTicket"))
	    {
	    	HttpSession sesion = request.getSession(false);
	    	
	    	int data_1= 0;
	    	int data_2= 0;
	    	// date and hour			
	    	Date date = new Date();
	        DateFormat hourFormat = new SimpleDateFormat("HH:mm:ss");
	    	String hora = hourFormat.format(date);
	    	DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
	    	String fecha = dateFormat.format(date);
	    	
	    	// Setting up user for ticket information
	    	String varUser = request.getParameter("varUser").trim();
	    	String varCantidad = request.getParameter("varCantidad").trim();
	    	TicketServiceDeposito tsd = new TicketServiceDeposito();
	    	
	    	// cretae user data and person infromation.
	    	Usuario u = new Usuario();
	    	UsuarioDao ud = new UsuarioDao();
	    	
	    	Persona p = new Persona();
	    	PersonaDao pd = new PersonaDao();
	    		    	
	    	u = ud.getUniqueUsuario(varUser);	    	
	    	p = pd.readUniquePersonbyId(u);
	    	if(u.getUsuario().equals(varUser))
	    	{	
	    		// create session and asign values
	    		Sesion ss = new Sesion();
				ReporteCaja rc = new ReporteCaja();
				SesionDao sd = new SesionDao();
				ReporteCajaDao rcd = new ReporteCajaDao();
				
				ss.setIdUsuario(u.getIdUsuario());
				ss.setUsuario(u.getUsuario());
				ss.setFechaIngreso(fecha.toString());
				ss.setHoraIngreso(hora.toString());
				
				rc.setIdUsuario(u.getIdUsuario());
				rc.setFecha(ss.getFechaIngreso());
				rc.setHoraInicial(ss.getHoraIngreso());
				rc.setDeposito(Float.parseFloat(varCantidad));
				
				// save session and save report					
				data_1 =  sd.createSession(ss).intValue();
			    data_2 = rcd.createReporteCaja(rc).intValue();
							    
				if(data_1 !=0 && data_2 != 0)
				{
					// create ticket					
					sesion.setAttribute("idSesion", data_1);
					sesion.setAttribute("idReporte", data_2);
					
		    		tsd.setIdUsuario(u.getIdUsuario());
		    		tsd.setUsuario(varUser);
		    		tsd.setCaja(1);
		    		tsd.setTipo("DEPOSITO");
		    		tsd.setMonto(varCantidad);
		    		tsd.setFecha(fecha);
		    		tsd.setHora(hora);
		    		tsd.setN_usuario(p.getNombre());
		    		tsd.setN_apellidop(p.getApellidoPat());
		    		tsd.setN_apellidom(p.getApellidoMat());
										
					// Create a simple JSON Output for save session an continue.
					
					  obj.put("iduser", u.getIdUsuario());
					  obj.put("idsesion",data_1);
					  obj.put("idreport",data_2);
					  
					  response.setContentType("application/json");
					  response.setCharacterEncoding("UTF-8"); 
					  response.getWriter().write(obj.toString());
        
				}
				else
				{				
					response.setContentType("text/plain");           
					response.setCharacterEncoding("UTF-8"); 
					response.getWriter().write("Failed");										
				}
				
	    		
	    	}
	    	else
	    	{
	    		System.out.println("entro al primer if");
	    		response.setContentType("text/plain");           
				response.setCharacterEncoding("UTF-8"); 
				response.getWriter().write("Usernot");	
	    		
	    	}
	    	
	    }
	    
	
	}


}
