package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Direccion;
import mx.com.pastillero.model.formBeans.Proveedor;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProveedorDireccionDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(ProveedorDireccionDao.class);
	
	@SuppressWarnings("unchecked")
	public List<Object[]> mostrar(){
		Session session = null;
		List<Object[]> proveedor = null;
		try{
			session = factory.openSession();
			proveedor =  session.createQuery("select p.idProveedor, p.nombre, p.email, p.fax, p.rfc,"
					+ " p.diasCredito, p.idDireccion, p.descGeneral, p.desc2, p.desc3, d.calle, d.noInt, d.noExt, d.colonia, "
					+ "d.ciudad, d.estado, d.cp from Proveedor as p, Direccion as d where p.idDireccion=d.idDireccion").list();
		
			for(Object[] p:proveedor){
				System.out.println("idProveedor[0] "+p[0]+" nombre[1] "+p[1]+" email[2] "+p[2]+" fax[3] "+p[3]+" rfc[4] "+p[4]+" diasCred[5] "+p[5]+" idDireccion[6] "+p[6]+" desGeneral[7] "+p[7]+" desc2[8] "
						+p[8]+" desc3[9] "+p[9]+" calle[10]"+p[10]+" noInt[11] "+p[11]+" noExt[12] "+p[12]+" colonia[13]"+p[13]+" estado[14]"+p[14]+" cp[15]"+p[15]);
			}
		}catch(HibernateException e){
			proveedor = null;
			logger.error("ERROR: No se pudo recuperar la informacion del proveedor.");
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
		return proveedor;
	}
	
	public int guardarDireccion(Direccion d){
		Session session = null;
		Transaction tx = null;
		Integer id = 0;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			id = (Integer) session.save(d);
			tx.commit();
		}catch(HibernateException ex){
			id = 0;
			logger.error("Error al guardar Direccion");
			ex.printStackTrace();
			tx.rollback();
		}finally{
			if(session!=null&&session.isOpen()){
				try{
					session.close();
				}catch(Exception ex){
					ex.printStackTrace();
				}
			}
		}
		return id;
	}
	
	public boolean guardarProveedor(Proveedor p){
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			session.save(p);
			tx.commit();
			resultado = true;
		}catch(Exception ex){
			resultado = false;
			System.out.println("Error al guardar Proveedor");
			ex.printStackTrace();
			tx.rollback();
		}finally{
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
	
	public boolean actualizarProveedor(Proveedor p, Direccion d){
		boolean resultado = false;
		
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			Proveedor proveedor = (Proveedor) session.get(Proveedor.class, p.getIdProveedor());
			proveedor.setNombre(p.getNombre());
			proveedor.setEmail(p.getEmail());
			proveedor.setFax(p.getFax());
			proveedor.setRfc(p.getRfc());
			proveedor.setDiasCredito(p.getDiasCredito());
			proveedor.setDescGeneral(p.getDescGeneral());
			proveedor.setDesc2(p.getDesc2());
			proveedor.setDesc3(p.getDesc3());
			
			session.update(proveedor);
			
			Direccion direccion = (Direccion) session.get(Direccion.class, d.getIdDireccion());
			direccion.setCalle(d.getCalle());
			direccion.setNoInt(d.getNoInt());
			direccion.setNoExt(d.getNoExt());
			direccion.setColonia(d.getColonia());
			direccion.setCiudad(d.getCiudad());
			direccion.setEstado(d.getEstado());
			direccion.setCp(d.getCp());
			
			session.update(direccion);
			
			tx.commit();
			resultado = true;
		}catch(HibernateException ex){
			resultado = false;
			logger.error("Error al actualizar proveedor");
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
	
	@SuppressWarnings("unchecked")
	public List<Object[]> getIdProveedor(String nombre){
		Session session = null;
		List<Object[]> proveedor = null;
		try{
			session = factory.openSession();
			proveedor = session.createQuery("select idProveedor,idDireccion from Proveedor where nombre ='"+nombre+"'")
							.list();
		}catch(HibernateException e){
			proveedor = null;
			logger.error("ERROR: No de puede obtener la informacion del proveedor.");
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
		return proveedor;
	} 
	
	public boolean eliminarProveedor(int idProveedor){
		boolean resultado = false;
		Session session = null;
		Transaction tx= null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			Proveedor proveedor = (Proveedor) session.get(Proveedor.class, idProveedor);
			session.delete(proveedor);
			tx.commit();
			resultado = true;
		}catch(Exception ex){
			resultado = false;
			logger.error("Error al eliminar proveedor");
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

}
