package mx.com.pastillero.model.dao;

import java.util.List;

import mx.com.pastillero.model.formBeans.CfgSucursal;

import org.hibernate.HibernateException;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ConfiguracionSucursalDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(ConfiguracionSucursalDao.class);
	  
	  public boolean guardarSucursal2(CfgSucursal sucursal){
		  boolean result = false;
		  Session session = null;
		  Transaction tx = null;
		  try{
			  session = factory.openSession();
			  tx = session.beginTransaction();
			  session.save(sucursal);
			  tx.commit();
			  result = true;
		  }catch(HibernateException ex){
			  result = false;
			  logger.error("Erro al guardar Sucursal");
			  ex.printStackTrace();
			  tx.rollback();
		  }finally{
			  if(session!=null&&session.isOpen()){
				  try{
					  session.close();
				  }catch(Exception e){
					  e.printStackTrace();
				  }
			  }
		  }
		  return result;
	  }
	  
	  public boolean guardarSucursal(CfgSucursal s){
		  boolean resultado =  false;
		  Transaction tx = null;
		  Session session = null;
		  try{
			  session = factory.openSession();
			  tx = session.beginTransaction();
			  CfgSucursal sucursal = (CfgSucursal) session.get(CfgSucursal.class, s.getIdSistema());
			  sucursal.setRazonSocial(s.getRazonSocial());
			  sucursal.setRfc(s.getRfc());
			  sucursal.setSucursal(s.getSucursal());
			  sucursal.setCalle(s.getCalle());
			  sucursal.setColonia(s.getColonia());
			  sucursal.setNumeroExt(s.getNumeroExt());
			  sucursal.setNumeroInt(s.getNumeroInt());
			  sucursal.setMunicipio(s.getMunicipio());
			  sucursal.setEstado(s.getEstado());
			  sucursal.setCp(s.getCp());
			  sucursal.setTelefono(s.getTelefono());
			  sucursal.setEmail(s.getEmail());
			  sucursal.setWeb(s.getWeb());
			  
			  session.update(sucursal);
			  tx.commit();
			  resultado = true;
		  }catch(HibernateException ex){
			  resultado =  false;
			  logger.error("ERROR: no se puede guardar datos de Sucursal");
			  ex.printStackTrace(); 
			  tx.rollback();
		  }finally{
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
	  
	  
	  @SuppressWarnings("unchecked")
	  public List<CfgSucursal> mostrarSucursal(){
		  Session session = null;
		  List<CfgSucursal> sucursal = null;
		  try{
			  session = factory.openSession();
			  sucursal = session.createQuery("from CfgSucursal").list();
		  }catch(HibernateException e){
			  sucursal = null;
			  logger.error("ERROR: No se pudo mostrar la sucursal.\n");
			  e.printStackTrace();
		  }finally{
			  if(session!=null&&session.isOpen()){
				  try{
					  session.close();
				  }catch(Exception e){
					  e.printStackTrace();
				  }
			  }
		  } 
		  return sucursal;
	  }

}
