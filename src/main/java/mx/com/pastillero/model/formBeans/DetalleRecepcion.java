package mx.com.pastillero.model.formBeans;

public class DetalleRecepcion {
	private int cantidad;
	private String idProducto;
	private int idRecepcion;
	private int numFactura;
	
	public DetalleRecepcion() {
	
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	public String getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(String idProducto) {
		this.idProducto = idProducto;
	}

	public int getIdRecepcion() {
		return idRecepcion;
	}

	public void setIdRecepcion(int idRecepcion) {
		this.idRecepcion = idRecepcion;
	}

	public int getNumFactura() {
		return numFactura;
	}

	public void setNumFactura(int numFactura) {
		this.numFactura = numFactura;
	}

	
	@Override
	public String toString() {
		return "DetalleRecepcion [cantidad=" + cantidad + ", idProducto="
				+ idProducto + ", idRecepcion=" + idRecepcion + ", numFactura="
				+ numFactura + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + cantidad;
		result = prime * result
				+ ((idProducto == null) ? 0 : idProducto.hashCode());
		result = prime * result + idRecepcion;
		result = prime * result + numFactura;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DetalleRecepcion other = (DetalleRecepcion) obj;
		if (cantidad != other.cantidad)
			return false;
		if (idProducto == null) {
			if (other.idProducto != null)
				return false;
		} else if (!idProducto.equals(other.idProducto))
			return false;
		if (idRecepcion != other.idRecepcion)
			return false;
		if (numFactura != other.numFactura)
			return false;
		return true;
	}
	
	
}