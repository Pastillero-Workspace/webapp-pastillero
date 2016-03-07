package mx.com.pastillero.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.com.pastillero.model.formBeans.MovimientoGeneral;
import mx.com.pastillero.model.viewdao.ViewModelMovimientosDao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;

public class ViewModelMovimientosController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(ViewModelMovimientosController.class);
	ViewModelMovimientosDao movimientosDao = new ViewModelMovimientosDao();
	List<MovimientoGeneral> movimientos = new ArrayList<MovimientoGeneral>();
			
	public ViewModelMovimientosController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.info("Buscando movimientos....");
		try{
				String movimiento = request.getParameter("txtMovimiento").trim();
				String fechaIni = request.getParameter("txtFechaIni").trim();
				String fechaFin = request.getParameter("txtFechaFin").trim();
				String codigo = request.getParameter("txtCodigo").trim();
				String documento = request.getParameter("txtDocumento").trim();
				String descripcion = request.getParameter("txtDescripcion").trim();
				
				
				switch (movimiento){
					case "1": movimiento = "VENTA";break;
					case "2": movimiento = "RECEPCION";break;
					case "3": movimiento = "SALIDA";break;
					case "4": movimiento = "DEVOLUCION S/COMPRA";break;
					case "5": movimiento = "DEVOLUCION S/VENTA";break;
					default: movimiento = "";
				}
				StringBuilder query = new StringBuilder("SELECT"
						+ " M.[tipo]"
						+ ",M.[idNota]"
						+ ",M.[documento]"
						+ ",M.[clave]"
						+ ",P.[descripcion]"
						+ ",M.[adquiridos]"
						+ ",M.[vendidos]"
						+ ",M.[valor]"
						+ ",M.[habian]"
						+ ",M.[quedan]"
						+ ",M.[fecha]"
						+ ",M.[hora]"
						+ ",M.[utilidad]"
						+ " FROM Movimiento_general as M, Productos as P"
						+ " WHERE M.CLAVE = P.COD_BAR");
				if(!movimiento.equals("")){
					query.append(" AND M.TIPO LIKE '%"+movimiento+"%'");
				}
				if(!fechaIni.equals("") || !fechaFin.equals("")){
					String[] fechaIni1 = fechaIni.split("-");
					String[] fechaFin1 = fechaFin.split("-");
					
					fechaIni = fechaIni1[2]+"-"+fechaIni1[1]+"-"+fechaIni1[0];
					fechaFin = fechaFin1[2]+"-"+fechaFin1[1]+"-"+fechaFin1[0];
					query.append(" AND M.FECHA >= '"+ fechaIni +"' AND M.FECHA <= '"+ fechaFin+"'");
				}
				if(!codigo.equals("")){
					query.append(" AND M.CLAVE  LIKE '%"+codigo+"%'");
				}
				if(!documento.equals("")){
					query.append(" AND M.DOCUMENTO = '"+documento+"'");
				}
				if(!descripcion.equals("")){
					query.append(" AND P.DESCRIPCION LIKE '%"+ descripcion +"%'");
				}
				
				query.append(" ORDER BY M.FECHA DESC, M.HORA DESC");
				
				movimientos = movimientosDao.getViewStored(query.toString());
				
				Gson g = new Gson();
				String json = g.toJson(movimientos);
				
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(json);
				logger.info("Movimientos encontrados con Exito!");
				
			}catch(Exception e){
				e.printStackTrace();
				logger.info("Error al consultar movimientos "+e);
		}
	}
}
