package mx.com.pastillero.model.dao;

import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.formBeans.DevolucionCompra;
import mx.com.pastillero.model.formBeans.DevolucionVenta;
import mx.com.pastillero.model.formBeans.MovimientoDevolucionCompra;
import mx.com.pastillero.model.formBeans.MovimientoDevolucionVenta;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DevolucionesDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(DevolucionesDao.class);
	
	@SuppressWarnings("unchecked")
	public List<Object[]> mostrarRecepcion(){
		Session session = null;
		List<Object[]> recepcion = null;
		try{
			session = factory.openSession();
			recepcion = session.createQuery("select m.fecha,p.nombre,m.idNota,m.documento,m.adquiridos,"
					+ "m.clave,m.descripcion,m.valor  from Recepcion r, MovimientoRecepcion m, Proveedor p, Productos pr "
					+ "where r.idRecepcion=m.idNota and r.idProveedor=p.idProveedor and m.clave=pr.codBar order by idNota desc").list();
		}catch(HibernateException e){
			recepcion = null;
			logger.error("ERROR: No se puede mostrar la recepcion.\n");
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
		return recepcion;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Object[]> verificarDevCompra(String codigo, String documento){
		Session session = null;
		List<Object[]> devolucion = null;
		try{
			session = factory.openSession();
			devolucion = session.createQuery("select m.descripcion,m.adquiridos, md.vendidos"
					+ " from MovimientoRecepcion m, MovimientoDevolucionCompra md where m.clave='"+codigo+"'"
					+ " and md.clave='"+codigo+"'"+" and md.documento='"+documento+"'"+" and m.documento='"+documento+"'").list();
		}catch(HibernateException e){
			devolucion = null;
			logger.error("ERROR: No se puede verificar la devolucion de la compra.");
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
		return devolucion;
	}
	
	public int insertarDevolucionCompra(DevolucionCompra devolucion){
		Session session = null;
		Transaction tx = null;
		Integer idDev = 0;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			idDev = (Integer) session.save(devolucion);
			tx.commit();
		}catch(Exception e){
			idDev = 0;
			logger.error("Error al guardar Devolucion");
			e.printStackTrace();			
		}finally{ 
			if(session!=null&&session.isOpen())
				try{  
					session.close(); 
				}catch(Exception ex){
						ex.printStackTrace();
				}
		}
		return idDev;		
	}	
	
	public boolean insertarMovimientoDevCompra(MovimientoDevolucionCompra movDevolucion){
		Session session = null;
		Transaction tx = null;
		boolean res = false;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			session.save(movDevolucion);
			tx.commit();
			res = true;
		}catch(Exception e){
			res = false;
			logger.error("Error al guardar Devolucion");
			e.printStackTrace();			
		}finally{ 
			if(session!=null&&session.isOpen())
				try{  
					session.close(); 
				}catch(Exception ex){
						ex.printStackTrace();
				}
		}
		return res;
		
	}
	
	
	
	
	@SuppressWarnings("unchecked")
	public int buscarUsuario (String user){
		Session session = null;
		List<Object> usuario = null;
		int idUsuario = -1;
		try{
			session = factory.openSession();
			usuario = session.createQuery("select idUsuario from Usuario where usuario='"+user+"'").list();
			idUsuario=(int)usuario.get(0);
		}catch(HibernateException e){
			idUsuario = -1;
			logger.error("ERROR: No su puede consultar al usuario.\n");
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
	public List<Object[]> mostrarVentas(){
		Session session = null;
		List<Object[]> ventas =null;
		try{
			session = factory.openSession();
			ventas = session.createQuery("select n.fecha, n.hora, n.idNota, p.nombre, c.nombre, n.estado, "
					+ "n.subtotal, n.descuento, n.iva, n.total from Nota n, Usuario u, Cliente c, Persona p where "
					+ "n.idUsuario=u.idUsuario and n.idCliente=c.idCliente and u.idPersona=p.idPersona order by idNota desc").list();
		}catch(HibernateException e){
			ventas =null;
			logger.error("ERROR: No se pude mostrar las ventas.\n");
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
		return ventas;
	}
	
	@SuppressWarnings("unchecked")
	public List<Object[]>mostrarVentaDetalle(int nota){
		Session session = null;
		List<Object[]> ventaDetalle = null;
		
		try{
			session = factory.openSession();
			ventaDetalle = session.createQuery("select n.fecha, n.idNota, m.clave, m.descripcion, m.vendidos, m.valor/m.vendidos, m.valor, n.iva, m.valor+n.iva "
												+ "from Nota n, MovimientoVenta m "
												+ "where n.idNota= m.idNota and m.idNota="+nota).list();
		}catch(HibernateException e){
			ventaDetalle = null;
			logger.error("ERROR: No se puede mostrar el detalle de la venta.\n");
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
		return ventaDetalle;
	}
	
	
	public int insertarDevolucionVenta(DevolucionVenta devolucion){
		Session session = null;
		Transaction tx = null;
		Integer idDev = 0;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			idDev = (Integer) session.save(devolucion);
			tx.commit();
		}catch(Exception e){
			idDev = 0;
			tx.rollback();
			logger.error("ERROR: No se puede guardar Devolucion de Venta");
			e.printStackTrace();			
		}finally{ 
			if(session!=null&&session.isOpen())
				try{  
					session.close(); 
				}catch(Exception ex){
						ex.printStackTrace();
				}
		}
		return idDev;
		
	}
	
	public boolean insertarMovimientoDevVenta(MovimientoDevolucionVenta movDevolucion){
		Session session = null;
		Transaction tx = null;
		boolean res = false;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			session.save(movDevolucion);
			tx.commit();
			res = true;
		}catch(Exception e){
			res = false;
			tx.rollback();
			logger.error("ERRORO: No se puede guardar Movimiento Devolucion de Venta");
			e.printStackTrace();			
		}finally{ 
			if(session!=null&&session.isOpen())
				try{  
					session.close(); 
				}catch(Exception ex){
						ex.printStackTrace();
				}
		}
		return res;		
	}
	
	

}
