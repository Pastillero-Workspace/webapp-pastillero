/**
 *   
 *    ** ------------------------ FUNCTIONS ------------------------------  **
 *   
 */ 
function saveEstatus(a,b,c){	 		  	
		  	localStorage.setItem("sesionend","1");
		  	localStorage.setItem("usuario", a);
		  	localStorage.setItem("perfil", b);
		  	localStorage.setItem("sessionid",c);
		  	console.log("      usuario : "+localStorage.getItem("usuario"));
		  	console.log("       perfil : "+localStorage.getItem("perfil"));
		  	console.log("sesion activa : "+localStorage.getItem("sesionend"));
		  	console.log("    sesion id : "+localStorage.getItem("sessionid"));
}

/** Check restrictions **/

function checkConstraintRestriction(a){	
	if(a != null && a > 0){
		alert("Los permisos han cambiado. Pulse el boton actualizar para continuar");
		$("#update-restrictions").show();
	}	
}

/** Modify restrictions **/

function updateConstraintRestriction(){	
    $.post('dom.jr',
    	    {   
    	    	workout:'upd'
    	    },function(data)
    	    {   
    	    	if(data == "Error")
    	    	{
    	    		alert("Ha ocurrido un error: Contacte el administrador");
    	    	    window.location.replace("welcome.jsp");
    	    	}
    	    	if(data == "Done")
    		    {
    	    	    alert("Actualizacion exitosa")
    		    	window.location.replace("welcome.jsp");
    		    }		   
    	    });		
}

/** Close sessions user**/

function rstActives(a,b,c){	
	var type = a;
	if(typeof type !== 'undefined' && type !== null)
	{
		var data = localStorage.getItem("sessionid");
	    console.log("click en salir sesion num # "+data);
	    $.post('logout.jr',
	    {   u: b,
	    	p: c,
	       	idLocalSesion: data,
	    	workout:type
	    },function(data)
	    {   
	    	if(data == "ExitError")
	    	{
	    		alert("Cierre la ventana y vuelva iniciar sesion");
	    	    window.location.replace("index.jsp");
	    	}
	    	else if(data == "Exit")
		    	{
		    		localStorage.setItem("sesionend","0");
		 		  	localStorage.setItem("usuario","");
		 		  	localStorage.setItem("perfil","");
		    		alert("Sesion finalizada");
		    	    window.location.replace("index.jsp");
		    	}
		    	else
		    		window.location.replace("index.jsp");
	    });		
	}	

}

function venta()
{
	window.open("cobro.jsp");
}

function info( x)
{
	if(x == '1')
		alert("Función: Corte aún no implementada");
	if(x == '2')
		alert("Función: Medico en desarrollo");
}

function loadcjnotes(a)
{
	if(a != null && a == 'CAJERO'){
		var controlventa = localStorage.getItem("idcontrolventa");
		var arraynt = JSON.parse(localStorage.getItem("nota"));	
		var t = $('#example').DataTable({
			dom : "rtiS",
			"bSort": false,
			scrollY : 100,
			scrollCollapse : true
	   });
	  	if(controlventa !=null && arraynt !=null)
	  	{
			if(controlventa.localeCompare("1") == 0)
	  		{
				 document.getElementById("cobro").childNodes[0].onclick = function() {return false;};
				 t.row.add([					         
							arraynt.idnt,
							arraynt.usuario,
							'<button type="button" onclick="venta()">Continuar</button>'])
							.draw();
	  		}
			else
			{
				 document.getElementById("cobro").childNodes[0].onclick = function() {return true;};
			}
	  	} 
	}
}

/** -----------------------DOM Process Events Handlers --------------------------------------**/

$(document).ready(function() 
{	
	  /** User exits**/ 
		$("#close").click(
	            function() 
	             {
	            	rstActives("exitnr","","");
	             });
		
		$("#closeActive").click(
	            function() 
	             {
	            	rstActives("exitfr",$("#u").val(),$("#p").val());
	             });
		
    	$(function(){
    		$("#menuSecond").change(function() {
                if ($(this).val()) {
                    window.open($(this).val(), '_blank');
                }
    		});
    	});
	        	
    	window.addEventListener("beforeunload", function (e) {
    		var confirmationMessage = "Antes de cerrar el navegador, verifique y cierre su sesión del sistema";

    		  (e || window.event).returnValue = confirmationMessage;     
    		  	return confirmationMessage;                            
    	});
		
});