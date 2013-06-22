<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
function adicionar() {
	  var data = $('#dataLancamento').val();
	  var motivo = $('#motivoLancamento').val();
	  var contaOrigem = $('#contaOrigem');
	  var idContaOrigem = contaOrigem.val();
	  var contaDestino = $('#contaDestino');
	  var idContaDestino = contaDestino.val();
	  var valor = $('#valor').val();
	  	  
	  $.ajax({  
	    type: "POST",  
	    url: "salvaTransferencia",  
	    data: "idContaOrigem=" + idContaOrigem + "&idContaDestino=" + idContaDestino + "&data=" + data 
	    + "&motivoLancamento=" + motivo + "&valorLancamento=" + valor,  
	    success: function(response){  
	      window.location = "listagemTransferencias";
	      alert("Registro salvo com sucesso!");
	    },  
	    error: function(e){
	    	alert('confirm');
	      alert('Error: ' + e);  
	    }  
	  });
	}

function habilitarCampos(id) {
	var contador = 0;
	$("#linha_" + id).find('td').each(function() {
		var value = $(this).text();
		
		if (contador == 0) {
			$(this).html("<input style='height:40px;font-size:13pt;' class='input-large' placeholder='Data' type='date' maxlength='8' id='dataLancamento' value='" + value + "'/>");			
		} else if (contador == 1) {
			$(this).html("<input style='height:40px;font-size:13pt;' class='input-large' class='input-large' type='text' placeholder='Motivo' maxlength='50' id='motivoLancamento' value='" + value + "'/>");
		} else if (contador == 2) {
			$(this).html("<select id='contaOrigem2' style='height:40px;font-size:13pt;' class='input-large'></select>");
		} else if (contador == 3) {
			$(this).html("<select id='contaDestino2' style='height:40px;font-size:13pt;' class='input-large'></select>");
		} else if (contador == 4) {
			$(this).html("<input style='height:40px;font-size:13pt;' class='input-large' class='input-large' type='text' placeholder='Valor' id='valor' value='" + value + "'/>");
		}
		contador++;
	});

	
	$('#data').mask('99/99/9999');
	
	$('#contaOrigem').find('option').clone().appendTo('#contaOrigem2');
	$('#contaDestino').find('option').clone().appendTo('#contaDestino2');
	$("#editar_" + id).html("<input type='button' class='btn btn-primary' onclick='editar(" + id + ")' style='font-weight: bold;font-size:15pt;' value='+' />");
};

function editar(id) {
	var data; 
	var motivo;
	var idContaOrigem;
	var idContaDestino;
	var valor;
	
	data = $("#linha_" + id).find('input[type="date"]').val();
 
	var contador = 0;
	$("#linha_" + id).find('input[type="text"]').each(function() {
		if (contador == 0) {
			motivo = $(this).val();
		} else if (contador == 1) {
			valor = $(this).val();
		}
		contador++;
	});
	idContaOrigem = $("#contaOrigem2").val();
	idContaDestino = $("#contaDestino2").val();

	$.ajax({  
	    type: "POST",  
	    url: "editaTransferencia",  
	    data: "idContaOrigem=" + idContaOrigem + "&idContaDestino=" + idContaDestino + "&data=" + data 
	    + "&codLancamento=" + id + "&motivoLancamento=" + motivo + "&valorLancamento=" + valor,  
	    success: function(response){  
	      window.location = "listagemTransferencias";
	      alert("Registro editado com sucesso!");
	    }  
	  });
};

function excluir(id) {
	if (confirm("Realmente deseja excluir?")) {
	  $.ajax({  
	    type: "POST",  
	    url: "excluiTransferencia",  
	    data: "idTransferencia=" + id,
	    success: function(response) {  
	    	window.location = "listagemTransferencias";
			alert("Registro excluído com sucesso!");
	    }  
	  });
	}
};	

    $(function(){
//     	$("#valor").maskMoney({symbol:'R$ ',showSymbol:true, thousands:'.', decimal:',', symbolStay: true});

    		$('#data').mask('99/99/9999');
    });
    	$(document).ready(function(){
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
		            <tr id="linha_${transferencia.codLancamento}">
			            <td><fmt:formatDate value="${transferencia.dataLancamento}" type="both" pattern="dd/MM/yyyy" /></td>
			            <td>${transferencia.motivoLancamento}</td>
			            <td>${transferencia.contaCorrente.banco.nomeBanco} - ${transferencia.contaCorrente.numeroAgencia} - ${transferencia.contaCorrente.numeroConta}</td>
			            <td>${transferencia.contaDestino.banco.nomeBanco} - ${transferencia.contaDestino.numeroAgencia} - ${transferencia.contaDestino.numeroConta}</td>
			            <td>${transferencia.valorLancamento}</td>
			            <td>
			            	<span id="editar_${transferencia.codLancamento}"><input type="button" class="btn btn-primary" id="${transferencia.codLancamento}" onclick="habilitarCampos(this.id)" style="font-weight: bold;" value=">" /></span>
			            	<span id="excluir"><input type="button" class="btn btn-danger" id="${transferencia.codLancamento}" onclick="excluir(this.id)" style="font-weight: bold;font-size:15pt;" value="-" /></span>
			            </td>
		            </tr>
	            </c:forEach>
	         </tbody>
	       </table>
	    </div>
    </div>
    <form name="cadastro_transferencia">
       <input style="height:40px;font-size:13pt;" class="input-large" placeholder="Data" type="date" maxlength="8" id="dataLancamento">
	   <input style="height:40px;font-size:13pt;" class="input-large" class="input-large" type="text" placeholder="Motivo" maxlength="50" id="motivoLancamento">
	     <select id="contaOrigem" style="height:40px;font-size:13pt;" class="input-large">
			<c:forEach var="conta" items="${contas}">
				<option value="${conta.codConta}">${conta.banco.nomeBanco} - ${conta.numeroAgencia} - ${conta.numeroConta}</option>
			</c:forEach>
		</select> 
	    <select id="contaDestino" style="height:40px;font-size:13pt;" class="input-large">
			<c:forEach var="conta" items="${contas}">
				<option value="${conta.codConta}">${conta.banco.nomeBanco} - ${conta.numeroAgencia} - ${conta.numeroConta}</option>
			</c:forEach>
		</select> 
	    <input style="height:40px;font-size:13pt;" class="input-large" class="input-large" type="text" placeholder="Valor" id="valor">
		<input type="button" class="btn btn-success" onclick="adicionar()" style="font-weight: bold;font-size:15pt;" value="+"/>
	</form>
</body>