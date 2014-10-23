package mx.com.pastillero.model.dao;

import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.formBeans.Direccion;
import mx.com.pastillero.model.formBeans.Persona;





import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DireccionDao extends GenericoDAO {
	private static final Logger logger = LoggerFactory.getLogger(DireccionDao.class);
	  
	  @SuppressWarnings("unchecked")
	  public Direccion readUniqueDirectionbyId(Persona p){
		Session session = null;
		List<Direccion> list = new ArrayList<Direccion>();
		Direccion d = null;
		try{
		  	session = factory.openSession(); 
		  	Criteria criteria = session.createCriteria(Direccion.class);
		  	criteria.add(Restrictions.eq("idDireccion", p.getIdDireccion()));	
			list = criteria.list();
			if(!list.isEmpty())
				d = list.get(0);
		}catch(HibernateException e){
			d=null;
			logger.error("ERRor: No se puede obtener al obtener el usuario");
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
		return d;
	  }
	  

}
