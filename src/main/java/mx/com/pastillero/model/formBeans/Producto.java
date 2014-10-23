package mx.com.pastillero.model.formBeans;

public class Producto {
	private int idProducto;
	private String codBar;
	private int existencias;
	private String descripcion;
	private String laboratorio;
	private String cls;
	private String ssa;
	private int iva;
	private int ieps;
	private String categoria;
	private String pareto;
	private float precioPub;
	private float precioDesc;
	private int idFamilia;
	
	public Producto() {
		
	}

	public int getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}

	public String getCodBar() {
		return codBar;
	}

	public void setCodBar(String codBar) {
		this.codBar = codBar;
	}

	public int getExistencias() {
		return existencias;
	}

	public void setExistencias(int existencias) {
		this.existencias = existencias;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getLaboratorio() {
		return laboratorio;
	}

	public void setLaboratorio(String laboratorio) {
		this.laboratorio = laboratorio;
	}

	public String getCls() {
		return cls;
	}

	public void setCls(String cls) {
		this.cls = cls;
	}

	public String getSsa() {
		return ssa;
	}

	public void setSsa(String ssa) {
		this.ssa = ssa;
	}

	public int getIva() {
		return iva;
	}

	public void setIva(int iva) {
		this.iva = iva;
	}

	public int getIeps() {
		return ieps;
	}

	public void setIeps(int ieps) {
		this.ieps = ieps;
	}

	public String getCategoria() {
		return categoria;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}

	public String getPareto() {
		return pareto;
	}

	public void setPareto(String pareto) {
		this.pareto = pareto;
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

	public int getIdFamilia() {
		return idFamilia;
	}

	public void setIdFamilia(int idFamilia) {
		this.idFamilia = idFamilia;
	}

	@Override
	public String toString() {
		return "Producto [idProducto=" + idProducto + ", codBar=" + codBar
				+ ", existencias=" + existencias + ", descripcion="
				+ descripcion + ", laboratorio=" + laboratorio + ", cls=" + cls
				+ ", ssa=" + ssa + ", iva=" + iva + ", ieps=" + ieps
				+ ", categoria=" + categoria + ", pareto=" + pareto
				+ ", precioPub=" + precioPub + ", precioDesc=" + precioDesc
				+ ", idFamilia=" + idFamilia + "]";
	}
	
	public String setFormatData() {
		return "" + idProducto + "," + codBar
				+ "," + existencias + ","
				+ descripcion + "," + laboratorio + "," + cls
				+ "," + ssa + "," + iva + "," + ieps
				+ "," + categoria + "," + pareto
				+ "," + precioPub + "," + precioDesc
				+ "," + idFamilia + ",";
	}
	

	
	
}
	