package mx.com.pastillero.model.formBeans;

public class Movimientos {
	private int idMovimiento;
	private String movimiento;
	private int folio;
	private int documento;
	private int clave;
	private String descripcion;
	private int adquiridos;
	private int vendidos;
	private int valor;
	private int habian;
	private int quedan;
	private String fecha;
	private String hora;
	
	
	public Movimientos() {
		
	}


	public int getIdMovimiento() {
		return idMovimiento;
	}


	public void setIdMovimiento(int idMovimiento) {
		this.idMovimiento = idMovimiento;
	}


	public String getMovimiento() {
		return movimiento;
	}


	public void setMovimiento(String movimiento) {
		this.movimiento = movimiento;
	}


	public int getFolio() {
		return folio;
	}


	public void setFolio(int folio) {
		this.folio = folio;
	}


	public int getDocumento() {
		return documento;
	}


	public void setDocumento(int documento) {
		this.documento = documento;
	}


	public int getClave() {
		return clave;
	}


	public void setClave(int clave) {
		this.clave = clave;
	}


	public String getDescripcion() {
		return descripcion;
	}


	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
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


	public int getValor() {
		return valor;
	}


	public void setValor(int valor) {
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


	@Override
	public String toString() {
		return "Movimientos [idMovimiento=" + idMovimiento + ", movimiento="
				+ movimiento + ", folio=" + folio + ", documento=" + documento
				+ ", clave=" + clave + ", descripcion=" + descripcion
				+ ", adquiridos=" + adquiridos + ", vendidos=" + vendidos
				+ ", valor=" + valor + ", habian=" + habian + ", quedan="
				+ quedan + ", fecha=" + fecha + ", hora=" + hora + "]";
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + adquiridos;
		result = prime * result + clave;
		result = prime * result
				+ ((descripcion == null) ? 0 : descripcion.hashCode());
		result = prime * result + documento;
		result = prime * result + ((fecha == null) ? 0 : fecha.hashCode());
		result = prime * result + folio;
		result = prime * result + habian;
		result = prime * result + ((hora == null) ? 0 : hora.hashCode());
		result = prime * result + idMovimiento;
		result = prime * result
				+ ((movimiento == null) ? 0 : movimiento.hashCode());
		result = prime * result + quedan;
		result = prime * result + valor;
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
		Movimientos other = (Movimientos) obj;
		if (adquiridos != other.adquiridos)
			return false;
		if (clave != other.clave)
			return false;
		if (descripcion == null) {
			if (other.descripcion != null)
				return false;
		} else if (!descripcion.equals(other.descripcion))
			return false;
		if (documento != other.documento)
			return false;
		if (fecha == null) {
			if (other.fecha != null)
				return false;
		} else if (!fecha.equals(other.fecha))
			return false;
		if (folio != other.folio)
			return false;
		if (habian != other.habian)
			return false;
		if (hora == null) {
			if (other.hora != null)
				return false;
		} else if (!hora.equals(other.hora))
			return false;
		if (idMovimiento != other.idMovimiento)
			return false;
		if (movimiento == null) {
			if (other.movimiento != null)
				return false;
		} else if (!movimiento.equals(other.movimiento))
			return false;
		if (quedan != other.quedan)
			return false;
		if (valor != other.valor)
			return false;
		if (vendidos != other.vendidos)
			return false;
		return true;
	}
	
	
}