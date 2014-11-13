/*funcion de Jquery que crea el cuadro de dialogo para ingresar la cantidad de dinero que entrara en caja, si la cantidad es valida (menor a mil pesos, aparece el cuadro de dialogo de bienvenida" confirmation-2"),
 * en caso contrario aparece el cuadro de dialogo error "confirmation-1"*/
$(function() {
	$("#dialog").dialog({
		modal : true,
		autoOpen : op,
		closeOnEscape : false,
		buttons : [ {
			text : "Aceptar",
			click : function() {
				$(this).blur();
				$(this).dialog("close");
				var x = $("#cantidad").val();
				console.log(x);
				if (x > 0 && x < 1000) {
					EnviarTicket(x);
				} else {
					console.log("cantidad incorrecta");
					$("#confirmation-1").dialog("open");
				}
			}
		} ]
	});
	$("#dialog").dialog("option", "width", 420);
	$("#dialog").dialog("option", "height", 190);
	$("#cantidad").keypress(function(e) {
		if (e.keyCode == $.ui.keyCode.ENTER) {
			$("#dialog").dialog("close");
			var x = $("#cantidad").val();
			console.log(x);
			if (x < 1000) {
				EnviarTicket(x);
			} else {
				console.log("cantidad incorrecta");
				$("#confirmation-1").dialog("open");
			}
		}
	});
});
/*
 * Funcion para la creacion del cuadro de dialogo "confirmation-1", que mostrara
 * un error en caso de que la cantidad ingresada al input sea invalida
 */
$(function() {
	$("#confirmation-1").dialog({
		modal : true,
		autoOpen : false,
		closeOnEscape : false,
		buttons : {
			"Aceptar" : function() {
				$(this).dialog("close");
				$("#dialog").dialog("open");
			}
		}
	});
	$("#confirmation-1").dialog("option", "width", 420);
	$("#confirmation-1").dialog("option", "height", 200);
});
/*
 * Funcion para la creacion del cuadro de dialogo "confirmation-2", que mostrara
 * un mensaje de bienvenida en caso de que la cantidad ingresada al input sea
 * valida
 */
$(function() {
	$("#confirmation-2").dialog({
		modal : true,
		autoOpen : false,
		closeOnEscape : false,
		buttons : {
			"Aceptar" : function() {
				$(this).dialog("close");
			}
		}
	});
	$("#confirmation-2").dialog("option", "width", 420);
	$("#confirmation-2").dialog("option", "height", 150);
});
/* Popus forms data context */
$(function() {
	$("#formAltaMedico").dialog({
		modal : true,
		autoOpen : false,
		buttons : {
			"Dar de Alta" : function() {
				$(this).dialog("close");
			},
			"Cancelar" : function() {
				$(this).dialog("close");
			}
		}
	});
	$("#formAltaMedico").dialog("option", "width", 540);
	$("#formAltaMedico").dialog("option", "height", 460);
});
$(function() {
	$("#formAltaCliente").dialog({
		modal : true,
		autoOpen : false,
		buttons : {
			"Dar de Alta" : function() {
				$(this).dialog("close");
			},
			"Cancelar" : function() {
				$(this).dialog("close");
			}
		}
	});
	$("#formAltaCliente").dialog("option", "width", 540);
	$("#formAltaCliente").dialog("option", "height", 460);
});
/*
 * Function for dialog F10 Sales: Funcion 10 que llama el ticket de cobro una
 * vez presionado F10
 */
