<body>
     <div class="navbar" align="center">
  		<div class="navbar-inner" align="center">
    		<ul class="nav" align="center">
		      <li  class="divider-vertical"><a href="lancamentos.jsp">Entradas</a></li>
		      <li  class="divider-vertical"><a href="#">Saídas</a></li>
		  	  <li  class="divider-vertical"><a href="#">Cheques</a></li>
		  	  <li class="active"><a href="transferencias.jsp">Transferências entre C.C.</a></li>
		  	  <li class="divider-vertical"><a href="#">Débito Automático</a></li>
		  	  <li  class="divider-vertical"><a href="#">Aplicações</a></li>
		  	  <li  class="divider-vertical"><a href="#">Resgates</a></li>
   		 	</ul>
  		</div>
	  </div>
    <div class="well well-large" align="justify">
	    <h3 align="center">Gerenciamento de Transferência Entre Contas Correntes</h3>
	    <br/>
	    <div align="justify">
	       <table class="table table-with-borderradius">
	         <thead>
	           <tr>
	             <th>Data</th>
	             <th>Motivo</th>
	             <th>Conta Origem</th>
	             <th>Conta Destino</th>
	             <th>Opções</th>
	             </tr>
	         </thead>
	         <tbody>
	            <tr>
		            <td>23/04/2013</td>
		            <td>teste</td>
		            <td>Santander 12-123-4232</td>
		            <td>Itau 122-123-4232</td>
		            <td>32.000</td>
		            <td><a class="btn btn-primary" href="#"><i class="icon-chevron-right icon-white"></i></a><a class="btn btn-danger" href="#"><i class="icon-minus icon-white"></i></a></td>
	            </tr>
	            <tr>
		            <td>26/05/2013</td>
		            <td>teste2</td>
		            <td>Santander 54-123-4232</td>
		            <td>Itau 122-187-4232</td>
		            <td>89.000</td>
		            <td><a class="btn btn-primary" href="#"><i class="icon-chevron-right icon-white"></i></a><a class="btn btn-danger" href="#"><i class="icon-minus icon-white"></i></a></td>
	            </tr>
	            	</tbody>
	            </table>
	    </div>
    </div>
    <form name="cadastro_conta">
        <input style="height:40px;font-size:13pt;" class="input-large" type="date" placeholder="Data">
	    <input style="height:40px;font-size:13pt;" class="input-large" class="input-large" type="text" placeholder="Motivo">
	     <select style="height:40px;font-size:13pt;" class="input-large" >
	        <option disabled selected style='display:none;'>Conta Origem</option><selected>
			<option>conta1</option>
			<option>conta2</option>
			<option>conta3</option>
		</select> 
	    <select style="height:40px;font-size:13pt;" class="input-large">
	        <option disabled selected style='display:none;'>Conta Destino</option><selected>
			<option>conta1</option>
			<option>conta2</option>
			<option>conta3</option>
		</select> 
	    <input style="height:40px;font-size:13pt;" class="input-large" class="input-large" type="number" placeholder="Valor">
		<a class="btn btn-success" href="#"><i class="icon-plus icon-white"></i></a>
	</form>
</body>