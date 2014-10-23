package mx.com.pastillero.model.dao;


import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.formBeans.Sesion;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SesionDao extends GenericoDAO
{
	private static final Logger logger = LoggerFactory.getLogger(SesionDao.class);
	  public Integer createSession(Sesion s) 
	  {
			Integer idSesion = 0;
			Session session = null; 
			Transaction tx=null;
			try{
				session = factory.openSession(); 
				tx=session.beginTransaction(); 
				idSesion = (Integer)session.save(s); 
				tx.commit(); 
			}catch(HibernateException e1)
			{
				idSesion = 0;
				logger.error("Error funcion guardar sesion ");
				e1.printStackTrace();
			}
			finally{ 
				if(session!=null&&session.isOpen())
					try{  
						session.close(); 
					}catch(Exception ex){
							ex.printStackTrace();
					}

			}			
			return idSesion;
	 }
	  
	  public boolean updateSession(Sesion s) 
	  {
			boolean resultado=false;
			Session session = factory.openSession(); 
			Transaction tx=null;
			try{
				tx=session.beginTransaction(); 
				session.update(s); 
				tx.commit(); 
				resultado=true;
			}catch(HibernateException e1)
			{
				resultado=false;
				logger.error("Error al actualizar session ");
				e1.printStackTrace();
			}
			finally{ 
				if(session!=null&&session.isOpen())
					try{  
						session.close(); 
					}catch(Exception ex){
							ex.printStackTrace();
					}

			}			
			return resultado;
	 }
	  
	  @SuppressWarnings("unchecked")
	public Sesion readSesion(int sesion)
	  {
		    Session session = null;
		    Sesion s = null;
		    try
		    {
		    	session = factory.openSession();
		    	List<Sesion> ls = session.createQuery("from Sesion where idSesion='"+sesion+"'").list();
			   if(!ls.isEmpty())
			   {
				   s = ls.get(0);
			   }
		    }catch(HibernateException e)
		    {
		    	s = null;
		    	logger.error("Error al leer la sesion");
		    	e.printStackTrace();
		    }
			return s;
	  }
		

}