$(function() {
	$("#formAltaCobro").dialog({
		modal : true,
		autoOpen : false,
		buttons : {
			"btnF10" : {
				text : "F10 Efectivo",
				id : "btnF10",
				type : "submit",
				keydown : function(e) {
					// Se activa cuando se presiona el boton F10
					if (e.which == 121) {
						var totalCobro = parseFloat($('#txtTotalPago').val());
						var totalCambio = parseFloat($('#txtCambio').val());
						if (totalCobro != 0 && totalCambio >= 0) {
							EnviarFormulario();
							$(this).dialog("close");
						} else
							alert("Debe especificar una cantidad a cobrar");
					} else {
						alert("Debe presionar F10 para cobrar la venta");
						$('#btnF10').focus();
					}
				},
				click : function(e) {
					var totalCobro = parseFloat($('#txtTotalPago').val());
					var totalCambio = parseFloat($('#txtCambio').val());
					if (totalCobro != 0 && totalCambio >= 0) {
						EnviarFormulario();
						$(this).dialog("close");
					} else
						alert("Debe especificar una cantidad a cobrar");
				}
			},
			"Venta Domicilio" : function() {
				$(this).dialog("close");
			},
			"Cr�dito" : function() {
				$(this).dialog("close");
			},
			"F11 Tarjeta Cr�dito" : function() {
				$(this).dialog("close");
			},
			"Vale" : function() {
				$(this).dialog("close");
			}
		}
	});
	$("#formAltaCobro").dialog("option", "width", 345);
	$("#formAltaCobro").dialog("option", "height", 380);
});
$(function() {
	$("#formAltaAntibiotico").dialog({
		modal : true,
		autoOpen : false,
		closeOnEscape : false,
		buttons : {
			"aceptar" : {
				text : "Aceptar",
				id : "aceptar",
				type : "submit",
				keydown : function(e) {
					// Se activa cuando se presiona enter
					if (e.which == 13) {
						alert("Antibiotico guardado con exito");
						var myObject = new Object();
						myObject.idnt = $('#txtFolio').val();
						myObject.caja = $('#txtCaja').val();
						myObject.usuario = $('#txtUsuario').val();
						myObject.cliente = $('#txtCliente').val();
						myObject.dcliente = $('#txtDescripcion').val();
						localStorage.setItem("nota", JSON.stringify(myObject));
						$(this).dialog("close");
					}
				},
				click : function(e) {
					alert("Antibiotico guardado con exito");
					$(this).dialog("close");
				}
			},
			"Cancelar" : function() {
				$(this).dialog("close");
			}
		}
	});
	$("#formAltaAntibiotico").dialog("option", "width", 350);
	$("#formAltaAntibiotico").dialog("option", "height", 300);
});
// rutina de enviar formulario
function EnviarFormulario() {
	blockpage();
	var table = $('#example').tableToJSON(); // Convert the table into a
												// javascript object
	var datosNota = {
			idnt:	$('#txtFolio').val(),
			caja:	$('#txtCaja').val(),
			usuario:$('#txtUsuario').val(),
			cliente:$('#txtCliente').val(),
			dcliente:$('#txtDescripcion').val()
			
	};
	$.post('cobroController.jr', {
		data_1 : JSON.stringify(datosNota),
		data_2 : localStorage.getItem("totales"),
		data_3 : JSON.stringify(table),
		varTotalCobro : $('#txtTotalCobro').val(),
		varTotalPago : $('#txtTotalPago').val(),
		varCambio : $('#txtCambio').val(),
		// se envian los datos de antibiotico
		varMedico : $('#selMedico').val(),
		varReceta : $('#selReceta').val(),
		varSello : $('#selSello').val(),
		workout : 'insertdbp'
	}, function(data) {
		if (data == "OK") {
			var popPrinter;
			// delete storage
			table = null;
			localStorage.removeItem("nota");
			localStorage.removeItem("totales");
			localStorage.setItem("idcontrolventa", "0"); // set control de venta 0 for leave cobro
			localStorage.removeItem("descClteFrec");
			localStorage.removeItem("descInsen");
			/*for (var i = 1; i <= localStorage.getItem("item"); i++) {
				var producto = JSON.parse(localStorage.getItem("Producto"+i+""));
				localStorage.removeItem(""+producto.codigo);
				localStorage.removeItem("Producto" + i + "");
			}*/
			var productos = JSON.parse(localStorage.getItem("productosVenta"));
			for (var i = 1; i < productos.length; i++) {
				localStorage.removeItem(""+productos[i].codigo);
			}
			localStorage.removeItem("productosVenta");
			
			localStorage.removeItem("item");
			$.unblockUI();
			popPrinter = window.open("ticketcobro.jsp", "Impresion","height=600,width=400");
			popPrinter.focus();
		}
	});
}
function EnviarTicket(x) {
	console.log("cantidad correcta");
	$("#confirmation-2").dialog("open");
	$.post('ticket.jr', {
		varUser : $("#lbluser").text(), // send quantity input add
		varCantidad : x,
		workout : 'saveTicket'
	}, function(data) {
		// save the data in localstorage
		localStorage.setItem("sesionend", "1");
		localStorage.setItem("userid", data.iduser);
		localStorage.setItem("sessionid", data.idsesion);
		localStorage.setItem("reportid", data.idreport);
		console.log("Usuario :" + data.iduser);
		console.log("Sesion :" + data.idsesion);
		console.log("Report :" + data.idreport);
		var popPrinter;
		popPrinter = window.open("ticketdeposito.jsp", "Impresion",
				"height=600,width=350");
		popPrinter.focus();
	});
}
// pagina de espera con block page
function blockpage() {
	$.blockUI({
		css : {
			border : 'none',
			padding : '15px',
			backgroundColor : '#000',
			'-webkit-border-radius' : '10px',
			'-moz-border-radius' : '10px',
			opacity : .6,
			color : '#fff'
		}
	});
}