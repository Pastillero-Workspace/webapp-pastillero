package mx.com.pastillero.model.viewdao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.formBeans.MovimientoGeneral;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.jdbc.Work;


public class ViewModelMovimientosDao {
	
	 private static SessionFactory factory; 
	 	 
	  public SessionFactory getBuildSess()
	  {
		  try{
		        factory = new Configuration().configure("mx/com/pastillero/model/hibernate.cfg.xml").buildSessionFactory();
		     }catch (Throwable ex) { 
		        System.err.println("Failed to create sessionFactory object." + ex);
		        throw new ExceptionInInitializerError(ex); 
		     }
		  return factory;
		  
	  }

	  public List<MovimientoGeneral> getViewStored() throws Exception
	  {		
		final List<MovimientoGeneral> datos = new ArrayList<MovimientoGeneral>();
		  
	  	Session session = factory.openSession();
	  	try{
	             session.beginTransaction();
	             session.doWork(new Work() {
	                    @Override
	                    public void execute(Connection c) throws SQLException {
	                  	    CallableStatement cs = null;
	                  	    ResultSet rs=null;
	                          try{     
	                                 cs = c.prepareCall("{ call usp_alterview_Movimiento(?) }",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	                                 cs.setInt(1, 5);
	                                 boolean results = cs.execute();
	                                 int rowsAffected = 0;
	                                 while (results || rowsAffected != -1){
	                                     if (results) {
	                                    	 rs = cs.getResultSet();
	                                       break;
	                                     } else {
	                                         rowsAffected = cs.getUpdateCount();
	                                     }
	                                     results = cs.getMoreResults();
	                                 }
	                                 while (rs.next()) {             

	                                     System.out.println("Tipo: "+ rs.getString("tipo") + "Fecha: "+rs.getString("fecha")+"Hora: "+rs.getString("hora")+"Utilidad: "+rs.getString("utilidad"));
	                                     MovimientoGeneral mg = new MovimientoGeneral();
	                                     //mg.setIdMovimiento(Integer.parseInt(rs.getString("idMovimiento")));
	                                     mg.setTipo(rs.getString("tipo"));
	                                     mg.setIdNota(Integer.parseInt(rs.getString("idNota")));
	                                     mg.setDocumento(rs.getString("documento"));
	                                     mg.setClave(rs.getString("clave"));
	                                     mg.setDescripcion(rs.getString("descripcion"));
	                                     mg.setAdquiridos(Integer.parseInt(rs.getString("adquiridos")));
	                                     mg.setVendidos(Integer.parseInt(rs.getString("vendidos")));
	                                     mg.setValor(Float.parseFloat(rs.getString("valor")));
	                                     mg.setHabian(Integer.parseInt(rs.getString("habian")));
	                                     mg.setQuedan(Integer.parseInt(rs.getString("quedan")));
	                                     mg.setFecha(rs.getString("fecha"));
	                                     mg.setHora(rs.getString("hora"));
	                                     mg.setUtilidad(Float.parseFloat(rs.getString("utilidad")));
	                                     datos.add(mg);
	                                 }
	                          }
	                          finally{
	                                 cs.close();
	                          }
	                    }
	             });
	             session.getTransaction().commit();
	      }
	      catch(HibernateException e){
	             throw new Exception("error al obtener la vista: Consulte al administrador del sistema",e);
	      }
	      finally{
	      	session.close();
	      }
	  	return datos;
	  } 
}
