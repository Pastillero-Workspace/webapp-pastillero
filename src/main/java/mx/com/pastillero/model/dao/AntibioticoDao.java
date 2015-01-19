package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Antibioticos;
import mx.com.pastillero.model.formBeans.AntibioticosCopy;
import mx.com.pastillero.model.formBeans.Productos;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//try{}catch(HibernateException e){}finally{}
public class AntibioticoDao extends GenericoDAO {
	private static final Logger logger = LoggerFactory.getLogger(AntibioticoDao.class);
	
	@SuppressWarnings("unchecked")
	public List<Object[]>mostrar(){
			Session session = null;
			List<Object[]> usuarios = null;
			try{
				session = factory.openSession();
				usuarios = session.createQuery("select pr.descripcion, a.fecha, a.documento, a.receta, a.sello, a.adquiridos, a.vendidos, a.habian, a.quedan, m.nombre, pv.nombre, a.idAntibiotico "
						+" from AntibioticosCopy as a,Productos as pr,Proveedor as pv, Medico as m "
						+" where a.idProducto = pr.idProducto and a.idMedico = m.idMedico and a.idProveedor = pv.idProveedor").list();
			}catch(HibernateException e){
				usuarios = null;
				logger.error("ERROR: No se puede mostrar usuarios.");
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
			return usuarios;
		}
	
	public boolean guardarAntibiotico(Antibioticos antibiotico, AntibioticosCopy antibioticoCopy) {
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			session.save(antibioticoCopy);
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
	
	public boolean actualizarAntibiotico(AntibioticosCopy antibioticoCopy){
		boolean resultado = false;		
		Session session = null;
		Transaction tx = null;		
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			session.update(antibioticoCopy);
			tx.commit();
			resultado = true;
		}catch(HibernateException ex){
			resultado = false;
		    logger.error("Error al actualizar");
			ex.printStackTrace();
			tx.rollback();
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
		return resultado;	
	}
	
	public List<AntibioticosCopy> getAntibioticoById(String idAntibiotico) {
		Session session = null;
		List<AntibioticosCopy> antCopy = null;
		try{
			session = factory.openSession();
			Criteria cr = session.createCriteria(Productos.class);
			cr.add(Restrictions.eq("idAntibiotico", idAntibiotico));			
			antCopy = (List<AntibioticosCopy>)cr.list();
		}catch(HibernateException e){
			logger.error("ERROR: La consulta no fue realizada.\n");
			e.printStackTrace();
			antCopy = null;
		}finally{
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return antCopy;
	}

}