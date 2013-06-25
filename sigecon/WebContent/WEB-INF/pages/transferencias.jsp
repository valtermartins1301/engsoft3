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
	  $('#valor').data('mask').remove();
	  var valor = $('#valor').val();
	  
	  if (validarCampos(data, motivo, idContaOrigem, idContaDestino, valor)) {
		  $('#dataLancamento').data('mask').remove();
		  data = $('#dataLancamento').val();
		  $.ajax({  
		    type: "POST",  
		    url: "salvaTransferencia",  
		    data: "idContaOrigem=" + idContaOrigem + "&idContaDestino=" + idContaDestino + "&data=" + data 
		    + "&motivoLancamento=" + motivo + "&valorLancamento=" + valor,  
		    success: function(response){
		      if (response == "sucesso") {
			      window.location = "listagemTransferencias";
			      alert("Registro salvo com sucesso!");
		      }
		    }  
		  });
	  }	else {
		  $('#valor').mask('000.000.000.000.000,00',{reverse: true});
		  $('#dataLancamento').mask('00/00/0000',{reverse: true});
	  }  
	};
	
var ativo = 0;
function habilitarCampos(id) {
	if (ativo == id || ativo == 0) {
		ativo = id;
		
		var contador = 0;
		$("#linha_" + id).find('td').each(function() {
			var value = $(this).text();
			
			if (contador == 0) {
				$(this).html("<input style='height:40px;font-size:13pt;' class='input-large' placeholder='Data' type='text' maxlength='8' id='dataLancamento' value='" + value + "'/>");			
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
	
		$('#valor').mask('000.000.000.000.000,00',{reverse: true});
		$('#dataLancamento').mask('00/00/0000',{reverse: true});
		$('#contaOrigem').find('option').clone().appendTo('#contaOrigem2');
		$('#contaDestino').find('option').clone().appendTo('#contaDestino2');
		$("#editar_" + id).html("<input type='button' class='btn btn-primary' onclick='editar(" + id + ")' style='font-weight: bold;font-size:15pt;' value='+' />");
	}
};

function editar(id) {
	var data; 
	var motivo;
	var idContaOrigem;
	var idContaDestino;
	$('#valor').data('mask').remove();
	var valor;
	
	data = $("#linha_" + id).find('input[id="dataLancamento"]').val();
 
	var contador = 0;
	$("#linha_" + id).find('input[type="text"]').each(function() {
		if (contador == 1) {
			motivo = $(this).val();
		} else if (contador == 2) {
			valor = $(this).val();
		}
		contador++;
	});
	idContaOrigem = $("#contaOrigem2").val();
	idContaDestino = $("#contaDestino2").val();

	if (validarCampos(data, motivo, idContaOrigem, idContaDestino, valor)) {
		$('#dataLancamento').data('mask').remove();
		data = $("#linha_" + id).find('input[id="dataLancamento"]').val();
		$.ajax({  
		    type: "POST",
		    url: "editaTransferencia",  
		    data: "idContaOrigem=" + idContaOrigem + "&idContaDestino=" + idContaDestino + "&data=" + data 
		    + "&codLancamento=" + id + "&motivoLancamento=" + motivo + "&valorLancamento=" + valor,  
		    success: function(response){  
		      if (response == "sucesso") {
			      window.location = "listagemTransferencias";
			      alert("Registro editado com sucesso!");
		      }
		    }  
		  });
	} else {
		$('#valor').mask('000.000.000.000.000,00',{reverse: true});
		$('#dataLancamento').mask('00/00/0000',{reverse: true});
	}
};

function excluir(id) {
	if (confirm("Realmente deseja excluir?")) {
	  $.ajax({  
	    type: "POST",  
	    url: "excluiTransferencia",  
	    data: "idTransferencia=" + id,
	    success: function(response) {  
			if (response == "sucesso") {
		    	window.location = "listagemTransferencias";
				alert("Registro excluído com sucesso!");
			}
	    }  
	  });
	}
};	

function validarCampos(dataLancamento, motivo, idContaOrigem, idContaDestino, valor) {
	var mensagem = "";
	var data="";
	
	if ((data=validarData(dataLancamento)) != ""){
	    mensagem += data;
	}
	
	if (dataLancamento == "") {
		mensagem += "O campo data de lançamento não pode estar em branco!\n";
	}
	
	if (motivo == "") {
		mensagem += "O campo motivo não pode estar em branco!\n";
	}
	
	if (idContaOrigem == idContaDestino) {
		mensagem += "Conta origem e destino não podem ser iguais!\n";
	}
	
	if (valor == "") {
		mensagem += "O campo valor não pode estar em branco!\n";
	}
	
	if (mensagem != "") {
		alert("Os seguintes erros foram encontrados:\n" + mensagem);
		return false;
	}
	
	return true;
};

function validarData(DATA) {
    var msgErro = 'Data inválida.\n';
    var mensagem = "";
    if ((DATA.length == 10) && (DATA !='')){
     var dia = DATA.substring(0,2);
     var mes = DATA.substring(3,5);
     var ano = DATA.substring(6,10);
     if(mes > 12) mensagem ="Mês inválido.\n";
     if(dia > 31) mensagem +="Dia inválido.\n";
     if((mes==04 && dia > 30) || (mes==06 && dia > 30) || (mes==09 && dia > 30) || (mes==11 && dia > 30)){
       mensagem +="Dia incorreto !!! O mês especificado contém no máximo 30 dias.\n";
       return mensagem;
     }else{ //1
       if(ano%4!=0 && mes==2 && dia>28){
    	 mensagem +="Data incorreta!! O mês especificado contém no máximo 28 dias.\n";
         return mensagem;
         } else{ //2
          if(ano%4==0 && mes==2 && dia>29){
           mensagem +="Data incorreta!! O mês especificado contém no máximo 29 dias.\n";
           return mensagem;
           } else{ //3
                return mensagem;
           } //3-else
         }//2-else
       }//1-else                       
   }else { //5
	 mensagem =msgErro;
     return mensagem;
  }//5-else
}

$(document).ready(function(){
	$('#dataLancamento').mask('00/00/0000',{reverse: true});	
	$('#valor').mask('000.000.000.000.000,00',{reverse: true});
	$('.valortransferencia').mask('000.000.000.000.000,00',{reverse: true}); 		
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
			            <td class="valortransferencia">${transferencia.valorLancamento}</td>
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
       <input style="height:40px;font-size:13pt;" class="input-large" placeholder="Data" type="text" maxlength="8" id="dataLancamento">
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