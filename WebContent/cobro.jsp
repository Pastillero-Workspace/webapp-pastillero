<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="mx.com.pastillero.types.Types"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Pastillero 4.0 | Panel de Venta</title>
<meta name="description" content="venta">
<link href="<c:url value="/resources/css/cobrostyle.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/jquery-ui-1.10.4.custom.css"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/resources/css/jquery.dataTables.css" />"	rel="stylesheet">
<link href="<c:url value="/resources/css/demo.css" />" rel="stylesheet">
<!-- Javascript functions-->
<script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
<script src="<c:url value="/resources/js/jquery.dataTables.js" />"></script>
<script src="<c:url value="/resources/js/dataTables.scroller.js" />"></script>
<script src="<c:url value="/resources/js/utils.js" />"></script>
<script src="<c:url value="/resources/js/jquery-ui-1.10.4.custom.js" />"></script>
<script src="<c:url value="/resources/js/jquery-ui-dialog.js" />"></script>
<script src="<c:url value="/resources/js/jquery.tabletojson.min.js" />"></script>
<script src="<c:url value="/resources/js/blockUI/jquery.blockUI.js" />"></script>
<script type="text/javascript">
	/*Funcion que muestra el formulario de "Alta Cobro"*/
	var op = false;
	$(document)
			.ready(
					function() {
						// open the dialog for buy the sale. with F9 key
						$(document).keydown(
								function(e) {
									if (e.which == 120
											&& !$('#openFormAltaCobro').is(
													':disabled')) {
										process_antibiotico();
										process_sale();
									}
								});
						// open dialog w for buy the sale with click process
						$("#openFormAltaCobro").click(function(event) {
							if (!$('#openFormAltaCobro').is(':disabled')) // Se presionó F9
							{
								process_antibiotico();
								process_sale();
							}
						});
						$("#btnDevolucion").click(function(){
							window.open("listadevolventas.jsp", "_blank");
						});
						
						// keypress for calculate pago total
						$("#txtTotalPago").keypress(function(event) {
							var inputPago = (parseFloat($("#txtTotalPago").val())).toFixed(0);
							if (event.which == 13 && inputPago != 0) {
								$("#txtTotalPago").val(inputPago);
								var inputCobro = parseFloat($("#txtTotalCobro").val());
								if (inputPago >= inputCobro) {
									var Cambio = inputPago - inputCobro;
									console.log("Panel Cobro : diferencia = " + Cambio);
									Cambio = Cambio.toFixed(2);
									$("#txtCambio").val(Cambio);
									$('#btnF10').focus();
								} else
									alert("La cantidad ingresada debe ser mayor al total a cobrar");
							}
						});
					});
	// procesa el formulario de alta de cobro
	function process_sale() {
		$("#formAltaCobro").dialog('open');
		var Total = parseFloat($('#txtTotal').val());
		$('#txtTotalCobro').val(Total);
		$('#txtTotalPago').val("0.0");
		$('#txtTotalPago').select();
		$('#txtCambio').val("0.0");
	}
	// procesa el formulario de antibiotico
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
			/*$.ajax({
		        url: "/webapp-pastillero/consulta.jr",
		        type: 'POST',
		        dataType: 'json',
		        data://txtcodigo+':'+txtdescripcion,
		        	{
		        	workout: 'getMedicos'
		        	},
		        contentType: 'application/json',
		        mimeType: 'application/json', 
		        success: function (medicos) {
		        	//
		        	alert(medicos);
		        	$("#selMedico").empty();
		        	var nombreMedicos = [];
		        	$.each(medicos, function(i, medico){
		        		nombreMedicos.push(medico);
					  });
		        	$( "#selMedico" ).autocomplete({
		        	      source: nombreMedicos
		        	});
		        	$("#formAltaAntibiotico").dialog('open');
		        },
		        error:function(data,status,er) {
		            alert("error: "+data+" status: "+status+" er:"+er);
		        }
		    });*/
		}
	}
