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
th
{
color: olive;
}
</style>

</head>
<body>

	<div>
		<h2>Customer Detail Sorted on Number of Debit Card</h2>
		<br> <br>
		<c:forEach var="customer" items="${customers}">
		<br>
			<h4  style="color:#0000ff">Customer Name: ${customer.customerName} </h4>
			<table class="table table-hover" border="2" width="70%"
				cellpadding="2">
				<tr class="info">
					<th>Debit Card Number</th>
					<th>Account Type</th>
					<th>Expiry Date</th>
					<th>Amount</th>
					<th>Customer Age</th>
					<th></th>
				</tr>

				<c:forEach var="debit" items="${customer.getDebitCards()}">
					<tr class="danger">
						<td>${debit.debitCardNumber}</td>
						<td>${debit.accountType }</td>
						<td>${debit.expiryDate}</td>
						<td>${debit.amount}</td>
						<td>${customer.age}</td>
						<form >
								<td><input type="submit" value="Update" onclick="form.action='/update/${debit.debitCardNumber}'"  /></td>
						</form>
					</tr>
				</c:forEach>
			</table>
		</c:forEach>
	</div>
	<a href="/">Back</a>
</body>
</html>