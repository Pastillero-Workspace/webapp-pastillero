
$(document).ready(function() {
					/* Create a new table instance */
					var productData = "";
					var PrecioUnitario = 0;
					var DescuentoUnitario = 0;
					var DescuentoTotal = 0;
					var IvaUnitario = 0;
					var counter = 0;
					var productos = [];
					var productos2 = [];
					var t = $('#example').DataTable({
						dom : "rtiS",
						"bSort" : false,
						scrollY : 200,
						scrollCollapse : true
					});
					/* Event to get ID when the page is loaded */
					$(window).load(function() {
										
										var datacontextload = localStorage.getItem("idcontrolventa");
										console.log("dataContext: "+datacontextload);
										//if (datacontextload != null && datacontextload == "0") {
										if (datacontextload == null || datacontextload == "0") {
											$.post('cobroController.jr',{
												varUsuario : $('#txtUsuario').val(),
												context : 1,
												workout : 'getNota'
											},function(data) {
												console.log("data: "+data);
												if (data != 'Reload') {
													$('#txtFolio').val(data);
													$('#txtCaja').val("1");
													$('#txtTotal').val("0.0");
													$('#txtDesT').val("0.0");
													$('#txtSubtotal').val("0.0");
													$('#txtIva').val("0.0");
													$('#txtPrecT').val("0.0");
													$('#openFormAltaCobro').prop("disabled",true);
													
													var myObject = new Object();
													myObject.idnt = $('#txtFolio').val();
													myObject.caja = $('#txtCaja').val();
													myObject.usuario = $('#txtUsuario').val();
													
													localStorage.setItem("nota",JSON.stringify(myObject));
												}
											}).fail(function(xhr,textStatus, errorThrown){
												alert("Error: "+errorThrown);
											});
											localStorage.setItem("idcontrolventa", "1");
										} else {
											// loading data if page is reload
											// (read data from localstorage)
											/*
											 * If data exist in local storage,
											 * if not not load in cobro
											 */
											var arraynt = JSON.parse(localStorage.getItem("nota"));
											console.log("arraynt: "+arraynt);
											if (arraynt != null) {
												$('#txtFolio').val(arraynt.idnt);
												$('#txtCaja').val(arraynt.caja);
												$('#txtUsuario').val(arraynt.usuario);
												$('#txtCliente').val(arraynt.cliente);
												$('#txtDescripcion').val(arraynt.dcliente);
											}
											$('#txtCodigo').val("");
											$('#lblDscp').text("");
											$('#txtCantidad').val("0");
											$('#lblPrcp').text("0.0");
											$('#lblPrcd').text("0.0");
											$('#lblImpTotal').text("0.0");
											//console.log("item "+localStorage.getItem("item"));
											productos2 = JSON.parse(localStorage.getItem("productosVenta"));
											//for (var i = 0; i <= localStorage.getItem("item"); i++) {
											if(productos2 != null){
												for(var i = 0; i < productos2.length; i++){
													/*var arrayp = JSON.parse(localStorage.getItem("Producto"+i+""));
													console.log("Productos arrayp: "+arrayp.descripcion);
													if (arrayp != null) {
														t.row.add(
															[ 	arrayp.codigo,
																arrayp.descripcion,
																arrayp.cantidad,
																arrayp.preciopub,
																arrayp.preciodesc,
																arrayp.subtotal,
																'<button type="button" class="myButton" id="Producto'+i+'">X</button>'
															]).draw();
													}*/
													t.row.add(
															[
															 productos2[i].codigo,
															 productos2[i].descripcion,
															 productos2[i].cantidad,
															 productos2[i].preciopub,
															 productos2[i].preciodesc,
															 productos2[i].subtotal,
															 '<button type="button" class="myButton" id="Producto'+i+'">X</button>'
															]).draw();
												}
											}
											
											// load local values
											var arrayt = JSON.parse(localStorage.getItem("totales"));
											console.log("totales arrayt: "+arrayt);
											if (arrayt != null) {
												$('#txtPrecT').val(arrayt.pt);
												$('#txtDesT').val(arrayt.dt);
												$('#txtIva').val(arrayt.va);
												$('#txtSubtotal').val(arrayt.sbt);
												$('#txtTotal').val(arrayt.tt);
											}
											
											// $('#openFormAltaCobro').prop("disabled",
											// false);
											// $('#openFormAltaCobro').prop("disabled",
											// true);
											console.log("Item: "+localStorage.getItem("item"));
											if (localStorage.getItem("item") <= 0)
												counter = 0;
											else {
												counter = parseInt(localStorage.getItem("item"));
												counter++;
												console.log("datos de contador despues de recargar: "+ counter);
											}
										}
									});
					/*
					 * Event change on: txtCantidad enables math operation when
					 * input change value
					 */
					$('#txtCantidad').on('keyup ',function(e) {
										// se verifica si no items en la lista o
										// si es asi se actualiza
										var cantidad = $.trim($("#txtCantidad").val());
										cantidad = parseInt(cantidad);
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
											// Se presiona la tecla enter:  agrega a la lista el item
											// seleccionado por defecto
											if (e.which == 13 && cantidad > 0) {
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
												
												localStorage.setItem("item",counter);
												console.log("nuevo item agregado: "	+ localStorage.getItem("item"));
												
												// add items for local storage products
												/*var myObject = new Object();
												myObject.codigo = codigo1.concat($("#txtCodigo").val().trim());
												myObject.descripcion = $('#lblDscp').text();
												myObject.cantidad = $('#txtCantidad').val();
												myObject.preciopub = $('#lblPrcp').text();
												myObject.preciodesc = $('#lblPrcd').text();
												myObject.subtotal = $('#lblImpTotal').text();*/
												
												
												var producto = {
														codigo: 	codigo1.concat($("#txtCodigo").val().trim()),
														descripcion:$('#lblDscp').text(),
														cantidad:	$('#txtCantidad').val(),
														preciopub:	$('#lblPrcp').text(),
														preciodesc:	$('#lblPrcd').text(),
														subtotal:	$('#lblImpTotal').text()
														
												};
												productos.push(producto);
												localStorage.setItem("productosVenta", JSON.stringify(productos));
												console.log("productosVenta: "+localStorage.getItem("productosVenta"));
												
												//localStorage.setItem("Producto" + counter + "", JSON.stringify(myObject));
												//console.log("Producto"+counter+" "+JSON.parse(localStorage.getItem("Producto"+ counter+ "")));
												counter++;
												
												// proceso de operaciones matematicas para el calculo total de los items
												var inputTotal = parseFloat($('#txtTotal').val());
												var inputSubTotal = parseFloat($('#txtSubtotal').val());
												var inputTotalPublico = parseFloat($('#txtPrecT').val());
												var inputIva = parseFloat($('#txtIva').val());
												var inputDescuento = parseFloat($('#txtDesT').val());
												/*
												 * en esta seccion se realizaria el calculo de insen la implemntacion es por rpoducto
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
												
												// saved data (hard code not is good practice for security reasons)
												var myObject = new Object();
												myObject.pt = $('#txtPrecT').val();
												myObject.dt = $('#txtDesT').val();
												myObject.va = $('#txtIva').val();
												myObject.sbt = $('#txtSubtotal').val();
												myObject.tt = $('#txtTotal').val();
												
												localStorage.setItem("totales",JSON.stringify(myObject));
												console.log("totales: "+JSON.parse(localStorage.getItem("totales")));
												
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
										} else {
											alert("No se puede calcular cantidad sin producto ingresado");
											$('#txtCantidad').val("");
											$('#txtCodigo').focus();
										}
									});
					/*
					 * Event for txtCodigo when active search product in servlet
					 * context return data [botonbuscar]
					 */
					$('#txtCodigo').keypress(function(event) {
							if (event.which == 13) {
								$.get('cobroController.jr',{
									varCodigo : $('#txtCodigo').val()
								},function(data) {
									console.log("Item Load: "+ data);
									if (data.length > 0) {
										productData = data.split('~');
										
										//salvar la info necesaia para realizar los calculo de descuentos e iva
										//                     nombre: codigo , precioPublico   +   descFamilia     +       cls        +      iva     
										localStorage.setItem(""+productData[1],productData[11]+"~"+productData[15]+"~"+productData[5]+"~"+productData[7]);
										
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
										
										if (productData[9] == "C") {
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
									} else {
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
																	
											var myObject = new Object();
											myObject.idnt = $('#txtFolio').val();
											myObject.caja = $('#txtCaja').val();
											myObject.usuario = $('#txtUsuario').val();
											myObject.cliente = $('#txtCliente').val();
											myObject.dcliente = $('#txtDescripcion').val();
											
											localStorage.setItem("nota",JSON.stringify(myObject));
											// localStorage.setItem("idcontrolventa","1");
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
							var iddelete = $(this).attr('id').trim();
							console.log("idDelete: "+iddelete);
							alert("Desea eliminar el item seleccionado: "+ description);
							//var arrayp = JSON.parse(localStorage.getItem(iddelete));
							var arrayp = JSON.parse(localStorage.getItem("productosVenta"));
							console.log("datos obtenidos del arreglo: "+ arrayp[index]);
							
							if (arrayp != null) {
//								$.post('cobroController.jr',{
//									varCodigo : arrayp.codigo,
//									workout : 'deleteDataList'
//								},function(data) {
//									console.log("Delete data process: "+ data);
//									var producto = data.split('~');
//									
//									if (producto != null) {
										var infoProductDesc = localStorage.getItem(""+arrayp[index].codigo).split("~");;
										var iva = 0;
										var preciopublico = 0;
										var preciodescuento = 0;
										var pdt = 0;
										var subtotal = 0;
										var total = 0;
										var cantidad = 0;
										
//										preciopublico = parseFloat(producto[11]);
										preciopublico = parseFloat(infoProductDesc[0]);
//										preciodescuento = (preciopublico * parseFloat(producto[15] / 100)).toFixed(2);
										preciodescuento = (preciopublico * parseFloat(infoProductDesc[1] / 100)).toFixed(2);
										cantidad = parseInt(arrayp[index].cantidad);
										
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
										//pdt = preciopublico- preciodescuento;
										
										if (infoProductDesc[3] == '2'){ // si el producto tiene iva
											iva = pdt - (pdt / 1.16);
											iva = iva.toFixed(2);
										}
										console.log("iva: "+iva);	
										subtotal = (pdt - iva).toFixed(2);
										total = (parseFloat(subtotal) + parseFloat(iva)).toFixed(2);
										
										var inputprecio = parseFloat($('#txtPrecT').val());
										inputprecio = inputprecio - (preciopublico * cantidad);
										$('#txtPrecT').val(inputprecio.toFixed(2));
										
										var inputpreciodes = parseFloat($('#txtDesT').val());
//										inputpreciodes = inputpreciodes - (preciodescuento * cantidad);
										inputpreciodes = inputpreciodes - (sumDesc * cantidad);
										$('#txtDesT').val(inputpreciodes.toFixed(2));
										var inputiva = parseFloat($('#txtIva').val());
										
										inputiva = inputiva	- (iva * cantidad);
										$('#txtIva').val(inputiva.toFixed(2));
										
										var inputsub = parseFloat($('#txtSubtotal').val());
										inputsub = inputsub	- (subtotal * cantidad);
										$('#txtSubtotal').val(inputsub.toFixed(2));
										
										var inputtot = parseFloat($('#txtTotal').val());
										inputtot = inputtot	- (total * cantidad);
										$('#txtTotal').val(inputtot.toFixed(2));
										
										var myObject = new Object();
										myObject.pt = $('#txtPrecT').val();
										myObject.dt = $('#txtDesT').val();
										myObject.va = $('#txtIva').val();
										myObject.sbt = $('#txtSubtotal').val();
										myObject.tt = $('#txtTotal').val();
										
										localStorage.setItem("totales",JSON.stringify(myObject));
										var item = parseInt(localStorage.getItem("item"));
										item = item - 1;
										console.log("indice item: "	+ item);

										// localStorage.setItem("item",item);
										
										// remove row from datatable
										//localStorage.removeItem(iddelete);
										
										arrayp.splice(index,1);
										console.log("arrayp: "+arrayp);
										localStorage.setItem('productosVenta', JSON.stringify(arrayp));
										t.row($(this).parents('tr')).remove().draw(false);
										
										// check if table is empty
										if (t.column(0).data().length == 0) {
											$('#openFormAltaCobro').prop('disabled',true);
										}
//									}
//								});
							}
							table.row($(this).parents('tr')).remove().draw(false);
						}
					});
					
					/* end document ready */
				});
/*
 * function fcneliminaFilas(x) { var t = $('#example').DataTable(); $('#example
 * tbody').on( 'click', 'button', function () { // console.log("received data:
 * "+x); var index = t.row( $(this).parents('tr')).index(); console.log("indice
 * obtenido:"+index); var arrayp =
 * JSON.parse(localStorage.getItem("Producto"+(index+1)+"")); console.log("datos
 * obtenidos del arreglo: " +localStorage.getItem("Producto"+(index+1)+""));
 * if(localStorage.getItem("item") > 0) { if(arrayp!=null) {
 * $.post('cobroController.jr', { varCodigo: arrayp.codigo, workout:
 * 'deleteDataList' }, function(data) { console.log("Delete data process:
 * "+data); var producto = data.split(','); if(producto !=null) { var iva = 0 ;
 * var preciopublico = 0; var preciodescuento = 0; var pdt = 0; var subtotal =
 * 0; var total = 0; var cantidad = 0; preciopublico = parseFloat(producto[11]);
 * preciodescuento = (preciopublico * parseFloat(producto[15]/100)).toFixed(2);
 * cantidad = parseInt(arrayp.cantidad); pdt = preciopublico - preciodescuento;
 * if(producto[7] == '2') // si el producto tiene iva { iva = pdt - (pdt /
 * 1.16); iva = iva.toFixed(2); } subtotal = pdt.toFixed(2) - iva; total =
 * (parseFloat(subtotal) + parseFloat(iva)).toFixed(2); var inputprecio =
 * parseFloat($('#txtPrecT').val()); inputprecio = inputprecio - (preciopublico *
 * cantidad); $('#txtPrecT').val(inputprecio.toFixed(2)); var inputpreciodes =
 * parseFloat($('#txtDesT').val()); inputpreciodes = inputpreciodes -
 * (preciodescuento *cantidad); $('#txtDesT').val(inputpreciodes.toFixed(2));
 * var inputiva = parseFloat($('#txtIva').val()); inputiva = inputiva - (iva *
 * cantidad); $('#txtIva').val(inputiva.toFixed(2)); var inputsub =
 * parseFloat($('#txtSubtotal').val()); inputsub = inputsub - (subtotal *
 * cantidad); $('#txtSubtotal').val(inputsub.toFixed(2)); var inputtot =
 * parseFloat($('#txtTotal').val()); inputtot = inputtot - (total * cantidad);
 * $('#txtTotal').val(inputtot.toFixed(2)); var myObject = new Object();
 * myObject.pt = $('#txtPrecT').val(); myObject.dt = $('#txtDesT').val();
 * myObject.va = $('#txtIva').val(); myObject.sbt = $('#txtSubtotal').val();
 * myObject.tt = $('#txtTotal').val(); localStorage.setItem("totales",
 * JSON.stringify(myObject)); var item = parseInt(localStorage.getItem("item"));
 * item = item - 1; console.log("indice: "+item);
 * localStorage.setItem("item",item); // remove row from datatable
 * localStorage.removeItem("Producto"+(index+1)+""); t.row(
 * $(this).parents('tr')).remove().draw(); // check if table is empty
 * if(t.column(0).data().length == 0) { $('#openFormAltaCobro').prop('disabled',
 * true); } } }); } } else localStorage.setItem("item",0); }); }
 */