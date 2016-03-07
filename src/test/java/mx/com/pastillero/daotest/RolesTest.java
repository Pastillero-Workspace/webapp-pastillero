package mx.com.pastillero.daotest;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mx.com.pastillero.model.dao.RolesDao;
import mx.com.pastillero.model.formBeans.Roles;

import org.junit.Before;
import org.junit.Test;

public class RolesTest {

	    RolesDao rd = new RolesDao();
	    Roles r = new Roles();
	    Map<String,List<Roles>> setA;

	    @Before
	    public void setUp() {
	    	
	        setA = new HashMap<String,List<Roles>>();
	       // setA = rd.getMapaRoles();
	    }

	    @Test
	    public void testEqualSets() {
	    	for (Map.Entry<String,List<Roles> > entry : setA.entrySet()){
	    	     System.out.println(entry.getKey() + "/" + entry.getValue());
	    	     for(Roles rd:entry.getValue()){	    	    	 
	    	    	 System.out.println(rd.getDescripcion());
	    	     }
	    	}
	    }
}
