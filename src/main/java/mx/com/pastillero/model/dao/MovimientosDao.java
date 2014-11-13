package mx.com.pastillero.model.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mx.com.pastillero.model.formBeans.Movimientos;

public class MovimientosDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(MovimientosDao.class);
	
	@SuppressWarnings("unchecked")
	public List<Movimientos> mostrar()
	{
		Session session = null;	
		List<Movimientos> list = null;
		try{
			session = factory.openSession();
			list = session.createQuery("select movimientos, folio, documento, clave, descripcion, adquiridos, vendidos,valor,habian,quedan,fecha,hora from Movimientos inner join"
					+ "select movimientos, folio, documento, clave, descripcion, adquiridos, vendidos,valor,habian,quedan,fecha,hora from Movimientos").list();
		}catch(HibernateException e){
			list = null;
			logger.error("ERROR: No se pudieron mostrar los movimientos.");
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
}
