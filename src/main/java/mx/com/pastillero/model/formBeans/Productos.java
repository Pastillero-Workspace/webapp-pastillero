package mx.com.pastillero.model.formBeans;


// master class for products

public class Productos 
{
	private int idProducto;
	private String proveedor;
	private String clave;
	private String codBar;
	private String descripcion;
	private int idFamilia;
	private float precioPub;
	private float precioDesc;
	private float precioFarmacia;
	private int iva;
	private String linea;
	private String referencia;
	private String SSA;
	private String laboratorio;
	private String departamento;
	private String categoria;
	private int actualizable;
	private int descuento;
	private float costo;
	private String equivalencia;
	private String superfamilia;
	private String cls;
	private String zona;
	private String pareto;
	private int ieps;
	private int ieps2;
	private float limitado;
	private String kit;
	private int comision;
	private float maxdescuento;
	private String grupo;
	private int aplicadescbase;
	private int aplicapo;
	private int antibiotico;
	private int existencias;
	private String ultimoproveedor;
	private float ultimocosto;
	private float costopromedio;
	private float costoreal;
	
	
	public int getIdProducto() {
		return idProducto;
	}
	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}
	public String getProveedor() {
		return proveedor;
	}
	public void setProveedor(String proveedor) {
		this.proveedor = proveedor;
	}
	public String getCodBar() {
		return codBar;
	}
	public void setCodBar(String codBar) {
		this.codBar = codBar;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public int getIdFamilia() {
		return idFamilia;
	}
	public void setIdFamilia(int idFamilia) {
		this.idFamilia = idFamilia;
	}
	public float getPrecioPub() {
		return precioPub;
	}
	public void setPrecioPub(float precioPub) {
		this.precioPub = precioPub;
	}
	public float getPrecioDesc() {
		return precioDesc;
	}
	public void setPrecioDesc(float precioDesc) {
		this.precioDesc = precioDesc;
	}

	public String getLinea() {
		return linea;
	}
	public void setLinea(String linea) {
		this.linea = linea;
	}
	public String getReferencia() {
		return referencia;
	}
	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}
	public String getSSA() {
		return SSA;
	}
	public void setSSA(String sSA) {
		SSA = sSA;
	}
	public String getLaboratorio() {
		return laboratorio;
	}
	public void setLaboratorio(String laboratorio) {
		this.laboratorio = laboratorio;
	}
	public String getDepartamento() {
		return departamento;
	}
	public void setDepartamento(String departamento) {
		this.departamento = departamento;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public int getActualizable() {
		return actualizable;
	}
	public void setActualizable(int actualizable) {
		this.actualizable = actualizable;
	}
	public int getDescuento() {
		return descuento;
	}
	public void setDescuento(int descuento) {
		this.descuento = descuento;
	}
	public float getCosto() {
		return costo;
	}
	public void setCosto(float costo) {
		this.costo = costo;
	}
	public String getEquivalencia() {
		return equivalencia;
	}
	public void setEquivalencia(String equivalencia) {
		this.equivalencia = equivalencia;
	}
	public String getSuperfamilia() {
		return superfamilia;
	}
	public void setSuperfamilia(String superfamilia) {
		this.superfamilia = superfamilia;
	}
	public String getCls() {
		return cls;
	}
	public void setCls(String cls) {
		this.cls = cls;
	}
	public String getZona() {
		return zona;
	}
	public void setZona(String zona) {
		this.zona = zona;
	}
	public String getPareto() {
		return pareto;
	}
	public void setPareto(String pareto) {
		this.pareto = pareto;
	}
	public int getIeps() {
		return ieps;
	}
	public void setIeps(int ieps) {
		this.ieps = ieps;
	}
	public int getIeps2() {
		return ieps2;
	}
	public void setIeps2(int ieps2) {
		this.ieps2 = ieps2;
	}
	public float getLimitado() {
		return limitado;
	}
	public void setLimitado(float limitado) {
		this.limitado = limitado;
	}
	public String getKit() {
		return kit;
	}
	public void setKit(String kit) {
		this.kit = kit;
	}
	public int getComision() {
		return comision;
	}
	public void setComision(int comision) {
		this.comision = comision;
	}
	public float getMaxdescuento() {
		return maxdescuento;
	}
	public void setMaxdescuento(float maxdescuento) {
		this.maxdescuento = maxdescuento;
	}
	public String getGrupo() {
		return grupo;
	}
	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}
	public int getAplicadescbase() {
		return aplicadescbase;
	}
	public void setAplicadescbase(int aplicadescbase) {
		this.aplicadescbase = aplicadescbase;
	}
	public int getAplicapo() {
		return aplicapo;
	}
	public void setAplicapo(int aplicapo) {
		this.aplicapo = aplicapo;
	}
	public int getAntibiotico() {
		return antibiotico;
	}
	public void setAntibiotico(int antibiotico) {
		this.antibiotico = antibiotico;
	}
	public int getExistencias() {
		return existencias;
	}
	public void setExistencias(int existencias) {
		this.existencias = existencias;
	}
	public String getUltimoproveedor() {
		return ultimoproveedor;
	}
	public void setUltimoproveedor(String ultimoproveedor) {
		this.ultimoproveedor = ultimoproveedor;
	}
	public float getUltimocosto() {
		return ultimocosto;
	}
	public void setUltimocosto(float ultimocosto) {
		this.ultimocosto = ultimocosto;
	}
	public float getCostopromedio() {
		return costopromedio;
	}
	public void setCostopromedio(float costopromedio) {
		this.costopromedio = costopromedio;
	}
	public float getCostoreal() {
		return costoreal;
	}
	public void setCostoreal(float costoreal) {
		this.costoreal = costoreal;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	
	public float getPrecioFarmacia() {
		return precioFarmacia;
	}
	public void setPrecioFarmacia(float precioFarmacia) {
		this.precioFarmacia = precioFarmacia;
	}
	public int getIva() {
		return iva;
	}
	public void setIva(int iva) {
		this.iva = iva;
	}
	
	
	// another methods for getting information
	
	@Override
	public String toString() {
		return "Productos [idProducto=" + idProducto + ", proveedor="
				+ proveedor + ", clave=" + clave + ", codBar=" + codBar
				+ ", descripcion=" + descripcion + ", idFamilia=" + idFamilia
				+ ", precioPub=" + precioPub + ", precioDesc=" + precioDesc
				+ ", precioFarmacia=" + precioFarmacia + ", iva=" + iva
				+ ", linea=" + linea + ", referencia=" + referencia + ", SSA="
				+ SSA + ", laboratorio=" + laboratorio + ", departamento="
				+ departamento + ", categoria=" + categoria + ", actualizable="
				+ actualizable + ", descuento=" + descuento + ", costo="
				+ costo + ", equivalencia=" + equivalencia + ", superfamilia="
				+ superfamilia + ", cls=" + cls + ", zona=" + zona
				+ ", pareto=" + pareto + ", ieps=" + ieps + ", ieps2=" + ieps2
				+ ", limitado=" + limitado + ", kit=" + kit + ", comision="
				+ comision + ", maxdescuento=" + maxdescuento + ", grupo="
				+ grupo + ", aplicadescbase=" + aplicadescbase + ", aplicapo="
				+ aplicapo + ", antibiotico=" + antibiotico + ", existencias="
				+ existencias + ", ultimoproveedor=" + ultimoproveedor
				+ ", ultimocosto=" + ultimocosto + ", costopromedio="
				+ costopromedio + ", costoreal=" + costoreal + "]";
	}
	
	public String setFormatData() {
		return "" + idProducto + "~" + codBar
				+ "~" + existencias + "~"
				+ descripcion + "~" + laboratorio + "~" + cls
				+ "~" + SSA + "~" + iva + "~" + ieps
				+ "~" + categoria + "~" + pareto
				+ "~" + precioPub + "~" + precioDesc
				+ "~" + idFamilia + "~";
	}
	
}
