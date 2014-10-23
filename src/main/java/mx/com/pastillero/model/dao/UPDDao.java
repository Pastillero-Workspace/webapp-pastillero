package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Direccion;
import mx.com.pastillero.model.formBeans.Persona;
import mx.com.pastillero.model.formBeans.Proveedor;
import mx.com.pastillero.model.formBeans.Usuario;









import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UPDDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(UPDDao.class);
	
	@SuppressWarnings("unchecked")
	public List<Object[]>mostrar(){
			Session session = null;
			List<Object[]> usuarios = null;
			try{
				session = factory.openSession();
				usuarios = session.createQuery("select u.usuario,u.contrasena,u.perfil,u.activo,u.sucursal"+
						" ,p.nombre,p.apellidoPat,p.apellidoMat,p.fechaIngreso,p.rfc,p.curp,p.turno,p.email,p.telFijo,p.telMovil,"
					    +" d.calle,d.noInt,d.noExt,d.colonia,d.estado,d.cp"
						+" from Usuario as u,Persona as p,Direccion as d where u.idPersona = p.idPersona and p.idDireccion = d.idDireccion").list();
			}catch(HibernateException e){
				usuarios = null;
				logger.error("ERROR: No se pudo guardar en la tabla Antibioticos.");
				e.printStackTrace();
			}finally{
				if (session != null && session.isOpen()) {
					try {
						session.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			return usuarios;
		}
	
	@SuppressWarnings("unchecked")
	public List<Usuario> mostrarUsuarios(){
		Session session = null;
		List<Usuario> usuarios = null;
		try{
			session = factory.openSession();
			usuarios = session.createQuery("from Usuario").list();
		}catch(HibernateException e){
			usuarios = null;
			logger.error("ERROR: No se puede recuperar los usuarios.");
			e.printStackTrace();
		}finally{
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return usuarios;
	}
	public boolean actualizarSesion(Usuario u){
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			Usuario usuario = (Usuario) session.get(Usuario.class, u.getIdUsuario());
			usuario.setActivo(0);
			session.update(usuario);
			tx.commit();
			resultado = true;
		}catch(HibernateException ex){
			resultado = false;
			logger.error("Error al intentar cerrar sesion");
			ex.printStackTrace();
		}finally{
			if(session!=null&&session.isOpen()){
				try{
					session.close();
				}catch(Exception ex){
					ex.printStackTrace();
				}
			}
		}
		return resultado;
	}
	  public boolean actualizarCliente(Usuario u,Persona p, Direccion d){
			boolean resultado = false;
			
			Session session = null;
			Transaction tx = null;
			
			try{
				session = factory.openSession();
				tx = session.beginTransaction();
						session.update(u);
						session.update(p);
						session.update(d);
				tx.commit();
				resultado = true;
			}catch(HibernateException ex){
				resultado = false;
			    logger.error("Error al actualizar");
				ex.printStackTrace();
				tx.rollback();
				
			}
			finally{
				if(session!=null&&session.isOpen()){
					try{
						session.close();
					}catch(Exception ex){
						ex.printStackTrace();
					}
				}
			}
			return resultado;	
		}
	  
	  
	  public int createUPD(Direccion d,Persona p,Usuario u)
	  {
	  	Session session = null;
	  	Transaction tx=null;
	  	Integer Direccion = null;
	  	Integer Persona = null;
	  	Integer Usuario = -1;
	  	try{
	  		session = factory.openSession();
	  		tx = session.beginTransaction(); 
	  		Direccion = (Integer)session.save(d);
	  		if(Direccion !=null)
	  		{
	  		 	p.setIdDireccion(Direccion.intValue());
	  		 	Persona = (Integer)session.save(p);
	  		}
	  		if(Persona !=null)
	  		{
	  			u.setIdPersona(Persona.intValue());
	  			Usuario = (Integer)session.save(u);
	  		}	
	  		session.clear();
	  		tx.commit(); 
	  	}catch(HibernateException e1){
	  		Usuario = -1;
	  		logger.error("Error al crear usuario");
	  		e1.printStackTrace();
	  	}
	  	finally{ 
	  		if(session!=null&&session.isOpen())
	  			try{  
	  				session.close(); 
	  			}catch(Exception ex){
	  					ex.printStackTrace();
	  			}
	  		//session.close();
	  	}
	  	return Usuario;
	  }
	  
	  
	  public boolean deleteUPD(Usuario u,Persona p, Direccion d){
			boolean resultado = false;
			Session session = null;
			Transaction tx = null;
			
			try{
				session = factory.openSession();
				tx = session.beginTransaction();						
						session.delete(u);
						session.delete(p);
						session.delete(d);
				tx.commit();
				resultado = true;
			}catch(HibernateException ex){
				resultado = false;
				logger.error("Error al eliminar");
				ex.printStackTrace();
				tx.rollback();				
			}
			finally{
				if(session!=null&&session.isOpen()){
					try{
						session.close();
					}catch(Exception ex){
						ex.printStackTrace();
					}
				}
			}
			return resultado;	
		}
	  
	  	

}
