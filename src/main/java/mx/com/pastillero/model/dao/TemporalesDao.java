package mx.com.pastillero.model.dao;

import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.formBeans.TemporalNotaVenta;
import mx.com.pastillero.model.formBeans.TemporalProductoVenta;
import mx.com.pastillero.model.formBeans.TemporalTotalesVenta;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TemporalesDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(TemporalesDao.class);
	
	public boolean guardarNotaVentaTemporal(TemporalNotaVenta nota) {
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			session.save(nota);
			tx.commit();
			resultado = true;
		} catch (HibernateException e) {
			resultado = false;
			logger.info("ERROR: No se pudo guardar en la tabla TemporalNota."+e);
			e.printStackTrace();
		} finally {
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return resultado;
	}
	
	
	public boolean actualizarNotaVentaTemporal(TemporalNotaVenta nota) {
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			TemporalNotaVenta n = (TemporalNotaVenta) session.get(TemporalNotaVenta.class, nota.getFolio());
			n.setCliente(nota.getCliente());
			n.setDescripcion(nota.getDescripcion());
			session.update(n);
			tx.commit();
			resultado = true;
		} catch (HibernateException e) {
			resultado = false;
			logger.info("ERROR: No se pudo guardar en la tabla TemporalNota."+e);
			e.printStackTrace();
			tx.rollback();
		} finally {
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return resultado;
	}
	
	
	public boolean guardarProductoVentaTemporal(TemporalProductoVenta producto) {
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			session.save(producto);
			tx.commit();
			resultado = true;
		} catch (HibernateException e) {
			resultado = false;
			logger.info("ERROR: No se pudo guardar en la tabla TemporalProductoVenta."+e);
			e.printStackTrace();
		} finally {
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return resultado;
	}
	
	
	public boolean guardarTotalesVentaTemporal(TemporalTotalesVenta totales) {
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			session.saveOrUpdate(totales);
			tx.commit();
			resultado = true;
		} catch (HibernateException e) {
			resultado = false;
			logger.info("ERROR: No se pudo guardar en la tabla TemporalTotales."+e);
			e.printStackTrace();
		} finally {
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return resultado;
	}
	
	@SuppressWarnings("unchecked")
	public List<TemporalNotaVenta> getNota(String usuario){
		List<TemporalNotaVenta> notaVenta = new ArrayList<TemporalNotaVenta>();
		Session session = null;
		try{
			session = factory.openSession();
			notaVenta =  session.createQuery("from TemporalNotaVenta where usuario = :usuario")
											.setParameter("usuario", usuario).list();
		}catch(HibernateException e){
			notaVenta = null;
			logger.info("Error al obtener nota. "+e);
		}finally{
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return notaVenta;
	}
	
	@SuppressWarnings("unchecked")
	public List<TemporalProductoVenta> getProductos(int nota){
		List<TemporalProductoVenta> productos = new ArrayList<TemporalProductoVenta>();
		Session session = null;
		try{
			session = factory.openSession();
			productos = session.createQuery("from TemporalProductoVenta where nota = :nota")
											.setParameter("nota", nota).list();
		}catch(HibernateException e){
			productos = null;
			logger.info("Error al obtener productos temporales. "+e);
		}finally{
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return productos; 
	}
	
	@SuppressWarnings("unchecked")
	public List<TemporalProductoVenta> getProductoEliminar(TemporalProductoVenta producto){
		List<TemporalProductoVenta> productos = new ArrayList<TemporalProductoVenta>();
		Session session = null;
		try{
			session = factory.openSession();
			productos = session.createQuery("from TemporalProductoVenta where nota = :nota and codigo = :codigo and cantidad = :cantidad")
											.setParameter("nota", producto.getNota())
											.setParameter("codigo", producto.getCodigo())
											.setParameter("cantidad", producto.getCantidad()).list();
		}catch(HibernateException e){
			productos = null;
			logger.info("Error al obtener productos temporales. "+e);
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
		return productos; 
	}
	
	
	@SuppressWarnings("unchecked")
	public List<TemporalTotalesVenta> getTotales(int nota){
		List<TemporalTotalesVenta> totalesVenta = new ArrayList<TemporalTotalesVenta>();
		Session session = null;
		try{
			session = factory.openSession();
			totalesVenta =  session.createQuery("from TemporalTotalesVenta where nota = :nota")
												.setParameter("nota", nota).list();
		}catch(HibernateException e){
			totalesVenta = null;
			logger.info("Error al obtener totales temporales. "+e);
		}finally{
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return totalesVenta;
	}
	
	public boolean eliminarNotaVentaTemporal(int idNota){
		boolean resultado = false;
		Session session = null;
		Transaction tx= null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			TemporalNotaVenta nota = (TemporalNotaVenta) session.get(TemporalNotaVenta.class, idNota);
			session.delete(nota);
			tx.commit();
			resultado = true;
		}catch(Exception ex){
			resultado = false;
			logger.info("Error al eliminar nota Temporal "+ex);
			ex.printStackTrace();
			tx.rollback();
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
	
	
	public boolean eliminarTotalesVentaTemporal(int idNota){
		boolean resultado = false;
		Session session = null;
		Transaction tx= null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			TemporalTotalesVenta totales = (TemporalTotalesVenta) session.get(TemporalTotalesVenta.class, idNota);
			session.delete(totales);
			tx.commit();
			resultado = true;
		}catch(Exception ex){
			resultado = false;
			logger.info("Error al eliminar totales de nota Temporal "+ex);
			ex.printStackTrace();
			tx.rollback();
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
	
	public boolean eliminarProductoVentaTemporal(int nota){
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			Query query = session.createQuery("delete TemporalProductoVenta where nota = :nota").setParameter("nota", nota);
			int result = query.executeUpdate();
			tx.commit();
			logger.info("Se eliminaron "+result+" productos almacenados de manera temporal");
			resultado = true;
		}catch(Exception ex){
			tx.rollback();
			resultado = false;
			logger.info("Error al eliminar producto Temporal "+ex);
			ex.printStackTrace();
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
	
	
	public boolean eliminarProductoVentaTemporal(TemporalProductoVenta producto){
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			session.delete(producto);
			tx.commit();
			resultado = true;
		}catch(Exception ex){
			tx.rollback();
			resultado = false;
			logger.info("Error al eliminar producto Temporal "+ex);
			ex.printStackTrace();
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
}


