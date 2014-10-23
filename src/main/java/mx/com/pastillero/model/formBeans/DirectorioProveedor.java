package mx.com.pastillero.model.formBeans;

public class DirectorioProveedor {
	private int idTelefono;
	private String telefono;
	private int idProveedor;
	
	public DirectorioProveedor() {
	
	}
	
	public int getIdTelefono() {
		return idTelefono;
	}
	public void setIdTelefono(int idTelefono) {
		this.idTelefono = idTelefono;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public int getIdProveedor() {
		return idProveedor;
	}
	public void setIdProveedor(int idProveedor) {
		this.idProveedor = idProveedor;
	}
	
	@Override
	public String toString() {
		return "DirectorioProveedor [idTelefono=" + idTelefono + ", telefono="
				+ telefono + ", idProveedor=" + idProveedor + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + idProveedor;
		result = prime * result + idTelefono;
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
		DirectorioProveedor other = (DirectorioProveedor) obj;
		if (idProveedor != other.idProveedor)
			return false;
		if (idTelefono != other.idTelefono)
			return false;
		if (telefono == null) {
			if (other.telefono != null)
				return false;
		} else if (!telefono.equals(other.telefono))
			return false;
		return true;
	}
}
