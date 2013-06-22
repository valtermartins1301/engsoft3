<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
function doAjaxPost() {
	  var numeroAgencia = $('#numeroAgencia').val();
	  var numeroConta = $('#numeroConta').val();
	  var comboBancos = $('#comboBancos');
	  var idBanco = comboBancos.val();
	  var nomeBanco = comboBancos.find('option').filter(':selected').text();
	  
	  $.ajax({  
	    type: "POST",  
	    url: "salvaConta",  
	    data: "idBanco=" + idBanco + "&numeroAgencia=" + numeroAgencia + "&numeroConta=" + numeroConta,  
	    success: function(response) {
// 	      $('#agencia').val('');
// 	      $('#conta').val('');
	      
// 	      Adicionar(nomeBanco, numeroAgencia, numeroConta, response);
		  window.location = "listagemContas";
	      alert("Registro salvo com sucesso!");
	
	    },  
	    error: function(e){  
	      alert('Error: ' + e);  
	    }  
	  });
	}
	
function Adicionar(nomeBanco, numeroAgencia, numeroConta, idConta){
    $("#tabelaContas tbody").append(
        "<tr>"
        + "<td>" + nomeBanco + "</td>"
        + "<td>" + numeroAgencia + "</td>"
        + "<td>" + numeroConta + "</td>"
        + "<td>" 
        + "<input type='button' class='btn btn-primary btnEditar' style='font-weight: bold;font-size:15pt;' value='>' />"
 		+ "<input type='button' class='btn btn-danger btnExcluir' style='font-weight: bold;font-size:15pt;' value='-' />" 
 		+ "<input type='hidden' name='idConta' value='" + idConta + "' />"
    	+ "</td>"
    	+ "</tr>");
  		
    	$(".btnEditar").on("click", habilitarCampos);
    	$(".btnExcluir").on("click", Excluir);
};

function habilitarCampos(id) {
// 	alert(id);
// 	return;
		var contador = 0;
	$("#linha_" + id).find('td').each (function() {
		var value = $(this).text();
		
		if (contador == 0) {
			$(this).html("<select id='comboBancos2'></select>");			
		} else if (contador == 1) {
			$(this).html("<input type='text' style='height:40px;font-size:13pt;' id='txtTelefone' value='"+value+"'/>");
			
		} else if (contador == 2) {
			$(this).html("<input type='text' style='height:40px;font-size:13pt;' id='txtTelefone' value='"+value+"'/>");
		}
		contador++;
		});
	$('#comboBancos').find('option').clone().appendTo('#comboBancos2');
	$("#editar_" + id).html("<input type='button' class='btn btn-primary' onclick='Editar(" + id + ")' style='font-weight: bold;font-size:15pt;' value='+' />");
	
	
// 	var par = $(this).parent().parent(); //tr
// 	 var tdBanco = par.children("td:nth-child(1)");
// 	 var tdNumeroAgencia = par.children("td:nth-child(2)");
// 	 var tdNumeroConta = par.children("td:nth-child(3)");
// 	 var tdOpcoes = par.children("td:nth-child(4)");
	 
// 	 var hidden = $(this).parent().find('input[name="idConta"]');
// 	 var idConta = hidden.val();
	 
// 	 tdBanco.html("<select id='comboBancos' style='height:40px;font-size:13pt;'><c:forEach var='banco' items='${bancos}'><option value='${banco.codBanco}'>${banco.nomeBanco}</option></c:forEach></select>");
// 	 tdNumeroAgencia.html("<input type='text' style='height:40px;font-size:13pt;' id='txtTelefone' value='"+tdNumeroAgencia.html()+"'/>");
// 	 tdNumeroConta.html("<input type='text' style='height:40px;font-size:13pt;' id='txtEmail' value='"+tdNumeroConta.html()+"'/>");
// 	 tdOpcoes.html("<input type='button' class='btn btn-primary btnSalvar' style='font-weight: bold;font-size:15pt;' value='+' /><input type='button' class='btn btn-danger btnExcluir' style='font-weight: bold;font-size:15pt;' value='-' /><input type='hidden' name='idConta' value='" + idConta + "' />");
	 
// 	 $(".btnSalvar").on("click", Editar);
// 	 $(".btnExcluir").on("click", Excluir);
};

