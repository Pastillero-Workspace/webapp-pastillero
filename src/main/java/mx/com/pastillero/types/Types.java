/**
 * 
 */
package mx.com.pastillero.types;

/**
 * @author Raymundo Martínez
 *
 */
public enum Types 
{
	
	// Tipos definidos para usuarios de sistema
	
	C ("CAJERO"), 
	V ("VENDEDOR"), 
	A ("ADMINISTRADOR"), 
	G ("GERENTE"),
	 
	// tipos definidos para rutas de sistema
	
	CL   ("/consulta.jsp"),
	ERRS ("/errorsesion.jsp"),
	ERRP ("/errorpermisos.jsp"),
	WLC  ("/welcome.jsp");
	
	//
	
	
	private String statusCode;
 
	private Types(String s) {
		statusCode = s;
	}
 
	public String getStatusCode() {
		return statusCode;
	}

}
