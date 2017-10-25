<!-- #include file=conexion.asp -->

<%
		idavion=request.querystring("id_avion")
		avion=request.querystring("avion")
		nplazas=request.querystring("nplazas")
		precio=request.querystring("precio")
		
		SentenciaSQL = "update AVION set AVION = '" &avion& "', N_PLAZAS = " &nplazas& ", PRECIO_BASE = " &precio& " where IDAVION=" & idavion

		set rs = Conexion.Execute(SentenciaSQL)

		response.write("El avión se modificado con exito")
		'response.write("update AVION set AVION = '" &avion& "', N_PLAZAS = " &nplazas& ", PRECIO_BASE = " &precio& " where IDAVION=" & idavion)

%>    