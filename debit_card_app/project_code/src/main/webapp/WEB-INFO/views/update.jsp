<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Debit Card App</title>
<style type="text/css">
div#message {
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
			<form action="" method="post" id="form1">

				<div>
					<label>Debit Card Number:</label> <input type="number"
						class="form-control item" id="debitCardNumber"
						placeholder="Card Number " name="debitCardNumber"
						value="${debitCard.debitCardNumber }" disabled><br>
				</div>

				<br> <br>

				<div>
					<label>Amount</label> <input type="number"
						class="form-control item" id="amount" placeholder="Amount "
						name="amount" value="${debitCard.amount }" disabled> <span
						id="amount1" class="text-danger font-weight-bold"></span> <br>
				</div>

				<div>
					<label>Enter the Expiry Date You Want To update :</label> <input
						type="date" class="form-control item" id="expiryDate"
						placeholder="Expiry Date" name="expiryDate"><br>
				</div>

				<div>
					<button id="button1" type="submit"
						class=" btn-primary create-button"
						onclick="form.action='/updateDebitCard'">Update</button>
					&emsp; &emsp;

				</div>
			</form>

			<form>
				<button type="submit" class=" btn-primary create-button"
					onclick="action='/getCustomers'">Back</button>
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

				<div id="message" style="color: #0000ff">${message}</div>
			</c:if>
		</div>
	</div>
</body>
</html>