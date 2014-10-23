package mx.com.pastillero.model.formBeans;

public class Cliente {
	private int idCliente;
	private String clave;
	private String nombre;
	private String email;
	private String rfc;
	private int idDireccion;
	private int credito;
	private int diasCredito;
	private float limiteCredito;
	private float ventaAnual;
	private float saldo;
	private float descuentoExtra;
	private float ventaMensual;
	private float insen;
	
	public Cliente() {
	
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}

	public String getClave() {
		return clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRfc() {
		return rfc;
	}

	public void setRfc(String rfc) {
		this.rfc = rfc;
	}

	public int getIdDireccion() {
		return idDireccion;
	}

	public void setIdDireccion(int idDireccion) {
		this.idDireccion = idDireccion;
	}

	public int getCredito() {
		return credito;
	}

	public void setCredito(int credito) {
		this.credito = credito;
	}

	public int getDiasCredito() {
		return diasCredito;
	}

	public void setDiasCredito(int diasCredito) {
		this.diasCredito = diasCredito;
	}

	public float getLimiteCredito() {
		return limiteCredito;
	}

	public void setLimiteCredito(float limiteCredito) {
		this.limiteCredito = limiteCredito;
	}

	public float getVentaAnual() {
		return ventaAnual;
	}

	public void setVentaAnual(float ventaAnual) {
		this.ventaAnual = ventaAnual;
	}

	public float getSaldo() {
		return saldo;
	}

	public void setSaldo(float saldo) {
		this.saldo = saldo;
	}

	public float getDescuentoExtra() {
		return descuentoExtra;
	}

	public void setDescuentoExtra(float descuentoExtra) {
		this.descuentoExtra = descuentoExtra;
	}

	public float getVentaMensual() {
		return ventaMensual;
	}

	public void setVentaMensual(float ventaMensual) {
		this.ventaMensual = ventaMensual;
	}

	public float getInsen() {
		return insen;
	}

	public void setInsen(float insen) {
		this.insen = insen;
	}

	@Override
	public String toString() {
		return "Cliente [idCliente=" + idCliente + ", clave=" + clave
				+ ", nombre=" + nombre + ", email=" + email + ", rfc=" + rfc
				+ ", idDireccion=" + idDireccion + ", credito=" + credito
				+ ", diasCredito=" + diasCredito + ", limiteCredito="
				+ limiteCredito + ", ventaAnual=" + ventaAnual + ", saldo="
				+ saldo + ", descuentoExtra=" + descuentoExtra
				+ ", ventaMensual=" + ventaMensual + ", insen=" + insen + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((clave == null) ? 0 : clave.hashCode());
		result = prime * result + credito;
		result = prime * result + Float.floatToIntBits(descuentoExtra);
		result = prime * result + diasCredito;
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + idCliente;
		result = prime * result + idDireccion;
		result = prime * result + Float.floatToIntBits(insen);
		result = prime * result + Float.floatToIntBits(limiteCredito);
		result = prime * result + ((nombre == null) ? 0 : nombre.hashCode());
		result = prime * result + ((rfc == null) ? 0 : rfc.hashCode());
		result = prime * result + Float.floatToIntBits(saldo);
		result = prime * result + Float.floatToIntBits(ventaAnual);
		result = prime * result + Float.floatToIntBits(ventaMensual);
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
		Cliente other = (Cliente) obj;
		if (clave == null) {
			if (other.clave != null)
				return false;
		} else if (!clave.equals(other.clave))
			return false;
		if (credito != other.credito)
			return false;
		if (Float.floatToIntBits(descuentoExtra) != Float
				.floatToIntBits(other.descuentoExtra))
			return false;
		if (diasCredito != other.diasCredito)
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (idCliente != other.idCliente)
			return false;
		if (idDireccion != other.idDireccion)
			return false;
		if (Float.floatToIntBits(insen) != Float.floatToIntBits(other.insen))
			return false;
		if (Float.floatToIntBits(limiteCredito) != Float
				.floatToIntBits(other.limiteCredito))
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		if (rfc == null) {
			if (other.rfc != null)
				return false;
		} else if (!rfc.equals(other.rfc))
			return false;
		if (Float.floatToIntBits(saldo) != Float.floatToIntBits(other.saldo))
			return false;
		if (Float.floatToIntBits(ventaAnual) != Float
				.floatToIntBits(other.ventaAnual))
			return false;
		if (Float.floatToIntBits(ventaMensual) != Float
				.floatToIntBits(other.ventaMensual))
			return false;
		return true;
	}
	
}
