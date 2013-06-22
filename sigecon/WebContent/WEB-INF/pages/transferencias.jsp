<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
function doAjaxPost() {
	  // get the form values  
	  var data = $('#dataLancamento').val();
	  var motivo = $('#motivoLancamento').val();
	  var contaOrigem = $('#contaOrigem');
	  var idContaOrigem = contaOrigem.val();
	  var contaDestino = $('#contaDestino');
	  var idContaDestino = contaDestino.val();
	  var valor = $('#valor').val();
	  var nomeContaOrigem = contaOrigem.find('option').filter(':selected').text();
	  var nomeContaDestino = contaOrigem.find('option').filter(':selected').text();
	  	  
	  $.ajax({  
	    type: "POST",  
	    url: "cadastraTransferencia",  
	    data: "dataLancamento=" + data + "&motivoLancamento=" + motivo + "&contaOrigem=" + idContaOrigem + "&contaDestino=" + idContaDestino
	    + "&valorLancamento=" + valor,  
	    success: function(response){  
	      // we have the response  
// 	      alert('confirm');
	      $('#info').html(response);
	      $('#dataLancamento').val('');
	      $('#motivoLancamento').val('');
	      $('#contaOrigem').val('');
	      $('#contaDestino').val('');
	      $('#valor').val('');	      
	      
	      Adicionar(data, motivo, nomeContaOrigem, nomeContaDestino, valor, response);
	      alert("Registro salvo com sucesso!");
	    },  
	    error: function(e){
	    	alert('confirm');
	      alert('Error: ' + e);  
	    }  
	  });
	}
	
function Adicionar(data, motivo, nomeContaOrigem, nomeContaDestino, valor, idTransferencia){
    $("#tabelaTransferencias tbody").append(
        "<tr>"+
        "<td>" + data + "</td>"+
        "<td>" + motivo + "</td>"+
        "<td>" + nomeContaOrigem + "</td>"+
        "<td>" + nomeContaDestino + "</td>"+
        "<td>" + valor + "</td>"
        + "<td>" 
        + "<input type='button' class='btn btn-primary btnEditar' style='font-weight: bold;font-size:15pt;' value='>' />"
 		+ "<input type='button' class='btn btn-danger btnExcluir' style='font-weight: bold;font-size:15pt;' value='-' />" 
 		+ "<input type='hidden' name='idConta' value='" + idTransferencia + "' />"
 		+"</td>"+
        "</tr>");
};


function habilitarCampos() {
	
};

function Editar() {
	 
};

function Excluir(){
	if (confirm("Realmente deseja excluir?")) {
	  var $this = $(this);
	  var hidden = $this.parent().find('input[name="idTransferencia"]');
	  var idTransferencia = hidden.val();
	   
	  $.ajax({  
	    type: "POST",  
	    url: "excluiTransferencia",  
	    data: "idTransferencia=" + idTransferencia,
	    success: function(response){  
			var par = $this.parent().parent(); //tr
		    par.remove();
	    },  
	    error: function(e){  
	      alert('Error: ' + e);  
	    }  
	  })
	};
};

    $(function(){
    	$("#btnCadastrar").on("click", doAjaxPost);
    	$(".btnExcluir").on("click", Excluir);
    	$(".btnEditar").on("click", habilitarCampos);
    	$('.inputagencia').numberMask({beforePoint:8});
    	$('.inputconta').numberMask({beforePoint:8});
//     	$("#valor").maskMoney({symbol:'R$ ',showSymbol:true, thousands:'.', decimal:',', symbolStay: true});});
//     	$(document).ready(function(){$('#data').mask('99/99/9999');
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
		            <td><input type='button' class='btn btn-primary btnEditar' style="font-weight: bold;" value='>' />
		            <input type="button" class="btn btn-danger btnExcluir" style="font-weight: bold;font-size:15pt;" value="-" />
		            <input type="hidden" name="idTransferencia" value="${transferencia.codLancamento}" />
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
	     <select id="contaOrigem" style="height:40px;font-size:13pt;" class="input-large" >
	        <option disabled selected style='display:none;'>Conta Origem</option><selected>
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
	    <input style="height:40px;font-size:13pt;" class="input-large" class="input-large" type="text" placeholder="Valor" id="valor">
		<input id="btnCadastrar" type="button" class="btn btn-success" style="font-weight: bold;font-size:15pt;" value="+"/>
<!-- 		<button class="btn btn-success" onclick="doAjaxPost()" value="Cadastrar"><i class="icon-plus icon-white"></i></button> -->
	</form>
</body>