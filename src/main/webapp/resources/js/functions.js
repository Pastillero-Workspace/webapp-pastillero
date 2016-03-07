function loadPreferences(a){		
  	// una vez cargado los datos dentro del contexto se filtran los permisos
	console.log("loadPreferences done");
  	var jsona = a;
  	var obj = jQuery.parseJSON(jsona);
    $.each(obj, function() {
    	var exp = $.trim('#'+this['clave']);
    	if(typeof this["clave"] !== 'undefined' && this["clave"] !== null)
    		if (exp.length){  			 
    			$(exp).show(); 
    			//console.log(this["clave"]+"---"+this["descripcion"]);
    		}
    			
	    });	
}
function rstPreferences(b){	
	// disable div update restrctions 
	$("#update-restrictions").hide();
  	console.log("rstPrefences done");
  	var jsonb = b;
  	var obj = jQuery.parseJSON(jsonb);	
    $.each(obj, function() {
    	var exp = $.trim('#'+this['clave']);
    	if(typeof this["clave"] !== 'undefined' && this["clave"] !== null)
    			$(exp).hide();
    });	
    
  }

function checkEnabledRestriction(a,b){
	  console.log("check Permision is: "+ a);
		if(a != null && a > 0 && b != null){
			window.location.replace("errorpermisos.jsp");
		}	
}
