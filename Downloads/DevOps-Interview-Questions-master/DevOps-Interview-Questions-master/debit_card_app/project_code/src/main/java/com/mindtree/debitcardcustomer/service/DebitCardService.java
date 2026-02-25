package com.mindtree.debitcardcustomer.service;

import java.sql.Date;
import java.util.List;

import com.mindtree.debitcardcustomer.entity.Customer;
import com.mindtree.debitcardcustomer.entity.DebitCard;

public interface DebitCardService {

	String saveCustomer(Customer customer);

	String saveDebitCard(Customer customer, DebitCard debitCard);

	List<Customer> getAllCustomers();

	List<Customer> getCustomerDetails();

	DebitCard update(long debitCardNumber);

	String updateDebitCard(long dCardNumber, Date expiryDate);

}
