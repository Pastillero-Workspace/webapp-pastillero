package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Cliente;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ClienteDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(ClienteDao.class);
	
	@SuppressWarnings("unchecked")
	public List<Cliente> getSearchClientebyClave(String clave)
	  {
		List<Cliente> list = null;
		Session session = factory.openSession(); 
		try{
			Criteria criteria = session.createCriteria(Cliente.class);
			criteria.add(Restrictions.eq("clave", clave));
		    list = criteria.list();
		}catch(HibernateException e){
			list = null;
			logger.error("ERROR: No se pudo guardar en la tabla Antibioticos.\n");
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
	
	@SuppressWarnings("unchecked")
	public List<Cliente> readFirstCliente()
	{
		List<Cliente> list = null;
		Session session=null;
		try{
			session= factory.openSession();
			Criteria criteria = session.createCriteria(Cliente.class);
			criteria.setMaxResults(1);   
		    if(!criteria.list().isEmpty())
		    	list = criteria.list();
		}catch(HibernateException e){
			list = null;
			logger.error("ERROR: No se puede recuperar al primer cliente.\n");
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
