package mx.com.pastillero.model.dao;



import java.util.List;

import mx.com.pastillero.model.formBeans.Usuario;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.LogicalExpression;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/* Logica de implementacion de busqueda de usuario */

public class UsuarioDao extends GenericoDAO
{
	private static final Logger logger = LoggerFactory.getLogger(UsuarioDao.class);
	
	@SuppressWarnings("unchecked")
	public boolean isUsuario(String usuario, String password){
	  boolean value = false;
	  Session session = null;
	  try{
		  	session = factory.openSession();
		  	List<Object> users = session.createQuery("select usuario from Usuario "
		  			+ "where usuario = '"+usuario+"' and contrasena= '"+password+"'").list();
		  			if(!users.isEmpty() && users.get(0).toString().equals(usuario))
		  			  value = true;
	     }
	     catch (HibernateException ex) 
	  	 {
	    	 value = false;
	    	 logger.error("Error al consultar usuario\n" + ex);	  
	  	 }
	     finally
	     {
	    	 if (session != null && session.isOpen()) {
					try {
						session.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
	     }
	  return value;
		  
	  }

	@SuppressWarnings("unchecked")
	public List<Usuario> getUsuario(String usuario)
	  {
		Session session = null;
		List<Usuario> list = null;
		try
		{
		  	session = factory.openSession(); 
		  	Criteria criteria = session.createCriteria(Usuario.class);
		  	criteria.add(Restrictions.eq("usuario", usuario));	
			list = criteria.list();
		}catch(HibernateException ex)
		{
			list = null;
			logger.error("Error al obtener el usuario:\n" + ex);	 
		}
		finally
		{
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	  }
	
	
	@SuppressWarnings("unchecked")
	public List<Usuario> getAllUsers()
	  {
		Session session = null;
		List<Usuario> list = null;
		try
		{
		  	session = factory.openSession(); 
		  	Criteria criteria = session.createCriteria(Usuario.class);
			list = criteria.list();
		}catch(HibernateException ex)
		{
			list = null;
			logger.error("Error al obtener el usuario:\n" + ex);	 
		}
		finally
		{
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	  }
	
	@SuppressWarnings("unchecked")
	public Usuario getUniqueUsuario(String usuario)
	  {
		Session session = null;
		List<Usuario> list = null;
		Usuario u = null;
		try
		{
		  	session = factory.openSession(); 
		  	Criteria criteria = session.createCriteria(Usuario.class);
		  	criteria.add(Restrictions.eq("usuario", usuario));	
			list = criteria.list();
			if(!list.isEmpty())
				u = list.get(0);
		}catch(HibernateException ex)
		{
			u = null;
			logger.error("Error al obtener el usuario:\n" + ex);	 
		}
		finally
		{
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}			
		}
		return u;
	  }
	
	@SuppressWarnings("unchecked")
	public Usuario getUniqueUsuario(String usuario,String contrasena)
	  {
		Session session = null;
		List<Usuario> list = null;
		Usuario u = null;
		try
		{
		  	session = factory.openSession(); 
		  	Criteria criteria = session.createCriteria(Usuario.class);
		  	criteria.add(Restrictions.eq("usuario", usuario));
		  	criteria.add(Restrictions.eq("contrasena", contrasena));	
			list = criteria.list();
			if(!list.isEmpty())
				u = list.get(0);
			else{
				u = null;
			}
				
		}catch(HibernateException ex)
		{
			u = null;
			logger.error("Error al obtener el usuario:" + ex);	 
		}
		finally
		{
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return u;
	  }
	
	public boolean isNullUser(Usuario u, String usuario, String contrasena)
	{
		boolean result = false;
		if((u.getUsuario() != null && u.getContrasena() != null))
		{
			result = true;
		}
				
		return result;		
	}
	
	public boolean isUser(Usuario u, String usuario, String contrasena)
	{
		boolean result = false;
		if(u.getUsuario().compareTo(usuario) == 0 && u.getContrasena().compareTo(contrasena)== 0)
		{
			result = true;
		}			
		return result;		
	}
	
	public boolean updateUsuario(Usuario u){
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx  = session.beginTransaction();
			session.update(u);
			tx.commit();
			resultado = true;
		}catch(Exception e){
			resultado=false;
			logger.error("Error en updateUsuario");
			e.printStackTrace();
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
	
	@SuppressWarnings("unchecked")
	public List<Usuario> readUserActive(String profile)
	  {
		Session session = null;
		List<Usuario> list = null;
		try
		{
		  	session = factory.openSession(); 
		  	Criteria criteria = session.createCriteria(Usuario.class);
		  	
		  	Criterion perfil = Restrictions.eq("perfil", profile);	
		  	Criterion status = Restrictions.eq("activo",1);
		  	
		  	LogicalExpression andExp = Restrictions.and(perfil,status);
		  	criteria.add( andExp );	
		  
			list = criteria.list();
			
		}
		catch(Throwable ex)
		{
			list = null;
			logger.error("Error al obtener el usuario:\n" + ex);	 
		}
		finally
		{
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	  }
	
	@SuppressWarnings("unchecked")
	public List<Usuario> readUserActive()
	  {
		Session session = null;
		List<Usuario> list = null;
		try
		{
		  	session = factory.openSession(); 
		  	Criteria criteria = session.createCriteria(Usuario.class);
		  	
		  	Criterion perfil = Restrictions.eq("perfil", "CAJERO");	
		  	Criterion status = Restrictions.eq("activo",1);
		  	
		  	LogicalExpression andExp = Restrictions.and(perfil,status);
		  	criteria.add( andExp );	
		  
			list = criteria.list();
			
		}
		catch(Throwable ex)
		{
			list = null;
			logger.error("Error al obtener el usuario:\n" + ex);	 
		}
		finally
		{
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	  }
	
}
 