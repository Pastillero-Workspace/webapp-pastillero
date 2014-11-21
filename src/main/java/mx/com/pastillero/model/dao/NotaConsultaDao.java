package mx.com.pastillero.model.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.dao.GenericoDAO;
import mx.com.pastillero.model.formBeans.NotaCliente;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class NotaConsultaDao extends GenericoDAO{
	private static final Logger logger = LoggerFactory.getLogger(NotaConsultaDao.class);

	 
	  public List<NotaCliente> getNotaCliente(final String fechaIni, final String fechaFin) throws Exception
	  {	
		  logger.info("Realizando Consulta!");  
		final List<NotaCliente> datos = new ArrayList<NotaCliente>();
		
		Connection con = null;
		Statement stmt = null;
		CallableStatement cs = null;
		ResultSet rs = null;
		
		try{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433; databasename=pastillero;user=sa;password=123456");
			
			stmt = con.createStatement();
			cs = con.prepareCall("{call consultaNota(?,?)}");
			cs.setString(1, "2014-10-01");
			cs.setString(2, "2014-10-30");
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

                NotaCliente nota = new NotaCliente();
                nota.setFecha(rs.getString("fecha"));
                nota.setHora(rs.getString("hora"));
                nota.setIdNota(Integer.parseInt(rs.getString("idNota")));
                nota.setUsuario(rs.getString("usuario"));
                nota.setCliente(rs.getString("cliente"));
                nota.setEstado(rs.getString("estado"));
                nota.setSubtotal(Float.parseFloat(rs.getString("subtotal")));
                nota.setDescuento(Float.parseFloat(rs.getString("descuento")));
                nota.setIva(Float.parseFloat(rs.getString("iva")));
                nota.setTotal(Float.parseFloat(rs.getString("total")));
                datos.add(nota);
                
            }
     }catch(Exception e){
    	 e.printStackTrace();
     }finally{
            cs.close();
     }		
		
	  	return datos;
	  } 

}
/*Session session = factory.openSession();
	try{
         session.beginTransaction();
         session.doWork(new Work() {
                @Override
                public void execute(Connection c) throws SQLException {
              	    CallableStatement cs = null;
              	    ResultSet rs=null;
                      try{     
                             cs = c.prepareCall("{ call consultaNota(?,?) }",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                             cs.setString(1, fechaIni);
                             cs.setString(2, fechaFin);
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

                                 NotaCliente nota = new NotaCliente();
                                 nota.setFecha(rs.getString("fecha"));
                                 nota.setHora(rs.getString("hora"));
                                 nota.setIdNota(Integer.parseInt(rs.getString("idNota")));
                                 nota.setUsuario(rs.getString("usuario"));
                                 nota.setCliente(rs.getString("cliente"));
                                 nota.setEstado(rs.getString("estado"));
                                 nota.setSubtotal(Float.parseFloat(rs.getString("subtotal")));
                                 nota.setDescuento(Float.parseFloat(rs.getString("descuento")));
                                 nota.setIva(Float.parseFloat(rs.getString("iva")));
                                 nota.setTotal(Float.parseFloat(rs.getString("total")));
                                 datos.add(nota);
                                 
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
         throw new Exception("error al obtener la consulta: Consulte al administrador del sistema",e);
  }
  finally{
  	session.close();
  }
	*/