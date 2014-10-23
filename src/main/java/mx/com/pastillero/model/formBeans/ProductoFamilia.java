package mx.com.pastillero.model.formBeans;

public class ProductoFamilia {
	private String codBar;
	private int existencias;
	private String descripcion;
	private String nombre;
	private String laboratorio;
	private String cls;
	private String ssa;
	private int iva;
	private int ieps;
	private String categoria;
	private String pareto;
	private String precioPub;
	private String precioDesc;
	
	public ProductoFamilia(){
		
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

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
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

	public int isIva() {
		return iva;
	}

	public void setIva(int iva) {
		this.iva = iva;
	}

	public int isIeps() {
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

	public String getPrecioPub() {
		return precioPub;
	}

	public void setPrecioPub(String precioPub) {
		this.precioPub = precioPub;
	}

	public String getPrecioDesc() {
		return precioDesc;
	}

	public void setPrecioDesc(String precioDesc) {
		this.precioDesc = precioDesc;
	}

	@Override
	public String toString() {
		return "ProductoFamilia [codBar=" + codBar + ", existencias="
				+ existencias + ", descripcion=" + descripcion + ", nombre="
				+ nombre + ", laboratorio=" + laboratorio + ", cls=" + cls
				+ ", ssa=" + ssa + ", iva=" + iva + ", ieps=" + ieps
				+ ", categoria=" + categoria + ", pareto=" + pareto
				+ ", precioPub=" + precioPub + ", precioDesc=" + precioDesc + "]";
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductoFamilia other = (ProductoFamilia) obj;
		if (categoria == null) {
			if (other.categoria != null)
				return false;
		} else if (!categoria.equals(other.categoria))
			return false;
		if (cls == null) {
			if (other.cls != null)
				return false;
		} else if (!cls.equals(other.cls))
			return false;
		if (codBar == null) {
			if (other.codBar != null)
				return false;
		} else if (!codBar.equals(other.codBar))
			return false;
		if (descripcion == null) {
			if (other.descripcion != null)
				return false;
		} else if (!descripcion.equals(other.descripcion))
			return false;
		if (existencias != other.existencias)
			return false;
		if (ieps != other.ieps)
			return false;
		if (iva != other.iva)
			return false;
		if (laboratorio == null) {
			if (other.laboratorio != null)
				return false;
		} else if (!laboratorio.equals(other.laboratorio))
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		if (pareto == null) {
			if (other.pareto != null)
				return false;
		} else if (!pareto.equals(other.pareto))
			return false;
		if (precioDesc != other.precioDesc)
			return false;
		if (precioPub != other.precioPub)
			return false;
		if (ssa == null) {
			if (other.ssa != null)
				return false;
		} else if (!ssa.equals(other.ssa))
			return false;
		return true;
	}
	
	

}
