<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Debit Card App</title>
<style type="text/css">
#simple-form {
	max-width: 1000px;
	padding: 50px 70px;
	border-radius: 10px;
	box-shadow: 4px 4px 15px rgba(0, 0, 0, 0.2);
}
</style>
</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<div class="row">
		<div class="col-md-4"></div>
		<div class="col-md-4" id="simple-form">

			<h2>Menu</h2>
			<table class="table table-hover">
				<tbody>
					<tr>
						<th>1.</th>
						<th><a class="nav-link" href="/customer">Register Customer</a></th>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<th>2.</th>
						<th><a class="nav-link" href="addDebitCard">Add Debit
								Card</a></th>
					</tr>
				</tbody>

				<tbody>
					<tr>
						<th>3.</th>
						<th><a id = "a1" class="nav-link" href="/getCustomers">View Customers
								Sorted Based on no. of debit card </a></th>

					</tr>
				</tbody>

			</table>



		</div>
		<div class="col-md-4"></div>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
		  $("#a1").mouseenter(function(){
		    alert("Click This Link To Sign Up!!!!");
		  });
		});
	
	</script>
</body>
</html>