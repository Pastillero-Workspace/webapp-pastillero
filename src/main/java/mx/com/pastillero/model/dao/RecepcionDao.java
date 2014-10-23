package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Recepcion;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
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
			vendedores = session.createQuery("select p.nombre from Usuario as u, Persona as p where u.idPersona=p.idPersona")
									.list();
			for(Object vendedor:vendedores){
				System.out.println(vendedor);
			}
		}catch(HibernateException e){
			vendedores = null;
			logger.error("ERROR: No se pude obtener la informacion de los vendedores.");
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
	public List<Object> muestraProveedores(){
		Session session = null;
		List<Object> proveedores = null;
		try{
			session = factory.openSession();
			proveedores = session.createQuery("select nombre from Proveedor").list();
		}catch(HibernateException e){
			proveedores = null;
			logger.error("ERROR: No se puede mostrar el nombre del proveedor.");
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
					+ "r.folioElectronico, r.notaFactura,r.subtotal, r.estado,u.usuario,p.nombre from Recepcion as r, Usuario as u, "
					+ "Proveedor as p where r.idUsuario=u.idUsuario and r.idProveedor=p.idProveedor").list();
		}catch(HibernateException e){
			recepciones = null;
			logger.error("ERROR: No se puede recuperar la informacion de recepcion.");
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
		return idUsuario; 
	}
	
	@SuppressWarnings("unchecked")
	public int idProveedor(String proveedor){
		Session session = null;
		List<Object> proveedores = null;
		int idProveedor = -1;
		try{
			session = factory.openSession();
			proveedores = session.createQuery("select idProveedor from Proveedor where nombre='"+proveedor+"'")
									.list();
			idProveedor =(int) proveedores.get(0); 
		}catch(HibernateException e){
			idProveedor = -1;
			logger.error("ERROR: No se pude obtener el id del proveedor.");
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
		}catch(Exception e1){
			idRecepcion = 0;
			System.out.println("Error funcion guardarUsuario de UsuarioFormDao ");
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
			recepcion.setEstado(r.getEstado());
			recepcion.setIdUsuario(r.getIdUsuario());
			recepcion.setIdProveedor(r.getIdProveedor());
		
			session.update(recepcion); 
				
			tx.commit(); 
			resultado=true;
			System.out.println("commit");
			//for(LoginForm usuario: usuarios){
				//System.out.println(usuario);}
		}catch(HibernateException e1){
			resultado=false;
			logger.error("Error funcion actualizarRecepciom de RecepcionDao ");
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
			logger.error("Error en metodo Eliminar de RecepcionDao");
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
