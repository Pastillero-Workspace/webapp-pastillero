
<div id="formUsuario" title="Actualizar Usuario" class="text-form">
	<form id="clienteActualizar">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Usuario</legend>
		<ol>
			<li><label for="usuario">*Usuario: </label><input type="text" id="txtUsuario" name="usuario" size="20" requiered ><label for="nombre">*Contraseña: </label><input type="text" size="15" id="txtContrasena" name="contraseña" requiered> </li>
			<li><label for="perfil">*Perfil: </label><input type="text" size="20" id="txtPerfil" name="Perfil" requiered><label for="tel">*Usuario Activo:</label><input type="checkbox" id="chkActivo"name="Activo" value="0"requiered>
	        <label for="sucursal">*Sucursal: </label><input type="text" size="15" id="txtSucursal" name="sucursal" value="SIN ASIGNAR" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Datos Personales</legend>
		<ol>
			<li><label for="persona">Nombre:</label><input type="text" id="txtNombre" name="Nombre" size="25" requiered><label for="Apellido Paterno">*Apellido Paterno:</label><input type="text" id="txtApePat" name="Apellido Paterno" size="25" requiered></li>
			<li><label for="apellidopat">*Apellido Materno:</label><input type="text" id="txtApeMat" name="apellidopat" size="25" requiered><label for="fechaingreso">*Fecha Ingreso:</label><input type="text" id="txtFechaIngreso" name="fechaingreso" size="25" value="00-00-0000" requiered></li>
			<li><label for="rfc">*RFC:</label><input type="text" id="txtRFC" name="rfc" size="25" value="SIN ASIGNAR" requiered><label for="curp">*CURP:</label><input type="text" id="txtCURP" name="curp" size="25" value="SIN ASIGNAR" requiered></li>
			<li><label for="turno">*Turno:</label><input type="text" id="txtTurno" name="turno" size="25" value="SIN ASIGNAR" requiered><label for="email">*Email:</label><input type="text" id="txtEmail" name="email" size="25" value="SIN ASIGNAR" requiered></li>
			<li><label for="telfijo">*Telefono Fijo:</label><input type="text" id="txtTelFijo" name="telfijo" size="15" value="(000)-000-00-00" requiered><label for="telmovil">*Telefono Móvil:</label><input type="text" id="txtTelMovil" name="telmovil" size="15" value="00-00-00-00-00"></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalle" name="txtCalle" value="SIN ASIGNAR" requiered><label for="noExt">*Num.Ext.: </label><input type="text" id="txtNoExt" name="txtNoExt" size="5" value="00" requiered><label for="noInt">*Num.Int.: </label><input type="text" id="txtNoInt" name="txtNoInt" size="5" value="00" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColonia" name="txtColonia" value="SIN ASIGNAR" requiered><label for="ciudad">*Ciudad: </label><input type="text" id="txtCiudad" name="txtCiudad" size="15" value="SIN ASIGNAR" requiered><li>
			<li><label for="estado">*Estado: </label><input type="text" id="txtEstado" name="txtEstado" size="15" value="SIN ASIGNAR" requiered><label for="cp">*C.P: </label><input type="text" id="txtCp" name="txtCp" size="5" value="00000" requiered></li>
		</ol>
	</fieldset>
	</form>
</div>
<div id="formUsuarioNuevo" title="Agregar Usuario" class="text-form">
	<form id="UsuarioNuevo">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Usuario</legend>
		<ol>
			<li><label for="usuario">*Usuario: </label><input type="text" id="txtUsuarioNuevo" name="usuario" size="20" requiered autofocus><label for="contrasena">*Contraseña: </label><input type="text" size="15" id="txtContrasenaNuevo" name="contrasena" requiered> </li>
			<li><label for="perfil">*Perfil: </label><input type="text" size="20" id="txtPerfilNuevo" name="Perfil" requiered><label for="tel">*Usuario Activo:</label><input type="checkbox" id="chkActivoNuevo" name="Activo" value="0" requiered>
			<label for="sucursal">*Sucursal: </label><input type="text" size="15" id="txtSucursalNuevo" name="sucursal" value="SIN ASIGNAR" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Datos Personales</legend>
		<ol>
			<li><label for="nombre">Nombre:</label><input type="text" id="txtNombreNuevo" name="Nombre" size="25" requiered><label for="apellidoPat">*Apellido Paterno:</label><input type="text" id="txtApePatNuevo" name="Apellido Paterno" size="25" requiered></li>
			<li><label for="apellidoMat">*Apellido Materno:</label><input type="text" id="txtApeMatNuevo" name="apellidoMat" size="25" requiered><label for="fechaingreso">*Fecha Ingreso:</label><input type="text" id="txtFechaIngresoNuevo" name="fechaingreso" size="25" value="00-00-0000" requiered></li>
			<li><label for="rfc">*RFC:</label><input type="text" id="txtRFCNuevo" name="rfc" size="25" value="SIN ASIGNAR" requiered><label for="curp">*CURP:</label><input type="text" id="txtCURPNuevo" name="curp" size="25" value="SIN ASIGNAR" requiered></li>
			<li><label for="turno">*Turno:</label><input type="text" id="txtTurnoNuevo" name="turno" size="25" value="SIN ASIGNAR" requiered><label for="email">*Email:</label><input type="text" id="txtEmailNuevo" name="email" size="25" value="SIN ASIGNAR" requiered></li>
			<li><label for="telfijo">*Telefono Fijo:</label><input type="text" id="txtTelFijoNuevo" name="telfijo" size="15" value="(000)-000-00-00" requiered><label for="telmovil">*Telefono Móvil:</label><input type="text" id="txtTelMovilNuevo" name="telmovil" size="15" value="00-00-00-00-00" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalleNuevo" name="txtCalleNuevo" value="SIN ASIGNAR" requiered><label for="noExt">*Num.Ext.: </label><input type="text" id="txtNoExtNuevo" name="txtNoExtNuevo" size="5" value="00" requiered><label for="noInt">*Num.Int.: </label><input type="text" id="txtNoIntNuevo" name="txtNoIntNuevo" size="5" value="00" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColoniaNuevo" name="txtColoniaNuevo" value="SIN ASIGNAR" requiered><label for="ciudad">*Ciudad: </label><input type="text" id="txtCiudadNuevo" name="txtCiudadNuevo" size="15" value="SIN ASIGNAR" requiered><li>
			<li><label for="estado">*Estado: </label><input type="text" id="txtEstadoNuevo" name="txtEstadoNuevo" size="15" value="SIN ASIGNAR" requiered><label for="cp">*C.P: </label><input type="text" id="txtCpNuevo" name="txtCpNuevo" size="5" value="00000" requiered></li>
		</ol>
	</fieldset>
	</form>
</div>
<div>