package mx.com.pastillero.model.formBeans;

public class Proveedor {
	private int idProveedor;
	private String nombre;
	private String razonSocial;
	private String email;
	private String fax;
	private String rfc;
	private int diasCredito;
	private int idDireccion;
	private int descGeneral;
	private int desc2;
	private int desc3;

	public Proveedor() {

	}

	public int getIdProveedor() {
		return idProveedor;
	}

	public void setIdProveedor(int idProveedor) {
		this.idProveedor = idProveedor;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getRazonSocial() {
		return razonSocial;
	}

	public void setRazonSocial(String razonSocial) {
		this.razonSocial = razonSocial;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getRfc() {
		return rfc;
	}

	public void setRfc(String rfc) {
		this.rfc = rfc;
	}

	public int getDiasCredito() {
		return diasCredito;
	}

	public void setDiasCredito(int diasCredito) {
		this.diasCredito = diasCredito;
	}

	public int getIdDireccion() {
		return idDireccion;
	}

	public void setIdDireccion(int idDireccion) {
		this.idDireccion = idDireccion;
	}

	public int getDescGeneral() {
		return descGeneral;
	}

	public void setDescGeneral(int descGeneral) {
		this.descGeneral = descGeneral;
	}

	public int getDesc2() {
		return desc2;
	}

	public void setDesc2(int desc2) {
		this.desc2 = desc2;
	}

	public int getDesc3() {
		return desc3;
	}

	public void setDesc3(int desc3) {
		this.desc3 = desc3;
	}

	@Override
	public String toString() {
		return "Proveedor [idProveedor=" + idProveedor + ", nombre=" + nombre
				+ ", razonSocial=" + razonSocial + ", email=" + email
				+ ", fax=" + fax + ", rfc=" + rfc + ", diasCredito="
				+ diasCredito + ", idDireccion=" + idDireccion
				+ ", descGeneral=" + descGeneral + ", desc2=" + desc2
				+ ", desc3=" + desc3 + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + desc2;
		result = prime * result + desc3;
		result = prime * result + descGeneral;
		result = prime * result + diasCredito;
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((fax == null) ? 0 : fax.hashCode());
		result = prime * result + idDireccion;
		result = prime * result + idProveedor;
		result = prime * result + ((nombre == null) ? 0 : nombre.hashCode());
		result = prime * result
				+ ((razonSocial == null) ? 0 : razonSocial.hashCode());
		result = prime * result + ((rfc == null) ? 0 : rfc.hashCode());
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
		Proveedor other = (Proveedor) obj;
		if (desc2 != other.desc2)
			return false;
		if (desc3 != other.desc3)
			return false;
		if (descGeneral != other.descGeneral)
			return false;
		if (diasCredito != other.diasCredito)
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (fax == null) {
			if (other.fax != null)
				return false;
		} else if (!fax.equals(other.fax))
			return false;
		if (idDireccion != other.idDireccion)
			return false;
		if (idProveedor != other.idProveedor)
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		if (razonSocial == null) {
			if (other.razonSocial != null)
				return false;
		} else if (!razonSocial.equals(other.razonSocial))
			return false;
		if (rfc == null) {
			if (other.rfc != null)
				return false;
		} else if (!rfc.equals(other.rfc))
			return false;
		return true;
	}
	
	

}
