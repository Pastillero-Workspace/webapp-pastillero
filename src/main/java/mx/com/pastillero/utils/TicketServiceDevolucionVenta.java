package mx.com.pastillero.utils;

import java.util.List;

import mx.com.pastillero.model.formBeans.ItemVenta;

public class TicketServiceDevolucionVenta {
	private static int IdNota;
	private static String date;
	private static String time;
	private static String userPerson;
	private static List<ItemVenta> itemsDetail;
	private static String subtotal;
	private static String total;
	private static String iva;
	private static String descuento;
	public static int getIdNota() {
		return IdNota;
	}
	public static void setIdNota(int idNota) {
		IdNota = idNota;
	}
	public static String getDate() {
		return date;
	}
	public static void setDate(String date) {
		TicketServiceDevolucionVenta.date = date;
	}
	public static String getTime() {
		return time;
	}
	public static void setTime(String time) {
		TicketServiceDevolucionVenta.time = time;
	}
	public static String getUserPerson() {
		return userPerson;
	}
	public static void setUserPerson(String userPerson) {
		TicketServiceDevolucionVenta.userPerson = userPerson;
	}
	public static List<ItemVenta> getItemsDetail() {
		return itemsDetail;
	}
	public static void setItemsDetail(List<ItemVenta> itemsDetail) {
		TicketServiceDevolucionVenta.itemsDetail = itemsDetail;
	}
	public static String getSubtotal() {
		return subtotal;
	}
	public static void setSubtotal(String subtotal) {
		TicketServiceDevolucionVenta.subtotal = subtotal;
	}
	public static String getTotal() {
		return total;
	}
	public static void setTotal(String total) {
		TicketServiceDevolucionVenta.total = total;
	}
	public static String getIva() {
		return iva;
	}
	public static void setIva(String iva) {
		TicketServiceDevolucionVenta.iva = iva;
	}
	public static String getDescuento() {
		return descuento;
	}
	public static void setDescuento(String descuento) {
		TicketServiceDevolucionVenta.descuento = descuento;
	}
	
	
	
}
