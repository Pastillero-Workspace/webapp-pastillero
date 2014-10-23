package mx.com.pastillero.model.formBeans;

public class Direccion {
	
	private int idDireccion;
	private String calle;
	private int noInt;
	private int noExt;
	private String colonia;
	private String estado;
	private int cp;
	
	public Direccion() {
		
	}
	
	public int getIdDireccion() {
		return idDireccion;
	}
	public void setIdDireccion(int idDireccion) {
		this.idDireccion = idDireccion;
	}
	public String getCalle() {
		return calle;
	}
	public void setCalle(String calle) {
		this.calle = calle;
	}
	public int getNoInt() {
		return noInt;
	}
	public void setNoInt(int noInt) {
		this.noInt = noInt;
	}
	public int getNoExt() {
		return noExt;
	}
	public void setNoExt(int noExt) {
		this.noExt = noExt;
	}
	public String getColonia() {
		return colonia;
	}
	public void setColonia(String colonia) {
		this.colonia = colonia;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public int getCp() {
		return cp;
	}
	public void setCp(int cp) {
		this.cp = cp;
	}

	@Override
	public String toString() {
		return "Direccion [idDireccion=" + idDireccion + ", calle=" + calle
				+ ", noInt=" + noInt + ", noExt=" + noExt + ", colonia="
				+ colonia + ", estado=" + estado + ", cp=" + cp + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((calle == null) ? 0 : calle.hashCode());
		result = prime * result + ((colonia == null) ? 0 : colonia.hashCode());
		result = prime * result + cp;
		result = prime * result + ((estado == null) ? 0 : estado.hashCode());
		result = prime * result + idDireccion;
		result = prime * result + noExt;
		result = prime * result + noInt;
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
		Direccion other = (Direccion) obj;
		if (calle == null) {
			if (other.calle != null)
				return false;
		} else if (!calle.equals(other.calle))
			return false;
		if (colonia == null) {
			if (other.colonia != null)
				return false;
		} else if (!colonia.equals(other.colonia))
			return false;
		if (cp != other.cp)
			return false;
		if (estado == null) {
			if (other.estado != null)
				return false;
		} else if (!estado.equals(other.estado))
			return false;
		if (idDireccion != other.idDireccion)
			return false;
		if (noExt != other.noExt)
			return false;
		if (noInt != other.noInt)
			return false;
		return true;
	}
	
}
