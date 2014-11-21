package mx.com.pastillero.model.formBeans;

public class ItemVenta {
	
	private String codigo;
	private String Descripcion;
	private int cantidad;
	private float preciopub;
	private float preciodesc;
	private float subtotal;
	private int idproducto;
	private int habian;
	private float ultimocosto;
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getDescripcion() {
		return Descripcion;
	}
	public void setDescripcion(String descripcion) {
		Descripcion = descripcion;
	}
	public int getCantidad() {
		return cantidad;
	}
	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}
	public float getPreciopub() {
		return preciopub;
	}
	public void setPreciopub(float preciopub) {
		this.preciopub = preciopub;
	}
	public float getPreciodesc() {
		return preciodesc;
	}
	public void setPreciodesc(float preciodesc) {
		this.preciodesc = preciodesc;
	}
	public float getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(float subtotal) {
		this.subtotal = subtotal;
	}
	public int getIdproducto() {
		return idproducto;
	}
	public void setIdproducto(int idproducto) {
		this.idproducto = idproducto;
	}
	public int getHabian() {
		return habian;
	}
	public void setHabian(int habian) {
		this.habian = habian;
	}
	public float getUltimocosto() {
		return ultimocosto;
	}
	public void setUltimocosto(float ultimocosto) {
		this.ultimocosto = ultimocosto;
	}
	@Override
	public String toString() {
		return "ItemVenta [codigo=" + codigo + ", Descripcion=" + Descripcion
				+ ", cantidad=" + cantidad + ", preciopub=" + preciopub
				+ ", preciodesc=" + preciodesc + ", subtotal=" + subtotal
				+ ", idproducto=" + idproducto + ", habian=" + habian
				+ ", ultimocosto=" + ultimocosto + "]";
	}
	
	
	
	
}
