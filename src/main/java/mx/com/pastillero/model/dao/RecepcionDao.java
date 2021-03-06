package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Proveedor;
import mx.com.pastillero.model.formBeans.Recepcion;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RecepcionDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(RecepcionDao.class);
	
	@SuppressWarnings("unchecked")
	public List<Object> muestraVendedores(){
		Session session = null;
		List<Object> vendedores = null;
		try{
			session = factory.openSession();
			vendedores = session.createQuery("select p.nombre from Usuario as u, Persona as p where u.idPersona=p.idPersona").list();
		}catch(HibernateException e){
			vendedores = null;
			logger.info("ERROR: No se pude obtener la informacion de los vendedores.");
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
		return vendedores;
	}
	
	@SuppressWarnings("unchecked")
	public List<Proveedor> muestraProveedores(){
		Session session = null;
		List<Proveedor> proveedores = null;
		try{
			session = factory.openSession();
			proveedores = session.createQuery("from Proveedor").list();
		}catch(HibernateException e){
			proveedores = null;
			logger.info("ERROR: No se puede mostrar el nombre del proveedor. "+e);
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
		return proveedores;
	}
	@SuppressWarnings("unchecked")
	public List<Object[]>muestraRecepciones(){
		Session session = null;
		List<Object[]> recepciones = null;
		try{
			session = factory.openSession();
			recepciones = session.createQuery("select r.idRecepcion, r.numFactura, r.fecha, r.hora, r.desc1, r.desc2, "
					+ "r.folioElectronico, r.notaFactura,r.subtotal, r.iva, r.ieps, r.ieps2, r.total, r.estado,u.usuario,p.nombre from Recepcion as r, Usuario as u, "
					+ "Proveedor as p where r.idUsuario=u.idUsuario and r.idProveedor=p.idProveedor order by r.idRecepcion desc").list();
		}catch(HibernateException e){
			recepciones = null;
			logger.info("ERROR: No se puede recuperar la informacion de recepcion."+e);
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
		return recepciones;
	}
	
	@SuppressWarnings("unchecked")
	public int idUsuario(String usuario){
		Session session = null;
		List<Object> usuarios = null;
		int idUsuario = -1;
		try{
			session = factory.openSession();
			usuarios = session.createQuery("select u.idUsuario from Usuario as u, Persona p where p.idPersona=u.idPersona and p.nombre='"+ usuario+ "'")
								.list();
			idUsuario = (int)usuarios.get(0);
		}catch(HibernateException e){
			idUsuario = -1;
			logger.info("ERROR: No se pudo obtener usuario. "+e);
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
		return idUsuario; 
	}
	
	@SuppressWarnings("unchecked")
	public int idProveedor(String proveedor){
		Session session = null;
		List<Object> proveedores = null;
		int idProveedor = -1;
		try{
			session = factory.openSession();
			proveedores = session.createQuery("select idProveedor from Proveedor where nombre='"+proveedor+"'").list();
			idProveedor =(int) proveedores.get(0); 
		}catch(HibernateException e){
			idProveedor = -1;
			logger.info("ERROR: No se pude obtener el id del proveedor. "+e);
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
		return idProveedor; 
	}
	
	public int guardarRecepcion(Recepcion recepcion) {
		Integer idRecepcion = 0;
		Session session = null; 
		Transaction tx=null;
		try{
			session = factory.openSession();
			tx=session.beginTransaction(); 
			idRecepcion = (Integer)session.save(recepcion); 
			tx.commit(); 
		}catch(Exception e){
			idRecepcion = 0;
			logger.info("Error al guardar recepcion "+e);
			e.printStackTrace();
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
		return idRecepcion;
	}
	
	public boolean actualizarRecepcion(Recepcion r) {
		boolean resultado=false;
		Session session = null; 
		Transaction tx=null;
		try{
			session = factory.openSession();
			tx=session.beginTransaction();
			Recepcion recepcion = (Recepcion)session.get(Recepcion.class, r.getFolioElectronico());
			recepcion.setNumFactura(r.getNumFactura());
			recepcion.setFecha(r.getFecha());
			recepcion.setHora(r.getHora());
			recepcion.setDesc1(r.getDesc1());
			recepcion.setDesc2(r.getDesc2());
			recepcion.setFolioElectronico(r.getFolioElectronico());
			recepcion.setNotaFactura(r.getNotaFactura());
			recepcion.setSubtotal(r.getSubtotal());
			recepcion.setIva(r.getIva());
			recepcion.setIeps(r.getIeps());
			recepcion.setIeps2(r.getIeps2());
			recepcion.setTotal(r.getTotal());
			recepcion.setEstado(r.getEstado());
			recepcion.setIdUsuario(r.getIdUsuario());
			recepcion.setIdProveedor(r.getIdProveedor());
		
			session.update(recepcion); 
				
			tx.commit(); 
			resultado=true;
			//for(LoginForm usuario: usuarios){
				//System.out.println(usuario);}
		}catch(HibernateException e){
			resultado=false;
			logger.info("Error al actualizar recepcion "+e);
			e.printStackTrace();
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
	
	public boolean eliminar(int idRecepcion){
		boolean resultado=false;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			Recepcion recepcion = (Recepcion)session.get(Recepcion.class, idRecepcion);
			session.delete(recepcion);
			tx.commit();
			resultado=true;
		}catch(HibernateException e){
			resultado = false;
			logger.info("Error al eliminar recepcion "+e);
			e.printStackTrace();
		}
		finally{
			if(session!=null&&session.isOpen()){
				try{
					session.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		return resultado;
	}
	
	
}
