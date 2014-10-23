package mx.com.pastillero.model.formBeans;

public class CfgSucursal {
	
	private int idSistema;
	private String razonSocial;
	private String rfc;
	private String sucursal;
	private String calle;
	private String colonia;
	private String numeroInt;
	private String numeroExt;
	private String municipio;
	private String estado;
	private String cp;
	private String telefono;
	private String email;
	private String web;
	
	public int getIdSistema() {
		return idSistema;
	}
	public void setIdSistema(int idSistema) {
		this.idSistema = idSistema;
	}
	public String getRazonSocial() {
		return razonSocial;
	}
	public void setRazonSocial(String razonSocial) {
		this.razonSocial = razonSocial;
	}
	public String getRfc() {
		return rfc;
	}
	public void setRfc(String rfc) {
		this.rfc = rfc;
	}
	public String getSucursal() {
		return sucursal;
	}
	public void setSucursal(String sucursal) {
		this.sucursal = sucursal;
	}
	public String getCalle() {
		return calle;
	}
	public void setCalle(String calle) {
		this.calle = calle;
	}
	public String getColonia() {
		return colonia;
	}
	public void setColonia(String colonia) {
		this.colonia = colonia;
	}
	public String getNumeroInt() {
		return numeroInt;
	}
	public void setNumeroInt(String numeroInt) {
		this.numeroInt = numeroInt;
	}
	public String getNumeroExt() {
		return numeroExt;
	}
	public void setNumeroExt(String numeroExt) {
		this.numeroExt = numeroExt;
	}
	public String getMunicipio() {
		return municipio;
	}
	public void setMunicipio(String municipio) {
		this.municipio = municipio;
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
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWeb() {
		return web;
	}
	public void setWeb(String web) {
		this.web = web;
	}
	@Override
	public String toString() {
		return "CfgSucursal [idSistema=" + idSistema + ", razonSocial="
				+ razonSocial + ", rfc=" + rfc + ", sucursal=" + sucursal
				+ ", calle=" + calle + ", colonia=" + colonia + ", numeroInt="
				+ numeroInt + ", numeroExt=" + numeroExt + ", municipio="
				+ municipio + ", estado=" + estado + ", cp=" + cp
				+ ", telefono=" + telefono + ", email=" + email + ", web="
				+ web + "]";
	}
	
		
	
}
