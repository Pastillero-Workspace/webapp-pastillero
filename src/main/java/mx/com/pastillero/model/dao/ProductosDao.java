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
	  		logger.error("ERROR: No se pudo consultar el producto. "+e);
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
		  		logger.info("ERROR: No se pudieron mostrar los productos. "+e);
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
			producto.setProveedor2(p.getProveedor2());
			producto.setProveedor3(p.getProveedor3());
			producto.setClave(p.getClave());
			producto.setCodBar(p.getCodBar());
			producto.setDescripcion(p.getDescripcion());
			producto.setIdFamilia(p.getIdFamilia());
			producto.setPrecioPub(p.getPrecioPub());
			producto.setPrecioDesc(p.getPrecioDesc());
			producto.setPrecioFarmacia(p.getPrecioFarmacia());
			producto.setFechaPcio(p.getFechaPcio());
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
			producto.setPareto2(p.getPareto2());
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
			producto.setEspecial(p.getEspecial());
			producto.setFamactualizar(p.getFamactualizar());
			producto.setCominmediata(p.getCominmediata());
			producto.setUltimoproveedor(p.getUltimoproveedor());
			producto.setUltimocosto(p.getUltimocosto());
			producto.setCostopromedio(p.getCostopromedio());
			producto.setCostoreal(p.getCostoreal());			
			// update product			
			session.update(producto);	
			tx.commit();
			resultado = true;
			logger.info("Producto Actualizado con Exito! "+producto.getIdProducto());
		}catch(HibernateException e){
			resultado=false;
			logger.info("Error al Actualizar el producto "+e);
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
	
	public boolean actualizarExistencias(Productos p){
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx  = session.beginTransaction();
			Productos producto = (Productos) session.get(Productos.class, p.getIdProducto());
			producto.setExistencias(p.getExistencias());
			producto.setUltimocosto(p.getUltimocosto());
			producto.setCosto(p.getCosto());
			producto.setUltimoproveedor(p.getUltimoproveedor());
			// update product			
			session.update(producto);	
			tx.commit();
			resultado = true;
			logger.info("Existencias del producto actualizadas con Exito! "+producto.getExistencias());
		}catch(HibernateException e){
			resultado=false;
			logger.info("Error al actualizar Existencias de producto. "+e);
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
		} catch (Exception e) {
			resultado=false;
			logger.info("Error funcion guardar producto "+e);
			e.printStackTrace();
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
	public boolean actualizarTotales(Productos p){
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
			logger.info("Existencias de producto Actualizadas con Exito! "+producto.getExistencias());
		}catch(Exception e){
			resultado=false;
			logger.info("Error al Actualizar Existencias de Producto. "+e);
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
			producto = session.createQuery("select descripcion,iva,ieps,ieps2,costo,existencias from Productos where codBar='"+codigo+"'").list();
		}catch(HibernateException e){
			producto = null;
			logger.info("ERROR: No se puede obtener informacion del producto. "+e);
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


	@SuppressWarnings("unchecked")
	public List<Object[]> buscarCodigo(String codigo)
	{
		Session session = null;	
		List<Object[]> list = null;
		try{
			session = factory.openSession();
			list = session.createQuery("select p.proveedor,p.proveedor2,p.proveedor3, p.clave, p.codBar, p.descripcion, p.existencias, f.nombre, p.precioPub, p.precioDesc, p.precioFarmacia,"
					+"p.fechaPcio,p.iva, p.linea, p.referencia, p.SSA, p.laboratorio, p.departamento, p.categoria, p.actualizable, p.descuento, p.costo,"
					+"p.equivalencia, p.superfamilia, p.cls, p.zona, p.pareto, p.pareto2, p.ieps, p.ieps2, p.limitado, p.kit, p.comision, p.maxdescuento,"
					+"p.grupo, p.aplicadescbase, p.aplicapo, p.antibiotico, p.especial, p.famactualizar, p.cominmediata, p.ultimoproveedor, p.ultimocosto, p.costopromedio, p.costoreal "
					+ " from Productos as p, Familia as f "
					+ "where p.idFamilia = f.idFamilia and p.codBar like '%"+codigo+"'").list();
		}catch(HibernateException e){
			list = null;
			logger.info("ERROR: No se pudo mostrar la informacion de los productos. "+e);
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


	@SuppressWarnings("unchecked")
	public List<Object[]> buscarDescripcion(String descripcion) {
		Session session = null;	
		List<Object[]> list = null;
		try{
			session = factory.openSession();
			list = session.createQuery("select p.proveedor,p.proveedor2,p.proveedor3, p.clave, p.codBar, p.descripcion, p.existencias, f.nombre, p.precioPub, p.precioDesc, p.precioFarmacia,"
					+"p.fechaPcio,p.iva, p.linea, p.referencia, p.SSA, p.laboratorio, p.departamento, p.categoria, p.actualizable, p.descuento, p.costo,"
					+"p.equivalencia, p.superfamilia, p.cls, p.zona, p.pareto, p.pareto2, p.ieps, p.ieps2, p.limitado, p.kit, p.comision, p.maxdescuento,"
					+"p.grupo, p.aplicadescbase, p.aplicapo, p.antibiotico, p.especial, p.famactualizar, p.cominmediata, p.ultimoproveedor, p.ultimocosto, p.costopromedio, p.costoreal "
					+ " from Productos as p, Familia as f "
					+ "where p.idFamilia = f.idFamilia and p.descripcion like '%"+descripcion+"%'").list();
		}catch(HibernateException e){
			list = null;
			logger.info("ERROR: No se pudo mostrar la informacion de los productos. "+e);
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
	
	
	
	
}
