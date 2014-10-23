package mx.com.pastillero.model.formBeans;

public class Privilegios {
	private int idPrivilegio;
	private String operacion;
	private byte estado;
	
	
	public Privilegios() {
	
	}
	
	public int getIdPrivilegio() {
		return idPrivilegio;
	}
	public void setIdPrivilegio(int idPrivilegio) {
		this.idPrivilegio = idPrivilegio;
	}
	public String getOperacion() {
		return operacion;
	}
	public void setOperacion(String operacion) {
		this.operacion = operacion;
	}
	public byte getEstado() {
		return estado;
	}
	public void setEstado(byte estado) {
		this.estado = estado;
	}

	@Override
	public String toString() {
		return "Privilegios [idPrivilegio=" + idPrivilegio + ", operacion="
				+ operacion + ", estado=" + estado + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + estado;
		result = prime * result + idPrivilegio;
		result = prime * result
				+ ((operacion == null) ? 0 : operacion.hashCode());
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
		Privilegios other = (Privilegios) obj;
		if (estado != other.estado)
			return false;
		if (idPrivilegio != other.idPrivilegio)
			return false;
		if (operacion == null) {
			if (other.operacion != null)
				return false;
		} else if (!operacion.equals(other.operacion))
			return false;
		return true;
	}	
}
