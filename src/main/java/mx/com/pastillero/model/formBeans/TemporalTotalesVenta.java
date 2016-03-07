package mx.com.pastillero.model.formBeans;

public class TemporalTotalesVenta {
	private int nota;
	private String usuario;
	private float precioTotal;
	private float descuentoTotal;
	private float iva;
	private float subtotal;
	private float total;
	
	public int getNota() {
		return nota;
	}
	public void setNota(int nota) {
		this.nota = nota;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public float getPrecioTotal() {
		return precioTotal;
	}
	public void setPrecioTotal(float precioTotal) {
		this.precioTotal = precioTotal;
	}
	public float getDescuentoTotal() {
		return descuentoTotal;
	}
	public void setDescuentoTotal(float descuentoTotal) {
		this.descuentoTotal = descuentoTotal;
	}
	public float getIva() {
		return iva;
	}
	public void setIva(float iva) {
		this.iva = iva;
	}
	public float getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(float subtotal) {
		this.subtotal = subtotal;
	}
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	
	
}
