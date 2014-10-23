package mx.com.pastillero.model.formBeans;

public class PagoProveedor {
	private int folio;
	private int idUsuario;
	private String nombreProveedor;
	private int idRecepcion;
	private String fecha;
	private String hora;
	
	public PagoProveedor() {
	
	}

	public int getFolio() {
		return folio;
	}

	public void setFolio(int folio) {
		this.folio = folio;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getNombreProveedor() {
		return nombreProveedor;
	}

	public void setNombreProveedor(String nombreProveedor) {
		this.nombreProveedor = nombreProveedor;
	}

	public int getIdRecepcion() {
		return idRecepcion;
	}

	public void setIdRecepcion(int idRecepcion) {
		this.idRecepcion = idRecepcion;
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

	@Override
	public String toString() {
		return "PagoProveedor [folio=" + folio + ", idUsuario=" + idUsuario
				+ ", nombreProveedor=" + nombreProveedor + ", idRecepcion="
				+ idRecepcion + ", fecha=" + fecha + ", hora=" + hora + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((fecha == null) ? 0 : fecha.hashCode());
		result = prime * result + folio;
		result = prime * result + ((hora == null) ? 0 : hora.hashCode());
		result = prime * result + idRecepcion;
		result = prime * result + idUsuario;
		result = prime * result
				+ ((nombreProveedor == null) ? 0 : nombreProveedor.hashCode());
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
		PagoProveedor other = (PagoProveedor) obj;
		if (fecha == null) {
			if (other.fecha != null)
				return false;
		} else if (!fecha.equals(other.fecha))
			return false;
		if (folio != other.folio)
			return false;
		if (hora == null) {
			if (other.hora != null)
				return false;
		} else if (!hora.equals(other.hora))
			return false;
		if (idRecepcion != other.idRecepcion)
			return false;
		if (idUsuario != other.idUsuario)
			return false;
		if (nombreProveedor == null) {
			if (other.nombreProveedor != null)
				return false;
		} else if (!nombreProveedor.equals(other.nombreProveedor))
			return false;
		return true;
	}
}
