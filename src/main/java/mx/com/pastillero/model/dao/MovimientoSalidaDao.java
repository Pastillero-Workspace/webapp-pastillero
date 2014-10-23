package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.MovimientoRecepcion;
import mx.com.pastillero.model.formBeans.MovimientoSalida;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MovimientoSalidaDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(MovimientoSalidaDao.class);
	
	public boolean guardarMovimientoSalida(MovimientoSalida movimientoSalida) {
		boolean resultado=true;
		Session session = null; 
		Transaction tx=null;
		try{
			session = factory.openSession();
			tx=session.beginTransaction(); 
			session.save(movimientoSalida); 
			tx.commit(); 
		}catch(Exception e1){
			resultado=false;
			logger.error("Error al guardar salida");
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
	public List<MovimientoSalida> mostrarMovimientos(){
		Session session = null;
		Transaction tx = null;
		List<MovimientoSalida> movimientos = null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			//movimientos = session.createQuery("from MovimientoSalida inner join Movimientos").list();
			movimientos = session.createQuery("from MovimientoSalida").list();
			tx.commit();
		}catch(Exception e){
			movimientos = null;
			logger.error("Error en mostraMovimientos");
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

