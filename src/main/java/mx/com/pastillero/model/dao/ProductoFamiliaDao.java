package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Productos;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session; 
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

  

public class ProductoFamiliaDao extends GenericoDAO {
	private static final Logger logger = LoggerFactory.getLogger(ProductoFamiliaDao.class);
	   
	@SuppressWarnings("unchecked")
	public List<Object[]> mostrar()
	{
		Session session = null;	
		List<Object[]> list = null;
		try{
			session = factory.openSession();
			list = session.createQuery("select p.idProducto, p.codBar, p.existencias, p.descripcion, f.nombre,"
					+ "p.laboratorio, p.cls, p.SSA, p.iva, p.ieps, p.categoria, p.pareto, p.precioPub, p.precioDesc"
					+ " from Productos as p, Familia as f where p.idFamilia = f.idFamilia").list();
		}catch(HibernateException e){
			list = null;
			logger.error("ERROR: No se pudo mostrar la informacion de los productos por famila.");
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
	
	
	/*METODO: getProductoByCodigo 
	 * Entrada: codigo de barras a buscar
	 * retorno: objeto del tipo buscado, si este se encuentra devuelve el objeto con datos
	 * si no, solamente retorna null*/
	@SuppressWarnings("unchecked")
	public Object[] getProductobyCodigo(String codigoBarra)
	{
		List<Object[]> list = null;
		Object[] resultset = null;
		Session session = null;
		try{
			session = factory.openSession();
			Query query = session.createQuery("select p.idProducto, p.codBar, p.existencias, p.descripcion, f.nombre,"
					 + "p.laboratorio, p.cls, p.ssa, p.iva, p.ieps, p.categoria, p.pareto, p.precioPub, p.precioDesc"
					 + " from Productos as p, Familia as f where p.idFamilia=f.idFamilia and p.codBar = '"+codigoBarra+"'");
		    list = query.list();
			if(!list.isEmpty())
			{
				resultset = list.get(0);
			}
		}catch(HibernateException e){
			resultset = null;
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
		return resultset;
	}
		 
	public boolean guardarProducto(Productos producto) {
	
		boolean resultado=false;
		Session session = null;
		Transaction tx=null;
		try{
			session = factory.openSession();
			tx=session.beginTransaction(); 
			session.save(producto); 
			tx.commit(); 
			resultado = true;
		}catch(HibernateException e1){
			resultado=false;
			logger.error("ERROR: No se puede guardar el producto");
			e1.printStackTrace();
		}
		finally{ 
			if(session!=null&&session.isOpen())
				try{  
					session.close(); 
				}catch(Exception ex){
						ex.printStackTrace();
				}
		}	
		return resultado;
	}


}
