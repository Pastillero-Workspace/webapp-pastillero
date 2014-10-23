/*package mx.com.pastillero.model;

import java.util.Properties;
import java.util.ResourceBundle;

import org.hibernate.SessionFactory; 
import org.hibernate.cfg.Configuration;
  

import mx.com.pastillero.model.formBeans.LoginForm;
public class HibernateUtil {

    private static final SessionFactory sessionFactory = buildSessionFactory1();

    @SuppressWarnings("deprecation")
	private static SessionFactory buildSessionFactory1() {
        try {
        	ResourceBundle rb= ResourceBundle.getBundle("mx.com.pastillero.model.hibernate_config");
        	Properties p=new Properties();
        	
        	p.setProperty("hibernate.connection.url", rb.getString("hibernate.connection.url"));
        	p.setProperty("hibernate.connection.username", rb.getString("hibernate.connection.username"));
        	p.setProperty("hibernate.connection.password", rb.getString("hibernate.connection.password"));
        	
        	p.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
        	p.setProperty("hibernate.connection.driver_class","com.mysql.jdbc.Driver");
        	p.setProperty("hibernate.hbm2ddl.auto","update");
        	p.setProperty("hibernate.current_session_context_class","thread");
        	p.setProperty("hibernate.show_sql","false");
        	 
            return new Configuration().addProperties(p)
            		.addAnnotatedClass(LoginForm.class).buildSessionFactory();
        }
        catch (Throwable ex) {
            System.out.println("Initial SessionFactory creation failed: \n" + ex);
            ex.printStackTrace();
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory1() {
    	System.out.println(sessionFactory);
        return sessionFactory;
    }

}*/