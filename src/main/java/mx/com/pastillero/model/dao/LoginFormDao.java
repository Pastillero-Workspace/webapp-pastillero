
package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.LoginForm;

import org.hibernate.HibernateException;
import org.hibernate.Session; 
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
  

public class LoginFormDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(LoginFormDao.class);
	
	@SuppressWarnings("unchecked")
	public void mostrar()
	{
		Session session = null;
		try{
			session = factory.openSession();
			List<LoginForm> usuarios = session.createQuery("from LoginForm").list();
			for(LoginForm usuario:usuarios)
				System.out.println(usuario.toString());
		}catch(HibernateException e){
			logger.error("ERROR: No se puede mostrar loginForm.");
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
		
	}
		  
	public boolean guardarLogin(LoginForm ptt) {
			
		boolean resultado=true;
		Session session = null;
		Transaction tx=null;
		logger.info("entra a try");
		try{
			session = factory.openSession();
			logger.info("obtiene sesion "+session);
			tx=session.beginTransaction(); 
			logger.info("metodo saveorupdate");
			session.save(ptt); 
			
			//List<LoginForm> usuarios=session.createQuery("from loginform").list();
			tx.commit(); 
			logger.info("commit");
			//for(LoginForm usuario: usuarios){
				//System.out.println(usuario);}
		}catch(Exception e1){
			resultado=false;
			logger.error("Error funcion guardarUsuario de UsuarioFormDao ");
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
