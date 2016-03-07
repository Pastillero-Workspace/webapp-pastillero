<!--  Formulario editar cliente  -->
<div id="formCliente" title="Editar Cliente" class="text-form">
	<form id="cliente">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Cliente</legend>
		<ol>
			<li><label for="clave">*Clave: </label><input type="text" id="txtClave" name="txtClave" size="5" requiered autofocus><label for="nombre">*Nombre: </label><input type="text" size="45" id="txtNombre" name="txtNombre" requiered> </li>
			<li><label for="email">*Email: </label><input type="text" size="30" id="txtEmail" name="txtEmail" value="SIN ASIGNAR" requiered><label for="tel">*Tel: </label><input type="text" size="20" id="txtTel" name="txtTel" value="00-00-00-00-00" requiered></li>
			<li><label for="rfc">*RFC: </label><input type="text" size="15" id="txtRfc" name="txtRfc" value="SIN ASIGNAR" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Credito</legend>
		<ol>
			<li><label for="credito">*Credito:</label><input type="text" id="txtCredito" name="txtCredito" size="5" value="0" requiered><label for="diasCredito">*Dias Cred:</label><input type="text" id="txtDiasCred" name="txtDiasCred" size="5" value="00" requiered>
			<label for="limiteCredito">*Limite Cred:</label><input type="text" id="txtLimiteCred" name="txtLimiteCred" size="5" value="0.00" requiered><label for="ventaAnual">*Venta anual:</label><input type="text" id="txtVentaAnual" name="txtVentaAnual" size="5" value="0.00" requiered></li>
			<li><label for="saldo">*Saldo:</label><input type="text" id="txtSaldo" name="txtSaldo" size="5" value="0.00" requiered>
			<!--label for="desc">*Descuento</label><select id="opcDesc" name="opcDesc" requiered><option value="0">Sin Descuento</option><option value="5.00">Cliente Frecuente</option><option value="2.00">INSEN 2%</option><option value="3.00">INSEN 3%</option></select-->
			
			<!--label for="descExtra">*Desc. Extra:</label><input type="text" id="txtDescExtra" name="txtDescExtra" size="5" value="0.00" requiered-->
			<label for="ventaMensual">*Venta Mensual:</label><input type="text" id="txtVentaMensual" name="txtVentaMensual" size="5" value="0.00" requiered></li>
			
			<li><label for="desc">*Descuento</label><select id="opcDesc" name="opcDesc" requiered><option value="0">Sin Descuento</option><option value="1">Cliente Frecuente</option><option value="2">INSEN 2%</option><option value="3">INSEN 3%</option><option value="4">INSEN 4%</option><option value="5">INSEN 5%</option></select>
			<label for="clienteFrec">*% ClienteFrec:</label><input type="text" id="txtClienteFrec" name="txtClienteFrec" size="5" value="0.0" disabled></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalle" name="txtCalle" value="SIN ASIGNAR" requiered><label for="noExt">*Num. Ext.: </label><input type="text" id="txtNoExt" name="txtNoExt" size="5" value="00" requiered><label for="noInt">*Num. Int.: </label><input type="text" id="txtNoInt" name="txtNoInt" size="5" value="00" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColonia" name="txtColonia" value="SIN ASIGNAR" requiered><label for="ciudad">*Ciudad: </label><input type="text" id="txtCiudad" name="txtCiudad" size="30" value="SIN ASIGNAR" requiered><li>
			<li><label for="estado">*Estado: </label><input type="text" id="txtEstado" name="txtEstado" size="30" value="SIN ASIGNAR" requiered><label for="cp">*C.P: </label><input type="text" id="txtCp" name="txtCp" size="7" value="00000" requiered></li>
		</ol>
	</fieldset>
	</form>
