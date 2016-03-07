<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
        <title>Pastillero | Inicio de sesión </title>
        <meta name="description" content="Pastillero Login" />
        <link rel="shortcut icon" href="../favicon.ico"> 
        <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet" type="text/css">
        <link href="<c:url value="/resources/css/font-awesome.css" />" rel="stylesheet" type="text/css">
         <script src="<c:url value="/resources/js/jquery-1.10.2.js" />"></script>
         <script src="<c:url value="/resources/js/DOMinit.js" />"></script> 
       	<script type = "text/javascript" >
					function disableBackButton()
					{
					window.history.forward();
					}
					setTimeout("disableBackButton()",0);
	                 
					$(document).ready(function(){
					$("input").click(function() {
						   $("#message").hide(300);
						});
					});
      	</script>         
    </head>
    <body onunload="disableBackButton()" onload="loadpagesession()" >
        <div class="container">		<!-- Contenedor principal -->
			<!--top bar -->
            <div class="codrops-top">
                <span class="right">
                </span>
            </div><!--/ top bar -->			
			<div class="img">					
			</div>	
			<section class="main">
				<form id="login"class="form-2" method="post" action="login.jr" >			
					<h1><span class="log-in">Sesión de usuario</span></h1>
					<div class="clearfix">
							<div  class="float-left" >
								<p>
									<label for="login"><i class="icon-user"></i>Usuario</label>
									<input id="userName" type="text" name="userName" required >
									<input id="s" type="hidden" name="s" value="0">
								</p>
							</div>
							<div  class="float-left" >
								<p>
									<label for="password"><i class="icon-lock"></i>Clave</label>
									<input id="userPassword"type="password" name="userPassword" required >							
								</p>
							
							</div>
							<div class="float-right">
								<p ><input type="submit" name="submit" value="Ingresar" id="sub"> </p>
							</div>
						
					</div>
				</form>​​
			</section>
			<div id="message" class="codrops-demos">
			<c:if test="${not empty message}">
				    <p>${message}</p>
			</c:if></div>
			<footer class="codrops-demos" >
			<!-- Information if user is sesion not closed -->
			<div id="1">
				<p id="p1"></p>
				<p id="p2"></p>
			</div>
			<!-- Information if ticket is crashed or closed -->
			<div id="2">
				<p id="p3"></p>
			</div>
					<p>Sistema Integral Farmaceútico SIF 4.0 | Derechos Reservados 2014 | Microtek ED</p>
					<p>Farmacias El Pastillero S.A de C.V</p>
			</footer>
        </div>		
    </body>
</html>
