
<!--Fomulario para dar de alta un medico, este formulario se mostrara en un Dialog de JQuery, se activara al hacer click en el menu "Alta medico" dentro de la pagina principal-->
	<!--Insersion de la imagen de marca de agua en la parte del centro del sistema-->
	<!--Fomulario para dar de alta a un cliente, este formulario se mostrara en un Dialog de JQuery, se activara al hacer click en el menu "Alta cliente" dentro de la pagina principal-->
<div id="formProveedor" title="Editar Proveedor" class="text-form">
	<form id="proveedor">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Proveedor</legend>
		<ol>
			<li><label for="nombre">*Nombre: </label><input type="text" size="56" id="txtNombre" name="txtNombre" requiered autofocus >  </li>
			<li><label for="razon">*Razon Social: </label><input type="text" size="56" id="txtRazonSocial" name="txtRazonSocial" value="SIN ASIGNAR" requiered >  </li>
			<li><label for="email">*Email: </label><input type="text" size="25" id="txtEmail" name="txtEmail" value="SIN ASIGNAR" requiered><label for="fax">*Fax: </label><input type="text" size="18" id="txtFax" name="txtFax" value="000 00 00 00" requiered></li>
			<li><label for="rfc">*RFC: </label><input type="text" size="25" id="txtRfc" name="txtRfc" value="SIN ASIGNAR" requiered><label for="diasCredito">* Dias Credito: </label><input type="text" size="10" id="txtDiasCredito" name="txtDiasCredito" value="0" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalle" name="txtCalle" value="SIN ASIGNAR" requiered><label for="noExt">*Num. Ext.: </label><input type="text" id="txtNoExt" name="txtNoExt" size="5" value="0" requiered><label for="noInt">*Num. Int.: </label><input type="text" id="txtNoInt" name="txtNoInt" size="5" value="0" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColonia" name="txtColonia" value="SIN ASIGNAR" requiered><label for="colonia">*Ciudad: </label><input type="text" id="txtCiudad" name="txtCiudad" value="SIN ASIGNAR" requiered><li>
			<li><label for="estado">*Estado: </label><input type="text" id="txtEstado" name="txtEstado" size="23" value="SIN ASIGNAR" requiered><label for="cp">*C.P: </label><input type="text" id="txtCp" name="txtCp" size="7" value="00000" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Descuentos</legend>
		<ol>
			<li><label for="descGeneral">*Descuento General: </label><input type="text" size="5" id="txtDescGeneral" name="txtDescGeneral" value="0" requiered></li>
			<li><label for="desc2">*Descuento 2: </label><input type="text" size="5" id="txtDesc2" name="txtDesc2" value="0" requiered></li>
			<li><label for="desc3">*Descuento 3</label><input type="text" size="5" id="txtDesc3" name="txtDesc3" value="0" requiered></li>
		</ol>
	</fieldset>
	</form>
</div>

<div id="formProveedorNuevo" title="Nuevo Proveedor" class="text-form">
	<form id="proveedorNuevo">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Proveedor</legend>
		<ol>
			<li><label for="nombre">*Nombre: </label><input type="text" size="56" id="txtNombreNuevo" name="txtNombreNuevo" requiered autofocus >  </li>
			<li><label for="razon">*Razon Social: </label><input type="text" size="56" id="txtRazonSocialNuevo" name="txtRazonSocialNuevo" value="SIN ASIGNAR" requiered >  </li>
			<li><label for="email">*Email: </label><input type="text" size="25" id="txtEmailNuevo" name="txtEmailNuevo" value="SIN ASIGNAR" requiered><label for="fax">*Fax: </label><input type="text" size="18" id="txtFaxNuevo" name="txtFaxNuevo" value="000 00 00 00" requiered></li>
			<li><label for="rfc">*RFC: </label><input type="text" size="25" id="txtRfcNuevo" name="txtRfcNuevo" value="SIN ASIGNAR" requiered><label for="diasCredito">* Dias Credito: </label><input type="text" size="10" id="txtDiasCreditoNuevo" name="txtDiasCreditoNuevo" value="0" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalleNuevo" name="txtCalleNuevo" value="SIN ASIGNAR" requiered><label for="noExt">*Num. Ext.: </label><input type="text" id="txtNoExtNuevo" name="txtNoExtNuevo" size="5" value="0" requiered><label for="noInt">*Num. Int.: </label><input type="text" id="txtNoIntNuevo" name="txtNoIntNuevo" size="5" value="0" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColoniaNuevo" name="txtColoniaNuevo" value="SIN ASIGNAR" requiered><label for="colonia">*Ciudad: </label><input type="text" id="txtCiudadNuevo" name="txtCiudadNuevo" value="SIN ASIGNAR" requiered><li>
			<li><label for="estado">*Estado: </label><input type="text" id="txtEstadoNuevo" name="txtEstadoNuevo" size="23" value="SIN ASIGNAR" requiered><label for="cp">*C.P: </label><input type="text" id="txtCpNuevo" name="txtCpNuevo" size="7" value="00000" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Descuentos</legend>
		<ol>
			<li><label for="descGeneral">*Descuento General: </label><input type="text" size="5" id="txtDescGeneralNuevo" name="txtDescGeneralNuevo" value="0" requiered></li>
			<li><label for="desc2">*Descuento 2: </label><input type="text" size="5" id="txtDesc2Nuevo" name="txtDesc2Nuevo" value="0" requiered></li>
			<li><label for="desc3">*Descuento 3</label><input type="text" size="5" id="txtDesc3Nuevo" name="txtDesc3Nuevo" value="0" requiered></li>
		</ol>
	</fieldset>
	</form>
</div>