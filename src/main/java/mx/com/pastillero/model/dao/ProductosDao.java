package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Productos;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProductosDao extends GenericoDAO 
{
	private static final Logger logger = LoggerFactory.getLogger(ProductosDao.class);
	  
	  // get producto by codbar value	  	  
	  @SuppressWarnings("unchecked")
	  public List<Productos>productoPorCodigo(String codigo)
	  {
	  	Session session = factory.openSession();
	  	List<Productos> results = null;
	  	try{
	  		session = factory.openSession();	  	
		  	Criteria cr = session.createCriteria(Productos.class);
		  	cr.add(Restrictions.eq("codBar", codigo));
		  	results = cr.list();
	  	}catch(HibernateException e){
	  		results = null;
	  		logger.error("ERROR: No se pudo consultar el producto.");
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
	  	return results;
	  }
	  
	  
	 @SuppressWarnings("unchecked")
	public List<Productos> mostrar()
	  {
		    Session session = null;	  	
		  	List<Productos> results = null;
		  	try{
		  		session = factory.openSession();	  	
			  	Criteria cr = session.createCriteria(Productos.class);
			  	results = cr.list();
		  	}catch(HibernateException e){
		  		results = null;
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
		  	return results;		  
	  }
	 	 
	public boolean actualizarproducto(Productos p)
	{
		
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx  = session.beginTransaction();
			Productos producto = (Productos) session.get(Productos.class, p.getIdProducto());
			producto.setIdProducto(p.getIdProducto());
			producto.setProveedor(p.getProveedor());
			producto.setClave(p.getClave());
			producto.setCodBar(p.getCodBar());
			producto.setDescripcion(p.getDescripcion());
			producto.setIdFamilia(p.getIdFamilia());
			producto.setPrecioPub(p.getPrecioPub());
			producto.setPrecioDesc(p.getPrecioDesc());
			producto.setPrecioFarmacia(p.getPrecioFarmacia());
			producto.setIva(p.getIva());
			producto.setLinea(p.getLinea());
			producto.setReferencia(p.getReferencia());
			producto.setSSA(p.getSSA());
			producto.setLaboratorio(p.getLaboratorio());		
			producto.setDepartamento(p.getDepartamento());
			producto.setCategoria(p.getCategoria());
			producto.setActualizable(p.getActualizable());
			producto.setDescuento(p.getDescuento());
			producto.setCosto(p.getCosto());
			producto.setEquivalencia(p.getEquivalencia());
			producto.setSuperfamilia(p.getSuperfamilia());
			producto.setCls(p.getCls());
			producto.setZona(p.getZona());
			producto.setPareto(p.getPareto());
			producto.setIeps(p.getIeps());
			producto.setIeps2(p.getIeps2());
			producto.setLimitado(p.getLimitado());
			producto.setKit(p.getKit());
			producto.setComision(p.getComision());
			producto.setMaxdescuento(p.getMaxdescuento());
			producto.setGrupo(p.getGrupo());
			producto.setAplicadescbase(p.getAplicadescbase());
			producto.setAplicapo(p.getAplicapo());
			producto.setAntibiotico(p.getAntibiotico());
			producto.setExistencias(p.getExistencias());
			producto.setUltimoproveedor(p.getUltimoproveedor());
			producto.setUltimocosto(p.getUltimocosto());
			producto.setCostopromedio(p.getCostoreal());
			producto.setCostoreal(p.getCostoreal());			
			// update product			
			session.update(producto);	
			tx.commit();
			resultado = true;
		}catch(HibernateException e){
			resultado=false;
			logger.error("Error en actualizar : Verifique datos");
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
	
	public boolean actualizarExistencias(Productos p)
	{
		
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx  = session.beginTransaction();
			Productos producto = (Productos) session.get(Productos.class, p.getIdProducto());
			producto.setExistencias(p.getExistencias());	
			// update product			
			session.update(producto);	
			tx.commit();
			resultado = true;
		}catch(HibernateException e){
			resultado=false;
			logger.error("Error en actualizar : Verifique datos");
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
	
	
	public boolean guardarProducto(Productos producto) {

		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			session.save(producto);
			tx.commit();
			resultado=true;
		} catch (Exception e1) {
			resultado=false;
			logger.error("Error funcion guardar producto ");
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
		
	// actualizar producto para la parte de cobro	
	public boolean actualizarTotales(Productos p)
	{
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx  = session.beginTransaction();
			Productos producto = (Productos) session.get(Productos.class, p.getIdProducto());
			producto.setExistencias(p.getExistencias());
			session.update(producto);
			tx.commit();
			resultado = true;
		}catch(Exception e){
			resultado=false;
			System.out.println("Error en actualizarProducto de ProductoDao");
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
	@SuppressWarnings("unchecked")
	public List<Object[]>isProducto(String codigo){
		Session session = null;
		List<Object[]> producto = null;
		try{
			session = factory.openSession();
			producto = session.createQuery("select descripcion,iva,ieps,ultimocosto,existencias from Productos where codBar='"+codigo+"'")
								.list();
		}catch(HibernateException e){
			producto = null;
			logger.error("ERROR: No se puede obtener informacion del producto.");
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
		return producto;
	}


	  
	  
		  
}
