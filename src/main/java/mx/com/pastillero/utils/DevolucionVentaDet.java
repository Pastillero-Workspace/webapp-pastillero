package mx.com.pastillero.utils;

import java.util.ArrayList;
import java.util.List;

import mx.com.pastillero.model.formBeans.DetalleDevolucionVenta;

public class DevolucionVentaDet {

	private static List<DetalleDevolucionVenta> detalle = new ArrayList<DetalleDevolucionVenta>();
	
	public static void setDetalleVenta(List<DetalleDevolucionVenta> det){
		detalle.addAll(det);
	}
	public static List<DetalleDevolucionVenta> getDetalleVenta(){
		return detalle;
	}
	public static void limpiar(){
		detalle.clear();
	}

}
