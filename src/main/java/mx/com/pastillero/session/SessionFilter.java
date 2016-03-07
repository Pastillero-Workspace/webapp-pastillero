package mx.com.pastillero.session;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mx.com.pastillero.controller.LoginController;
import mx.com.pastillero.model.dao.UserChangeDao;
import mx.com.pastillero.types.Types;


public class SessionFilter implements Filter {
	
private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
public void init(FilterConfig args0) throws ServletException {}
	
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
	// Get session if no sesion active send response error 
	HttpServletRequest httpRequest = (HttpServletRequest)request;
	HttpSession session= httpRequest.getSession(false);
	UserChangeDao ucd = new UserChangeDao();
	Object iduser = null;
	boolean result = false;	
	if(session != null)
	{
		logger.info("session not null --");
		iduser = session.getAttribute("iduser");
		if(iduser != null)
		{
			logger.info("user not null --");
			result = ucd.getChange((int) iduser);
			if(result)		{
				session.removeAttribute("pv");
				session.setAttribute("pv", 1); 
				logger.info("permisos con cambios");	
				try 
				{
					httpRequest.getRequestDispatcher(Types.WLC.getStatusCode()).forward(request, response);
					return;
				}
				catch (ServletException e) { }
				catch (IOException e) {}								
			}						
		}					
	}	
	try 
	{
		if(session == null && iduser == null){
			httpRequest.getRequestDispatcher(Types.ERRS.getStatusCode()).forward(request, response);
			return;
				
			}
	}
	catch (ServletException e) { }
	catch (IOException e) {}

	// try function filter
	try {chain.doFilter(request, response);} 
	catch (IOException e) {e.printStackTrace();} 
	catch (ServletException e){e.printStackTrace();}

}





public void destroy() {
}



}





/*


if (session==null || iduser ==null) 
{
	
}
*/