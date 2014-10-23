package mx.com.pastillero.model.formBeans;

public class Presupuesto {
	private int idPresupuesto;
	private String fecha;
	private String hora;
	private int subtotal;
	private int idUsuario;
	
	public Presupuesto() {
	
	}

	public int getIdPresupuesto() {
		return idPresupuesto;
	}

	public void setIdPresupuesto(int idPresupuesto) {
		this.idPresupuesto = idPresupuesto;
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

	public int getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(int subtotal) {
		this.subtotal = subtotal;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	@Override
	public String toString() {
		return "Presupuesto [idPresupuesto=" + idPresupuesto + ", fecha="
				+ fecha + ", hora=" + hora + ", subtotal=" + subtotal
				+ ", idUsuario=" + idUsuario + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((fecha == null) ? 0 : fecha.hashCode());
		result = prime * result + ((hora == null) ? 0 : hora.hashCode());
		result = prime * result + idPresupuesto;
		result = prime * result + idUsuario;
		result = prime * result + subtotal;
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
		Presupuesto other = (Presupuesto) obj;
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
		if (idPresupuesto != other.idPresupuesto)
			return false;
		if (idUsuario != other.idUsuario)
			return false;
		if (subtotal != other.subtotal)
			return false;
		return true;
	}
}
