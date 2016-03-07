<div id="formAntibiotico" title="Editar Antibiotico" class="text-form">
	<form id="antibiotico">
	<legend>* Campos Obligatorios</legend>
	<fieldset>
		<legend>Antibiotico</legend>
		<ol>
			<label id="idAnt" hidden="true">x</label>
			<li><label for="antibiotico">*Antibiotico: </label><input type="text" size="45" id="txtAntibiotico" name="txtAntibiotico" disabled></li>
			<li><label for="proveedor">*Proveedor: </label><input type="text" size="45" id="txtProveedor" name="txtProveedor" disabled></li>
			<li><label for="medico">*Medico: </label><input type="text" size="45" id="txtMedico" name="txtMedico" requiered autofocus></li>
			<li><label for="nota">*Num. de Nota: </label><input type="text" size="15" id="txtNota" name="txtNota" requiered><label for="fecha">*Fecha: </label><input type="text" size="15" id="txtFecha" name="txtFecha" disabled></li>
			<li><!--label for="receta">*Receta: </label><input type="text" size="15" id="txtReceta" name="txtReceta" requiered-->
			<label for="receta">*Receta: </label><select name="opcReceta" id="opcReceta">
													<option value='0'>NO</option>
													<option value='1'>SI</option>
												</select>
			<label for="sello">*Sello: </label><select name="opcSello" id="opcSello">
							<option value="0">0</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>
							<option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option>
					</select></li>
			<li><label for="adquiridos">*Adquiridos: </label><input type="text" size="15" id="txtAdquiridos" name="txtAdquiridos" requiered><label for="vendidos">*Vendidos: </label><input type="text" size="15" id="txtVendidos" name="txtVendidos" requiered></li>
			<li><label for="habian">*Habian: </label><input type="text" size="15" id="txtHabian" name="txtHabian" requiered><label for="quedan">*Quedan: </label><input type="text" size="15" id="txtQuedan" name="txtQuedan" requiered></li>
		</ol>
	</fieldset>
	</form>
</div>
