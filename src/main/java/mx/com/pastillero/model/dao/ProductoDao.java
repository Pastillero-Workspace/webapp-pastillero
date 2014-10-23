package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Producto;
import mx.com.pastillero.model.formBeans.ProductoFamilia;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.HibernateException;
import org.hibernate.Session; 
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
  

public class ProductoDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(ProductoDao.class);
   
	@SuppressWarnings("unchecked")
	public void mostrar()
	{
		Session session = null;
		try{
			session = factory.openSession();	
			Criteria criteria = session.createCriteria(Producto.class);
			criteria.setFetchMode("Familia", FetchMode.JOIN);
			List<ProductoFamilia> list = criteria.list();
			
			int fila=1;
			for(ProductoFamilia lista:list){
				System.out.println("Registro "+fila+": "+lista);
				fila++;
			}
		}catch(HibernateException e){
			logger.error("ERROR: No se pueden mostrar los productos.");
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
	
	@SuppressWarnings("unchecked")
	public List<Object[]>isProducto(String codigo){
		Session session = null;
		List<Object[]> producto = null;
		try{
			session = factory.openSession();
			producto = session.createQuery("select descripcion,iva,ieps from Producto where codBar='"+codigo+"'").list();
		}catch(HibernateException e){
			producto = null;
			logger.error("ERROR: No sepuede obtener la informacion del producto.");
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
		return producto;
	}
	
	@SuppressWarnings("unchecked")
	public List<Producto> productoPorCodigo(String codigo){
		Session session = null;
        List<Producto> producto = null;
		try{
			session = factory.openSession();
			producto = session.createQuery("from Producto where codBar='"+codigo+"'").list();
		}catch(HibernateException e){
			producto = null;
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
		return producto;
	}
	
	public boolean guardarProducto(Producto producto) {

		System.out.println("entro a metodo guardarLogin");
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		System.out.println("entra a try");
		try {
			session = factory.openSession();
			System.out.println("obtiene sesion " + session);
			tx = session.beginTransaction();
			System.out.println("metodo saveorupdate");
			session.save(producto);
			tx.commit();
			System.out.println("commit");
			resultado = true;
		} catch (Exception e1) {
			resultado = false;
			logger.error("Error funcion guardarUsuario de UsuarioFormDao ");
			e1.printStackTrace();
		} finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			// session.close();
		}

		return resultado;
	}
	
	public boolean actualizarProducto(Producto p){
		boolean resultado = true;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx  = session.beginTransaction();
			Producto producto = (Producto) session.get(Producto.class, p.getIdProducto());
			producto.setExistencias(p.getExistencias());
			session.update(producto);
			tx.commit();
		}catch(Exception e){
			resultado=false;
			logger.error("Error en actualizarProducto de ProductoDao");
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

}
