package mx.com.pastillero.model.dao;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class GenericoDAO {
	private static final Logger logger = LoggerFactory.getLogger(GenericoDAO.class);
	protected static SessionFactory factory;
	
	static{
		try {
			factory = new Configuration().configure("mx/com/pastillero/model/hibernate.cfg.xml").buildSessionFactory();
			logger.info("***** ssessionFactory ha sido creado correctamente. ********");
		} catch (HibernateException ex) {
			logger.error("ERROR: Fallo al crear el objeto sessionFactory.\n");
			ex.printStackTrace();
		}
	}
	
	private synchronized static void createFactory(){
		if(factory == null){
			try {
				factory = new Configuration().configure("mx/com/pastillero/model/hibernate.cfg.xml").buildSessionFactory();
				logger.info("***** ssessionFactory ha sido creado correctamente. ********");
			} catch (HibernateException ex) {
				logger.error("ERROR: Fallo al crear el objeto sessionFactory.\n");
				ex.printStackTrace();
			}
		}
	}
	
	public static SessionFactory getFactory(){
		if(factory == null) createFactory();
		return factory;
	}
}
