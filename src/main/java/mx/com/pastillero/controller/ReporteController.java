package mx.com.pastillero.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.com.pastillero.utils.ReporteExcel;

//
public class ReporteController extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ReporteController(){
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

/**
 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("reporte").equals("recepciones")){
			
			
			String titulo = request.getParameter("txtTitulo");
			String table = request.getParameter("tblRecepciones");
			System.out.println("Llamada a reporte");
			System.out.println(titulo);
			System.out.println(table);
			
			//request.setAttribute("datos", "datos de servlet");
			//response.sendRedirect("recepcion.jsp");
			ReporteExcel.setReporte(titulo);
			ReporteExcel.setDatos(table);
		
		}
		else if(request.getParameter("reporte").equals("clientes")){
			String titulo = request.getParameter("txtTitulo");
			String table = request.getParameter("tblClientes");
			
			System.out.println(titulo);
			System.out.println(table);
			
			ReporteExcel.setReporte(titulo);
			ReporteExcel.setDatos(table);
		}
		else if(request.getParameter("reporte").equals("proveedores")){
			String titulo = request.getParameter("txtTitulo");
			String table = request.getParameter("tblProveedores");
			
			System.out.println(titulo);
			System.out.println(table);
			
			ReporteExcel.setReporte(titulo);
			ReporteExcel.setDatos(table);
		}
		else if(request.getParameter("reporte").equals("movimientos")){
			String titulo = request.getParameter("txtTitulo");
			String table = request.getParameter("tblMovimientos");
			
			System.out.println(titulo);
			System.out.println(table);
			
			ReporteExcel.setReporte(titulo);
			ReporteExcel.setDatos(table);
		}
		else if(request.getParameter("reporte").equals("usuarios")){
			String titulo = request.getParameter("txtTitulo");
			String table = request.getParameter("tblUsuarios");
			
			System.out.println(titulo);
			System.out.println(table);
			
			ReporteExcel.setReporte(titulo);
			ReporteExcel.setDatos(table);
		}
		else if(request.getParameter("reporte").equals("medicos")){
			String titulo = request.getParameter("txtTitulo");
			String table = request.getParameter("tblMedicos");
			
			System.out.println(titulo);
			System.out.println(table);
			
			ReporteExcel.setReporte(titulo);
			ReporteExcel.setDatos(table);
		}
		else if(request.getParameter("reporte").equals("productos")){
			String titulo = request.getParameter("txtTitulo");
			String table = request.getParameter("tblProductos");
			
			System.out.println(titulo);
			System.out.println(table);
			
			ReporteExcel.setReporte(titulo);
			ReporteExcel.setDatos(table);
		}
	}
	
}

