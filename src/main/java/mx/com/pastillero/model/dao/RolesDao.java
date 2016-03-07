package mx.com.pastillero.model.dao;



import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import mx.com.pastillero.model.formBeans.UserRol;
import mx.com.pastillero.model.formBeans.Roles;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session; 
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
  

public class RolesDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(RolesDao.class);
   
	
/** Devuelve una lista de roles**/
	@SuppressWarnings("unchecked")
	public String getListaRoles()
	{	
		Session session = null;
		String jsondata = new String();
		List<Roles> list = new ArrayList<Roles>();
		List<JSONObject>  l1 = new LinkedList<JSONObject>();
		try{
			session = factory.openSession();	
			Criteria criteria = session.createCriteria(Roles.class);
			list = criteria.list();
				for(Roles rol: list){
				        JSONObject obj=new JSONObject();;
				        obj.put("clave",rol.getClave());
				        obj.put("ruta",rol.getRuta());
				        l1.add(obj);
				        }		
					
			
		}catch(HibernateException e){
				logger.error("ERROR: No se pueden mostrar los roles de canela."+ e.getCause());
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
		jsondata = JSONValue.toJSONString(l1);
		return jsondata;
	}
	
	
	
/** Devuelve una lista de roles**/
	@SuppressWarnings("unchecked")
	public List<Roles> getRoles()
	{	
		Session session = null;
		List<Roles> list = new ArrayList<Roles>();
		
		try{
			session = factory.openSession();	
			Criteria criteria = session.createCriteria(Roles.class);
			list = criteria.list();
	
		}catch(HibernateException e){
				logger.error("ERROR: No se pueden mostrar los roles de canela."+ e.getCause());
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
	
/** Devuelve una lista de roles con filtrado**/ // Debería ser el trabajo de la base de datos con el inner pero bueno
	@SuppressWarnings("unchecked")
	public String getListaRolesFilter(List<UserRol> usrol)
	{	
		Session session = null;
		List<Roles> list = new ArrayList<Roles>();
		List<JSONObject>  l1 = new LinkedList<JSONObject>();

		String jsondata = new String();
		try{
			session = factory.openSession();	
			Criteria criteria = session.createCriteria(Roles.class);
			list = criteria.list();
			for(UserRol r:usrol){
				for(Roles rol: list)
					if(r.getId_rol() == rol.getId_rol()){
				        JSONObject obj=new JSONObject();
				        obj.put("idusr",r.getIdUsuario());
				        obj.put("clave",rol.getClave());
				        obj.put("descripcion",rol.getDescripcion());
				        
				        l1.add(obj);
				        }		
			}
			
		}catch(HibernateException e){
				logger.error("ERROR: No se pueden mostrar los roles de canela."+ e.getCause());
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
	jsondata = JSONValue.toJSONString(l1);
	return jsondata;
	}
	
/** metodo generico **/
/*	public Map<String,List<Roles>> getMapaRoles()
	{
		List<Roles> list = getListaRoles();		
		List<Roles> generic_map = new ArrayList<Roles>();
		String[] string_rol = {"ME","CR","RC","CL","MD","PR","PD","US","BA"};
		Map<String,List<Roles>> maproles = new HashMap<String,List<Roles>>();
		// adding entryes for mapkey
		for(String rol:string_rol)
		{
			for(Roles r: list)
			{				
				if(r.getClave().contains(rol)){				
					  generic_map.add(r);
					  }
			}
			maproles.put(rol, new ArrayList<Roles>(generic_map));
			generic_map.clear();
		}

	return maproles;
	}*/


/**  insertar permisos **/	
	
	 public Integer addRol(String clave, String descripcion, String ruta){
		 
		  Session session = null;
	      
	      Transaction tx = null;
	      Integer resultset = null;
	      try{
	    	 session = factory.openSession();
	         tx = session.beginTransaction();
	         Roles rol = new Roles();
	         /* guardar valores en obj */
	         rol.setClave(clave);
	         rol.setDescripcion(descripcion);
	         rol.setRuta(ruta);
	         resultset = (Integer) session.save(rol); 
	         tx.commit();
	      }catch (HibernateException e) {
	         if (tx!=null) tx.rollback();
	         e.printStackTrace(); 
	      }finally {
	         session.close(); 
	      }
	      return resultset;
	   }
	 
/** actualizar permisos **/
	 
		public boolean updateRol(Roles r){
			boolean resultado = true;
			Session session = null;
			Transaction tx = null;
			try{
				session = factory.openSession();
				tx  = session.beginTransaction();
				Roles rol = (Roles) session.get(Roles.class, r.getId_rol());			
				rol.setClave(r.getClave());
				rol.setDescripcion(r.getDescripcion());
				rol.setRuta(r.getRuta());
				
				session.update(rol);
				tx.commit();
			}catch(Exception e){
				resultado=false;
				logger.error("Error en updateRoles RolesDao");
				e.printStackTrace();
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
		
	/** **/
		public Roles readRol(String clave){
			Roles result = new Roles();
			Session session = factory.openSession();
		  
		  	try{
		  		session = factory.openSession();	  	
			  	Criteria cr = session.createCriteria(Roles.class);
			  	cr.add(Restrictions.eq("clave", clave));
			  	result = (Roles) cr.uniqueResult();
		  	}catch(HibernateException e){
		  		result = null;
		  		logger.error("ERROR: No se pudo consultar el permiso. "+e);
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