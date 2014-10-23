package mx.com.pastillero.model.formBeans;

public class PrivilegiosUsuarios {
	private int idPrivilegio;
	private int idUsuario;
	
	public PrivilegiosUsuarios() {
	
	}

	public int getIdPrivilegio() {
		return idPrivilegio;
	}

	public void setIdPrivilegio(int idPrivilegio) {
		this.idPrivilegio = idPrivilegio;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	@Override
	public String toString() {
		return "PrivilegiosUsuarios [idPrivilegio=" + idPrivilegio
				+ ", idUsuario=" + idUsuario + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + idPrivilegio;
		result = prime * result + idUsuario;
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
		PrivilegiosUsuarios other = (PrivilegiosUsuarios) obj;
		if (idPrivilegio != other.idPrivilegio)
			return false;
		if (idUsuario != other.idUsuario)
			return false;
		return true;
	}
}
