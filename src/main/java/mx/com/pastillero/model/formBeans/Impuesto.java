package mx.com.pastillero.model.formBeans;

public class Impuesto 
{
	private int iva;
	private int ieps1;
	private int ieps2;
	
	/* Getters and Setters */
	
	public int getIva() {
		return iva;
	}
	public void setIva(int iva) {
		this.iva = iva;
	}
	public int getIeps1() {
		return ieps1;
	}
	public void setIeps1(int ieps1) {
		this.ieps1 = ieps1;
	}
	public int getIeps2() {
		return ieps2;
	}
	public void setIeps2(int ieps2) {
		this.ieps2 = ieps2;
	}
	
	@Override
	public String toString() {
		return "Impuestos [iva=" + iva + ", ieps1=" + ieps1 + ", ieps2="
				+ ieps2 + "]";
	}
	
	
	
}
