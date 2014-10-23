package mx.com.pastillero.model.formBeans;

public class DevolucionCompra {
	private int IdDevolucion;
	private String fecha;
	private String hora;
	private String motivo;
	private String estado;
	private int IdUsuario;
	private int notaReferencia;
	private int notaActual;
	public int getIdDevolucion() {
		return IdDevolucion;
	}
	public void setIdDevolucion(int idDevolucion) {
		IdDevolucion = idDevolucion;
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
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public int getIdUsuario() {
		return IdUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		IdUsuario = idUsuario;
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
		return "DevolucionCompra [IdDevolucion=" + IdDevolucion + ", fecha="
				+ fecha + ", hora=" + hora + ", motivo=" + motivo + ", estado="
				+ estado + ", IdUsuario=" + IdUsuario + ", notaReferencia="
				+ notaReferencia + ", notaActual=" + notaActual + "]";
	}
	
	
	
	
	
}
