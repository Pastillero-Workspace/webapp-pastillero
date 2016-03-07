package mx.com.pastillero.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/*User imports*/
import mx.com.pastillero.model.dao.UsuarioDao;
import mx.com.pastillero.model.formBeans.Usuario;
import mx.com.pastillero.model.formBeans.Roles;
import mx.com.pastillero.model.formBeans.UserRol;
import mx.com.pastillero.model.dao.RolesDao;
import mx.com.pastillero.model.dao.UserChangeDao;
import mx.com.pastillero.model.dao.UserRolDao;

public class PermisosController extends HttpServlet{

	private static final long serialVersionUID = 4447556523657770677L;
	private static final Logger logger = LoggerFactory.getLogger(PermisosController.class);
	
	public PermisosController() {}

	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

	}	
	
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if (request.getParameter("workout").equals("getUser")) {
			 String Usuario = request.getParameter("Usuario").trim().toUpperCase();
			 logger.info("Obteniendo pérmisos de usuario..." + Usuario);
			 
			 /*Creando los objetos*/			 
			 UsuarioDao ud = new UsuarioDao();
			 Usuario u = new Usuario();
					 
			 UserRolDao usrd = new UserRolDao();
			 List<UserRol> lu = new ArrayList<>();

			 JSONArray la = new JSONArray();			  			  			 
			 u = ud.getUniqueUsuario(Usuario);
			  
			 if(u != null)			 
			     lu = usrd.getPermisosbyUser(u,0);
			 if(!lu.isEmpty() && lu.size()>0){
				 for(UserRol i: lu){
					 JSONObject obj = new JSONObject();
					 obj.put("UserRol",i.getIdUserRol());
					 obj.put("Usuario",i.getIdUsuario());
					 obj.put("Rol",i.getId_rol());
					 obj.put("Estatus",i.getEstatus());
					 la.add(obj);
					 }
				}
			    response.setContentType("text/plain");
				response.setCharacterEncoding("UTF-8");			
				response.getWriter().write(la.toJSONString());		 
		}
		
		if (request.getParameter("workout").equals("setUser")) 
		{	
			HttpSession sesion = request.getSession(false);
			String s = request.getParameter("jsn").trim();
			String user = request.getParameter("user");
			String message_1 = "0";
			String message_2 = "0";
			JSONArray array= null;
			if(!s.isEmpty() && s != null)
			{
				JSONParser parser = new JSONParser();
				Object obj = null;				
				try {
					obj = parser.parse(s);
					array = (JSONArray) obj;
				} catch (ParseException e) {
					logger.error("Error a procesar la cadena: Verificar envio/recepcion json");
					e.printStackTrace();
				}
				/* Create objects for: User , Rol and  RolDao*/
				RolesDao roles = new RolesDao();
				Roles rol = new Roles();
				UsuarioDao ud = new UsuarioDao();
				Usuario u = new Usuario();		 
				UserRolDao usrd = new UserRolDao();
				List<UserRol> lu = new ArrayList<>();
				List<UserRol> lud = new ArrayList<>();			
				u = ud.getUniqueUsuario(user);
				try{
					if(u!=null){
						for (int i = 0; i < array.size(); i++) {
							JSONObject objitem = (JSONObject) array.get(i);
							System.out.println("data permisions: "+objitem.get("id")+" user : "+user);
							rol = roles.readRol(objitem.get("id").toString());
							System.out.println(rol.toString());
							/* create obj UserRol */
							UserRol ur = new UserRol();
							ur.setIdUsuario(u.getIdUsuario());
							ur.setId_rol(rol.getId_rol());
							ur.setEstatus(1);
							lu.add(ur);
						}
					}
				}catch(Exception e){
					logger.error("Ha ocurrido un error en la funcion: Objeto | Array | consulta");
					e.printStackTrace();
				}			
				/* Delete row with user after insert new records in db using for*/
				try{
					lud = usrd.getPermisosbyUser(u,0);
					if(lud.size() > 0 && lud != null)
						for (int i = 0; i < lud.size(); i++) {
							boolean result = usrd.deleteUsrRol(lud.get(i).getIdUserRol());
							if(result){
								 message_2="2";
								logger.info("Registro eliminado con éxito: "+lud.get(i).getId_rol());
							}					
						}
				/*Insert new records updated in db ussing for*/
					if(lu.size() > 0 && lu != null)
						for (int i = 0; i < lu.size(); i++) {
						   Integer resultins = usrd.addUsrRol(lu.get(i));
						   if(resultins > 0  && resultins !=null){message_1="1";}
					    }
				}catch(Exception e){
					logger.error("Ocurrio un problema al actualizar");
				}			
				// update in database control user estatus			
				UserChangeDao usc = new UserChangeDao();
				boolean r = usc.setChange(u.getIdUsuario(),1);
			    if(r){
			    	System.out.println("Control de permisos activado !!!");	
			    	if(sesion != null){	    		
			    		sesion.removeAttribute("pv");
			    		sesion.setAttribute("pv", 1);
			    		System.out.println("Sesion actualizada !!!");	
			    	}
			    }				
			}// en if			
			// save messages for jsp
			JSONObject obj=new JSONObject();
			obj.put("msg1",message_1);
			obj.put("msg2",message_2);
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(obj.toJSONString());		
			}// end if (function)
		 	
		if (request.getParameter("workout").equals("getAll")) {
			 System.out.println("Get perfect success");
			 RolesDao rd = new RolesDao();
	         List<Roles> lu = rd.getRoles();
			 JSONArray la = new JSONArray();			  			  			 
				 for(Roles i: lu){
					 JSONObject obj = new JSONObject();
					 obj.put("Num",String.valueOf(i.getId_rol()));
					 obj.put("Clave",i.getClave());
					 obj.put("Descripcion",i.getDescripcion());
					 obj.put("A","t");
					 la.add(obj);
					 }           
			    response.setContentType("text/plain");
				response.setCharacterEncoding("UTF-8");	
				System.out.println(la.toJSONString());
				response.getWriter().write(la.toJSONString());			 
			 
		}
		
		if(request.getParameter("workout").equals("control-enabled")){
			/**Este co´digo se va optimizar en la segunda entrega. Falta refactorizar**/
			UsuarioDao ud = new UsuarioDao();
			List<Usuario> lu = new ArrayList<Usuario>();
			UserChangeDao uscd = new UserChangeDao();;
			lu = ud.getAllUsers();
			if(lu != null && !lu.isEmpty()){
				uscd.delChange(0);  //Habilita eliminacion completa de los usuario para qgregar otra
				// se agregan los nuevos records
				for(Usuario u : lu){
					if(uscd.insChange(u.getIdUsuario()));
					  logger.info("Control "+u.getUsuario()+"actualizado");	
				}
				
			}
					
			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");	
			response.getWriter().write("Success");
		}
		  
		
		}
	
}
