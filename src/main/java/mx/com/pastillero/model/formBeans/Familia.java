package mx.com.pastillero.model.formBeans;

public class Familia {
	private int idFamilia;
	private String nombre;
	private float descuento;
	
	
	public Familia() {
		
	}
	public int getIdFamilia() {
		return idFamilia;
	}
	public void setIdFamilia(int idFamilia) {
		this.idFamilia = idFamilia;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public float getDescuento() {
		return descuento;
	}
	public void setDescuento(float descuento) {
		this.descuento = descuento;
	}
	@Override
	public String toString() {
		return "Familia [idFamilia=" + idFamilia + ", nombre=" + nombre
				+ ", descuento=" + descuento + "]";
	}
	
	
	public String toSetFormat() {
		return "" + nombre + "~" + descuento;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + Float.floatToIntBits(descuento);
		result = prime * result + idFamilia;
		result = prime * result + ((nombre == null) ? 0 : nombre.hashCode());
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
		Familia other = (Familia) obj;
		if (Float.floatToIntBits(descuento) != Float
				.floatToIntBits(other.descuento))
			return false;
		if (idFamilia != other.idFamilia)
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		return true;
	}
}
