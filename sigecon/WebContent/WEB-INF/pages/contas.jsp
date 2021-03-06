<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
function adicionar() {
	  var numeroAgencia = $('#numeroAgencia').val();
	  var numeroConta = $('#numeroConta').val();
	  var comboBancos = $('#comboBancos');
	  var idBanco = comboBancos.val();

	  if (validarCampos(numeroConta, numeroAgencia)) {
		  $.ajax({  
		    type: "POST",  
		    url: "salvaConta",  
		    data: "idBanco=" + idBanco + "&numeroAgencia=" + numeroAgencia + "&numeroConta=" + numeroConta,  
		    success: function(response) {
		      if (response == "sucesso") {
				  window.location = "listagemContas";
			      alert("Registro salvo com sucesso!");
		      }
		    }  
		  });
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
				$(this).html("<select id='comboBancos2' style='height:40px;font-size:13pt;'></select>");			
			} else if (contador == 1) {
				$(this).html("<input class='input-large inputagencia' type='text' style='height:40px;font-size:13pt;' value='" + value + "'/>");
			} else if (contador == 2) {
				$(this).html("<input class='input-large inputconta' type='text' style='height:40px;font-size:13pt;' value='" + value + "'/>");
			}
			contador++;
			});
		
		$('.inputagencia').mask('00000000');
		$('.inputconta').mask('00000000');
		$('#comboBancos').find('option').clone().appendTo('#comboBancos2');
		$("#editar_" + id).html("<input type='button' class='btn btn-primary' onclick='editar(" + id + ")' style='font-weight: bold;font-size:15pt;' value='+' />");
	}
};

function editar(id) {	 
	 	var numeroAgencia; 
	 	var numeroConta;
	 	var idBanco;
	 	
	 	var contador = 0;
		$("#linha_" + id).find('input[type="text"]').each(function() {
			if (contador == 0) {
				numeroAgencia = $(this).val();
			} else if (contador == 1) {
				numeroConta = $(this).val();
			}
			contador++;
		});
		idBanco = $("#comboBancos2").val();
	
		if (validarCampos(numeroConta, numeroAgencia)) {
		  $.ajax({  
		    type: "POST",  
		    url: "editaConta",  
		    data: "idBanco=" + idBanco + "&codConta=" + id + "&numeroAgencia=" + numeroAgencia + "&numeroConta=" + numeroConta,  
		    success: function(response) {
				if (response == "sucesso") {
			    	window.location = "listagemContas";
			        alert("Registro editado com sucesso!");
				}
		    }  
		  });			
		}
		
};

function excluir(id){
	  if (confirm("Realmente deseja excluir?")) {
		  $.ajax({  
		    type: "POST",  
		    url: "excluiConta",  
		    data: "idConta=" + id,
		    success: function(response){ 
		    	if (response == "erroAssociacao") {
					alert("N�o � poss�vel excluir uma conta que est� associada a um ou mais lan�amentos. Delete os lan�amentos associados primeiro.");		    		
		    	} else if (response == "sucesso") {
					window.location = "listagemContas";
					alert("Registro exclu�do com sucesso!");
		    	} 
		    } 
		  });
	  }
};

function validarCampos(numeroConta, numeroAgencia) {
	var mensagem = "";
	
	if (numeroConta == "") {
		mensagem = mensagem + "O campo n�mero da conta n�o pode estar em branco!\n";
	}
	
	if (numeroAgencia == "") {
		mensagem = mensagem + "O campo n�mero da ag�ncia n�o pode estar em branco!\n";
	}
	
	if (mensagem != "") {
		alert("Os seguintes erros foram encontrados:\n" + mensagem);
		return false;
	}
	
	return true;
};

$(function(){
	$('.inputagencia').mask('00000000');
	$('.inputconta').mask('00000000');
});
</script>
<body>
    <div class="well well-large" align="justify">
	    <h3 align="center">Gerenciamento de Contas</h1>
	    <div align="justify">
	       <table id="tabelaContas" class="table table-with-borderradius">
	         <thead>
	           <tr>
	             <th>Banco</th>
	             <th>Ag�ncia</th>
	             <th>Conta</th>
	             <th>Op��es</th>
	             </tr>
	         </thead>
		     	<tbody>
	         	<c:forEach var="conta" items="${contas}">
					<tr id="linha_${conta.codConta}">
						<td>${conta.banco.nomeBanco}</td>
						<td>${conta.numeroAgencia}</td>
						<td>${conta.numeroConta}</td>
						<td>
							<span id="editar_${conta.codConta}"><input type='button' class='btn btn-primary btnEditar' id="${conta.codConta}" onclick="habilitarCampos(this.id)" style="font-weight: bold;" value='>' /></span>	
							<span id="excluir"><input type="button" class="btn btn-danger btnExcluir" id="${conta.codConta}" onclick="excluir(this.id)" style="font-weight: bold;font-size:15pt;" value="-" /></span>
						</td>
					</tr>
				</c:forEach>
		     	</tbody>
	         </table>
	    </div>
    </div>
    <form name="cadastro_conta">
	    <select id="comboBancos" style="height:40px;font-size:13pt;">
	    	<c:forEach var="banco" items="${bancos}">
		        <option value="${banco.codBanco}">${banco.nomeBanco}</option>
	    	</c:forEach>
		</select>
	   	<input class="input-large inputagencia" style="height:40px;font-size:13pt;" type="text" placeholder="Ag�ncia" maxlength="8" id="numeroAgencia"/>
	    <input class="input-large inputconta" style="height:40px;font-size:13pt;" type="text" placeholder="Conta" maxlength="8" id="numeroConta"/>
		<input id="btnCadastrar" type="button" class="btn btn-success" onclick="adicionar()" style="font-weight: bold;font-size:15pt;" value="+"/>
	</form>
</body>