package mx.com.pastillero.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.com.pastillero.model.dao.DireccionDao;
import mx.com.pastillero.model.dao.PersonaDao;
import mx.com.pastillero.model.dao.UPDDao;
import mx.com.pastillero.model.dao.UsuarioDao;
import mx.com.pastillero.model.formBeans.Direccion;
import mx.com.pastillero.model.formBeans.Persona;
import mx.com.pastillero.model.formBeans.Productos;
import mx.com.pastillero.model.formBeans.Usuario;

public class UsuarioController extends HttpServlet{
	
	
	Productos pds = new Productos();
	private static final long serialVersionUID = 1L;	
	public UsuarioController()
	{
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		if(request.getParameter("tarea").equals("update"))
		{
		    // Usuario
			String olduser = request.getParameter("olduser");
			String usuario = request.getParameter("txtUsuario");
			String contrasena = request.getParameter("txtContrasena");
			String perfil = request.getParameter("txtPerfil");
			int activo = Integer.parseInt(request.getParameter("txtActivo"));
			String sucursal = request.getParameter("txtSucursal");
			//Persona
			String nombre = request.getParameter("txtNombre");
			String apellidopat = request.getParameter("txtApePat");
			String apellidomat = request.getParameter("txtApeMat");
			String fechaingreso =request.getParameter("txtFechaIn");
			String rfc =  request.getParameter("txtRFC");
			String curp = request.getParameter("txtCURP");
			String turno = request.getParameter("txtTurno");
			String email = request.getParameter("txtEmail");
			String telfijo = request.getParameter("txtTelFijo");
			String telmovil = request.getParameter("txtTelMovil");
			// Direccion
			String calle =   request.getParameter("txtCalle");
			int noext = Integer.parseInt(request.getParameter("txtNoExt"));
			int noint = Integer.parseInt(request.getParameter("txtNoInt"));
			String colonia = request.getParameter("txtColonia");
			String estado = request.getParameter("txtEstado");
			int cp = Integer.parseInt(request.getParameter("txtCp"));
			// logical businnes temporaly implementation
			
			System.out.println("values:"+olduser+" "+usuario+" | "+contrasena+" | "+perfil+" | "+activo+" | "+sucursal+" | "+nombre+" | "+
					apellidopat+" | "+apellidomat+" | "+fechaingreso+" | "+rfc+" | "+curp+" | "+turno+" | "+email+" | "+telfijo+" | "+
					telmovil+" | "+calle+" | "+noext+" | "+noint+" | "+colonia+" | "+estado+" | "+cp);
			
				Usuario u = new Usuario();
				Persona p = new Persona();
				Direccion d = new Direccion();
				UsuarioDao  ud = new UsuarioDao();
				PersonaDao pd = new PersonaDao();
				DireccionDao dd = new DireccionDao();
				UPDDao updd = new UPDDao();
							
			// asume if user is not null and get the others class
			
			u = ud.getUniqueUsuario(olduser);
			p = pd.readUniquePersonbyId(u);	
			d = dd.readUniqueDirectionbyId(p);
			
			System.out.println(" User: " +u.getIdUsuario());
			System.out.println(" Person: " +p.getIdPersona());
			System.out.println(" Directory: " +d.getIdDireccion());
			
		// update data i u,p,d
			
			u.setUsuario(usuario);
			u.setContrasena(contrasena);
			u.setPerfil(perfil);
			u.setActivo(activo);
			u.setSucursal(sucursal);
			
			p.setNombre(nombre);
			p.setApellidoPat(apellidopat);
			p.setApellidoMat(apellidomat);
			p.setFechaIngreso(fechaingreso);
			p.setRfc(rfc);
			p.setCurp(curp);
			p.setTurno(turno);
			p.setEmail(email);
			p.setTelFijo(telfijo);
			p.setTelMovil(telmovil);
			
			d.setCalle(calle);
			d.setColonia(colonia);
			d.setNoInt(noint);
			d.setNoExt(noext);
			d.setEstado(estado);
			d.setCp(cp);
			
			// call update 
			updd.actualizarCliente(u, p, d);					
		    response.getWriter().write("Update");
		
		}		
		if(request.getParameter("tarea").equals("create"))
		{
			
			String usuario = request.getParameter("txtUsuario");
			String contrasena = request.getParameter("txtContrasena");
			String perfil = request.getParameter("txtPerfil");
			int activo = Integer.parseInt(request.getParameter("txtActivo"));
			String sucursal = request.getParameter("txtSucursal");
			//Persona
			String nombre = request.getParameter("txtNombre");
			String apellidopat = request.getParameter("txtApePat");
			String apellidomat = request.getParameter("txtApeMat");
			String fechaingreso =request.getParameter("txtFechaIn");
			String rfc =  request.getParameter("txtRFC");
			String curp = request.getParameter("txtCURP");
			String turno = request.getParameter("txtTurno");
			String email = request.getParameter("txtEmail");
			String telfijo = request.getParameter("txtTelFijo");
			String telmovil = request.getParameter("txtTelMovil");
			// Direccion
			String calle =   request.getParameter("txtCalle");
			int noext = Integer.parseInt(request.getParameter("txtNoExt"));
			int noint = Integer.parseInt(request.getParameter("txtNoInt"));
			String colonia = request.getParameter("txtColonia");
			String estado = request.getParameter("txtEstado");
			int cp = Integer.parseInt(request.getParameter("txtCp"));
			
			System.out.println("values:"+usuario+" | "+contrasena+" | "+perfil+" | "+activo+" | "+sucursal+" | "+nombre+" | "+
			apellidopat+" | "+apellidomat+" | "+fechaingreso+" | "+rfc+" | "+curp+" | "+turno+" | "+email+" | "+telfijo+" | "+
			telmovil+" | "+calle+" | "+noext+" | "+noint+" | "+colonia+" | "+estado+" | "+cp);
			

			Usuario u = new Usuario();
			Persona p = new Persona();
			Direccion d = new Direccion();

			UPDDao updd = new UPDDao();
							
	// update data i u,p,d
		
			u.setUsuario(usuario);
			u.setContrasena(contrasena);
			u.setPerfil(perfil);
			u.setActivo(activo);
			u.setSucursal(sucursal);
			
			p.setNombre(nombre);
			p.setApellidoPat(apellidopat);
			p.setApellidoMat(apellidomat);
			p.setFechaIngreso(fechaingreso);
			p.setRfc(rfc);
			p.setCurp(curp);
			p.setTurno(turno);
			p.setEmail(email);
			p.setTelFijo(telfijo);
			p.setTelMovil(telmovil);
			
			d.setCalle(calle);
			d.setColonia(colonia);
			d.setNoInt(noint);
			d.setNoExt(noext);
			d.setEstado(estado);
			d.setCp(cp);
		
		// call create new user 
			try
			{
				int result = updd.createUPD(d, p, u);
				System.out.println("Create sucessful"+result);
				response.getWriter().write("Create");
						
			}
			catch(Exception e)
			{
				System.out.println("Error al crear: consulte a su administrador");
			}
		}
		
		if(request.getParameter("tarea").equals("delete"))
		{
			String keyuser = request.getParameter("Usuario");
			System.out.println("Key user: "+ keyuser);
			
			// getting data from user
			
			Usuario u = new Usuario();
			Persona p = new Persona();
			Direccion d = new Direccion();
			UsuarioDao  ud = new UsuarioDao();
			PersonaDao pd = new PersonaDao();
			DireccionDao dd = new DireccionDao();
			UPDDao updd = new UPDDao();
									
			// asume if user is not null and get the others class
			
			u = ud.getUniqueUsuario(keyuser);
			p = pd.readUniquePersonbyId(u);	
			d = dd.readUniqueDirectionbyId(p);
			
			System.out.println(" User: " +u.getIdUsuario());
			System.out.println(" Person: " +p.getIdPersona());
			System.out.println(" Directory: " +d.getIdDireccion());
			
			
			try
			{
				boolean result = updd.deleteUPD(u, p, d);
				if(result)
				{
					System.out.println("Delete sucessfull");
				    response.getWriter().write("Delete");
				}
						
			  }
			catch(Exception e)
			{
				System.out.println("Error al crear: consulte a su administrador");
			}			
			response.getWriter().write("Delete");	
		}
		if(request.getParameter("tarea").equals("session")){
			Usuario usuario = new Usuario();
			usuario.setIdUsuario(Integer.parseInt(request.getParameter("user").trim()));
			UPDDao upd = new UPDDao();
			upd.actualizarSesion(usuario);
		}
		
		
	
	}
}
