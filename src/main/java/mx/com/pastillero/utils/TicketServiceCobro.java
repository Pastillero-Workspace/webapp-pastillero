package mx.com.pastillero.utils;

import java.util.List;

import mx.com.pastillero.model.formBeans.ItemVenta;


public class TicketServiceCobro {
	
	private static int IdNota;
	private static String date;
	private static String time;
	private static String userPerson;
	private static List<ItemVenta> itemsDetail;
	private static String subtotal;
	private static String total;
	private static String iva;
	private static String descuento;
	private static String totalpago;
	private static String totalcobro;
	private static String cambio;
	
	public int getIdNota() {
		return IdNota;
	}
	public void setIdNota(int idNota) {
		IdNota = idNota;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String Date) {
		date = Date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String Time) {
		time = Time;
	}
	public String getUserPerson() {
		return userPerson;
	}
	public void setUserPerson(String UserPerson) {
		userPerson = UserPerson;
	}

	@Override
	public String toString() {
		return "TicketServiceCobro [IdNota=" + IdNota + ", date=" + date
				+ ", time=" + time + ", userPerson=" + userPerson
				+ ", itemsDetail=" + itemsDetail + "]";
	}
	public String getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(String Subtotal) {
		subtotal = Subtotal;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String Total) {
		total = Total;
	}
	public String getIva() {
		return iva;
	}
	public void setIva(String Iva) {
		iva = Iva;
	}
	public String getTotalpago() {
		return totalpago;
	}
	public void setTotalpago(String Totalpago) {
		totalpago = Totalpago;
	}
	public String getTotalcobro() {
		return totalcobro;
	}
	public void setTotalcobro(String Totalcobro) {
		totalcobro = Totalcobro;
	}
	public String getCambio() {
		return cambio;
	}
	public void setCambio(String Cambio) {
		cambio = Cambio;
	}
	public List<ItemVenta> getItemsDetail() {
		return itemsDetail;
	}
	public void setItemsDetail(List<ItemVenta> itemsDetail) {
		TicketServiceCobro.itemsDetail = itemsDetail;
	}
	public String getDescuento() {
		return descuento;
	}
	public void setDescuento(String descuento) {
		TicketServiceCobro.descuento = descuento;
	}


	
	
	

}
