package mx.com.pastillero.controller;

import java.io.IOException;



import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mx.com.pastillero.model.dao.FamiliaDao;
import mx.com.pastillero.model.dao.ProductosDao;
import mx.com.pastillero.model.formBeans.Familia;
import mx.com.pastillero.model.formBeans.Productos;

public class ProductoController extends HttpServlet{
	
	
	Productos pds = new Productos();
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(ProductoController.class);
	public ProductoController(){
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// This is a hard-code : Not good idea for implementation
		ProductosDao pd = new ProductosDao();
		List<Productos> lpds = pd.productoPorCodigo(request.getParameter("codBarRespaldo"));
		if(request.getParameter("tarea").equals("actualizar"))
		{
			StringBuilder codigo = new StringBuilder(request.getParameter("txtCodBar").trim());
			int tamaño = codigo.length();
	    	if(tamaño < 16){
	    		int falta = 16 - tamaño;
	    		for(int i = 0; i < falta; i++){
	    			codigo.insert(0,'0');
	    		}
	    	}
			logger.info("Actualizando Producto... "+codigo);
			String familia = request.getParameter("txtFamilia").trim().toUpperCase();
			FamiliaDao fd  = new FamiliaDao();
		 	List<Familia> lFamilia = fd.getFamilia(familia);
		 	int idFamilia = lFamilia.get(0).getIdFamilia();
		 	if(idFamilia!= 0)	
		 	{
				pds.setIdProducto(lpds.get(0).getIdProducto());
				pds.setProveedor(request.getParameter("txtProveedor").trim().toUpperCase());
				pds.setProveedor2(request.getParameter("txtProveedor2").trim().toUpperCase());
				pds.setProveedor3(request.getParameter("txtProveedor3").trim().toUpperCase());
				pds.setClave(request.getParameter("txtClave").trim());
				pds.setCodBar(codigo.toString());
				pds.setDescripcion(request.getParameter("txtDescripcion").trim().toUpperCase());
				pds.setIdFamilia(idFamilia);
				pds.setPrecioPub(Float.parseFloat(request.getParameter("txtPrecioPub").trim()));
				pds.setPrecioDesc(Float.parseFloat(request.getParameter("txtPrecDesc").trim()));
				pds.setPrecioFarmacia(Float.parseFloat(request.getParameter("txtFarmacia").trim()));
				pds.setFechaPcio(request.getParameter("txtFechaPcio").trim());
				pds.setIva(Integer.parseInt(request.getParameter("txtIva").trim()));
				pds.setLinea(request.getParameter("txtLinea").trim().toUpperCase());
				pds.setReferencia(request.getParameter("txtReferencia").trim().toUpperCase());
				pds.setSSA(request.getParameter("txtssa").trim().toUpperCase());
				pds.setLaboratorio(request.getParameter("txtLaboratorio").trim().toUpperCase());
				pds.setDepartamento(request.getParameter("txtDepto").trim().toUpperCase());
				pds.setCategoria(request.getParameter("txtCategoria").trim().toUpperCase());
				pds.setActualizable(Integer.parseInt(request.getParameter("txtActualizable").trim()));
				pds.setDescuento(Integer.parseInt(request.getParameter("txtDescuento").trim()));
				pds.setCosto(Float.parseFloat(request.getParameter("txtCosto").trim()));
				pds.setEquivalencia(request.getParameter("txtEquivalencia").trim().toUpperCase());
				pds.setSuperfamilia(request.getParameter("txtSuperfamilia").trim().toUpperCase());
				pds.setCls(request.getParameter("txtCls").trim().toUpperCase());
				pds.setZona(request.getParameter("txtZona").trim().toUpperCase());
				pds.setPareto(request.getParameter("txtPareto").trim().toUpperCase());
				pds.setPareto2(request.getParameter("txtPareto2").trim().toUpperCase());
				pds.setIeps(Integer.parseInt(request.getParameter("txtIeps").trim()));
				pds.setIeps2(Integer.parseInt(request.getParameter("txtIeps2").trim()));
				pds.setLimitado(Float.parseFloat(request.getParameter("txtLimitado").trim()));
				pds.setKit(request.getParameter("txtKit").trim().toUpperCase());
				pds.setComision(Integer.parseInt(request.getParameter("txtComision").trim()));
				pds.setMaxdescuento(Float.parseFloat(request.getParameter("txtMaxDescuento").trim()));
				pds.setGrupo(request.getParameter("txtGrupo").trim().toUpperCase());
				pds.setAplicadescbase(Integer.parseInt(request.getParameter("txtDescBase").trim()));
				pds.setAplicapo(Integer.parseInt(request.getParameter("txtPoliticaOferta").trim()));
				pds.setAntibiotico(Integer.parseInt(request.getParameter("txtAntibiotico").trim()));
				pds.setExistencias(Integer.parseInt(request.getParameter("txtExistencias").trim()));
				pds.setEspecial(request.getParameter("txtEspecial").trim().toUpperCase());
				pds.setFamactualizar(Integer.parseInt(request.getParameter("txtFamActualizar").trim()));
				pds.setCominmediata(Integer.parseInt(request.getParameter("txtComInmediata").trim()));
				pds.setUltimoproveedor(request.getParameter("txtUProveedor").trim().toUpperCase());
				pds.setUltimocosto(Float.parseFloat(request.getParameter("txtUCosto").trim()));
				pds.setCostopromedio(Float.parseFloat(request.getParameter("txtCostoPromedio").trim()));
				pds.setCostoreal(Float.parseFloat(request.getParameter("txtCostoReal").trim()));
				
				boolean result = pd.actualizarproducto(pds);
				if(result)
				{
					logger.info("Producto Actualizado con Exito!");
					response.setContentType("text/plain");          
				  	response.setCharacterEncoding("UTF-8"); 
				 	response.getWriter().write("Update");
				}
		 	}
		 	else
		 	{
		 		logger.info("El Producto no fue actualizado.");
		 	}
		}
		if(request.getParameter("tarea").equals("Agregar"))
		{
			StringBuilder codigo = new StringBuilder(request.getParameter("txtCodBar").trim());
			int tamaño = codigo.length();
	    	if(tamaño < 16){
	    		int falta = 16 - tamaño;
	    		for(int i = 0; i < falta; i++){
	    			codigo.insert(0,'0');
	    		}
	    	}
			logger.info("Guardando Producto... "+codigo);
			String familia = request.getParameter("txtFamilia").trim().toUpperCase();
			FamiliaDao fd  = new FamiliaDao();
		 	List<Familia> lFamilia = fd.getFamilia(familia);
		 	int idFamilia = lFamilia.get(0).getIdFamilia();
		 	if(idFamilia!= 0)	
		 	{
				pds.setProveedor(request.getParameter("txtProveedor").trim().toUpperCase());
				pds.setProveedor2(request.getParameter("txtProveedor2").trim().toUpperCase());
				pds.setProveedor3(request.getParameter("txtProveedor3").trim().toUpperCase());
				pds.setClave(request.getParameter("txtClave").trim());
				pds.setCodBar(codigo.toString());
				pds.setDescripcion(request.getParameter("txtDescripcion").trim().toUpperCase());
				pds.setIdFamilia(idFamilia);
				pds.setPrecioPub(Float.parseFloat(request.getParameter("txtPrecioPub").trim()));
				pds.setPrecioDesc(Float.parseFloat(request.getParameter("txtPrecDesc").trim()));
				pds.setPrecioFarmacia(Float.parseFloat(request.getParameter("txtFarmacia").trim()));
				pds.setFechaPcio(request.getParameter("txtFechaPcio").trim().toUpperCase());
				pds.setIva(Integer.parseInt(request.getParameter("txtIva").trim()));
				pds.setLinea(request.getParameter("txtLinea").trim().toUpperCase());
				pds.setReferencia(request.getParameter("txtReferencia").trim().toUpperCase());
				pds.setSSA(request.getParameter("txtssa").trim().toUpperCase());
				pds.setLaboratorio(request.getParameter("txtLaboratorio").trim().toUpperCase());
				pds.setDepartamento(request.getParameter("txtDepto").trim().toUpperCase());
				pds.setCategoria(request.getParameter("txtCategoria").trim().toUpperCase());
				pds.setActualizable(Integer.parseInt(request.getParameter("txtActualizable").trim()));
				pds.setDescuento(Integer.parseInt(request.getParameter("txtDescuento").trim()));
				pds.setCosto(Float.parseFloat(request.getParameter("txtCosto").trim()));
				pds.setEquivalencia(request.getParameter("txtEquivalencia").trim().toUpperCase());
				pds.setSuperfamilia(request.getParameter("txtSuperfamilia").trim().toUpperCase());
				pds.setCls(request.getParameter("txtCls").trim().toUpperCase());
				pds.setZona(request.getParameter("txtZona").trim().toUpperCase());
				pds.setPareto(request.getParameter("txtPareto").trim().toUpperCase());
				pds.setPareto2(request.getParameter("txtPareto2").trim().toUpperCase());
				pds.setIeps(Integer.parseInt(request.getParameter("txtIeps").trim()));
				pds.setIeps2(Integer.parseInt(request.getParameter("txtIeps2").trim()));
				pds.setLimitado(Float.parseFloat(request.getParameter("txtLimitado").trim()));
				pds.setKit(request.getParameter("txtKit").trim().toUpperCase());
				pds.setComision(Integer.parseInt(request.getParameter("txtComision").trim()));
				pds.setMaxdescuento(Float.parseFloat(request.getParameter("txtMaxDescuento").trim()));
				pds.setGrupo(request.getParameter("txtGrupo").trim().toUpperCase());
				pds.setAplicadescbase(Integer.parseInt(request.getParameter("txtDescBase").trim()));
				pds.setAplicapo(Integer.parseInt(request.getParameter("txtPoliticaOferta").trim()));
				pds.setAntibiotico(Integer.parseInt(request.getParameter("txtAntibiotico").trim()));
				pds.setExistencias(Integer.parseInt(request.getParameter("txtExistencias").trim()));
				pds.setEspecial(request.getParameter("txtEspecial").trim().toUpperCase());
				pds.setFamactualizar(Integer.parseInt(request.getParameter("txtFamActualizar").trim()));
				pds.setCominmediata(Integer.parseInt(request.getParameter("txtComInmediata").trim()));
				pds.setUltimoproveedor(request.getParameter("txtUProveedor").trim().toUpperCase());
				pds.setUltimocosto(Float.parseFloat(request.getParameter("txtUCosto").trim()));
				pds.setCostopromedio(Float.parseFloat(request.getParameter("txtCostoPromedio").trim()));
				pds.setCostoreal(Float.parseFloat(request.getParameter("txtCostoReal").trim()));
				boolean result = pd.guardarProducto(pds);
				if(result)
				{
					logger.info("Producto guardado con Exito!");
					response.setContentType("text/plain");          
				  	response.setCharacterEncoding("UTF-8"); 
				 	response.getWriter().write("Create");
				}
		 	}
			else
			{
			 		logger.info("Error al guardar el producto");
			}
		}
		if(request.getParameter("tarea").equals("eliminar"))
		{
			System.out.println("Item a eliminar :" + request.getParameter("txtNombre"));
		}
		
	}

}
