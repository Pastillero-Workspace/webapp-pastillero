package mx.com.pastillero.controller;

import java.io.IOException;



import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.com.pastillero.model.dao.FamiliaDao;
import mx.com.pastillero.model.dao.ProductosDao;
import mx.com.pastillero.model.formBeans.Familia;
import mx.com.pastillero.model.formBeans.Productos;

public class ProductoController extends HttpServlet{
	
	
	Productos pds = new Productos();
	private static final long serialVersionUID = 1L;	
	public ProductoController(){
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// This is a hard-code : Not good idea for implementation
		ProductosDao pd = new ProductosDao();
		List<Productos> lpds = pd.productoPorCodigo(request.getParameter("txtCodBar"));
		if(request.getParameter("tarea").equals("actualizar"))
		{
			String familia = request.getParameter("txtFamilia");
			FamiliaDao fd  = new FamiliaDao();
		 	List<Familia> lFamilia = fd.getFamilia(familia);
		 	int idFamilia = lFamilia.get(0).getIdFamilia();
		 	if(idFamilia!= 0)	
		 	{
				pds.setIdProducto(lpds.get(0).getIdProducto());
				System.out.println("Producto encontrdo con id:"+pds.getIdProducto());
				pds.setProveedor(request.getParameter("txtProveedor"));
				pds.setClave(request.getParameter("txtClave"));
				pds.setCodBar(request.getParameter("txtCodBar"));
				pds.setDescripcion(request.getParameter("txtDescripcion"));
				pds.setIdFamilia(idFamilia);
				pds.setPrecioPub(Float.parseFloat(request.getParameter("txtPrecioPub")));
				pds.setPrecioDesc(Float.parseFloat(request.getParameter("txtPrecDesc")));
				pds.setPrecioFarmacia(Float.parseFloat(request.getParameter("txtFarmacia")));
				pds.setIva(Integer.parseInt(request.getParameter("txtIva")));
				pds.setLinea(request.getParameter("txtLinea"));
				pds.setReferencia(request.getParameter("txtReferencia"));
				pds.setSSA(request.getParameter("txtssa"));
				pds.setLaboratorio(request.getParameter("txtLaboratorio"));
				pds.setDepartamento(request.getParameter("txtDepto"));
				pds.setCategoria(request.getParameter("txtCategoria"));
				pds.setActualizable(Integer.parseInt(request.getParameter("txtActualizable")));
				pds.setDescuento(Integer.parseInt(request.getParameter("txtDescuento")));
				pds.setCosto(Float.parseFloat(request.getParameter("txtCosto")));
				pds.setEquivalencia(request.getParameter("txtEquivalencia"));
				pds.setSuperfamilia(request.getParameter("txtSuperfamilia"));
				pds.setCls(request.getParameter("txtCls"));
				pds.setZona(request.getParameter("txtZona"));
				pds.setPareto(request.getParameter("txtPareto"));
				pds.setIeps(Integer.parseInt(request.getParameter("txtIeps")));
				pds.setIeps2(Integer.parseInt(request.getParameter("txtIeps2")));
				pds.setLimitado(Float.parseFloat(request.getParameter("txtLimitado")));
				pds.setKit(request.getParameter("txtKit"));
				pds.setComision(Integer.parseInt(request.getParameter("txtComision")));
				pds.setMaxdescuento(Float.parseFloat(request.getParameter("txtMaxDescuento")));
				pds.setGrupo(request.getParameter("txtGrupo"));
				pds.setAplicadescbase(Integer.parseInt(request.getParameter("txtDescBase")));
				pds.setAplicapo(Integer.parseInt(request.getParameter("txtPoliticaOferta")));
				pds.setAntibiotico(Integer.parseInt(request.getParameter("txtAntibiotico")));
				pds.setExistencias(Integer.parseInt(request.getParameter("txtExistencias")));
				pds.setUltimoproveedor(request.getParameter("txtUProveedor"));
				pds.setUltimocosto(Float.parseFloat(request.getParameter("txtUCosto")));
				pds.setCostopromedio(Float.parseFloat(request.getParameter("txtCostoReal")));
				pds.setCostopromedio(Float.parseFloat(request.getParameter("txtCostoPromedio")));			
				System.out.println(pds.toString());
				boolean result = pd.actualizarproducto(pds);
				if(result)
				{
					response.setContentType("text/plain");          
				  	response.setCharacterEncoding("UTF-8"); 
				 	response.getWriter().write("Update");
				}
		 	}
		 	else
		 	{
		 		System.out.println("Error al actualizar");
		 	}
		}
		if(request.getParameter("tarea").equals("Agregar"))
		{
			String familia = request.getParameter("txtFamilia");
			FamiliaDao fd  = new FamiliaDao();
		 	List<Familia> lFamilia = fd.getFamilia(familia);
		 	int idFamilia = lFamilia.get(0).getIdFamilia();
		 	if(idFamilia!= 0)	
		 	{
				pds.setProveedor(request.getParameter("txtProveedor"));
				pds.setClave(request.getParameter("txtClave"));
				pds.setCodBar(request.getParameter("txtCodBar"));
				pds.setDescripcion(request.getParameter("txtDescripcion"));
				pds.setIdFamilia(Integer.parseInt(request.getParameter("txtFamilia")));
				pds.setPrecioPub(Float.parseFloat(request.getParameter("txtPrecioPub")));
				pds.setPrecioDesc(Float.parseFloat(request.getParameter("txtPrecDesc")));
				pds.setPrecioFarmacia(Float.parseFloat(request.getParameter("txtFarmacia")));
				pds.setIva(Integer.parseInt(request.getParameter("txtIva")));
				pds.setLinea(request.getParameter("txtLinea"));
				pds.setReferencia(request.getParameter("txtReferencia"));
				pds.setSSA(request.getParameter("txtssa"));
				pds.setLaboratorio(request.getParameter("txtLaboratorio"));
				pds.setDepartamento(request.getParameter("txtDepto"));
				pds.setCategoria(request.getParameter("txtCategoria"));
				pds.setActualizable(Integer.parseInt(request.getParameter("txtActualizable")));
				pds.setDescuento(Integer.parseInt(request.getParameter("txtDescuento")));
				pds.setCosto(Float.parseFloat(request.getParameter("txtCosto")));
				pds.setEquivalencia(request.getParameter("txtEquivalencia"));
				pds.setSuperfamilia(request.getParameter("txtSuperfamilia"));
				pds.setCls(request.getParameter("txtCls"));
				pds.setZona(request.getParameter("txtZona"));
				pds.setPareto(request.getParameter("txtPareto"));
				pds.setIeps(Integer.parseInt(request.getParameter("txtIeps")));
				pds.setIeps2(Integer.parseInt(request.getParameter("txtIeps2")));
				pds.setLimitado(Float.parseFloat(request.getParameter("txtLimitado")));
				pds.setKit(request.getParameter("txtKit"));
				pds.setComision(Integer.parseInt(request.getParameter("txtComision")));
				pds.setMaxdescuento(Float.parseFloat(request.getParameter("txtMaxDescuento")));
				pds.setGrupo(request.getParameter("txtGrupo"));
				pds.setAplicadescbase(Integer.parseInt(request.getParameter("txtDescBase")));
				pds.setAplicapo(Integer.parseInt(request.getParameter("txtPoliticaOferta")));
				pds.setAntibiotico(Integer.parseInt(request.getParameter("txtAntibiotico")));
				pds.setExistencias(Integer.parseInt(request.getParameter("txtExistencias")));
				pds.setUltimoproveedor(request.getParameter("txtUProveedor"));
				pds.setUltimocosto(Float.parseFloat(request.getParameter("txtUCosto")));
				pds.setCostopromedio(Float.parseFloat(request.getParameter("txtCostoReal")));
				pds.setCostopromedio(Float.parseFloat(request.getParameter("txtCostoPromedio")));			
				System.out.println(pds.toString());
				boolean result = pd.guardarProducto(pds);
				if(result)
				{
					response.setContentType("text/plain");          
				  	response.setCharacterEncoding("UTF-8"); 
				 	response.getWriter().write("Create");
				}
		 	}
			else
			{
			 		System.out.println("Error al insertar los datos");
			}
		}
		if(request.getParameter("tarea").equals("eliminar"))
		{
			System.out.println("Item a eliminar :" + request.getParameter("txtNombre"));
		}
		
	}

}
