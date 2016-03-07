package mx.com.pastillero.model.formBeans;

public class Roles {
	
	private int id_rol;
	private String descripcion;
	private String clave;
	private String ruta;
	
	public int getId_rol() {
		return id_rol;
	}
	public void setId_rol(int id_rol) {
		this.id_rol = id_rol;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	public String getRuta() {
		return ruta;
	}
	public void setRuta(String ruta) {
		this.ruta = ruta;
	}
	@Override
	public String toString() {
		return "[id_rol=" + id_rol + ", descripcion=" + descripcion + ", clave=" + clave + ", ruta=" + ruta + "]";
	}
	

}
