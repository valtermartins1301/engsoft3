<script type="text/javascript">
function doAjaxPost() {  
	  // get the form values  
	  var agencia = $('#numeroAgencia').val();
	  var conta = $('#numeroConta').val();
	   
	  $.ajax({  
	    type: "POST",  
	    url: "cadastrar",  
	    data: "numeroAgencia=" + agencia + "&numeroConta=" + conta,  
	    success: function(response){  
	      // we have the response  
	      $('#info').html(response);
	      $('#agencia').val('');
	      $('#conta').val('');
	    },  
	    error: function(e){  
	      alert('Error: ' + e);  
	    }  
	  });  
	}  
</script>
<body>
 	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 	
    <div class="well well-large" align="justify">
	    <h3 align="center">Gerenciamento de Contas</h1>
	    <div align="justify">
	       <table class="table table-with-borderradius">
	         <thead>
	           <tr>
	             <th>Banco</th>
	             <th>Agência</th>
	             <th>Conta</th>
	             <th>Opções</th>
	             </tr>
	         </thead>
 				<c:forEach var="conta" items="${contas}">
		        	<tbody>
			            <tr>
				            <td>${conta.pessoa.nomePessoa}</td>
				            <td>${conta.numeroAgencia}</td>
				            <td>${conta.numeroConta}</td>
				            <td><a class="btn btn-primary" href="#"><i class="icon-chevron-right icon-white"></i></a><a class="btn btn-danger" href="#"><i class="icon-minus icon-white"></i></a></td>
			            </tr>
		            </tbody>
 				</c:forEach>
	    	</table>
	    </div>
    </div>
    <form name="cadastro_conta">
	    <select id="banco">
	    	<c:forEach var="banco" items="${bancos}">
		        <option>${banco.nomeBanco}</option>   	
	    	</c:forEach>
		</select> 
	    <input class="input-large" type="text" placeholder="Agência" id="numeroAgencia"/>
	    <input class="input-large" type="text" placeholder="Conta" id="numeroConta"/>
<!-- 	    <button class="btn btn-success" onclick="doAjaxPost()"><i class="icon-plus icon-white"></i></button> -->
	    <input type="button" class="btn btn-success" onclick="doAjaxPost()" value="Cadastrar"/>
<!-- 	    <a class="btn btn-success" href="#" onclick="" id="cadastrar"><i class="icon-plus icon-white"></i></a> -->
	    <tr><td colspan="2"><div id="info" style="color: green;"></td></tr> 
	    </div>
	</form>
</body>