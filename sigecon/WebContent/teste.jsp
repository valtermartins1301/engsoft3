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
 	
 	<c:forEach var="texto" items="textos">
 		${texto}<br/>
 	</c:forEach>
 	
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
	         <tbody>
	            <tr>
		            <td>Teste1</td>
		            <td>Mark</td>
		            <td>Otto</td>
		            <td><a class="btn btn-primary" href="#"><i class="icon-chevron-right icon-white"></i></a><a class="btn btn-danger" href="#"><i class="icon-minus icon-white"></i></a></td>
	            </tr>
	            <tr>
		            <td>Teste2</td>
		            <td>Jacob</td>
		            <td>Thornton</td>
		            <td><a class="btn btn-primary" href="#"><i class="icon-chevron-right icon-white"></i></a><a class="btn btn-danger" href="#"><i class="icon-minus icon-white"></i></a></td>
	            </tr>
	            	</tbody>
	            </table>
	    </div>
    </div>
    <form name="cadastro_conta">
	    <select id="banco">
	        <option>Banco</option><selected>
			<option>Banco1</option>
			<option>Banco2</option>
			<option>Banco3</option>
		</select> 
	    <input class="input-large" type="text" placeholder="Agência" id="numeroAgencia"/>
	    <input class="input-large" type="text" placeholder="Conta" id="numeroConta"/> </td></tr> <a class="btn btn-success" onclick="doAjaxPost()" href=""><i class="icon-plus icon-white"></i></a>
	    </div>
	    <tr><td colspan="2"><div id="info" style="color: green;">
	</form>
</body>