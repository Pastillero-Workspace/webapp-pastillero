package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.MovimientoRecepcion;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MovimientoRecepcionDao extends GenericoDAO {
	private static final Logger logger = LoggerFactory.getLogger(MovimientoRecepcionDao.class);	
	
	public boolean guardarMovimientoRecepcion(MovimientoRecepcion movimientoRecepcion) {
		boolean resultado=true;
		Session session = null;
		Transaction tx=null;
		try{
			session = factory.openSession();
			tx=session.beginTransaction(); 
			session.save(movimientoRecepcion); 
			tx.commit(); 
		}catch(Exception e1){
			resultado=false;
			logger.error("Error al guardar Movimiento");
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
		return resultado;
	}
	
	@SuppressWarnings("unchecked")
	public List<MovimientoRecepcion> mostrarMovimientos(){
		Session session = null;
		Transaction tx = null;
		List<MovimientoRecepcion> movimientos = null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			//movimientos = session.createQuery("from MovimientoRecepcion inner join Movimientos").list();
			movimientos = session.createQuery("from MovimientoRecepcion").list();
			tx.commit();
		}catch(Exception e){
			tx.rollback();
			movimientos = null;
			logger.error("ERROR: Error al mostrar movimientos");
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
		return movimientos;
	}
	
}

