package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.Direccion;
import mx.com.pastillero.model.formBeans.Medico;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MedicoDireccionDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(MedicoDireccionDao.class);

	@SuppressWarnings("unchecked")
	public List<Object[]> mostrar() {
		Session session = null;
		List<Object[]> medico = null;
		try{
			session = factory.openSession();
			medico = session
					.createQuery(
							"select m.idMedico, m.cedula, m.nombre, m.telFijo, m.telMovil, m.email,"
									+ " m.idDireccion, d.calle, d.noExt, d.noInt, d.colonia, d.estado, d.cp "
									+ "from Medico as m, Direccion as d where m.idDireccion=d.idDireccion")
					.list();
		}catch(HibernateException e){
			medico = null;
			logger.error("ERROR: No se obtener la informacion de los medicos");
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
		return medico;
	}

	public int guardarDireccion(Direccion d) {
		Session session = null;
		Transaction tx = null;
		Integer id = 0;
		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			id = (Integer) session.save(d);
			tx.commit();
		} catch (HibernateException ex) {
			logger.error("ERROR: Error al guardar Direccion");
			ex.printStackTrace();
			tx.rollback();
			id = 0;
		} finally {
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		}
		return id;
	}

	public boolean guardarMedico(Medico m) {
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			session.save(m);
			tx.commit();
			resultado=true;
		} catch (Exception ex) {
			resultado = false;
			logger.error("Error al guardar Proveedor");
			ex.printStackTrace();
			tx.rollback();
		} finally {
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		}
		return resultado;
	}

	public boolean actualizarMedico(Medico m, Direccion d) {
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			Medico medico = (Medico) session.get(Medico.class, m.getIdMedico());
			medico.setCedula(m.getCedula());
			medico.setNombre(m.getNombre());
			medico.setTelFijo(m.getTelFijo());
			medico.setTelMovil(m.getTelMovil());
			medico.setEmail(m.getEmail());
			session.update(medico);
			Direccion direccion = (Direccion) session.get(Direccion.class,
					d.getIdDireccion());
			direccion.setCalle(d.getCalle());
			direccion.setNoInt(d.getNoInt());
			direccion.setNoExt(d.getNoExt());
			direccion.setColonia(d.getColonia());
			direccion.setEstado(d.getEstado());
			direccion.setCp(d.getCp());
			session.update(direccion);
			tx.commit();
			resultado = true;
		} catch (Exception ex) {
			resultado = false;tx.rollback();
			logger.error("Error al actualizar");
			ex.printStackTrace();
		} finally {
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		}
		return resultado;
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getIdMedico(String cedula) {
		Session session = null;
		List<Object[]> medico = null;
		try{
			session = factory.openSession();
			medico = session.createQuery(
					"select idMedico,idDireccion from Medico where cedula ='"
							+ cedula + "'").list();
		}catch(HibernateException e){
			medico = null;
			logger.error("ERROR: No se pudo obtener el ID del medico.");
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
		return medico;
	}

	@SuppressWarnings("unchecked")
	public List<Integer> getIdMedicoByName(String name) {
		Session session = null;
		List<Integer> medico = null;
		try{
			session = factory.openSession();
			medico = session.createQuery("select idMedico from Medico where nombre ='" + name + "'").list();
		}catch(HibernateException e){
			medico = null;
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
		return medico;
	}

	public boolean eliminarMedico(int idMedico) {
		boolean resultado = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			Medico medico = (Medico) session.get(Medico.class, idMedico);
			session.delete(medico);
			tx.commit();
			resultado = true;
		} catch (Exception ex) {
			resultado = false;
			logger.error("Error al eliminar proveedor");
			ex.printStackTrace();
			tx.rollback();
		} finally {
			if (session != null && session.isOpen()) {
				try {
					session.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		}
		return resultado;
	}
}