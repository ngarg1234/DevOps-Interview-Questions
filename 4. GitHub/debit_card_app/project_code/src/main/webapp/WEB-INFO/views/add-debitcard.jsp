<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<script
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/additional-methods.min.js"
	integrity="sha256-vb+6VObiUIaoRuSusdLRWtXs/ewuz62LgVXg2f1ZXGo="
	crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Debit Card App</title>
<style type="text/css">
div#message 
{

  width: 300px;
  height: 100px;
  background-color: red;
  border: 1px solid black;
  padding: 30px;

  transform: rotate(20deg); 
}
</style>
</head>
<body>
<div class="row">
		<div class="col-md-4"></div>
		<div class="col-md-4">
			<form action="/saveDebitCard" method="post" id="form1">
				
				<div>
					<br>  <label>Select Customer :</label> <select name="customerId"
					id="customerId" class="btn btn-primary dropdown-toggle"
					data-toggle="dropdown" style="width: 200px" size="1">
					<option value="">Select Customer</option>
					<c:forEach var="customer" items="${ customers}">
						<option value="${customer.customerId}">${customer.customerName}</option>
					</c:forEach>
				</select>
				</div>

				<div>
					<label>Debit Card Number:</label> <input type="number"
						class="form-control item" id="debitCardNumber"
						placeholder="Card Number " name="debitCardNumber" ><br>
				</div>

				<br> <br>
				<div>
					<label>Enter the Expiry Date:</label> <input type="date"
						class="form-control item" id="expiryDate"
						placeholder="Expiry Date" name="expiryDate"><br>
				</div>

				<div>
					<label>Select Account Type :</label> <select name="accountType"
					id="accountType" class="btn btn-primary dropdown-toggle"
					data-toggle="dropdown" style="width: 200px" size="1">
					<option value="">Select Customer</option>
						<option value="VISA">VISA</option>
						<option value="Master Card">Master Card</option>
				</select>
				</div>

				<div>
					<label>Amount</label> <input type="number"
						class="form-control item" id="amount"
						placeholder="Amount " name="amount">
						<span id="amount1" class="text-danger font-weight-bold"></span>
						<br>
				</div>

				

				<div>
					<button id = "button1" type="submit" class=" btn-primary create-button"
						onclick="form.action='/saveDebitCard'">Add</button>
						&emsp; &emsp;
	
				</div>
			</form>
			
			<form>
				<button  type="submit" class=" btn-primary create-button"
					onclick="action='/'">Back</button>
			</form>
		</div>
		<div class="col-md-4">
		<c:if test="${message != null }">
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			
			<div id = "message" style="color:#0000ff">${message}</div>
				</c:if>
			</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function() 
			{
	$('#button1').click(function(e) 
			  {
		  	
			  var dDate = $('#expiryDate').val();
			  console.log(dDate);
			  var CurrentDate = new Date();
			  GivenDate = new Date(dDate);
			  
			    if(GivenDate < CurrentDate )
			    {	    	
			        alert('Selected Expiry Date is lesser than the current date..Please select valid date');
			        e.preventDefault();
			    }
			    
			   var amnt = $('#amount').val();
			   
			   if(amnt < 50000)
				   {
				   document.getElementById('amount1').innerHTML = "**Amount Should not be less than 50000";
				   //alert('Amount Should not be less than 50000..Please enter valid amount')
				   e.preventDefault();
				   }	  
	  });
	
	$("#form1").validate({
		
		rules : {
			debitCardNumber : {
				required : true,
				minlength : 16,
				maxlength : 16
			},
			
		},
		submitHandler : function(form) {
			form.submit();
		}
});
			});
	
	
	
	</script>
</body>
</html>