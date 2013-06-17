<script type="text/javascript">
function doAjaxPost() {
	  // get the form values  
	  var data = $('#dataLancamento').val();
	  var motivo = $('#motivoLancamento').val();
	  var contaOrigem = $('#idContaOrigem').val();
	  var contaDestino = $('#idContaDestino').val();
	  var valor = $('#valorLancamento').val();
	   
	  $.ajax({  
	    type: "POST",  
	    url: "cadastrarTransferencia",  
	    data: "dataLancamento=" + data + "&motivoLancamento=" + motivo + "&idContaOrigem=" + contaOrigem + "&idContaDestino=" + contaDestino
	    + "&valorLancamento=" + valor,  
	    success: function(response){  
	      // we have the response  
	      $('#info').html(response);
	      $('#dataLancamento').val('');
	      $('#motivoLancamento').val('');
	      $('#idContaOrigem').val('');
	      $('#idcontaDestino').val('');
	      $('#valorLancamento').val('');	      
	      
	      Adicionar(data, motivo, contaOrigem, contaDestino, valor);
	    },  
	    error: function(e){  
	      alert('Error: ' + e);  
	    }  
	  });
	}
	
function Adicionar(data, motivo, contaOrigem, contaDestino, valor){
    $("#tabelaTransferencias tbody").append(
        "<tr>"+
        "<td>" + data + "</td>"+
        "<td>" + motivo + "</td>"+
        "<td>" + + "</td>"+
        "<td>" + + "</td>"+
        "<td>" + valor + "</td>"+
        "<td>" + "<a class='btn btn-primary' href='#'><i class='icon-chevron-right icon-white'></i></a>"
//         <a class='btn btn-danger' href='#'><i class='icon-minus icon-white'></i></a>" 
 		+ "<input type='button' class='btn btn-danger btnExcluir' value='Excluir' />"
    	+"</td>"+
        "</tr>");
};


// $("#tabelaContas .btnExcluir").on("click", function() {
// 	var par = $(this).parent().parent(); //tr
//     par.remove();	
// });

function Excluir(){
	  var $this = $(this);
	  var hidden = $this.parent().find('input[name="idConta"]');
	  var idConta = hidden.val();
	   
	  $.ajax({  
	    type: "POST",  
	    url: "excluirConta",  
	    data: "idConta=" + idConta,
	    success: function(response){  
			var par = $this.parent().parent(); //tr
		    par.remove();
	    },  
	    error: function(e){  
	      alert('Error: ' + e);  
	    }  
	  });
};

$(function(){
	$(".btnExcluir").on("click", Excluir);
});

</script>

<body>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
     <div class="navbar" align="center">
  		<div class="navbar-inner" align="center">
    		<ul class="nav" align="center">
		      <li  class="divider-vertical"><a href="#">Entradas</a></li>
		      <li  class="divider-vertical"><a href="#">Saídas</a></li>
		  	  <li  class="divider-vertical"><a href="#">Cheques</a></li>
		  	  <li class="active"><a href="listagemTransferencias">Transferências entre C.C.</a></li>
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
	       <table id="tabelaTransferencias" class="table table-with-borderradius">
	         <thead>
	           <tr>
	             <th>Data</th>
	             <th>Motivo</th>
	             <th>Conta Origem</th>
	             <th>Conta Destino</th>
	             <th>Valor</th>
	             <th>Opções</th>
	             </tr>
	         </thead>
	         <tbody>
	            <c:forEach var="transferencia" items="${transferencias}">
	            <tr>
		            <td>${transferencia.dataLancamento}</td>
		            <td>${transferencia.motivoLancamento}</td>
		            <td>${transferencia.contaCorrente.banco.nomeBanco} - ${transferencia.contaCorrente.numeroAgencia} - ${transferencia.contaCorrente.numeroConta}</td>
		            <td>${transferencia.contaDestino.banco.nomeBanco} - ${transferencia.contaDestino.numeroAgencia} - ${transferencia.contaDestino.numeroConta}</td>
		            <td>${transferencia.valorLancamento}</td>
		            <td><a class="btn btn-primary" href="#"><i class="icon-chevron-right icon-white"></i></a><a class="btn btn-danger" href="#"><i class="icon-minus icon-white"></i></a></td>
	            </tr>
	            </c:forEach>
	            	</tbody>
	            </table>
	    </div>
    </div>
    <form name="cadastro_transferencia">
        <input style="height:40px;font-size:13pt;" class="input-large" type="date" placeholder="Data">
	    <input style="height:40px;font-size:13pt;" class="input-large" class="input-large" type="text" placeholder="Motivo">
	     <select style="height:40px;font-size:13pt;" class="input-large" >
	        <option id="contaOrigem" disabled selected style='display:none;'>Conta Origem</option><selected>
			<c:forEach var="transferencia" items="${transferencias}">
			<option value="${transferencia.contaCorrente.codConta}">${transferencia.contaCorrente.banco.nomeBanco} - ${transferencia.contaCorrente.numeroAgencia} - ${transferencia.contaCorrente.numeroConta}</option>
			</c:forEach>			
		</select> 
	    <select id="contaDestino" style="height:40px;font-size:13pt;" class="input-large">
	        <option disabled selected style='display:none;'>Conta Destino</option><selected>
			<c:forEach var="transferencia" items="${transferencias}">
			<option value="${transferencia.contaCorrente.codConta}">${transferencia.contaCorrente.banco.nomeBanco} - ${transferencia.contaCorrente.numeroAgencia} - ${transferencia.contaCorrente.numeroConta}</option>
			</c:forEach>
		</select> 
	    <input style="height:40px;font-size:13pt;" class="input-large" class="input-large" type="number" placeholder="Valor">
		<input id="btnCadastrar" type="button" class="btn btn-success" onclick="doAjaxPost()" value="Cadastrar"/>
<!-- 		<button class="btn btn-success" onclick="doAjaxPost()" value="Cadastrar"><i class="icon-plus icon-white"></i></button> -->
	</form>
</body>