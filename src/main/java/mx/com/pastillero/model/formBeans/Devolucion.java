package mx.com.pastillero.model.formBeans;

public class Devolucion {
	private int idDevolucion;
	private String fecha;
	private String hora;
	private String motivo;
	private int idUsuario;
	private int notaReferencia;
	private int notaActual;
	
	public Devolucion() {
	
	}

	public int getIdDevolucion() {
		return idDevolucion;
	}

	public void setIdDevolucion(int idDevolucion) {
		this.idDevolucion = idDevolucion;
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

	public String getMotivo() {
		return motivo;
	}

	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public int getNotaReferencia() {
		return notaReferencia;
	}

	public void setNotaReferencia(int notaReferencia) {
		this.notaReferencia = notaReferencia;
	}

	public int getNotaActual() {
		return notaActual;
	}

	public void setNotaActual(int notaActual) {
		this.notaActual = notaActual;
	}

	@Override
	public String toString() {
		return "Devolucion [idDevolucion=" + idDevolucion + ", fecha=" + fecha
				+ ", hora=" + hora + ", motivo=" + motivo + ", idUsuario="
				+ idUsuario + ", notaReferencia=" + notaReferencia
				+ ", notaActual=" + notaActual + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((fecha == null) ? 0 : fecha.hashCode());
		result = prime * result + ((hora == null) ? 0 : hora.hashCode());
		result = prime * result + idDevolucion;
		result = prime * result + idUsuario;
		result = prime * result + ((motivo == null) ? 0 : motivo.hashCode());
		result = prime * result + notaActual;
		result = prime * result + notaReferencia;
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
		Devolucion other = (Devolucion) obj;
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
		if (idDevolucion != other.idDevolucion)
			return false;
		if (idUsuario != other.idUsuario)
			return false;
		if (motivo == null) {
			if (other.motivo != null)
				return false;
		} else if (!motivo.equals(other.motivo))
			return false;
		if (notaActual != other.notaActual)
			return false;
		if (notaReferencia != other.notaReferencia)
			return false;
		return true;
	}
}
