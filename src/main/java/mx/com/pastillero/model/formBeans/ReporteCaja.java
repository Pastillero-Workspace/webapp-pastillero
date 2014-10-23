package mx.com.pastillero.model.formBeans;

public class ReporteCaja {
	private int idReporte;
	private int idUsuario;
	private String fecha;
	private String horaInicial;
	private String horaCorte;
	private float disponible;
	private float retiro;
	private float deposito;
	public ReporteCaja() {
	
	}

	public int getIdReporte() {
		return idReporte;
	}

	public void setIdReporte(int idReporte) {
		this.idReporte = idReporte;
	}

	public int getIdUsuario() {
		return idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getHoraInicial() {
		return horaInicial;
	}

	public void setHoraInicial(String horaInicial) {
		this.horaInicial = horaInicial;
	}

	public String getHoraCorte() {
		return horaCorte;
	}

	public void setHoraCorte(String horaCorte) {
		this.horaCorte = horaCorte;
	}

	
	public float getDisponible() {
		return disponible;
	}

	public void setDisponible(float disponible) {
		this.disponible = disponible;
	}

	public float getRetiro() {
		return retiro;
	}

	public void setRetiro(float retiro) {
		this.retiro = retiro;
	}

	@Override
	public String toString() {
		return "ReporteCaja [idReporte=" + idReporte + ", idUsuario="
				+ idUsuario + ", fecha=" + fecha + ", horaInicial="
				+ horaInicial + ", horaCorte=" + horaCorte + ", disponible="
				+ disponible + ", retiro=" + retiro + "]";
	}

	public float getDeposito() {
		return deposito;
	}

	public void setDeposito(float deposito) {
		this.deposito = deposito;
	}
	
	
}
