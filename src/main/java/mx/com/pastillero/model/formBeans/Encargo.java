package mx.com.pastillero.model.formBeans;

public class Encargo {
	private int idEncargo;
	private String nombre;
	private String telefono;
	private String fecha;
	private String hora;
	private int idUsuario;
	private int anticipo;
	
	public Encargo() {
	
	}

	public int getIdEncargo() {
		return idEncargo;
	}

	public void setIdEncargo(int idEncargo) {
		this.idEncargo = idEncargo;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getHora() {
		return hora;
	}

	public void setHora(String hora) {
		this.hora = hora;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public int getAnticipo() {
		return anticipo;
	}

	public void setAnticipo(int anticipo) {
		this.anticipo = anticipo;
	}

	@Override
	public String toString() {
		return "Encargo [idEncargo=" + idEncargo + ", nombre=" + nombre
				+ ", telefono=" + telefono + ", fecha=" + fecha + ", hora="
				+ hora + ", idUsuario=" + idUsuario + ", anticipo=" + anticipo
				+ "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + anticipo;
		result = prime * result + ((fecha == null) ? 0 : fecha.hashCode());
		result = prime * result + ((hora == null) ? 0 : hora.hashCode());
		result = prime * result + idEncargo;
		result = prime * result + idUsuario;
		result = prime * result + ((nombre == null) ? 0 : nombre.hashCode());
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
		Encargo other = (Encargo) obj;
		if (anticipo != other.anticipo)
			return false;
		if (fecha == null) {
			if (other.fecha != null)
				return false;
		} else if (!fecha.equals(other.fecha))
			return false;
		if (hora == null) {
			if (other.hora != null)
				return false;
		} else if (!hora.equals(other.hora))
			return false;
		if (idEncargo != other.idEncargo)
			return false;
		if (idUsuario != other.idUsuario)
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		if (telefono == null) {
			if (other.telefono != null)
				return false;
		} else if (!telefono.equals(other.telefono))
			return false;
		return true;
	}
}
