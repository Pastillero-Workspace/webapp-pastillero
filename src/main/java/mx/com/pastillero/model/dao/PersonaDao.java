package mx.com.pastillero.model.dao;

import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.formBeans.Persona;
import mx.com.pastillero.model.formBeans.Usuario;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PersonaDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(PersonaDao.class);
	  	
	  // Getting data for person, finding by id user
		@SuppressWarnings("unchecked")
		public List<Persona> getPersonabyId(int id)
		  {
		  	Session session = null;
		  	List<Persona> list = null;
		    try{
		    	session = factory.openSession();
		    	Criteria criteria = session.createCriteria(Persona.class);
			  	criteria.add(Restrictions.eq("idPersona", id));
				list = criteria.list();
				System.out.println("Nombre Persona: "+list.get(0).getNombre());
		    }catch(HibernateException e){
		    	logger.error("ERROR: No se pude obtener el id de la persona.");
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
		public Persona readUniquePersonbyId(Usuario u)
		  {
			Session session = null;
			Persona p = null;
			try
			{
			  	session = factory.openSession(); 
			  	Criteria criteria = session.createCriteria(Persona.class);
			  	criteria.add(Restrictions.eq("idPersona", u.getIdPersona()));	
			  	List<Persona> list = criteria.list();
				if(!list.isEmpty())
					p = list.get(0);
			}catch(HibernateException ex)
			{
				p = null;
				logger.error("Error al obtener el usuario:");
				ex.printStackTrace();
			}
			finally
			{
				if (session != null && session.isOpen()) {
					try {
						session.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			return p;
		  }
}
