package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Salida;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SalidaDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(SalidaDao.class);
	
	public int guardarSalida(Salida salida) {
		Integer idSalida = 0;
		Session session = null; 
		Transaction tx=null;
		try{
			session = factory.openSession();
			tx=session.beginTransaction(); 
			idSalida = (Integer)session.save(salida); 
			tx.commit(); 
			
		}catch(HibernateException e1){
			idSalida = 0;
			System.out.println("Error al guarda salida ");
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
		
		return idSalida;
	}
	
	
	public boolean actualizarSalida(Salida s) {
		boolean resultado=false;
		Session session = null; 
		Transaction tx=null;
		try{
			session = factory.openSession(); 
			tx=session.beginTransaction();
			Salida salida = (Salida)session.get(Salida.class, s.getFolioElectronico());
			salida.setFecha(s.getFecha());
			salida.setHora(s.getHora());
			salida.setMerma(s.getMerma());
			salida.setNumFactura(s.getNumFactura());
			salida.setFolioElectronico(s.getFolioElectronico());
			salida.setSubtotal(s.getSubtotal());
			salida.setIdUsuario(s.getIdUsuario());
			
			session.update(salida); 
			tx.commit(); 
			resultado=true;
		}catch(HibernateException e1){
			resultado=false;
			logger.error("Error al actualizar Salida ");
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
	
		
}
