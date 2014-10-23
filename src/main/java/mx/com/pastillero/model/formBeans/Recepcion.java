package mx.com.pastillero.model.formBeans;

public class Recepcion {
	private int idRecepcion;
	private String numFactura;
	private String fecha;
	private String hora;
	private float desc1;
	private float desc2;
	private int folioElectronico;
	private int notaFactura;
	private float subtotal;
	private int estado;
	private int idUsuario;
	private int idProveedor;
	
	public Recepcion() {
	
	}


	public int getIdRecepcion() {
		return idRecepcion;
	}



	public void setIdRecepcion(int idRecepcion) {
		this.idRecepcion = idRecepcion;
	}



	public String getNumFactura() {
		return numFactura;
	}



	public void setNumFactura(String numFactura) {
		this.numFactura = numFactura;
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



	public float getDesc1() {
		return desc1;
	}



	public void setDesc1(float desc1) {
		this.desc1 = desc1;
	}



	public float getDesc2() {
		return desc2;
	}



	public void setDesc2(float desc2) {
		this.desc2 = desc2;
	}



	public int getFolioElectronico() {
		return folioElectronico;
	}



	public void setFolioElectronico(int folioElectronico) {
		this.folioElectronico = folioElectronico;
	}



	public int getNotaFactura() {
		return notaFactura;
	}



	public void setNotaFactura(int notaFactura) {
		this.notaFactura = notaFactura;
	}



	public float getSubtotal() {
		return subtotal;
	}



	public void setSubtotal(float subtotal) {
		this.subtotal = subtotal;
	}



	public int getEstado() {
		return estado;
	}



	public void setEstado(int estado) {
		this.estado = estado;
	}



	public int getIdUsuario() {
		return idUsuario;
	}



	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}



	public int getIdProveedor() {
		return idProveedor;
	}



	public void setIdProveedor(int idProveedor) {
		this.idProveedor = idProveedor;
	}



	@Override
	public String toString() {
		return "Recepcion [idRecepcion=" + idRecepcion + ", numFactura="
				+ numFactura + ", fecha=" + fecha + ", hora=" + hora
				+ ", desc1=" + desc1 + ", desc2=" + desc2
				+ ", folioElectronico=" + folioElectronico + ", notaFactura="
				+ notaFactura + ", subtotal=" + subtotal + ", estado=" + estado
				+ ", idUsuario=" + idUsuario + ", idProveedor=" + idProveedor
				+ "]";
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + Float.floatToIntBits(desc1);
		result = prime * result + Float.floatToIntBits(desc2);
		result = prime * result + estado;
		result = prime * result + ((fecha == null) ? 0 : fecha.hashCode());
		result = prime * result + folioElectronico;
		result = prime * result + ((hora == null) ? 0 : hora.hashCode());
		result = prime * result + idProveedor;
		result = prime * result + idRecepcion;
		result = prime * result + idUsuario;
		result = prime * result + notaFactura;
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
		Recepcion other = (Recepcion) obj;
		if (Float.floatToIntBits(desc1) != Float.floatToIntBits(other.desc1))
			return false;
		if (Float.floatToIntBits(desc2) != Float.floatToIntBits(other.desc2))
			return false;
		if (estado != other.estado)
			return false;
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
		if (idProveedor != other.idProveedor)
			return false;
		if (idRecepcion != other.idRecepcion)
			return false;
		if (idUsuario != other.idUsuario)
			return false;
		if (notaFactura != other.notaFactura)
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