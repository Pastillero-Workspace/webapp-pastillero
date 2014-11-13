package mx.com.pastillero.model.dao;

import mx.com.pastillero.model.formBeans.DetalleRecepcion;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DetalleRecepcionDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(DetalleRecepcionDao.class);
		
	public boolean guardarDetalleRecepcion(DetalleRecepcion detalle) {
		System.out.println("entro a metodo guardarLogin");
		boolean resultado=true;
		Session session = null; 
		Transaction tx=null;
		System.out.println("entra a try");
		try{
			session = factory.openSession(); 
			System.out.println("obtiene sesion "+session);
			tx=session.beginTransaction(); 
			System.out.println("metodo saveorupdate");
			session.save(detalle); 
			
			//List<LoginForm> usuarios=session.createQuery("from loginform").list();
			tx.commit(); 
//			System.out.println("commit");
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
