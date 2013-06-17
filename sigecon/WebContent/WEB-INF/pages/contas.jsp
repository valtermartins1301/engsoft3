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
        "<tr>"+
        "<td>" + nomeBanco + "</td>"+
        "<td>" + numeroAgencia + "</td>"+
        "<td>" + numeroConta + "</td>"+
        "<td>" + "<a class='btn btn-primary' href='#'><i class='icon-chevron-right icon-white'></i></a>"
//         <a class='btn btn-danger' href='#'><i class='icon-minus icon-white'></i></a>" 
 		+ "<input type='button' class='btn btn-danger btnExcluir' value='Excluir' />" 
//  		+ "<input type='hidden' name='idConta' value='"+ idConta + "' />" 
    	+"</td>"+
        "</tr>");
    
//     	$(".btnExcluir").on("click", Excluir);
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
	$("#btnCadastrar").on("click", doAjaxPost);
});

</script>
<body>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
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
						<td><a class="btn btn-primary" href="#"><i class="icon-chevron-right icon-white"></i></a> 
						<!-- 				       <a class="btn btn-danger" href="#" onclick="Excluir()"><i class="icon-minus icon-white"></i></a> -->
						<input type="button" class="btn btn-danger btnExcluir" value="Excluir" />
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
	   	<input class="input-large" style="height:40px;font-size:13pt;" type="text" placeholder="Agência" id="numeroAgencia"/>
	    <input class="input-large" style="height:40px;font-size:13pt;" type="text" placeholder="Conta" id="numeroConta"/>
		<input id="btnCadastrar" type="button" class="btn btn-success" value="Cadastrar"/>
<!-- 		<button class="btn btn-success" value="Cadastrar"><i class="icon-plus icon-white"></i></button> -->
	</form>
</body>