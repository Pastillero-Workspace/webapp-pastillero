<!--  COMPONENTES PARA LOS FORMULARIOS  -->
<!--  1 .- Formulario para el deposito en caja al iniciar sesion como cajero -->
<div id="dialog" title="Caja">
			<p>Coloque la cantidad a depositar para fondo de caja.</p>
			<input type="text" id="cantidad" value="0.00" size="10">
</div>
<!--Contenido de la ventana de dialogo "confirmation-1", mmuestra un mensaje de error en caso de que la cantidad de fondo de caja sea mayor o igual a mil pesos-->
<div id="confirmation-1" class="text-message" title="Error">
	 	 Entrada invalida, favor de ingresar una cantidad menor, esta cantidad no esta autorizada por el gerente.
</div>
<!--Contendio de cuadro de dialogo "confirmation-2", muestra un mensaje de bienvenida en caso de que la cantidad ingresada como fondo de caja sea valida-->
<div id="confirmation-2" class="text-message" title="Bienvenido"> Bienvenido al sistema, ha iniciado correctamente! 
</div>
<!-- ...... -->