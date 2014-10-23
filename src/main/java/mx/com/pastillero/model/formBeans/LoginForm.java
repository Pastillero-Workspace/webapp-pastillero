package mx.com.pastillero.model.formBeans;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Loginform")
public class LoginForm{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String userName;
	private String userPassword;
	private String fechaIni;
	private String horaIni;


	public LoginForm()
	{
		
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getUserPassword() {
		return userPassword;
	}


	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}


	public String getFechaIni() {
		return fechaIni;
	}


	public void setFechaIni(String fechaIni) {
		this.fechaIni = fechaIni;
	}


	public String getHoraIni() {
		return horaIni;
	}


	public void setHoraIni(String horaIni) {
		this.horaIni = horaIni;
	}


	

	

	
}