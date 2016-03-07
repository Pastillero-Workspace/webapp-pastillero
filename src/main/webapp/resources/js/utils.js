
$(document).ready(function() {
					/* Create a new table instance */
					var productData = "";
					var PrecioUnitario = 0;
					var DescuentoUnitario = 0;
					var DescuentoTotal = 0;
					var IvaUnitario = 0;
					var counter = 0;
					
					var t = $('#example').DataTable({
						dom : "lrtip",
						"bSort" : false,
						scrollY : 200,
						scrollCollapse : true,
						paging: false
					});
					
					
					/* Event to get ID when the page is loaded */
					$(window).load(function() {
						var datacontextload = localStorage.getItem("idcontrolventa");
						console.log("dataContext: "+datacontextload);
						//if (datacontextload != null && datacontextload == "0") {
						if (datacontextload == null || datacontextload == "0") {
							//Carga número de Folio de base de datos
							blockpage();
							$.post('cobroController.jr',{
								varUsuario : $('#txtUsuario').val(),
								context : 1,
								workout : 'getNota'
							},function(data) {
								console.log("data: "+data);
								if(data != 'Error'){
									if (data != 'Reload') {
										var datos = data.split("+");
										console.log(datos[0]);
										console.log(datos[1]);
										$('#txtFolio').val(datos[0]);
										$('#txtCaja').val("1");
										$('#txtCajero').val(datos[1]);
										$('#txtTotal').val("0.0");
										$('#txtDesT').val("0.0");
										$('#txtSubtotal').val("0.0");
										$('#txtIva').val("0.0");
										$('#txtPrecT').val("0.0");
										$('#openFormAltaCobro').prop("disabled",true);
											
										localStorage.setItem("idcontrolventa", "1");
														
										//Guarda datos temporales de nota a tabla temporal en base de datos
										$.post('temporales.jr',{
											tarea:'notaVentaTemp',
											txtFolio: $('#txtFolio').val(),
											txtCaja: $('#txtCaja').val(),
											txtCajero: $('#txtCajero').val(),
											txtUsuario: $('#txtUsuario').val(),
										});
									}
									$.unblockUI();
								}else{
									$.unblockUI();
									alert('No hay ningun Cajero con sesion iniciada.');
									window.close();
								}				
							}).fail(function(xhr,textStatus, errorThrown){
								$.unblockUI();
								alert("Error: "+errorThrown);
							});
											
						} else {
							//Si hay datos almacenados de manera temporal en la base de datos los obtiene y los carga.
							//Carga los datos de nota desde base de datos.
							blockpage();
							$.ajax({
								async:false,
							    cache:false,
							    dataType:"json",
							    type: 'POST',  
							    url: "temporales.jr",
							    data: {
							    	tarea: 'obtenerNotaVentaTemp',
							        txtUsuario: $('#txtUsuario').val()
							    }
							}).done(function(nota){
								if(nota=='vacio'){
									$.unblockUI();
									alert("No se encontraron datos para la nota");
								}else{
									$('#txtFolio').val(nota.folio);
									$('#txtCaja').val(nota.caja);
									$('#txtCajero').val(nota.cajero);
									$('#txtUsuario').val(nota.usuario);
									$('#txtCliente').val(nota.cliente);
									$('#txtDescripcion').val(nota.descripcion);
								}
							}).fail(function(xhr,textStatus, errorThrown){
								$.unblockUI();
							    alert("Error"+errorThrown);
							});						
							$('#txtCodigo').val("");
							$('#lblDscp').text("");
							$('#txtCantidad').val("0");
							$('#lblPrcp').text("0.0");
							$('#lblPrcd').text("0.0");
							$('#lblImpTotal').text("0.0");					
							//Carga los datos de productos almacenados temporalmente desde base de datos.
							$.ajax({
								async:false,
								cache:false,
								dataType:"json",
								type: 'POST',  
								url: "temporales.jr",
								data: {
									tarea: 'obtenerProductosVentaTemp',
									txtNota: $('#txtFolio').val()
								}
							}).done(function(productos){
								if(productos.valor !='vacio'){
									var i=0;
									$.each(productos, function(key, producto) { // Iterate over the JSON object.
										table.row.add([
										     producto.codigo,
										     producto.descripcion,
										     producto.cantidad,
										     parseFloat(producto.precioPub).toFixed(2),
										     parseFloat(producto.precioDesc).toFixed(2),
										     parseFloat(producto.subtotal).toFixed(2),
										     '<button type="button" class="myButton" id="Producto'+i+'">X</button>'            
										]);
										i++;
									});
									table.draw();
								}
							}).fail(function(xhr,textStatus, errorThrown){
								$.unblockUI();
								alert("Error: "+errorThrown);
							});
								
							//Carga los datos de totales desde base de datos.
							$.ajax({
								async:false,
								cache:false,
								dataType:"json",
								type: 'POST',  
								url: "temporales.jr",
								data: {
									tarea: 'obtenerTotalesVentaTemp',
									txtNota: $('#txtFolio').val()
								}
							}).done(function(totales){
								if(totales.valor != 'vacio'){
									$('#txtPrecT').val(parseFloat(totales.precioTotal).toFixed(2));
									$('#txtDesT').val(parseFloat(totales.descuentoTotal).toFixed(2));
									$('#txtIva').val(parseFloat(totales.iva).toFixed(2));
									$('#txtSubtotal').val(parseFloat(totales.subtotal).toFixed(2));
									$('#txtTotal').val(parseFloat(totales.total).toFixed(2));
								}
							}).fail(function(xhr,textStatus, errorThrown){
								$.unblockUI();
								alert("Error: "+errorThrown);
							});
							$.unblockUI();
						}
					});
					//$('#txtCantidad').on('keyup ',function(e) {
					$('#txtCantidad').keypress(function(e){
						if (e.which == 13) {
							// se verifica si no items en la lista o
							// si es asi se actualiza
							var cantidad = $.trim($("#txtCantidad").val());
							if(!cantidad.startsWith('0')){
								cantidad = parseInt(cantidad);
								if(cantidad < 1000){
									if(cantidad > 10){
										var confirmar = confirm("Esta seguro que quiere vender el numero de piezas ingresadas, \n" +
											"sino vuelva a ingresar la cantidad");
										if(confirmar){
											agregarProducto();
										}else{
											$('#txtCantidad').select();
										}
									}else{
										agregarProducto();
									}
								}else{//Si cantidad de productos es mayor a mil
									alert("No puede vender esa cantidad para un mismo producto");
									$('#txtCantidad').select();
								}
							}else{
								alert("Asegurese de que la cantidad ingresada es correcta!");
								$('#txtCantidad').select();
							}
						}	
					});
					/*
					 * Event for txtCodigo when active search product in servlet
					 * context return data [botonbuscar]
					 */
					$('#txtCodigo').keypress(function(event) {
							if (event.which == 13) {
								blockpage();
								$.get('cobroController.jr',{
									varCodigo : $('#txtCodigo').val()
								},function(data) {
									console.log("Item Load: "+ data);
									if (data.length > 0) {
										productData = data.split('~');
										//salvar la info necesaia para realizar los calculo de descuentos e iva
										//                     nombre: codigo , precioPublico   +   descFamilia     +       cls        +      iva     
										localStorage.setItem(""+productData[1],productData[11]+"~"+productData[15]+"~"+productData[5]+"~"+productData[7]);
										
										console.log(""+productData[1]+" | "+productData[11]+"~"+productData[15]+"~"+productData[5]+"~"+productData[7]);
										
										// Datos en el panel inferior
										$('#lblDescripcion').text(productData[3]);
										var iva = 1.16; // iva
										// fijo
										var PrecioPublico = (parseFloat(productData[11])).toFixed(2); // Se obtiene precio publico
										var PrecioDescuento = (PrecioPublico * parseFloat(productData[15] / 100)).toFixed(2);
										var descInsen = 0;
										var descClteFrec = 0;
																	
										if(productData[5] == 'F'){
											descInsen = PrecioPublico * (parseFloat(localStorage.getItem("descInsen"))/100);
											descClteFrec = PrecioPublico * (parseFloat(localStorage.getItem("descClteFrec"))/100);
										}
										var sumDesc = (PrecioDescuento*1) + (descInsen*1) + (descClteFrec*1); 							
										var PrecioDescuentoTotal = (PrecioPublico - sumDesc).toFixed(2);
										
										console.log("precio descuento :"+ ((PrecioDescuento*1) + (descInsen*1) + (descClteFrec*1)));
										console.log(PrecioDescuentoTotal);
										
										if (productData[7] == '2'){ // si el producto tiene iva : se cambio por 2
											var IVA = PrecioDescuentoTotal - (PrecioDescuentoTotal / iva);
											IVA = IVA.toFixed(2);
											IvaUnitario = IVA;
										} else {
											IvaUnitario = '0.00';
										}
										
										console.log("categoria: "+ productData[9]);// agrega los dem�s datos al datatable
										$('#txtIdProducto').val(productData[0]);
										$('#txtAntibiotico').val(productData[9]);
										
										console.log("Antibiotico: "+productData[9]);
										if (productData[9] == "1") {
											localStorage.setItem("isAntibiotico","C");
										}
										
										$('#lblDscp').html(productData[3]);
										$('#lblPrcp').html(PrecioPublico);
										$('#lblPrcd').html(PrecioDescuentoTotal);
										$('#lblImpTotal').html(PrecioDescuentoTotal);
										
										$('#txtCantidad').val("1");
										$('#txtCantidad').select();
										
										DescuentoTotal = PrecioDescuentoTotal;
										PrecioUnitario = PrecioPublico;
										DescuentoUnitario = sumDesc;// el descuento se hace por familia
										$.unblockUI();
									} else {
										$.unblockUI();
										alert("El producto buscado no existe");
										$('#txtIdProducto').val("");
										$('#lblDscp').html("");
										$('#lblPrcp').html("0.0");
										$('#lblPrcd').html("0.0");
										$('#lblImpTotal').html("0.0");
										$('#txtCodigo').val("");
										$('#txtCodigo').focus();
									}
								});
							}
						});
					/* Event for txtCliente for select schema client */
					$("#txtCliente").keypress(function(event) {
						var inputCliente = $.trim($("#txtCliente").val());
						if (event.which == 13 && inputCliente.length > 0) {
							// alert("Some action");
							$.post('cobroController.jr',{
								varCCliente : $('#txtCliente').val(),
								workout : 'getCliente'
							},function(data) {
								if (data != 'NFC') { // client found match
									var infoClte = data.split(',');
									if(infoClte != null){
										//$('#txtDescripcion').val(data);
										$('#txtDescripcion').val(infoClte[0]);
										$('#txtCodigo').prop('disabled',false);
										$('#txtCantidad').prop('disabled',false);
										$('#txtCodigo').focus();
																		
										localStorage.setItem("descClteFrec", infoClte[1]);
										localStorage.setItem("descInsen", infoClte[2]);
								
										//Se actualizan datos de nota temporal
										$.post('temporales.jr',{
											tarea: 'actNotaVentaTemp',
											txtFolio: $('#txtFolio').val(),
											txtCliente: $('#txtCliente').val(),
											txtDescripcion: $('#txtDescripcion').val()
										},function(){
												
										});
									}
								} else {
									alert("Cliente no encontrado: Verifique datos");
									$('#txtDescripcion').val("");
									$('#txtCliente').select();
									$('#txtCliente').focus();
								}
							 });
							}
						});
					
					/* Remove item from table *//**
						* optimizar codigo posteriormente */
					var table = $('#example').DataTable();
					$('#example tbody').on('click','button',function() {
						if ($(this).hasClass('selected')) {
							$(this).removeClass('selected');
						} else {
							table.$('tr.selected').removeClass('selected');
							$(this).addClass('selected');
							
							var index = table.row($(this).parents('tr')).index();
							var description = table.cell(index,1).data();
							var codigo = table.cell(index,0).data();
							var cantidadProd = table.cell(index,2).data();
							var iddelete = $(this).attr('id').trim();
							console.log("idDelete: "+iddelete);
							alert("Desea eliminar el item seleccionado: "+ description);

							if (codigo != null && codigo != 0) {
								var infoProductDesc = localStorage.getItem(""+codigo).split("~");
								var iva = 0;
								var preciopublico = 0;
								var preciodescuento = 0;
								var pdt = 0;
								var subtotal = 0;
								var total = 0;
								var cantidad = 0;
								
								preciopublico = parseFloat(infoProductDesc[0]);
								preciodescuento = (preciopublico * parseFloat(infoProductDesc[1] / 100)).toFixed(2);
								cantidad = parseInt(cantidadProd);
								
								var descInsen = 0;
								var descClteFrec = 0;
								
								if(infoProductDesc[2] == 'F'){
									descInsen = preciopublico * (parseFloat(localStorage.getItem("descInsen"))/100);
									descClteFrec = preciopublico * (parseFloat(localStorage.getItem("descClteFrec"))/100);
								}
								console.log("precio publico: "+preciopublico+" - descinsen: "+descInsen+" - desccltefrec: "+descClteFrec);
								var sumDesc = (preciodescuento*1) + (descInsen*1) + (descClteFrec*1); 							
								pdt = (preciopublico - sumDesc).toFixed(2);
								console.log("sumDec: "+sumDesc+" - precioDescT: "+pdt);										
										
								if (infoProductDesc[3] == '2'){ // si el producto tiene iva
									iva = pdt - (pdt / 1.16);
									iva = iva.toFixed(2);
								}
									
								subtotal = (pdt - iva).toFixed(2);
								total = (parseFloat(subtotal) + parseFloat(iva)).toFixed(2);
								
								var inputprecio = parseFloat($('#txtPrecT').val());
								inputprecio = inputprecio - (preciopublico * cantidad);
								
								var inputpreciodes = parseFloat($('#txtDesT').val());
								inputpreciodes = inputpreciodes - (sumDesc * cantidad);
								
								var inputiva = parseFloat($('#txtIva').val());
								inputiva = inputiva	- (iva * cantidad);
								
								var inputsub = parseFloat($('#txtSubtotal').val());
								inputsub = inputsub	- (subtotal * cantidad);
										
								var inputtot = parseFloat($('#txtTotal').val());
								inputtot = inputtot	- (total * cantidad);
								
								//Borra producto temporal en base de datos.
								$.ajax({
				                      async:false,
				                      cache:false,
				                      type: 'POST',  
				                      url: "temporales.jr",
				                      data: {
				                    	tarea: 'borrarProductoVentaTemp',
										txtNota: $('#txtFolio').val(),
										txtCodigo: codigo,
										txtCantidad: cantidadProd
				                     }
								}).done(function(){//Si elimina producto correctamente, prosigue con el flujo.
									//Elimina producto de grid.
									table.row(index).remove().draw(true);
									//Actualiza totales temporales en base de datos										
									$.post('temporales.jr',{
										tarea: 'totalesVentaTemp',
										txtNota: $('#txtFolio').val(),
										txtPrecioTotal: inputprecio.toFixed(2),
										txtDescuentoTotal: inputpreciodes.toFixed(2),
										txtIva: inputiva.toFixed(2),
										txtSubtotal: inputsub.toFixed(2),
										txtTotal: inputtot.toFixed(2)
									}).done(function(){//Si se actualizan totales correctamente en base de datos, coloca cantidades en vista.
										$('#txtPrecT').val(inputprecio.toFixed(2));
										$('#txtDesT').val(inputpreciodes.toFixed(2));
										$('#txtIva').val(inputiva.toFixed(2));
										$('#txtSubtotal').val(inputsub.toFixed(2));
										$('#txtTotal').val(inputtot.toFixed(2));
									}).fail(function(xhr,textStatus, errorThrown){
								  	  	alert("Error al actualizar totalesTemporales: "+errorThrown+" ,"+xhr+" ,"+textStatus);
								    });
								}).fail(function(xhr,textStatus, errorThrown){
							  	  	alert("Error al borra producto de nota: "+errorThrown+" ,"+xhr+" ,"+textStatus);
							    });
								
								// Revisa el contenido de la tabla, si no contiene filas desactiva el boton de cobrar.
								if (table.column(0).data().length == 0 || table.column(0).data().length == undefined || table.column(0).data().length == null) {
									$('#openFormAltaCobro').prop('disabled',true);
								}
							}
						}
					});
				
					function agregarProducto(){
						var cantidad = $.trim($("#txtCantidad").val());
						var codigo = $("#txtCodigo").val();
						var descp = $("#lblDscp").text();
						var TotalPublico = 0;
						var TotalDescuento = 0;
						var TotalIVA = 0;
						var ImporteTotal = 0;
						if (codigo.length > 0 && descp.length > 0) {
							if (cantidad > 0) {
								// calculo del subtotal y del total
								TotalPublico = PrecioUnitario * cantidad;
								TotalDescuento = DescuentoUnitario * cantidad;
								TotalIVA = IvaUnitario * cantidad;
								ImporteTotal = ((DescuentoTotal * cantidad)).toFixed(2);
								$('#lblImpTotal').text(ImporteTotal);
							} else {
								$('#lblImpTotal').text("0.0");
							}
							
							var codigo1 = "";
							var tamano = $("#txtCodigo").val().trim().length;
							if (tamano < 16) {
								var falta = 16 - tamano;
								for (var i = 0; i < falta; i++) {
									codigo1 = "0".concat(codigo1);
								}
							}
							console.log("Codigo:" + codigo1.concat($("#txtCodigo").val().trim()));
							t.row.add([
							   codigo1.concat($("#txtCodigo").val().trim()),
							   $('#lblDscp').text(),
							   $('#txtCantidad').val(),
							   $('#lblPrcp').text(),
							   $('#lblPrcd').text(),
							   $('#lblImpTotal').text(),
							   '<button type="button" id="Producto'+counter+ '" class="myButton" >X</button>'
							]).draw();
							
														
							//Guarda en base de datos productos agregados de manera temporal
							$.post('temporales.jr',{
								tarea: 'productoVentaTemp',
								txtFolio: $('#txtFolio').val(),
								txtCodigo: codigo1.concat($("#txtCodigo").val().trim()),
								txtDescripcion: $('#lblDscp').text(),
								txtCantidad: $('#txtCantidad').val(),
								txtPrecioPub: $('#lblPrcp').text(),
								txtPrecioDesc: $('#lblPrcd').text(),
								txtSubtotal: $('#lblImpTotal').text(),
							}).fail(function(xhr,textStatus, errorThrown){
								alert("Error al guardar ProductoTemporal: "+errorThrown+" ,"+xhr+" ,"+textStatus);
							});;
								
							counter++;
								
							// proceso de operaciones matematicas para el calculo total de los items
							var inputTotal = parseFloat($('#txtTotal').val());
							var inputSubTotal = parseFloat($('#txtSubtotal').val());
							var inputTotalPublico = parseFloat($('#txtPrecT').val());
							var inputIva = parseFloat($('#txtIva').val());
							var inputDescuento = parseFloat($('#txtDesT').val());
							/*
							 * en esta seccion se realizaria el calculo de insen la implemntacion es por producto
							 * var DescuentoInsen = GranSubtotal + (GRanSubtotal - (descuento insen))
							 * precioPublico - porcentajinsen
							 * 
							 */
							var GranSubTotal = inputSubTotal - TotalIVA + (TotalPublico - TotalDescuento);
							var GranTotal = inputTotal + (TotalPublico - TotalDescuento);
							$('#txtPrecT').val((TotalPublico + inputTotalPublico).toFixed(2));
							$('#txtDesT').val((TotalDescuento + inputDescuento).toFixed(2));
							$('#txtIva').val((TotalIVA + inputIva).toFixed(2));
							$('#txtSubtotal').val(GranSubTotal.toFixed(2));
							$('#txtTotal').val(GranTotal.toFixed(2));
								
												
							//Totales que se guardan de manera temporal en la base de datos
							$.post('temporales.jr',{
								tarea: 'totalesVentaTemp',
								txtNota: $('#txtFolio').val(),
								txtPrecioTotal: $('#txtPrecT').val(),
								txtDescuentoTotal: $('#txtDesT').val(),
								txtIva: $('#txtIva').val(),
								txtSubtotal: $('#txtSubtotal').val(),
								txtTotal: $('#txtTotal').val()
							}).fail(function(xhr,textStatus, errorThrown){
							  	alert("Error al actualizar totalesTemporales: "+errorThrown+" ,"+xhr+" ,"+textStatus);
							});						
							// limpiar campos y botones y poner el foco en txt codigo
							$('#txtCodigo').val("");
							$('#lblDscp').text("");
							$('#lblPrcp').text("0.0");
							$('#lblPrcd').text("0.0");
							$('#lblImpTotal').text("0");
							$('#txtCantidad').val("0");
							$('#txtCodigo').focus();
							// Habilitar botones al agregar items
							$('#openFormAltaCobro').prop('disabled', false);
						}
					}					

	$(document).on("keydown", disableF5);
	$(document).keydown(
			function(e) {
				if (e.which == 120
						&& !$('#openFormAltaCobro').is(
								':disabled')) {
					process_antibiotico();
					process_sale();
				}
			});
	/**Habilita el cuadro de formulario de alta de antibiotico**/
	$("#openFormAltaCobro").click(function(event) {
		if (!$('#openFormAltaCobro').is(':disabled')) // Se presionó F9
		{
			process_antibiotico();
			process_sale();
		}
	});
	
	$("#CR13").click(function(){
		window.open("listadevolventas.jsp", "_blank");
	});	
	// keypress for calculate pago total
	$("#txtTotalPago").keypress(function(event) {
		var inputPago = parseFloat($("#txtTotalPago").val()).toFixed(2);
		if (event.which == 13 && inputPago != 0) {
			$("#txtTotalPago").val(inputPago);
			var inputCobro = parseFloat($("#txtTotalCobro").val()).toFixed(2);
			//if (inputPago >= inputCobro) {
			if (parseFloat($("#txtTotalPago").val()) >= parseFloat($("#txtTotalCobro").val())) {
				var Cambio = inputPago - inputCobro;
				console.log("Panel Cobro : diferencia = " + Cambio);
				Cambio = Cambio.toFixed(2);
				$("#txtCambio").val(Cambio);
				$('#btnF10').focus();
			}else
				alert("La cantidad ingresada debe ser mayor al total a cobrar");
		}
	});
	
	window.addEventListener("beforeunload", function (e) {
		var confirmationMessage = "Antes de cerrar el navegador, verifique y cierre su sesión del sistema";

		  (e || window.event).returnValue = confirmationMessage;     
		  	return confirmationMessage;                            
	});

});

/** FUNCIONES ASOCIADAS A COBRO **/
/**Habilita la funcion del boton F5 **/					
function disableF5(e) { if ((e.which || e.keyCode) == 116) e.preventDefault(); };

function process_sale() {
	$("#formAltaCobro").dialog('open');
	var Total = parseFloat($('#txtTotal').val()).toFixed(2);
	$('#txtTotalCobro').val(Total);
	$('#txtTotalPago').val("0.00");
	$('#txtTotalPago').select();
	$('#txtCambio').val("0.00");
}

function process_antibiotico() {
	if (localStorage.getItem("isAntibiotico") == 'C') {
		localStorage.setItem("isAntibiotico", "X");
		$.post('medico.jr', {
			tarea : 'mostrar'
		}, function(data) {
			var medicos = data.split(',');
			$("#selMedico").empty();
			//var $select = $('#selMedico');
			//$select.append(data);
			$( "#selMedico" ).autocomplete({
				source: medicos
	        	});
			$("#formAltaAntibiotico").dialog('open');
		});
	}
}