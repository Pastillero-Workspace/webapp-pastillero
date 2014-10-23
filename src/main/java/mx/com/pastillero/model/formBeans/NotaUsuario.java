package mx.com.pastillero.model.formBeans;

public class NotaUsuario {
	private int idUsuario;
	private int idNota;
	
	public NotaUsuario() {
	
	}
	
	public int getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
	public int getIdNota() {
		return idNota;
	}
	public void setIdNota(int idNota) {
		this.idNota = idNota;
	}
	@Override
	public String toString() {
		return "NotaUsuario [idUsuario=" + idUsuario + ", idNota=" + idNota
				+ "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + idNota;
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
		NotaUsuario other = (NotaUsuario) obj;
		if (idNota != other.idNota)
			return false;
		if (idUsuario != other.idUsuario)
			return false;
		return true;
	}
}
