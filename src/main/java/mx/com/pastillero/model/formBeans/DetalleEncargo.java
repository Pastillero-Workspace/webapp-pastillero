package mx.com.pastillero.model.formBeans;

public class DetalleEncargo {
	private int idDetalleEncargo;
	private String descripcion;
	private int cantidad;
	private byte registrado;
	private int idProducto;
	private int idEncargo;
	
	public DetalleEncargo() {
	
	}

	public int getIdDetalleEncargo() {
		return idDetalleEncargo;
	}

	public void setIdDetalleEncargo(int idDetalleEncargo) {
		this.idDetalleEncargo = idDetalleEncargo;
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

	public byte getRegistrado() {
		return registrado;
	}

	public void setRegistrado(byte registrado) {
		this.registrado = registrado;
	}

	public int getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}

	public int getIdEncargo() {
		return idEncargo;
	}

	public void setIdEncargo(int idEncargo) {
		this.idEncargo = idEncargo;
	}

	@Override
	public String toString() {
		return "DetalleEncargo [idDetalleEncargo=" + idDetalleEncargo
				+ ", descripcion=" + descripcion + ", cantidad=" + cantidad
				+ ", registrado=" + registrado + ", idProducto=" + idProducto
				+ ", idEncargo=" + idEncargo + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + cantidad;
		result = prime * result
				+ ((descripcion == null) ? 0 : descripcion.hashCode());
		result = prime * result + idDetalleEncargo;
		result = prime * result + idEncargo;
		result = prime * result + idProducto;
		result = prime * result + registrado;
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
		DetalleEncargo other = (DetalleEncargo) obj;
		if (cantidad != other.cantidad)
			return false;
		if (descripcion == null) {
			if (other.descripcion != null)
				return false;
		} else if (!descripcion.equals(other.descripcion))
			return false;
		if (idDetalleEncargo != other.idDetalleEncargo)
			return false;
		if (idEncargo != other.idEncargo)
			return false;
		if (idProducto != other.idProducto)
			return false;
		if (registrado != other.registrado)
			return false;
		return true;
	}
}
