package mx.com.pastillero.model.formBeans;

import java.util.List;

public class DetalleDevolucionVenta {
	private String fecha;
	private String nota;
	private String clave;
	private String descripcion; 
	private int cantidad;
	private float precioUnitario;
	private float subtotal;
	private float iva;
	private float importe;
	private float devolucion;
	private float total;
	
	
	
	
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public String getNota() {
		return nota;
	}
	public void setNota(String nota) {
		this.nota = nota;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public float getPrecioUnitario() {
		return precioUnitario;
	}
	public void setPrecioUnitario(float precioUnitario) {
		this.precioUnitario = precioUnitario;
	}
	public float getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(float subtotal) {
		this.subtotal = subtotal;
	}
	public float getIva() {
		return iva;
	}
	public void setIva(float iva) {
		this.iva = iva;
	}
	public float getImporte() {
		return importe;
	}
	public void setImporte(float importe) {
		this.importe = importe;
	}
	public float getDevolucion() {
		return devolucion;
	}
	public void setDevolucion(float devolucion) {
		this.devolucion = devolucion;
	}
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	@Override
	public String toString() {
		return "DetalleDevolucionVenta [fecha=" + fecha + ", nota=" + nota
				+ ", clave=" + clave + ", descripcion=" + descripcion
				+ ", cantidad=" + cantidad + ", precioUnitario="
				+ precioUnitario + ", subtotal=" + subtotal + ", iva=" + iva
				+ ", importe=" + importe + ", devolucion=" + devolucion
				+ ", total=" + total + "]";
	}
	
	
		

}
