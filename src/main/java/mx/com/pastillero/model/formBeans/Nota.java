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

	@Override
	public String toString() {
		return "Nota [idNota=" + idNota + ", fecha=" + fecha + ", hora=" + hora
				+ ", estado=" + estado + ", precio=" + precio + ", descuento="
				+ descuento + ", iva=" + iva + ", subtotal=" + subtotal
				+ ", total=" + total + ", idCliente=" + idCliente
				+ ", idUsuario=" + idUsuario + "]";
	}
	

}
