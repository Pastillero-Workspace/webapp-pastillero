/*funcion de Jquery que crea el cuadro de dialogo para ingresar la cantidad de dinero que entrara en caja, 
si la cantidad es valida (menor a mil pesos, aparece el cuadro de dialogo de bienvenida" confirmation-2"),
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
						var totalCobro = parseFloat($('#txtTotalPago').val()).toFixed(2);
						var totalCambio = parseFloat($('#txtCambio').val()).toFixed(2);
						if (totalCobro != 0 && totalCambio >= 0) {
							popPrinterCobro = EnviarFormulario();
							$("#formAltaCobro").dialog("close");
						} else
							alert("Debe especificar una cantidad a cobrar");
					}
					/*else {
						alert("Debe presionar F10 para cobrar la venta");
						$('#btnF10').focus();
					}*/
				},
				click : function() {
					var totalCobro = parseFloat($('#txtTotalPago').val()).toFixed(2);
					var totalCambio = parseFloat($('#txtCambio').val()).toFixed(2);
					if (totalCobro != 0 && totalCambio >= 0) {
						popPrinterCobro = EnviarFormulario();
						$("#formAltaCobro").dialog("close");
					} else
						alert("Debe especificar una cantidad a cobrar");
				}
			},
			"Venta Domicilio" : function() {
				$(this).dialog("close");
			},
			"Credito" : function() {
				$(this).dialog("close");
			},
			"F11 Tarjeta Credito" : function() {
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
var popPrinterCobro;
//funcion que procesa la informacion de venta
function EnviarFormulario() {
	blockpage();
	var table = $('#example').tableToJSON({ignoreColumns: [1]}); 
	
	var datosNota = {
			idnt:	$('#txtFolio').val(),
			caja:	$('#txtCaja').val(),
			cajero: $('#txtCajero').val(),
			usuario:$('#txtUsuario').val(),
			cliente:$('#txtCliente').val(),
			dcliente:$('#txtDescripcion').val()
			
	};
	
	var totalesNota = {
		pt: $('#txtPrecT').val(),
		dt: $('#txtDesT').val(),
		va: $('#txtIva').val(),
		sbt: $('#txtSubtotal').val(),
		tt: $('#txtTotal').val()
	};
	
	if (datosNota.idnt != "") {
		//Se envian datos de venta para procesar y guardar la información en base de datos.
		$.ajax({
			async:false,
	        cache:false,
	        type: 'POST',  
	        url: "cobroController.jr",
	        data: {
	        	workout : 'insertdbp', 
	        	txtUsuario: $("#txtUsuario").val(),
	        	data_1 : JSON.stringify(datosNota),
	    		data_2 : JSON.stringify(totalesNota),
	    		data_3 : JSON.stringify(table),
	    		varTotalCobro : $('#txtTotalCobro').val(),
	    		varTotalPago : $('#txtTotalPago').val(),
	    		varCambio : $('#txtCambio').val(),
	    		// se envian los datos de antibiotico
	    		varMedico : $('#selMedico').val(),
	    		varReceta : $('#selReceta').val(),
	    		varSello : $('#selSello').val()
	      }
		}).done(function(data){
			if (data == "OK") {
				//alert("Ok");
				// delete storage
				
					$.ajax({
	                    async:false,
	                    cache:false,
	                    type: 'POST',  
	                    url: "temporales.jr",
	                    data: {
	                    	tarea: 'borrarVentaTemp',
	    					txtNota: $('#txtFolio').val()
	                   }
					}).fail(function(xhr,textStatus, errorThrown){
	              	  alert("Error al eliminar temporales "+errorThrown);
	                });
					
					if(localStorage.getItem("descClteFrec") != null)
						localStorage.removeItem("descClteFrec");
					if(localStorage.getItem("descInsen") != null)
						localStorage.removeItem("descInsen");
					localStorage.setItem("idcontrolventa", "0"); // set control de venta 0 for leave cobro
					
					$.unblockUI();
					popPrinterCobro = window.open("ticketcobro.jsp", "Impresion","height=600,width=400");
					localStorage.setItem("popupTicket","1");
					
					$('#txtFolio').val("");
					$('#txtCaja').val("");
					$('#txtCajero').val("");
					$('#txtUsuario').val("");
					$('#txtCliente').val("");
					$('#txtDescripcion').val("");
					datosNota = {
							idnt:	"",
							caja:	"",
							cajero: "",
							usuario:"",
							cliente:"",
							dcliente:""
					};
					
					popPrinterCobro.focus();
					window.close();
			}else{
				$.unblockUI();
			}
		}).fail(function(xhr,textStatus, errorThrown){
			$.unblockUI();
	  	  	alert("Error al procesar venta: "+errorThrown+" ,"+xhr+" ,"+textStatus);
	    });	
	}else{
		$.unblockUI();
		alert("No se puede procesar venta, no hay datos");
	}
}

//Función que envia datos de ticket de deposito al iniciar sesion
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

function isTicket(){
	if(localStorage.getItem("popupTicket") == null || localStorage.getItem("popupTicket") == "0"){
		window.open("cobro.jsp");
	}else{
		alert("Usted tiene un Ticket pendiente de impresion, para abrir la ventana de cobro imprima antes el ticket pendiente");
	}
}


function launchApplication(l_url, l_windowName)
{
  if ( typeof launchApplication.winRefs == 'undefined' )
  {
    launchApplication.winRefs = {};
  }
  if ( typeof launchApplication.winrefs[l_windowName] == 'undefined' || launchApplication.winrefs[l_windowName].closed )
  {
    var l_width = screen.availWidth;
    var l_height = screen.availHeight;

    var l_params = 'status=1' +
                   ',resizable=1' +
                   ',scrollbars=1' +
                   ',width=' + l_width +
                   ',height=' + l_height +
                   ',left=0' +
                   ',top=0';

    launchApplication.winrefs[l_windowName] = window.open(l_url, l_windowName, l_params);
    launchApplication.winrefs[l_windowName].moveTo(0,0);
    launchApplication.winrefs[l_windowName].resizeTo(l_width, l_height);
  } else {
    launchApplication.winrefs[l_windowName].focus()
  }
}

