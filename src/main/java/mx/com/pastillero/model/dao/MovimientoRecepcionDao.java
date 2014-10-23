package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.MovimientoRecepcion;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MovimientoRecepcionDao extends GenericoDAO {
	private static final Logger logger = LoggerFactory.getLogger(MovimientoRecepcionDao.class);	
	/*
	@SuppressWarnings("unchecked")
	public List<Object> muestraVendedores(){
		Session session = factory.openSession();
		List<Object> vendedores = session.createQuery("select p.nombre from Usuario as u, Persona as p where u.idPersona=p.idPersona").list();
		
		for(Object vendedor:vendedores){
			System.out.println(vendedor);
		}
		return vendedores;
	}
	*/
	
	public boolean guardarMovimientoRecepcion(MovimientoRecepcion movimientoRecepcion) {
		logger.info("entro a metodo guardarMovimientoRecepcion");
		boolean resultado=true;
		Session session = null;
		Transaction tx=null;
		logger.info("entra a try");
		try{
			session = factory.openSession();
			logger.info("obtiene sesion "+session);
			tx=session.beginTransaction(); 
			logger.info("metodo saveorupdate");
			session.save(movimientoRecepcion); 
			tx.commit(); 
			logger.info("commit");
		}catch(Exception e1){
			resultado=false;
			logger.error("Error funcion guardarMovimientoRecepcion de MovimientoRecepcionDao ");
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
			logger.error("ERROR: Error en mostraMovimientos de MovimientosRecepcionDao");
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

