package mx.com.pastillero.model.formBeans;

public class Sesion 
{
	
	private int idSesion;
	private int idUsuario;
	private String usuario;
	private String fechaIngreso;
	private String horaIngreso;
	private String fechaSalida;
	private String horaSalida;
	
	// getters and setters
	
	public int getIdSesion() {
		return idSesion;
	}
	public void setIdSesion(int idSesion) {
		this.idSesion = idSesion;
	}
	public int getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getFechaIngreso() {
		return fechaIngreso;
	}
	public void setFechaIngreso(String fechaIngreso) {
		this.fechaIngreso = fechaIngreso;
	}
	public String getHoraIngreso() {
		return horaIngreso;
	}
	public void setHoraIngreso(String horaIngreso) {
		this.horaIngreso = horaIngreso;
	}
	public String getFechaSalida() {
		return fechaSalida;
	}
	public void setFechaSalida(String fechaSalida) {
		this.fechaSalida = fechaSalida;
	}
	public String getHoraSalida() {
		return horaSalida;
	}
	public void setHoraSalida(String horaSalida) {
		this.horaSalida = horaSalida;
	}
	
	@Override
	public String toString() {
		return "Sesion [idSesion=" + idSesion + ", idUsuario=" + idUsuario
				+ ", usuario=" + usuario + ", fechaIngreso=" + fechaIngreso
				+ ", horaIngreso=" + horaIngreso + ", fechaSalida="
				+ fechaSalida + ", horaSalida=" + horaSalida + "]";
	}
	
	
	
	
}
