package mx.com.pastillero.model.formBeans;

public class TemporalProductoVenta {
	private int idProducto;
	private int nota;
	private String codigo;
	private String descripcion;
	private int cantidad;
	private float precioPub;
	private float precioDesc;
	private float subtotal;
	
	public int getIdProducto() {
		return idProducto;
	}
	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}
	public int getNota() {
		return nota;
	}
	public void setNota(int nota) {
		this.nota = nota;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
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
	public float getPrecioPub() {
		return precioPub;
	}
	public void setPrecioPub(float precioPub) {
		this.precioPub = precioPub;
	}
	public float getPrecioDesc() {
		return precioDesc;
	}
	public void setPrecioDesc(float precioDesc) {
		this.precioDesc = precioDesc;
	}
	public float getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(float subtotal) {
		this.subtotal = subtotal;
	}
	@Override
	public String toString() {
		return "TemporalProductoVenta [idProducto=" + idProducto + ", nota="
				+ nota + ", codigo=" + codigo + ", descripcion=" + descripcion
				+ ", cantidad=" + cantidad + ", precioPub=" + precioPub
				+ ", precioDesc=" + precioDesc + ", subtotal=" + subtotal + "]";
	}
	
	
}
