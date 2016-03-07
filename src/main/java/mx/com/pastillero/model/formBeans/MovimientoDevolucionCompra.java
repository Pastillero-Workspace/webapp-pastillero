package mx.com.pastillero.model.formBeans;

public class MovimientoDevolucionCompra {
	private int idMovimiento;
	private String tipo;
	private int idNota;
	private String documento;
	private String clave;
	private int adquiridos;
	private int vendidos;
	private float valor;
	private int habian;
	private int quedan;
	private String fecha;
	private String hora;
	private float utilidad;
	
	public MovimientoDevolucionCompra(){
		
	}

	public int getIdMovimiento() {
		return idMovimiento;
	}

	public void setIdMovimiento(int idMovimiento) {
		this.idMovimiento = idMovimiento;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public int getIdNota() {
		return idNota;
	}

	public void setIdNota(int idNota) {
		this.idNota = idNota;
	}

	public String getDocumento() {
		return documento;
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}

	public String getClave() {
		return clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}

	public int getAdquiridos() {
		return adquiridos;
	}

	public void setAdquiridos(int adquiridos) {
		this.adquiridos = adquiridos;
	}

	public int getVendidos() {
		return vendidos;
	}

	public void setVendidos(int vendidos) {
		this.vendidos = vendidos;
	}

	public float getValor() {
		return valor;
	}

	public void setValor(float valor) {
		this.valor = valor;
	}

	public int getHabian() {
		return habian;
	}

	public void setHabian(int habian) {
		this.habian = habian;
	}

	public int getQuedan() {
		return quedan;
	}

	public void setQuedan(int quedan) {
		this.quedan = quedan;
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

	public float getUtilidad() {
		return utilidad;
	}

	public void setUtilidad(float utilidad) {
		this.utilidad = utilidad;
	}

	@Override
	public String toString() {
		return "MovimientoDevolucionCompra [idMovimiento=" + idMovimiento
				+ ", tipo=" + tipo + ", idNota=" + idNota + ", documento="
				+ documento + ", clave=" + clave + ", adquiridos=" + adquiridos
				+ ", vendidos=" + vendidos + ", valor=" + valor + ", habian="
				+ habian + ", quedan=" + quedan + ", fecha=" + fecha
				+ ", hora=" + hora + ", utilidad=" + utilidad + "]";
	}

		
	
}
