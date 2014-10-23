package mx.com.pastillero.model.formBeans;

public class Medico {
	private int idMedico;
	private String cedula;
	private String nombre;
	private String telFijo;
	private String telMovil;
	private String email;
	private int idDireccion;
	
	public Medico() {
	
	}

	public int getIdMedico() {
		return idMedico;
	}

	public void setIdMedico(int idMedico) {
		this.idMedico = idMedico;
	}

	public String getCedula() {
		return cedula;
	}

	public void setCedula(String cedula) {
		this.cedula = cedula;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getTelFijo() {
		return telFijo;
	}

	public void setTelFijo(String telFijo) {
		this.telFijo = telFijo;
	}

	public String getTelMovil() {
		return telMovil;
	}

	public void setTelMovil(String telMovil) {
		this.telMovil = telMovil;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getIdDireccion() {
		return idDireccion;
	}

	public void setIdDireccion(int idDireccion) {
		this.idDireccion = idDireccion;
	}

	@Override
	public String toString() {
		return "Medico [idMedico=" + idMedico + ", cedula=" + cedula
				+ ", nombre=" + nombre + ", telFijo=" + telFijo + ", telMovil="
				+ telMovil + ", email=" + email + ", idDireccion="
				+ idDireccion + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((cedula == null) ? 0 : cedula.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + idDireccion;
		result = prime * result + idMedico;
		result = prime * result + ((nombre == null) ? 0 : nombre.hashCode());
		result = prime * result + ((telFijo == null) ? 0 : telFijo.hashCode());
		result = prime * result
				+ ((telMovil == null) ? 0 : telMovil.hashCode());
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
		Medico other = (Medico) obj;
		if (cedula == null) {
			if (other.cedula != null)
				return false;
		} else if (!cedula.equals(other.cedula))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (idDireccion != other.idDireccion)
			return false;
		if (idMedico != other.idMedico)
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		if (telFijo == null) {
			if (other.telFijo != null)
				return false;
		} else if (!telFijo.equals(other.telFijo))
			return false;
		if (telMovil == null) {
			if (other.telMovil != null)
				return false;
		} else if (!telMovil.equals(other.telMovil))
			return false;
		return true;
	}
}
