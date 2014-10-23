package mx.com.pastillero.model.dao;


import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.formBeans.Nota;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class NotaDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(NotaDao.class);
	  
	  /* Obtiene el ultimo id insertado de la nota */
	  
	  public int getLastInsertIdNota(Nota nt)
	  {
	  	Session session = null; 
	  	Transaction tx=null;
	  	Integer NotaID = null;		
	  	try{
	  		session = factory.openSession();
	  		tx = session.beginTransaction(); 
	  		NotaID = (Integer)session.save(nt); 
	  		tx.commit(); 
	  	}catch(Exception e1){
	  		NotaID = -1;
	  		logger.error("ERROR: Error funcion getLastInsert ");
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
	  	return NotaID;
	  }
	  
	  /* Actualiza los datos del la nota insertada */
	  
	  public void updateNota(Nota nt)
	  {
	  	Session session = null;
	  	Transaction tx=null;
	  	
	  	try{
	  		session = factory.openSession();
	  		tx = session.beginTransaction(); 
	  		session.update(nt);
	  		tx.commit(); 
	  	}catch(Exception e1){
	  		logger.error("Error al actualizar nota ");
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
	  }
	  
	  @SuppressWarnings("unchecked")
	public List<Nota> readAllby(String constraint)
	  {
		  Session session = null;
		  List<Nota> ln = null;
		  try{
			  session = factory.openSession();
			  Criteria cr = session.createCriteria(Nota.class);
			  cr.add(Restrictions.eq(constraint,"COMPLETO"));
			  ln = cr.list();
		  }catch(HibernateException e){
			  ln = null;
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
		  return ln;
	  }

}
