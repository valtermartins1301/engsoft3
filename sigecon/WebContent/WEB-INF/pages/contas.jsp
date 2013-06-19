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
	    url: "cadastrarConta",  
	    data: "idBanco=" + idBanco + "&numeroAgencia=" + numeroAgencia + "&numeroConta=" + numeroConta,  
	    success: function(response) {
	      $('#agencia').val('');
	      $('#conta').val('');
	      
	      Adicionar(nomeBanco, numeroAgencia, numeroConta);
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
    	+ "</td>"
    	+ "</tr>");
    
    	$(".btnExcluir").on("click", Excluir);
};

function Editar() {
	 var par = $(this).parent().parent(); //tr
	 var tdBanco = par.children("td:nth-child(1)");
	 var tdNumeroAgencia = par.children("td:nth-child(2)");
	 var tdNumeroConta = par.children("td:nth-child(3)");
	 var tdOpcoes = par.children("td:nth-child(4)");
	 
	 tdBanco.html("<select id='comboBancos' style='height:40px;font-size:13pt;'><c:forEach var='banco' items='${bancos}'><option value='${banco.codBanco}'>${banco.nomeBanco}</option></c:forEach></select>");
	 tdNumeroAgencia.html("<input type='text' style='height:40px;font-size:13pt;' id='txtTelefone' value='"+tdNumeroAgencia.html()+"'/>");
	 tdNumeroConta.html("<input type='text' style='height:40px;font-size:13pt;' id='txtEmail' value='"+tdNumeroConta.html()+"'/>");
	 tdOpcoes.html("<input type='button' class='btn btn-primary btnEditar' style='font-weight: bold;font-size:15pt;' value='+' /><input type='button' class='btn btn-danger btnExcluir' style='font-weight: bold;font-size:15pt;' value='-' />");
	 
	 $(".btnEditar").on("click", Editar);
	 $(".btnExcluir").on("click", Excluir);
};

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
	$(".btnEditar").on("click", Editar);
	$("#btnCadastrar").on("click", doAjaxPost);
	$('.inputagencia').numberMask({beforePoint:8});
	$('.inputconta').numberMask({beforePoint:8});
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
					<tr>
						<td>${conta.banco.nomeBanco}</td>
						<td>${conta.numeroAgencia}</td>
						<td>${conta.numeroConta}</td>
						<td>
							<input type='button' class='btn btn-primary btnEditar' style="font-weight: bold;" value='>' />	
							<input type="button" class="btn btn-danger btnExcluir" style="font-weight: bold;font-size:15pt;" value="-" />
							<input type="hidden" name="idConta" value="${conta.codConta}" /> 
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
		<input id="btnCadastrar" type="button" class="btn btn-success" style="font-weight: bold;font-size:15pt;" value="+"/>
	</form>
</body>