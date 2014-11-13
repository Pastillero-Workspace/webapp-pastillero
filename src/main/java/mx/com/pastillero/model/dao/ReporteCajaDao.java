package mx.com.pastillero.model.dao;

import mx.com.pastillero.model.formBeans.ReporteCaja;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ReporteCajaDao extends GenericoDAO {
	private static final Logger logger = LoggerFactory.getLogger(ReporteCajaDao.class);
	  
	  public Integer createReporteCaja(ReporteCaja  rc) 
	  {
			Integer idReporteCaja = null;
			Session session = null;
			Transaction tx=null;
			try{
				session = factory.openSession();
				tx=session.beginTransaction(); 
				idReporteCaja= (Integer)session.save(rc); 
				tx.commit(); 
			}catch(HibernateException e1)
			{
				idReporteCaja = 0;
				logger.error("Error funcion guardar sesion ");
				e1.printStackTrace();
			}
			finally{ 
				if(session!=null&&session.isOpen())
					try{  
						session.close(); 
					}catch(Exception ex){
							ex.printStackTrace();
					}

			}			
			return idReporteCaja;
	 }

}
