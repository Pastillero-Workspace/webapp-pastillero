package mx.com.pastillero.model.formBeans;

public class DetalleDevolucion {
	private int cantidad;
	private String estado;
	private int idProducto;
	private int idDevolucion;
	
	public DetalleDevolucion() {
	
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public int getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}

	public int getIdDevolucion() {
		return idDevolucion;
	}

	public void setIdDevolucion(int idDevolucion) {
		this.idDevolucion = idDevolucion;
	}

	@Override
	public String toString() {
		return "DetalleDevolucion [cantidad=" + cantidad + ", estado=" + estado
				+ ", idProducto=" + idProducto + ", idDevolucion="
				+ idDevolucion + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + cantidad;
		result = prime * result + ((estado == null) ? 0 : estado.hashCode());
		result = prime * result + idDevolucion;
		result = prime * result + idProducto;
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
		DetalleDevolucion other = (DetalleDevolucion) obj;
		if (cantidad != other.cantidad)
			return false;
		if (estado == null) {
			if (other.estado != null)
				return false;
		} else if (!estado.equals(other.estado))
			return false;
		if (idDevolucion != other.idDevolucion)
			return false;
		if (idProducto != other.idProducto)
			return false;
		return true;
	}
}
