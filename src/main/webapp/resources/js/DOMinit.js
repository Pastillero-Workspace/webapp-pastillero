/**
 * Page success login
 * 
 * Funtion for index
 */

function loadpagesession()
{
	    $("#1").hide();
	    $("#3").hide();
	 
	  	    var nickname = localStorage.getItem("usuario");
	  	   var sesionend = localStorage.getItem("sesionend");	
	  	var controlventa = localStorage.getItem("idcontrolventa");
	  	
	  	// if exist one session
	  	if(sesionend !=null)
	  	{
		  	if(sesionend.localeCompare("1") == 0 )
		  		{
		  		    $("#sub").prop( "disabled", true );
		  			$("#1").show();
		  			$("#p1").html("Existe una sesion abierta para: <label id="+"user"+">"+nickname+"</label> | Que desea hacer ?");
		  			$("#p2").html("<button id="+"signout"+" onclick="+"cerrar()"+">Cerrar</button> | </b><button id="+"signin"+" onclick="+"continuar()"+">Continuar</button>");
		  		}
		  	else
		  		$("#sub").prop( "disabled", false );
	  	}
	  	
	  	if(controlventa != null)
	  	{
			if(controlventa.localeCompare("1") == 0)
	  		{
				var arraynt = JSON.parse(localStorage.getItem("nota"));
				if(arraynt !=null)
	  		    {
	
					$("#3").show();
					$("#p3").html("Existe una nota pendiente: <label id="+"user"+">"+arraynt.idnt+" </label> para el usuario: <label id="+"user"+
							      "> "+arraynt.usuario+"</label> inicie sesi&oacuten para continuar ");
					$("#p4").html("<button id="+"signout"+" onclick="+"continuarventa()"+">Continuar</button>");
	  		    }
	  			
	  		}

	  	}
	  	else
	  		localStorage.setItem("idcontrolventa", "0");
}


// cerrar: close the opened session
function cerrar()
{
	var nickname = localStorage.getItem("usuario");
  	var psw = prompt("Ingrese contrase\u00F1a para: "+nickname+"", "");     
     if (psw != null && psw.length > 0) 
     {
    	 
         var data = localStorage.getItem("sessionid");
         $.post('logout.jr',
         {          	
         	        user : nickname,
         	    password : psw, 
         	idLocalSesion: data,
         	     workout : 'exitws'    
         },function(data)
         {
         	if(data == "Exit")
         	{
         		localStorage.setItem("sesionend","0");
      		  	localStorage.setItem("usuario","");
      		  	localStorage.setItem("perfil","");
         	    window.location.replace("index.jsp");
         	    alert("Sesion finalizada");
         	}
         	if(data == "NS")
         	{
         		alert( ' Contrase\u00F1a err\u00F3nea ' );
         	}
         });
     }
}

function continuar()
{
	$("#1").hide();
	$("#sub").prop( "disabled", false );
	
	var nickname = localStorage.getItem("usuario");
	var sesionend = localStorage.getItem("sesionend");
	if(sesionend.localeCompare("1") == 0)
		{
		    $("#userName").val(nickname);
			$("#s").val(localStorage.getItem("sessionid"));
		}
}

function continuarventa()
{
	$("#3").hide();
	$("#sub").prop( "disabled", false );
	var arraynt = JSON.parse(localStorage.getItem("nota"));
	var sesionend = localStorage.getItem("sesionend");
	if(sesionend.localeCompare("1") == 0)
	  {
		    $("#userName").val(localStorage.getItem(arraynt.usuario));
	  }
}


