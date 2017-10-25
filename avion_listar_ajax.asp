<!-- #include file=conexion.asp -->
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
	</head>

	
	<script type="text/javascript">

	// Creamos el objeto AJAX httprequest
	function AJAXCrearObjeto()
	{
		var obj;
		if (window.XMLHttpRequest) 
		{ // no es IE
			obj = new XMLHttpRequest();
			//alert('El navegador no es IE');
		} 
		else 
		{ // Es IE o no tiene el objeto
			try 
			{
				obj = new ActiveXObject("Microsoft.XMLHTTP");
				// alert('El navegador utilizado es IE');
			}
			catch(e)
			{
				//alert('El navegador utilizado no está soportado');
			}
		}
		//alert('realizado');
		return obj;
	}

	function mostrar_avion()
	{
		var valorx=arguments[0];
		oXML = AJAXCrearObjeto();
		oXML.open('GET','./consulta_tabla_editar_avion.asp?IDAVION='+valorx,true);
		oXML.onreadystatechange = leerDatos;
		oXML.send('');
	}

	// Recibe y muestra los vuelos que pertenecen al avion seleccionado
	function leerDatos()
	{
		if(oXML.readyState == 4 && oXML.status==200)
		{
			document.getElementById("tAvion").innerHTML=oXML.responseText;
			if(oXML.responseText=="NULL")
			{
				alert("No hay resultados");
			}
		} 
	}

	function modifica()
	{
		var id_avion=document.getElementById("cel_id").innerHTML;
		//alert(id_avion);
		var avion=document.getElementById("cel_nom").innerHTML;
		//alert(avion);
		var nplazas=document.getElementById("cel_np").innerHTML;
		//alert(nplazas);
		var precio=document.getElementById("cel_pb").innerHTML;
		//alert(precio);
		oXML = AJAXCrearObjeto();
		oXML.open('GET','./consulta_update_BD_avion.asp?id_avion='+id_avion+'&avion='+avion+'&nplazas='+nplazas+'&precio='+precio,true);
		oXML.onreadystatechange = actualiza;
		oXML.send('');
		//actualizaTabla;
	}  

	function actualiza()
	{
		if(oXML.readyState == 4 && oXML.status==200)
		{
			alert(oXML.responseText);
		}
	}	

	function actualizaTabla()
	{
		oXML = AJAXCrearObjeto();
		oXML.open('GET','./consulta_tabla_aviones.asp',true);
		oXML.onreadystatechange = actualiza2;
		oXML.send('');
	}  

	function actualiza2()
	{
		if(oXML.readyState == 4 && oXML.status==200)
		{
			document.getElementById("Taviones").innerHTML=oXML.responseText;
		}
	}

</script>	




Seleccione un avión;
	<body>
		<table id=Taviones border="2">
			<tr>
				<td>ID</td>
				<td>AVIÓN</td>
				<td>PLAZAS</td>
				<td>PRECIO BASE</td>
			</tr>
			<%
				set resultado = Conexion.Execute("select IDAVION,AVION,N_PLAZAS, PRECIO_BASE from AVION")
				'recorremos el recordset
				do while not resultado.EOF
					response.write("<tr style=""cursor:pointer"" onclick=""return mostrar_avion("& resultado("IDAVION") & ");""><td>" & resultado("IDAVION") & "</td><td> " & resultado("AVION") & " </td><td><center>" & resultado("N_PLAZAS") & "</td><td>" & resultado("PRECIO_BASE") & "</td></tr> ")
					'nos desplazamos por el recordset
					resultado.movenext
				loop
			%>
			<tr>
			</tr>
			<tr>
			</tr>
			<tr>
			</tr>
			<tr>
				<td colspan=4> 
					<center>
						<input type="button" onclick="window.location.href='inicio.asp'" value="Salir">
				
						<input type="button" onclick="window.location.href='avion_nuevo.asp'" value="Nuevo">
						
						<input type="button" onclick="actualizaTabla()" value="Refrescar">
					</center> 
				</td>
			</tr>
		</table>
		<br>
		<br>
		<br>
		<table id="tAvion" name="TAvion" border=1 > 
		</table>
	<% Conexion.Close %>
	</body>
</html>

