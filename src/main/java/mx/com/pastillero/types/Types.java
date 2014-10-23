/**
 * 
 */
package mx.com.pastillero.types;

/**
 * @author Raymundo Martínez
 *
 */
public enum Types {
	
	/*
	 * Types of users in system defined
	 * 
	 * C: CAJERO
	 * V: VENDEDOR
	 * A: ADMINISTRACION
	 * G: GERENTE
	 * */
	
	C ("CAJERO"), 
	V ("VENDEDOR"), 
	A ("ADMINISTRADOR"), 
	G ("GERENTE");
	 
	private String statusCode;
 
	private Types(String s) {
		statusCode = s;
	}
 
	public String getStatusCode() {
		return statusCode;
	}

}
