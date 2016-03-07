package mx.com.pastillero.daotest;

import static org.junit.Assert.*;
import mx.com.pastillero.model.dao.UserChangeDao;

import org.junit.Before;
import org.junit.Test;

public class ControlPermisoTest {
	
	    UserChangeDao rd = new  UserChangeDao();
	    int a;
	    int b;


	    @Before
	    public void setUp() {
	    	
	        a = 8; // id usuario
	        b = 0;


	    }

	    @Test
	    public void testSUpdateorInsert() {
	        System.out.println("entrando a prueba de actualizacion o insercion de control: ");
	        
	        assertFalse(rd.getChange(a));
	        	System.out.println("Correcto no hay cambios en permisos:");
	        assertTrue(rd.getChange(a));
	        	System.out.println("Hay cambios en permisos:");
	        
	      // assertFalse(rd.setChange(a,b));
	        
	     //   assertTrue(rd.insChange(a));
	        
	        
	     }
	    

}