</div>
<!--  Formulario agregar cliente  -->
<div id="formClienteNuevo" title="Agregar Cliente" class="text-form">
	<form id="clienteNuevo">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Cliente</legend>
		<ol>
			<li><label for="clave">*Clave: </label><input type="text" id="txtClaveNuevo" name="txtClaveNuevo" size="5" requiered autofocus><label for="nombre">*Nombre: </label><input type="text" size="45" id="txtNombreNuevo" name="txtNombreNuevo" requiered> </li>
			<li><label for="email">*Email: </label><input type="text" size="30" id="txtEmailNuevo" name="txtEmailNuevo" value="SIN ASIGNAR" requiered><label for="tel">*Tel: </label><input type="text" size="20" id="txtTelNuevo" name="txtTelNuevo" value="00-00-00-00-00" requiered></li>
			<li><label for="rfc">*RFC: </label><input type="text" size="15" id="txtRfcNuevo" name="txtRfcNuevo" value="SIN ASIGNAR" requiered></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Credito</legend>
		<ol>
			<li><label for="credito">*Credito:</label><input type="text" id="txtCreditoNuevo" name="txtCreditoNuevo" size="5" value="0" requiered><label for="diasCredito">*Dias Cred:</label><input type="text" id="txtDiasCredNuevo" name="txtDiasCredNuevo" size="5" value="00" requiered>
			<label for="limiteCredito">*Limite Cred:</label><input type="text" id="txtLimiteCredNuevo" name="txtLimiteCredNuevo" size="5" value="0.00" requiered><label for="ventaAnual">*Venta anual:</label><input type="text" id="txtVentaAnualNuevo" name="txtVentaAnualNuevo" size="5" value="0.00" requiered></li>
			<li><label for="saldo">*Saldo:</label><input type="text" id="txtSaldoNuevo" name="txtSaldoNuevo" size="5" value="0.00" requiered>
			<!--label for="desc">*Descuento</label><select id="opcDescNuevo" name="opcDescNuevo" requiered><option value="0">Sin Descuento</option><option value="5.00">Cliente Frecuente</option><option value="2.00">INSEN 2%</option><option value="3.00">INSEN 3%</option><option value="4.00">INSEN 4%</option><option value="50.00">INSEN 5%</option></select-->
			
			<!--label for="descExtra">*Desc. Extra:</label><input type="text" id="txtDescExtraNuevo" name="txtDescExtraNuevo" size="5" value="0.00" disabled-->
			<label for="ventaMensual">*Venta Mensual:</label><input type="text" id="txtVentaMensualNuevo" name="txtVentaMensualNuevo" size="5" value="0.00" requiered></li>
			<li><label for="desc">*Descuento</label><select id="opcDescNuevo" name="opcDescNuevo" requiered><option value="0">Sin Descuento</option><option value="1">Cliente Frecuente</option><option value="2">INSEN 2%</option><option value="3">INSEN 3%</option><option value="4">INSEN 4%</option><option value="5">INSEN 5%</option></select>
			<label for="clienteFrec">*% ClienteFrec:</label><input type="text" id="txtClienteFrecNuevo" name="txtClienteFrecNuevo" size="5" value="0.0" disabled></li>
		</ol>
	</fieldset>
	<fieldset>
		<legend>Direccion</legend>
		<ol>
			<li><label for="calle">*Calle: </label><input type="text" id="txtCalleNuevo" name="txtCalleNuevo" value="SIN ASIGNAR" requiered><label for="noExt">*Num. Ext.: </label><input type="text" id="txtNoExtNuevo" name="txtNoExtNuevo" size="5" value="00" requiered><label for="noInt">*Num. Int.: </label><input type="text" id="txtNoIntNuevo" name="txtNoIntNuevo" size="5" value="00" requiered><li>
			<li><label for="colonia">*Colonia: </label><input type="text" id="txtColoniaNuevo" name="txtColoniaNuevo" value="SIN ASIGNAR" requiered><label for="ciudad">*Ciudad: </label><input type="text" id="txtCiudadNuevo" name="txtCiudadNuevo" size="23" value="SIN ASIGNAR" requiered><li>
			<li><label for="estado">*Estado: </label><input type="text" id="txtEstadoNuevo" name="txtEstadoNuevo" size="23" value="SIN ASIGNAR" requiered><label for="cp">*C.P: </label><input type="text" id="txtCpNuevo" name="txtCpNuevo" size="7" value="00000" requiered></li>
		</ol>
	</fieldset>
	</form>
</div>	