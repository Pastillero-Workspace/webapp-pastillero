package mx.com.pastillero.model.formBeans;

public class Direccion {
	
	private int idDireccion;
	private String calle;
	private String noInt;
	private String noExt;
	private String colonia;
	private String ciudad;
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

	public String getNoInt() {
		return noInt;
	}

	public void setNoInt(String noInt) {
		this.noInt = noInt;
	}

	public String getNoExt() {
		return noExt;
	}

	public void setNoExt(String noExt) {
		this.noExt = noExt;
	}

	public String getColonia() {
		return colonia;
	}

	public void setColonia(String colonia) {
		this.colonia = colonia;
	}

	public String getCiudad() {
		return ciudad;
	}

	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
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
				+ colonia + ", ciudad=" + ciudad + ", estado=" + estado
				+ ", cp=" + cp + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((calle == null) ? 0 : calle.hashCode());
		result = prime * result + ((ciudad == null) ? 0 : ciudad.hashCode());
		result = prime * result + ((colonia == null) ? 0 : colonia.hashCode());
		result = prime * result + cp;
		result = prime * result + ((estado == null) ? 0 : estado.hashCode());
		result = prime * result + idDireccion;
		result = prime * result + ((noExt == null) ? 0 : noExt.hashCode());
		result = prime * result + ((noInt == null) ? 0 : noInt.hashCode());
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
		if (ciudad == null) {
			if (other.ciudad != null)
				return false;
		} else if (!ciudad.equals(other.ciudad))
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
		if (noExt == null) {
			if (other.noExt != null)
				return false;
		} else if (!noExt.equals(other.noExt))
			return false;
		if (noInt == null) {
			if (other.noInt != null)
				return false;
		} else if (!noInt.equals(other.noInt))
			return false;
		return true;
	}

	
		
}
