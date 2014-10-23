package mx.com.pastillero.model.formBeans;

public class ProveedorDireccion {
	private int idProveedor;
	private String nombre;
	private String email;
	private String fax;
	private String rfc;
	private int diasCredito;
	private int idDireccion;
	private int descGeneral;
	private int desc2;
	private int desc3;
	private String calle;
	private int noInt;
	private int noExt;
	private String colonia;
	private String estado;
	private String cp;
	
	
	public ProveedorDireccion() {
		
	}


	public ProveedorDireccion(int idProveedor, String nombre, String email,
			String fax, String rfc, int diasCredito, int idDireccion,
			int descGeneral, int desc2, int desc3, String calle, int noInt,
			int noExt, String colonia, String estado, String cp) {
		super();
		this.idProveedor = idProveedor;
		this.nombre = nombre;
		this.email = email;
		this.fax = fax;
		this.rfc = rfc;
		this.diasCredito = diasCredito;
		this.idDireccion = idDireccion;
		this.descGeneral = descGeneral;
		this.desc2 = desc2;
		this.desc3 = desc3;
		this.calle = calle;
		this.noInt = noInt;
		this.noExt = noExt;
		this.colonia = colonia;
		this.estado = estado;
		this.cp = cp;
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


	public String getCalle() {
		return calle;
	}


	public void setCalle(String calle) {
		this.calle = calle;
	}


	public int getNoInt() {
		return noInt;
	}


	public void setNoInt(int noInt) {
		this.noInt = noInt;
	}


	public int getNoExt() {
		return noExt;
	}


	public void setNoExt(int noExt) {
		this.noExt = noExt;
	}


	public String getColonia() {
		return colonia;
	}


	public void setColonia(String colonia) {
		this.colonia = colonia;
	}


	public String getEstado() {
		return estado;
	}


	public void setEstado(String estado) {
		this.estado = estado;
	}


	public String getCp() {
		return cp;
	}


	public void setCp(String cp) {
		this.cp = cp;
	}


	@Override
	public String toString() {
		return "ProveedorDireccion [idProveedor=" + idProveedor + ", nombre="
				+ nombre + ", email=" + email + ", fax=" + fax + ", rfc=" + rfc
				+ ", diasCredito=" + diasCredito + ", idDireccion="
				+ idDireccion + ", descGeneral=" + descGeneral + ", desc2="
				+ desc2 + ", desc3=" + desc3 + ", calle=" + calle + ", noInt="
				+ noInt + ", noExt=" + noExt + ", colonia=" + colonia
				+ ", estado=" + estado + ", cp=" + cp + "]";
	}
	
	
	
	

}
