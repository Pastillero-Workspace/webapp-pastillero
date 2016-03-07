package mx.com.pastillero.model.formBeans;

public class UserRol {
	
	private int idUserRol;
	private int idUsuario;
	private int id_rol;
	private int estatus;
	
	
	public int getIdUserRol() {
		return idUserRol;
	}
	public void setIdUserRol(int idUserRol) {
		this.idUserRol = idUserRol;
	}
	public int getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
	public int getId_rol() {
		return id_rol;
	}
	public void setId_rol(int id_rol) {
		this.id_rol = id_rol;
	}
	public int getEstatus() {
		return estatus;
	}
	public void setEstatus(int estatus) {
		this.estatus = estatus;
	}
	
	
	@Override
	public String toString() {
		return "UserRol [idUserRol=" + idUserRol + ", idUsuario=" + idUsuario
				+ ", id_rol=" + id_rol + ", estatus=" + estatus + "]";
	}
	
	
	


	
	

}
