package mx.com.pastillero.model.formBeans;

public class Referencias {
	private String parentesco;
	private String ife;
	private String telefono;
	private int idPersona;
	private int idDireccion;
	
	public Referencias() {
	
	}

	public String getParentesco() {
		return parentesco;
	}

	public void setParentesco(String parentesco) {
		this.parentesco = parentesco;
	}

	public String getIfe() {
		return ife;
	}

	public void setIfe(String ife) {
		this.ife = ife;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public int getIdPersona() {
		return idPersona;
	}

	public void setIdPersona(int idPersona) {
		this.idPersona = idPersona;
	}

	public int getIdDireccion() {
		return idDireccion;
	}

	public void setIdDireccion(int idDireccion) {
		this.idDireccion = idDireccion;
	}

	@Override
	public String toString() {
		return "Referencias [parentesco=" + parentesco + ", ife=" + ife
				+ ", telefono=" + telefono + ", idPersona=" + idPersona
				+ ", idDireccion=" + idDireccion + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + idDireccion;
		result = prime * result + idPersona;
		result = prime * result + ((ife == null) ? 0 : ife.hashCode());
		result = prime * result
				+ ((parentesco == null) ? 0 : parentesco.hashCode());
		result = prime * result
				+ ((telefono == null) ? 0 : telefono.hashCode());
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
		Referencias other = (Referencias) obj;
		if (idDireccion != other.idDireccion)
			return false;
		if (idPersona != other.idPersona)
			return false;
		if (ife == null) {
			if (other.ife != null)
				return false;
		} else if (!ife.equals(other.ife))
			return false;
		if (parentesco == null) {
			if (other.parentesco != null)
				return false;
		} else if (!parentesco.equals(other.parentesco))
			return false;
		if (telefono == null) {
			if (other.telefono != null)
				return false;
		} else if (!telefono.equals(other.telefono))
			return false;
		return true;
	}
}
