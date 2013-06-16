<script type="text/javascript">
function doAjaxPost() {
	  // get the form values  
	  var agencia = $('#numeroAgencia').val();
	  var conta = $('#numeroConta').val();
	  var banco = $('#idBanco').val();
	   
	  $.ajax({  
	    type: "POST",  
	    url: "cadastrarConta",  
	    data: "idBanco=" + banco + "&numeroAgencia=" + agencia + "&numeroConta=" + conta,  
	    success: function(response){  
	      // we have the response  
	      $('#info').html(response);
	      $('#agencia').val('');
	      $('#conta').val('');
	      
	      Adicionar(agencia, conta, banco);
	    },  
	    error: function(e){  
	      alert('Error: ' + e);  
	    }  
	  });
	}
	
function Adicionar(agencia, conta, banco){
    $("#tabelaContas tbody").append(
        "<tr>"+
        "<td></td>"+
        "<td>" + agencia + "</td>"+
        "<td>" + conta + "</td>"+
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
	    <select id="idBanco" style="height:40px;font-size:13pt;">
	    	<c:forEach var="banco" items="${bancos}">
		        <option value="${banco.codBanco}">${banco.nomeBanco}</option>
	    	</c:forEach>
		</select>
	   	<input class="input-large" style="height:40px;font-size:13pt;" type="text" placeholder="Agência" id="numeroAgencia"/>
	    <input class="input-large" style="height:40px;font-size:13pt;" type="text" placeholder="Conta" id="numeroConta"/>
		<input id="btnCadastrar" type="button" class="btn btn-success" onclick="doAjaxPost()" value="Cadastrar"/>
<!-- 		<button class="btn btn-success" onclick="doAjaxPost()" value="Cadastrar"><i class="icon-plus icon-white"></i></button> -->
	</form>
</body>