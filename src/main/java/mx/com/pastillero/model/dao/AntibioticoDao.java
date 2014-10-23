package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Antibioticos;
import mx.com.pastillero.model.formBeans.Productos;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//try{}catch(HibernateException e){}finally{}
public class AntibioticoDao extends GenericoDAO {
	private static final Logger logger = LoggerFactory.getLogger(AntibioticoDao.class);
	
	public boolean guardarAntibiotico(Antibioticos antibiotico) {
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			session.save(antibiotico);
			tx.commit();
			resultado = true;
		} catch (HibernateException e) {
			resultado = false;
			logger.error("ERROR: No se pudo guardar en la tabla Antibioticos.");
			e.printStackTrace();
		} finally {
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return resultado;
	}

	@SuppressWarnings("unchecked")
	public boolean isAntibiotico(String codigo) {
		boolean result = false;
		Session session = null;
		try{
			session = factory.openSession();
			Criteria cr = session.createCriteria(Productos.class);
			cr.add(Restrictions.eq("codBar", codigo)).add(
					Restrictions.eq("categoria", "C"));			
			List<Productos> productos = cr.list();	
			if (productos != null && productos.size() > 0) {
				result = true;
			}
		}catch(HibernateException e){
			result = false;
			logger.error("ERROR: La consulta no fue realizada.\n");
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
		return result;
	}
}