function Editar(id) {
// 	var $this = $(this); 
// 	 var par = $this.parent().parent(); //tr
// 	 var tdBanco = par.children("td:nth-child(1)");
// 	 var tdNumeroAgencia = par.children("td:nth-child(2)");
// 	 var tdNumeroConta = par.children("td:nth-child(3)");
// 	 var tdOpcoes = par.children("td:nth-child(4)");
	 
// 	 var numeroAgencia = tdNumeroAgencia.find("input[type='text']").val();
// 	 var numeroConta = tdNumeroConta.find("input[type='text']").val();
	 
// 	 var hidden = $this.parent().find('input[name="idConta"]');
// 	 var idConta = hidden.val();
	  
// 	 var comboBancos = par.find('#comboBancos');
// 	 var idBanco = comboBancos.val();
// 	 var nomeBanco = comboBancos.find('option').filter(':selected').text();
	 
	 //Exemplo de validação
// 	if(!$.trim($('#nome').val()).length){
// 	    $('#nome').addClass("erroInputVazio"); 
// 	     mensagemAlerta("Campo Nome em branco","red");
// 	  }
	 
	 
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

	  $.ajax({  
	    type: "POST",  
	    url: "editaConta",  
	    data: "idBanco=" + idBanco + "&codConta=" + id + "&numeroAgencia=" + numeroAgencia + "&numeroConta=" + numeroConta,  
	    success: function(response) {
	      
// 	      tdNumeroAgencia.html(numeroAgencia);
// 	      tdNumeroConta.html(numeroConta);
// 	      tdBanco.html(nomeBanco);
// 	      tdOpcoes.html("<input type='button' class='btn btn-primary btnEditar' style='font-weight: bold;font-size:15pt;' value='>' /><input type='button' class='btn btn-danger btnExcluir' style='font-weight: bold;font-size:15pt;' value='-' />");
	      window.location = "listagemContas";
	      alert("Registro editado com sucesso!");
	    },  
	    error: function(e){  
	      alert('Error: ' + e);  
	    }  
	  });
};

function Excluir(id){
	  if (confirm("Realmente deseja excluir?")) {
		  var $this = $(this);
		  var hidden = $this.parent().find('input[name="idConta"]');
		  var idConta = hidden.val();
		   
		  $.ajax({  
		    type: "POST",  
		    url: "excluiConta",  
		    data: "idConta=" + id,
		    success: function(response){  
// 				var par = $this.parent().parent(); //tr
// 			    par.remove();
				window.location = "listagemContas";
				alert("Registro editado com sucesso!");
		    },  
		    error: function(e){  
		      alert('Error: ' + e);  
		    }  
		  });
	  }
};

$(function(){
// 	$(".btnExcluir").on("click", Excluir);
// 	$(".btnEditar").on("click", habilitarCampos);
// 	$("#btnCadastrar").on("click", doAjaxPost);
// 	$('.inputagencia').numberMask({beforePoint:8});
// 	$('.inputconta').numberMask({beforePoint:8});
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
	             <th>Agência</th>
	             <th>Conta</th>
	             <th>Opções</th>
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
							<span id="excluir"><input type="button" class="btn btn-danger btnExcluir" id="${conta.codConta}" onclick="Excluir(this.id)" style="font-weight: bold;font-size:15pt;" value="-" /></span>
<%-- 							<input type="hidden" name="idConta" value="${conta.codConta}" />  --%>
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
	   	<input class="input-large inputagencia" style="height:40px;font-size:13pt;" type="number" placeholder="Agência" maxlength="8" id="numeroAgencia"/>
	    <input class="input-large inputconta" style="height:40px;font-size:13pt;" type="number" placeholder="Conta" maxlength="8" id="numeroConta"/>
		<input id="btnCadastrar" type="button" class="btn btn-success" onclick="doAjaxPost()" style="font-weight: bold;font-size:15pt;" value="+"/>
	</form>
</body>