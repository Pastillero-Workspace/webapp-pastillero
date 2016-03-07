package mx.com.pastillero.model.dao;

import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.formBeans.UserRol;
import mx.com.pastillero.model.formBeans.Usuario;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UserRolDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(UserRolDao.class);
   
	
/** Devuelve una lista de roles y usuario : SELECT ALL**/
	@SuppressWarnings("unchecked")
	public List<UserRol> getAllPermisos()
	{	
		Session session = null;
		List<UserRol> list = new ArrayList<UserRol>();
		try{
			session = factory.openSession();	
			Criteria criteria = session.createCriteria(UserRol.class);
			list = criteria.list();
		
		}catch(HibernateException e){
					logger.error("ERROR: No se pueden mostrar los roles de usuario."+ e.getCause());
			    e.printStackTrace();
		}finally
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

	/** Devuelve una lista de roles y usuario : SELECT WHERE**/
	@SuppressWarnings("unchecked")
	public List<UserRol> getPermisosbyUser(Usuario usr, int id)
	{	
		Session session = null;
		List<UserRol> list = new ArrayList<UserRol>();
		
		try{
			session = factory.openSession();	
			Criteria criteria = session.createCriteria(UserRol.class);
			if(id == 0)
				criteria.add(Restrictions.eq("idUsuario", usr.getIdUsuario()));
			else
				criteria.add(Restrictions.eq("idUsuario", id));
			list = criteria.list();		
		}catch(HibernateException e){
					logger.error("ERROR: No se pueden mostrar los roles de usuario."+ e.getCause());
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
	return list;
	}

/**  insertar permisos de usuario **/	
	
	 public int addUsrRol(int id_user, int id_rol, int estatus){
		 
		  Session session = null;      
	      Transaction tx = null;
	      Integer usrRolID = null;
	      try{
	    	 session = factory.openSession();
	         tx = session.beginTransaction();
	         UserRol usrol = new UserRol();
	         usrol.setId_rol(id_rol);
	         usrol.setIdUsuario(id_user);
	         usrol.setEstatus(estatus);
	         usrRolID = (Integer)session.save(usrol); 
	         tx.commit();
	      }catch(Exception e1){
	    	    usrRolID = -1;
		  		logger.error("ERROR: Error funcion adduser");
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
		  	return usrRolID;
	   }
	 
/**  insertar por objetos **/
	 public int addUsrRol(UserRol rol){
		 
		  Session session = null;
	      
	      Transaction tx = null;
	      Integer usrRolID = null;
	      try{
	    	 session = factory.openSession();
	         tx = session.beginTransaction();
	         usrRolID = (Integer)session.save(rol); 
	         tx.commit();
	      }catch(Exception e1){
	    	    usrRolID = -1;
		  		logger.error("ERROR: Error funcion adduser");
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
		  	return usrRolID;
	   }
	 
/** actualizar permisos **/
	 
		public boolean updateUsrRol(UserRol usrol){
			boolean resultado = true;
			Session session = null;
			Transaction tx = null;
			try{
				session = factory.openSession();
				tx  = session.beginTransaction();
				UserRol updusrol = (UserRol) session.get(UserRol.class, usrol.getIdUserRol());				
				updusrol.setIdUsuario(usrol.getIdUsuario());
				updusrol.setId_rol(usrol.getId_rol());
				updusrol.setEstatus(usrol.getEstatus());			
				session.update(updusrol);
				tx.commit();
			}catch(Exception e){
				resultado=false;
				logger.error("Error en updateRoles RolesDao");
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
		
		
/** eliminar permisos **/
		
		public boolean deleteUsrRol(int idUserRol){
			boolean resultado = true;
			Session session = null;
			Transaction tx = null;
			try{
				session = factory.openSession();
				tx  = session.beginTransaction();
				UserRol delusrol = (UserRol) session.createCriteria(UserRol.class)
	                    .add(Restrictions.eq("idUserRol", idUserRol)).uniqueResult();
	            session.delete(delusrol);
				tx.commit();
			}catch(Exception e){
				resultado=false;
				logger.error("Error en updateRoles RolesDao");
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
		
	
}
