package mx.com.pastillero.model.dao;

import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.formBeans.UserChanged;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UserChangeDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(UserChanged.class);
   


	public boolean getChange(int id)
	{	
		Session session = null;
		boolean result = false;
		try{
			logger.info("entering getChange");		
			session = factory.openSession();	
			String sql = "select iduser,ischanged from ControlPermiso where iduser=:id";
			SQLQuery query = session.createSQLQuery(sql);
			query.setParameter("id", id);		
			 @SuppressWarnings("unchecked")
			List<Object[]> luh = (List<Object[]>)query.list();			    
			if(!luh.isEmpty() && luh.size()>0)
			{
				 for(Object[] r: luh){
					 Integer Active = (Integer)r[1];
					 if(Active.intValue() == 1)
						 result = true;
				 }
			}
				  
		}catch(HibernateException e){
					logger.error("ERROR: ControlPermiso get."+ e.getCause());
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
		logger.info("check if query is true ? "+result);
	return result;
	}

	@SuppressWarnings("unchecked")
	public List<UserChanged> getAll()
	{	
		Session session = null;
		boolean result = false;
		List<UserChanged> ls = new ArrayList<UserChanged>();
		try{
			logger.info("entering getChange");		
			session = factory.openSession();	
			String sql = "select * from ControlPermiso";
			SQLQuery query = session.createSQLQuery(sql);		
			ls = query.list();			    				  
		}catch(HibernateException e){
					logger.error("ERROR: ControlPermiso get."+ e.getCause());
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
		logger.info("check if query is true ? "+result);
	return ls;
	}
	
	public boolean setChange(int id,int value){	
	Session session = null;
	boolean result = false;
	try{
			
		session = factory.openSession();	
		String sql = "update ControlPermiso set ischanged=:value where iduser=:id";
		SQLQuery query = session.createSQLQuery(sql);
		query.setParameter("id", id);
		query.setParameter("value", value);
		int r = query.executeUpdate();
		if(r != 0)
			result = true;		  
	}catch(HibernateException e){
			logger.error("ERROR: ControlPermiso get."+ e.getCause());
			e.printStackTrace();
	}finally
		{
			if (session != null && session.isOpen()) {
				try {session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	return result;
	}
	
	public boolean insChange(int id){	
		
	boolean result = false;
    Session session = null;      
	Transaction tx = null;
	Integer r = null;
	      try{
	    	 session = factory.openSession();
	         tx = session.beginTransaction();
	         UserChanged usc = new UserChanged();
	         usc.setIduser(id);
	         usc.setIschanged(0);
	         r = (Integer) session.save(usc); 
	         if (r != null)
	         {
	        	 System.out.println(r.intValue()+" Row afected --");
	        	 result = true;
	         }
	         tx.commit();
	      }catch(Exception e1){
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
		
	return result;
	}

	
	public boolean delChange(int id){	
	Session session = null;
	boolean result = false;
	try{
			
		session = factory.openSession();
		String sql;
		if(id > 0)
			sql= "delete ControlPermiso where iduser=:id";
		else
			sql= "delete from ControlPermiso";
		SQLQuery query = session.createSQLQuery(sql);
		if(id > 0)
			query.setParameter("id", id);
		int r = query.executeUpdate();
		if(r != 0)
			result = true;		  
	}catch(HibernateException e){
			logger.error("ERROR: ControlPermiso get."+ e.getCause());
			e.printStackTrace();
	}finally
		{
			if (session != null && session.isOpen()) {
				try {session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	return result;
	}
	

}
	
	
