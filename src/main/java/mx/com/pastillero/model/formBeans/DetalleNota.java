package mx.com.pastillero.model.formBeans;

public class DetalleNota {
	private int cantidad;
	private int idProducto;
	private int idNota;
	private int idDetalleNota;
	
	public DetalleNota() {
	
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	public int getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}

	public int getIdNota() {
		return idNota;
	}

	public void setIdNota(int idNota) {
		this.idNota = idNota;
	}

	public int getIdDetalleNota() {
		return idDetalleNota;
	}

	public void setIdDetalleNota(int idDetalleNota) {
		this.idDetalleNota = idDetalleNota;
	}

	@Override
	public String toString() {
		return "DetalleNota [cantidad=" + cantidad + ", idProducto="
				+ idProducto + ", idNota=" + idNota + ", idDetalleNota="
				+ idDetalleNota + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + cantidad;
		result = prime * result + idDetalleNota;
		result = prime * result + idNota;
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
		DetalleNota other = (DetalleNota) obj;
		if (cantidad != other.cantidad)
			return false;
		if (idDetalleNota != other.idDetalleNota)
			return false;
		if (idNota != other.idNota)
			return false;
		if (idProducto != other.idProducto)
			return false;
		return true;
	}
}
