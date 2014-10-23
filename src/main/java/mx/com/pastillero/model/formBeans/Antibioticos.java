package mx.com.pastillero.model.formBeans;

public class Antibioticos {
	private int idAntibiotico;
	private int idProducto;
	private String fecha;
	private String documento;
	private int receta;
	private int sello;
	private int adquiridos;
	private int vendidos;
	private int quedan;
	private int idMedico;

	public Antibioticos() {
	}

	public int getIdAntibiotico() {
		return idAntibiotico;
	}

	public void setIdAntibiotico(int idAntibiotico) {
		this.idAntibiotico = idAntibiotico;
	}

	public int getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getDocumento() {
		return documento;
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}

	public int getReceta() {
		return receta;
	}

	public void setReceta(int receta) {
		this.receta = receta;
	}

	public int getSello() {
		return sello;
	}

	public void setSello(int sello) {
		this.sello = sello;
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

	public int getQuedan() {
		return quedan;
	}

	public void setQuedan(int quedan) {
		this.quedan = quedan;
	}

	public int getIdMedico() {
		return idMedico;
	}

	public void setIdMedico(int idMedico) {
		this.idMedico = idMedico;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + adquiridos;
		result = prime * result
				+ ((documento == null) ? 0 : documento.hashCode());
		result = prime * result + ((fecha == null) ? 0 : fecha.hashCode());
		result = prime * result + idAntibiotico;
		result = prime * result + idMedico;
		result = prime * result + idProducto;
		result = prime * result + quedan;
		result = prime * result + receta;
		result = prime * result + sello;
		result = prime * result + vendidos;
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
		Antibioticos other = (Antibioticos) obj;
		if (adquiridos != other.adquiridos)
			return false;
		if (documento == null) {
			if (other.documento != null)
				return false;
		} else if (!documento.equals(other.documento))
			return false;
		if (fecha == null) {
			if (other.fecha != null)
				return false;
		} else if (!fecha.equals(other.fecha))
			return false;
		if (idAntibiotico != other.idAntibiotico)
			return false;
		if (idMedico != other.idMedico)
			return false;
		if (idProducto != other.idProducto)
			return false;
		if (quedan != other.quedan)
			return false;
		if (receta != other.receta)
			return false;
		if (sello != other.sello)
			return false;
		if (vendidos != other.vendidos)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Antibioticos [idAntibiotico=" + idAntibiotico + ", idProducto="
				+ idProducto + ", fecha=" + fecha + ", documento=" + documento
				+ ", receta=" + receta + ", sello=" + sello + ", adquiridos="
				+ adquiridos + ", vendidos=" + vendidos + ", quedan=" + quedan
				+ ", idMedico=" + idMedico + "]";
	}
}