package mx.com.pastillero.model.formBeans;

public class MovimientoSalida 
{
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
		return "MovimientoSalida [idMovimiento=" + idMovimiento + ", tipo="
				+ tipo + ", idNota=" + idNota + ", documento=" + documento
				+ ", clave=" + clave + ", adquiridos=" + adquiridos
				+ ", vendidos=" + vendidos + ", valor=" + valor + ", habian="
				+ habian + ", quedan=" + quedan + ", fecha=" + fecha
				+ ", hora=" + hora + ", utilidad=" + utilidad + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + adquiridos;
		result = prime * result + ((clave == null) ? 0 : clave.hashCode());
		result = prime * result
				+ ((documento == null) ? 0 : documento.hashCode());
		result = prime * result + ((fecha == null) ? 0 : fecha.hashCode());
		result = prime * result + habian;
		result = prime * result + ((hora == null) ? 0 : hora.hashCode());
		result = prime * result + idMovimiento;
		result = prime * result + idNota;
		result = prime * result + quedan;
		result = prime * result + ((tipo == null) ? 0 : tipo.hashCode());
		result = prime * result + Float.floatToIntBits(utilidad);
		result = prime * result + Float.floatToIntBits(valor);
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
		MovimientoSalida other = (MovimientoSalida) obj;
		if (adquiridos != other.adquiridos)
			return false;
		if (clave == null) {
			if (other.clave != null)
				return false;
		} else if (!clave.equals(other.clave))
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
		if (habian != other.habian)
			return false;
		if (hora == null) {
			if (other.hora != null)
				return false;
		} else if (!hora.equals(other.hora))
			return false;
		if (idMovimiento != other.idMovimiento)
			return false;
		if (idNota != other.idNota)
			return false;
		if (quedan != other.quedan)
			return false;
		if (tipo == null) {
			if (other.tipo != null)
				return false;
		} else if (!tipo.equals(other.tipo))
			return false;
		if (Float.floatToIntBits(utilidad) != Float
				.floatToIntBits(other.utilidad))
			return false;
		if (Float.floatToIntBits(valor) != Float.floatToIntBits(other.valor))
			return false;
		if (vendidos != other.vendidos)
			return false;
		return true;
	}
	
	
		
	
	
}
