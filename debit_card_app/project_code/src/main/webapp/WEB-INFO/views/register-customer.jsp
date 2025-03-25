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
</head>
<body>
	<div class="row">
		<div class="col-md-4"></div>
		<div class="col-md-4">
			<h3>Customer Registration Form</h3>
			<br>
			<div class="simple-form">
				<form action="" method="post" id = "form1">
					<c:if test="${message != null }">

						<div id="message">${message}</div>
					</c:if>

					<div class="form-group">

						<label>Enter Customer name :</label> <input type="text"
							class="form-control item" id="customerName"
							placeholder="Customer name " name="customerName" ><br>
						<div id="i1"></div>

					</div>

					<div class="form-group">
						<label for="Age">Enter Customer Age :</label> <input type="number"
							class="form-control item" id="age" placeholder="Customer Age"
							name="age" >
							<span id="age1" class="text-danger font-weight-bold"></span>
					</div>

					<div>
						<button id = "button1" type="submit" class=" btn-primary create-button"
							onclick="form.action='/saveCustomer'">Register</button>
						&emsp; &emsp;
					</div>
				</form>
				<form>
					<button  type="submit" class=" btn-primary create-button"
						onclick="action='/'">Back</button>
				</form>
			</div>
		</div>
		<div class="col-md-4"></div>
	</div>
	<script type="text/javascript">
	
	/* $('#customerName').keyup(function(e) 
			  {	
			  var age1 = $('#customerName').val();
			  console.log(age1);
		    
			    if(age1 < 21 )
			    {
			    	document.getElementById('age1').innerHTML = "** Age Should not be lesser than 21....";
			        //alert('Age Should not be lesser than 21....Please enter valid Age');
			        e.preventDefault();
			    }  
	  }); */
$(document).ready(function() 
		{
	
	/* $('#button1').onclick(function()
			{
		
		
	});
	 */
	
	
	
$("#form1").validate({
	$("#age").keyup(function(e) 
			  {	
			  var age1 = $('#age').val();
			  console.log(age1);
		    
			    if(age1 < 21 )
			    {
			    	$("#age1").innerHTML = "** Age Should not be lesser than 21....";
			        //alert('Age Should not be lesser than 21....Please enter valid Age');
			        e.preventDefault();
			    }  
	  });

	rules : {
		customerName : {
			required : true,
			minlength : 4,
			maxlength : 16,
			lettersonly : true

		}
		
		
	},
	
	submitHandler : function(form) {
		form.submit();
	}
});
});
</script>
	
</body>
</html>