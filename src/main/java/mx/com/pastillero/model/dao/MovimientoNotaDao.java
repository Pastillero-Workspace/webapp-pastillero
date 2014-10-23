package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.MovimientoVenta;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.LogicalExpression;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MovimientoNotaDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(MovimientoNotaDao.class);
	  
	  /*
	   *  Metodo: Insertar movimiento de nota(registro de ventas por productos)
	   *  Parametros de entrada: Movimiento mv
	   *  Salida; Ninguna*/
	public void insertMovimientoNota(MovimientoVenta mv)
	  {
	  	Session session = null;
	  	Transaction tx=null;	
	  	try{
	  		session = factory.openSession();
	  		tx = session.beginTransaction(); 
	  		session.save(mv); 
	  		tx.commit(); 
	  	}catch(Exception e1){
	  		tx.rollback();
	  		logger.error("ERROR: no se puede insertar movimientoNota");
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
	  }
	  
	  
	@SuppressWarnings("rawtypes")
	public void getInsertedMovNota(int idNota, String tipo ){
		      Session session = null;
		      Transaction tx = null;
		      try{
		    	  session = factory.openSession();
		         tx = session.beginTransaction();
		         Criteria cr = session.createCriteria(MovimientoVenta.class);		         
		         Criterion id = Restrictions.eq("idNota", idNota);
		         Criterion venta = Restrictions.eq("tipo", tipo);		         
		         LogicalExpression andExp = Restrictions.and(id, venta);
		         cr.add( andExp );
		         cr.setProjection(Projections.rowCount());	         
		         List rowCount = cr.list();
		         tx.commit();
		      }catch (HibernateException e) {
		         if (tx!=null) tx.rollback();
		         logger.error("ERROR: No se pudo realizar la insercion de movimientoVenta");
		         e.printStackTrace(); 
		      }finally {
		    	  if (session != null && session.isOpen()) {
						try {
							session.close();
						} catch (Exception e) {
							e.printStackTrace();
						}
					} 
		      }
		   }

}
