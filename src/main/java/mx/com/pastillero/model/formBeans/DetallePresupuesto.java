package mx.com.pastillero.model.formBeans;

public class DetallePresupuesto {
	private int cantidad;
	private int idProducto;
	private int idPresupuesto;
	
	public DetallePresupuesto() {
	
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

	public int getIdPresupuesto() {
		return idPresupuesto;
	}

	public void setIdPresupuesto(int idPresupuesto) {
		this.idPresupuesto = idPresupuesto;
	}

	@Override
	public String toString() {
		return "DetallePresupuesto [cantidad=" + cantidad + ", idProducto="
				+ idProducto + ", idPresupuesto=" + idPresupuesto + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + cantidad;
		result = prime * result + idPresupuesto;
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
		DetallePresupuesto other = (DetallePresupuesto) obj;
		if (cantidad != other.cantidad)
			return false;
		if (idPresupuesto != other.idPresupuesto)
			return false;
		if (idProducto != other.idProducto)
			return false;
		return true;
	}
}