</script>
</head>
<body oncontextmenu="return false;">
	<form action="cobroController.jr" id="formCobro" method="post">
		<div class="container-p clearfix">
			<!-- contenedor principal wrapper -->
			<div id="width-extension">
				<label id="title-point">PUNTO DE VENTA | CAJERO : <%
					Date dNow = new Date();
					SimpleDateFormat ft = new SimpleDateFormat("E dd.MM.yyyy");
					out.print(ft.format(dNow));
				%></label>
			</div>
			<div id="width-extension">
				<!-- panel superior S1 -->
				<div class="float-left">
					<!-- wrapper 1 -->
					<label id="box-caja">Caja</label>
					<p>
						<input type="text" id="txtCaja" name="inputCaja" readonly>
				</div>
				<div class="float-left">
					<label id="box-cajero">Cajero</label>
					<p>
						<input type="text" id="txtCajero" name="inputCajero" readonly></p>
				</div>
				<div class="float-left">
					<label id="box-folio">Folio</label>
					<p>
						<input type="text" id="txtFolio" name="inputFolio" readonly>
				</div>
				<div class="float-left">
					<label id="box-usuario">Usuario</label>
					<%
						HttpSession sesion = request.getSession(false);
						String usuario = (String) sesion.getAttribute("usuario");
						String nombre = (String) sesion.getAttribute("nombre");
						String apepat = (String) sesion.getAttribute("apepat");
						String apemat = (String) sesion.getAttribute("apemat");
						String perfil = (String) session.getAttribute("perfil");
						Integer num = (Integer) sesion.getAttribute("numero");
						boolean res = false;
						if (num == null) {
							response.sendRedirect("index.jsp");
						} else {
							if (num == 1
									&& perfil.equalsIgnoreCase(Types.C.getStatusCode())) {
								sesion.setAttribute("numero", 2);
								res = true;
							}
						}
					%>
					<p>
						<input type="text" id="txtUsuario" name="inputUsuario"
							value=<%=usuario%> readonly>
				</div>
				<div class="float-left">
					<label id="lblClientes">Cliente</label>
					<p>
						<input type="text" id="txtCliente" name="inputidCliente">
				</div>
				<div class="box-container clearfix">
					<label id="box-usuario">-</label>
					<p>
						<input type="text" id="txtDescripcion" name="inputDescripCliente"
							readonly> <input type="hidden" id="txtAntibiotico"
							name="inputantibiotico" readonly>
				</div>
			</div>
			<!-- S1-->
			<!-- Panel S2-->
			<div id="width-extension">
				<div class="datagridstyle">
					<section>
					<table id="example" name="inputTable" class="display"
						cellspacing="0" width="100%">
						<thead>
							<tr>
								<!--th style="width: 13%">Código</th-->
								<th style="width: 13%">C&oacute;digo</th>
								<th style="width: 30%">Descripcion</th>
								<th style="width: 5%">Cantidad</th>
								<th style="width: 10%">PrecioPub</th>
								<th style="width: 10%">PrecioDes</th>
								<th style="width: 12%">Subtotal</th>
								<th></th>
							</tr>
						</thead>
						<thead>
							<tr>
								<th style="width: 13%"><input type="text" id="txtCodigo"
									name="txtCodigo" value="" disabled></th>
								<th style="width: 30%"><label id="lblDscp"></label></th>
								<th style="width: 5%"><input type="text" id="txtCantidad"
									value="1" disabled></th>
								<th><label id="lblPrcp">$ 0.0</label></th>
								<th><label id="lblPrcd">$ 0.0</label></th>
								<th><label id="lblImpTotal">$ 0.0</label></th>
								<th><label><button id="deleteitem" type="button">Borrar
											Item</button></label></th>
							</tr>
						</thead>
						<tbody>
						</tbody>
						<tfoot>
						</tfoot>
					</table>
					</section>
				</div>
			</div>
			<!-- S2-->
			<!-- Panel S3-->
			<div id="width-extension">
				<div class="group-left">
					<p>
						<label id="test"></label>
				</div>
				<div class="group-right">
					<div class="subgroup-left">
						<!-- <button type="button" class="button-sf9 myButton" id="openFormAltaCobro" >F9 | COBRAR</button>
<button type="button" class="button-sf9 myButton">Reimprimir </button>-->
						<input type="button" id="openFormAltaCobro" class="button-sf9"
							value="F9|COBRAR">
					</div>
					<div class="subgroup-left">
						<label> Precio $ </label> <label> Descuento $ </label> <label>
							IVA $</label> <label> Subtotal $ </label> <label> TOTAL $</label>
					</div>
					<div class="subgroup-left">
						<input type="text" id="txtPrecT" name="inputPrecT" value="0.0"
							readonly> <input type="text" id="txtDesT"
							name="inputDesT" value="0.0" readonly> <input type="text"
							id="txtIva" name="inputIva" value="0.0" readonly> <input
							type="text" id="txtSubtotal" name="inputSubtotal" value="0.0"
							readonly> <input type="text" id="txtTotal"
							name="inputTotal" value="0.0" readonly>
					</div>
				</div>
				<div class="group-left">
					<label id="lblDescripcion"></label>
				</div>
				<div class="group-left">
					<button type="button">Cuentas por cobrar</button>
					<button type="button">Pago a proveedores</button>
					<button type="button">Alta producto</button>
					<button type="button">Alta producto</button>
					<button type="button">Corte Caja</button>
				</div>
			</div>
			<!-- S3-->
			<!-- Panel S4-->
			<div id="width-extension">
				<div>
					<button type="button">F1 Presupuesto</button>
					<button type="button">F2 Alta médico</button>
					<button type="button">F4 Encargos</button>
					<button type="button">F5 Pendientes</button>
					<button type="button">F6 Alta cliente</button>
					<button type="button" id="btnDevolucion">F7 Devolución</button>
					<button type="button">F8 Facturar</button>
				</div>
				<!-- S4-->
			</div>
		</div>
		<!-- contenedor para ventana de javascript -->
		<div id="formAltaCobro" title="Pantalla de Cobro" class="text-form">
			<legend>Datos de Cobro</legend>
			<fieldset>
				<ol>
					<li><label> Total a Cobrar:</label><input type="text"
						id="txtTotalCobro" disabled></li>
					<li><label> Total Recibido:</label><input type="text"
						id="txtTotalPago" requiered></li>
					<li><label> Cambio:</label><input type="text" id="txtCambio"
						disabled></li>
				</ol>
			</fieldset>
		</div>
		<!-- contenedor para ventana de javascript de antibiotico -->
		<div id="formAltaAntibiotico" title="Pantalla de Antibiotico"
			class="text-form">
			<legend>Formulario Antibiotico</legend>
			<fieldset>
				<ol>
					<li><label> Medico:</label><input name="selMedico"	id="selMedico"></li>
					<li><label> Receta:</label><select name="selReceta"
						id="selReceta">
							<option value="SI">SI</option>
							<option value="NO">NO</option>
					</select> <label> Sello:</label><select name="selSello" id="selSello">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
					</select></li>
				</ol>
			</fieldset>
		</div>
	</form>
</body>
</html>