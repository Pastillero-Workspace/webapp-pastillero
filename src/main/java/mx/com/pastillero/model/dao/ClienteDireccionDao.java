package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Cliente;
import mx.com.pastillero.model.formBeans.Direccion;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ClienteDireccionDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(ClienteDireccionDao.class);
		
	@SuppressWarnings("unchecked")
	public List<Object[]>mostrar(){
		Session session = null;
		List<Object[]> clientes=null;
		try{
			session = factory.openSession();
			clientes = session.createQuery("select c.clave, c.nombre, c.email, c.rfc, c.idDireccion, c.credito, c.diasCredito, c.limiteCredito, "
						+ "c.ventaAnual, c.saldo, c.insen, c.descuentoExtra, c.ventaMensual, d.calle, d.noExt, d.noInt,d.colonia,d.ciudad, "
						+ "d.estado,d.cp from Cliente as c, Direccion as d where c.idDireccion=d.idDireccion").list();
		}catch(HibernateException e){
			session = null;clientes=null;
			logger.error("ERROR: No se puede recuperar la informacion del los clientes.");
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
		return clientes;
	}
	
	@SuppressWarnings("unchecked")
	public List<Object[]> getIdCliente(String clave){
		Session session = factory.openSession();
		
		List<Object[]> cliente = session.createQuery("select idCliente ,idDireccion from Cliente where clave ='"+clave+"'").list();
		
		return cliente;		
	}
	
	
	public int guardarDireccion(Direccion d){
		Session session = factory.openSession();
		Transaction tx = null;
		Integer id = 0;
		try{
			tx = session.beginTransaction();
			id = (Integer) session.save(d);
			tx.commit();
		}catch(Exception ex){
			System.out.println("Error al guardar Direccion");
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
	
	public boolean guardarCliente(Cliente c){
		logger.info("Guardando Cliente Nuevo...");
		boolean resultado = true;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			session.save(c);
			tx.commit();
			logger.info("Cliente Guardado con Exito!");
		}catch(Exception ex){
			resultado = false;
			logger.info("Error al Guardar Cliente.");
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
	public boolean actualizarCliente(Cliente c, Direccion d){
		logger.info("Actualizando Cliente...");
		boolean resultado = true;
		Session session = null;
		Transaction tx = null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			Cliente cliente = (Cliente) session.get(Cliente.class, c.getIdCliente());
			cliente.setClave(c.getClave());
			cliente.setNombre(c.getNombre());
			cliente.setEmail(c.getEmail());
			cliente.setRfc(c.getRfc());
			cliente.setCredito(c.getCredito());
			cliente.setDiasCredito(c.getDiasCredito());
			cliente.setLimiteCredito(c.getLimiteCredito());
			cliente.setVentaAnual(c.getVentaAnual());
			cliente.setSaldo(c.getSaldo());
			cliente.setDescuentoExtra(c.getDescuentoExtra());
			cliente.setVentaMensual(c.getVentaMensual());
			cliente.setInsen(c.getInsen());			
			session.update(cliente);
			
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
			logger.info("Cliente Actualizado con Exito!");
		}catch(Exception ex){
			resultado = false;
			logger.info("Error al Actualizar Cliente.");
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
	
	public boolean eliminarCliente(int idCliente){
		logger.info("Eliminando Cliente...");
		boolean resultado = true;
		Session session =null;
		Transaction tx= null;
		try{
			session = factory.openSession();
			tx = session.beginTransaction();
			Cliente cliente = (Cliente) session.get(Cliente.class, idCliente);
			session.delete(cliente);
			tx.commit();
			logger.info("Cliente Eliminado con Exito!");
		}catch(Exception ex){
			resultado = false;
			logger.info("Error al Eliminar Cliente.");
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
