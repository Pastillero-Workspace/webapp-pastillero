package mx.com.pastillero.model.formBeans;

public class Persona {
	private int idPersona;
	private String nombre;
	private String apellidoPat;
	private String apellidoMat;
	private String fechaIngreso;
	private String rfc;
	private String curp;
	private String turno;
	private String email;
	private String telFijo;
	private String telMovil;
	private int idDireccion;
	
	public Persona() {
	}

	public int getIdPersona() {
		return idPersona;
	}

	public void setIdPersona(int idPersona) {
		this.idPersona = idPersona;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellidoPat() {
		return apellidoPat;
	}

	public void setApellidoPat(String apellidoPat) {
		this.apellidoPat = apellidoPat;
	}

	public String getApellidoMat() {
		return apellidoMat;
	}

	public void setApellidoMat(String apellidoMat) {
		this.apellidoMat = apellidoMat;
	}

	public String getFechaIngreso() {
		return fechaIngreso;
	}

	public void setFechaIngreso(String fechaIngreso) {
		this.fechaIngreso = fechaIngreso;
	}

	public String getRfc() {
		return rfc;
	}

	public void setRfc(String rfc) {
		this.rfc = rfc;
	}

	public String getCurp() {
		return curp;
	}

	public void setCurp(String curp) {
		this.curp = curp;
	}

	public String getTurno() {
		return turno;
	}

	public void setTurno(String turno) {
		this.turno = turno;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public int getIdDireccion() {
		return idDireccion;
	}

	public void setIdDireccion(int idDireccion) {
		this.idDireccion = idDireccion;
	}

	@Override
	public String toString() {
		return "Persona [idPersona=" + idPersona + ", nombre=" + nombre
				+ ", apellidoPat=" + apellidoPat + ", apellidoMat="
				+ apellidoMat + ", fechaIngreso=" + fechaIngreso + ", rfc="
				+ rfc + ", curp=" + curp + ", turno=" + turno + ", email="
				+ email + ", telFijo=" + telFijo + ", telMovil=" + telMovil
				+ ", idDireccion=" + idDireccion + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((apellidoMat == null) ? 0 : apellidoMat.hashCode());
		result = prime * result
				+ ((apellidoPat == null) ? 0 : apellidoPat.hashCode());
		result = prime * result + ((curp == null) ? 0 : curp.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result
				+ ((fechaIngreso == null) ? 0 : fechaIngreso.hashCode());
		result = prime * result + idDireccion;
		result = prime * result + idPersona;
		result = prime * result + ((nombre == null) ? 0 : nombre.hashCode());
		result = prime * result + ((rfc == null) ? 0 : rfc.hashCode());
		result = prime * result + ((telFijo == null) ? 0 : telFijo.hashCode());
		result = prime * result
				+ ((telMovil == null) ? 0 : telMovil.hashCode());
		result = prime * result + ((turno == null) ? 0 : turno.hashCode());
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
		Persona other = (Persona) obj;
		if (apellidoMat == null) {
			if (other.apellidoMat != null)
				return false;
		} else if (!apellidoMat.equals(other.apellidoMat))
			return false;
		if (apellidoPat == null) {
			if (other.apellidoPat != null)
				return false;
		} else if (!apellidoPat.equals(other.apellidoPat))
			return false;
		if (curp == null) {
			if (other.curp != null)
				return false;
		} else if (!curp.equals(other.curp))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (fechaIngreso == null) {
			if (other.fechaIngreso != null)
				return false;
		} else if (!fechaIngreso.equals(other.fechaIngreso))
			return false;
		if (idDireccion != other.idDireccion)
			return false;
		if (idPersona != other.idPersona)
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		if (rfc == null) {
			if (other.rfc != null)
				return false;
		} else if (!rfc.equals(other.rfc))
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
		if (turno == null) {
			if (other.turno != null)
				return false;
		} else if (!turno.equals(other.turno))
			return false;
		return true;
	}
}
