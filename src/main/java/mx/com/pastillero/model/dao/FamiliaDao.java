package mx.com.pastillero.model.dao;

import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.formBeans.Familia;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session; 
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
  

public class FamiliaDao extends GenericoDAO{

	 private static final Logger logger = LoggerFactory.getLogger(FamiliaDao.class);
	@SuppressWarnings("unchecked")
	public void mostrar(){
		Session session = null;
		List<Familia> familias = null;
		try{
			session = factory.openSession();
			familias = session.createQuery("from Producto").list();
			for(Familia familia:familias)
				System.out.println(familia.toString());
		}catch(HibernateException e){
			logger.error("ERROR: No se pudo mostrar los productos.\n");
			e.printStackTrace();
		}
	}


	// get especific product by id
	@SuppressWarnings("unchecked")
	public List<Familia> getFamilia(int idFamilia){
		List<Familia> fam = null;
		Session session = null;
		try{
			session = factory.openSession();
			Criteria criteria = session.createCriteria(Familia.class);
			criteria.add(Restrictions.eq("idFamilia", idFamilia));
		    fam = criteria.list();
		}catch(HibernateException e){
			fam = null;
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
		return fam;
	}
	//get especific product by name
	@SuppressWarnings("unchecked")
	public List<Familia> getFamilia(String sFamilia){
		List<Familia> fam = null;
		Session session = null;
		try{
			session = factory.openSession();
			Criteria criteria = session.createCriteria(Familia.class);
			criteria.add(Restrictions.eq("nombre", sFamilia));
		    fam = criteria.list();
		}catch(HibernateException e){
			fam = null;
			logger.error("ERROR: Error al recuperar las familias.");
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
		return fam;
	}

	// gat all products 
	@SuppressWarnings("unchecked")
	public List<Familia> getFamilia(){
		List<Familia> fam = null;
		Session session = null;
		try{
			session = factory.openSession();
			Criteria criteria = session.createCriteria(Familia.class);
		    fam = criteria.list();  
		    if(!fam.isEmpty())
		    	logger.info("ID Cliente: "+fam.get(0).getIdFamilia());
		}catch(HibernateException e){
			fam = null;
			logger.error("ERROR: No se pudo guardar en la tabla Antibioticos.");
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
		return fam;
	}
	 
	public boolean guardarFamilia(Familia familia) {
		logger.info("entro a metodo guardarLogin");
		boolean resultado=true;
		Session session = null;
		Transaction tx=null;
		logger.info("entra a try");
		try
		{
			session = factory.openSession();
			tx=session.beginTransaction(); 
			session.save(familia); 
			tx.commit(); 
		}
		catch(HibernateException e1){
			resultado=false;
			tx.rollback();
			logger.error("Error funcion guardar familia ");
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
