package mx.com.pastillero.model.formBeans;

public class Salida {
	private int idSalida;
	private String fecha;
	private String hora;
	private String merma;
	private String numFactura;
	private int folioElectronico;
	private float subtotal;
	private int idUsuario;
	public int getIdSalida() {
		return idSalida;
	}
	public void setIdSalida(int idSalida) {
		this.idSalida = idSalida;
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
	public String getMerma() {
		return merma;
	}
	public void setMerma(String merma) {
		this.merma = merma;
	}
	public String getNumFactura() {
		return numFactura;
	}
	public void setNumFactura(String numFactura) {
		this.numFactura = numFactura;
	}
	public int getFolioElectronico() {
		return folioElectronico;
	}
	public void setFolioElectronico(int folioElectronico) {
		this.folioElectronico = folioElectronico;
	}
	public float getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(float subtotal) {
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
		return "Salida [idSalida=" + idSalida + ", fecha=" + fecha + ", hora="
				+ hora + ", merma=" + merma + ", numFactura=" + numFactura
				+ ", folioElectronico=" + folioElectronico + ", subtotal="
				+ subtotal + ", idUsuario=" + idUsuario + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((fecha == null) ? 0 : fecha.hashCode());
		result = prime * result + folioElectronico;
		result = prime * result + ((hora == null) ? 0 : hora.hashCode());
		result = prime * result + idSalida;
		result = prime * result + idUsuario;
		result = prime * result + ((merma == null) ? 0 : merma.hashCode());
		result = prime * result
				+ ((numFactura == null) ? 0 : numFactura.hashCode());
		result = prime * result + Float.floatToIntBits(subtotal);
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
		Salida other = (Salida) obj;
		if (fecha == null) {
			if (other.fecha != null)
				return false;
		} else if (!fecha.equals(other.fecha))
			return false;
		if (folioElectronico != other.folioElectronico)
			return false;
		if (hora == null) {
			if (other.hora != null)
				return false;
		} else if (!hora.equals(other.hora))
			return false;
		if (idSalida != other.idSalida)
			return false;
		if (idUsuario != other.idUsuario)
			return false;
		if (merma == null) {
			if (other.merma != null)
				return false;
		} else if (!merma.equals(other.merma))
			return false;
		if (numFactura == null) {
			if (other.numFactura != null)
				return false;
		} else if (!numFactura.equals(other.numFactura))
			return false;
		if (Float.floatToIntBits(subtotal) != Float
				.floatToIntBits(other.subtotal))
			return false;
		return true;
	}
	
	
	
}
