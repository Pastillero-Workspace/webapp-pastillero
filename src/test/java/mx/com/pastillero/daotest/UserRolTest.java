package mx.com.pastillero.daotest;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotSame;

import java.util.List;
import java.util.ArrayList;

import mx.com.pastillero.model.dao.UserRolDao;
import mx.com.pastillero.model.formBeans.UserRol;

import org.junit.Before;
import org.junit.Test;

public class UserRolTest {

	    UserRolDao rd = new UserRolDao();
	    List<UserRol>rdu = new ArrayList<UserRol>();
	
	    
	    @Before
	    public void setUp() {
	    	/*getting all list*/
	              rdu = rd.getAllPermisos();
	              System.out.println("Array lenght: "+ rdu.size());
	              System.out.println("Object: "+ rdu.iterator().next().toString());
	    }

	    @Test
	    public void testError() {
	        assertNotSame("Devuelve error ?",-1,rd.addUsrRol(2, 6, 1));
	      }
	    @Test
	    public void testCondition1() {
	    	System.out.println("Pruebas para insercion de permisos : insercion 1");	
	    	assertEquals("Debe devolver primera insercion: 1", 1, rd.addUsrRol(2, 3, 1));
	    }
	    @Test
	    public void testCondition2() {
	    	System.out.println("Pruebas para insercion de permisos : insercion 2");	 
	    	assertEquals("Debe devolver primera insercion: 2", 2, rd.addUsrRol(2, 4, 1));
	    }
	    @Test
	    public void testCondition3() {
	    	System.out.println("Pruebas para insercion de permisos : insercion 3");
	    	assertEquals("Debe devolver primera insercion: 3", 3, rd.addUsrRol(2, 21, 1));
	    }
	    
	    
	    /* Update */
	    
	    
	    @Test
	    public void testCondition4() {
	    	System.out.println("Pruebas para modificar permisos");
	    	rdu.get(2).setIdUsuario(4);
	    	assertEquals("Debe devolver update 1: true", true,rd.updateUsrRol(rdu.get(2)));
	    }
	    
	    @Test
	    public void testCondition5() {
	    	System.out.println("Pruebas para modificar permisos");
	    	rdu.get(1).setId_rol(19);;
	    	assertEquals("Debe devolver update 2: true", true,rd.updateUsrRol(rdu.get(1)));
	    }
	    	
	    /* Delete*/
	    
	    @Test
	    public void testCondition6() {
	    	System.out.println("Pruebas para eliminar permisos");
	    	assertEquals("Debe devolver primera eliminación: true", true, rd.deleteUsrRol(rdu.get(0).getIdUserRol()));
	    }
	    
	    @Test
	    public void testCondition7() {
	    	System.out.println("Pruebas para eliminar permisos");
	    	rdu.get(1).setId_rol(19);;
	    	assertEquals("Debe devolver primera eliminación: true", true, rd.deleteUsrRol(rdu.get(1).getIdUserRol()));
	    }


}
