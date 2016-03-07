package mx.com.pastillero.model.formBeans;

public class Nota {
	private int idNota;
	private String fecha;
	private String hora;
	private String estado;
	private float precio;
    private float descuento;
    private float iva;
    private float subtotal;
    private float total;
	private int idCliente;
	private int idUsuario;
	private int idCajero;
	
	public Nota()
	{
		
	}

	public int getIdNota() {
		return idNota;
	}

	public void setIdNota(int idNota) {
		this.idNota = idNota;
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

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public float getPrecio() {
		return precio;
	}

	public void setPrecio(float precio) {
		this.precio = precio;
	}

	public float getDescuento() {
		return descuento;
	}

	public void setDescuento(float descuento) {
		this.descuento = descuento;
	}

	public float getIva() {
		return iva;
	}

	public void setIva(float iva) {
		this.iva = iva;
	}

	public float getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(float subtotal) {
		this.subtotal = subtotal;
	}

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public int getIdCajero() {
		return idCajero;
	}

	public void setIdCajero(int idCajero) {
		this.idCajero = idCajero;
	}

	@Override
	public String toString() {
		return "Nota [idNota=" + idNota + ", fecha=" + fecha + ", hora=" + hora
				+ ", estado=" + estado + ", precio=" + precio + ", descuento="
				+ descuento + ", iva=" + iva + ", subtotal=" + subtotal
				+ ", total=" + total + ", idCliente=" + idCliente
				+ ", idUsuario=" + idUsuario + ", idCajero=" + idCajero + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + Float.floatToIntBits(descuento);
		result = prime * result + ((estado == null) ? 0 : estado.hashCode());
		result = prime * result + ((fecha == null) ? 0 : fecha.hashCode());
		result = prime * result + ((hora == null) ? 0 : hora.hashCode());
		result = prime * result + idCajero;
		result = prime * result + idCliente;
		result = prime * result + idNota;
		result = prime * result + idUsuario;
		result = prime * result + Float.floatToIntBits(iva);
		result = prime * result + Float.floatToIntBits(precio);
		result = prime * result + Float.floatToIntBits(subtotal);
		result = prime * result + Float.floatToIntBits(total);
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
		Nota other = (Nota) obj;
		if (Float.floatToIntBits(descuento) != Float
				.floatToIntBits(other.descuento))
			return false;
		if (estado == null) {
			if (other.estado != null)
				return false;
		} else if (!estado.equals(other.estado))
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
		if (idCajero != other.idCajero)
			return false;
		if (idCliente != other.idCliente)
			return false;
		if (idNota != other.idNota)
			return false;
		if (idUsuario != other.idUsuario)
			return false;
		if (Float.floatToIntBits(iva) != Float.floatToIntBits(other.iva))
			return false;
		if (Float.floatToIntBits(precio) != Float.floatToIntBits(other.precio))
			return false;
		if (Float.floatToIntBits(subtotal) != Float
				.floatToIntBits(other.subtotal))
			return false;
		if (Float.floatToIntBits(total) != Float.floatToIntBits(other.total))
			return false;
		return true;
	}

	

}
