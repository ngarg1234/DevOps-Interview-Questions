package com.mindtree.debitcardcustomer.service.serviceimpl;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mindtree.debitcardcustomer.entity.Customer;
import com.mindtree.debitcardcustomer.entity.DebitCard;
import com.mindtree.debitcardcustomer.repository.CustomerRepository;
import com.mindtree.debitcardcustomer.repository.DebitCardRepository;
import com.mindtree.debitcardcustomer.service.DebitCardService;

@Service
public class DebitCardServiceImpl implements DebitCardService {
	@Autowired
	CustomerRepository customerRepository;

	@Autowired
	DebitCardRepository debitCardRepository;

	@Override
	public String saveCustomer(Customer customer) {
		customerRepository.save(customer);
		return "Customer Registered Successfully";
	}

	@Override
	public String saveDebitCard(Customer customer, DebitCard debitCard) {
		Customer customer2 = customerRepository.findById(customer.getCustomerId()).get();

		debitCard.setCustomer(customer2);
		debitCardRepository.save(debitCard);
		return "Debit Card Added Successfully";
	}

	@Override
	public List<Customer> getAllCustomers() {
		// TODO Auto-generated method stub
		
		
		return customerRepository.findAll();
	}

	@Override
	public List<Customer> getCustomerDetails() {
		List<Customer> customers = customerRepository.findAll();
		List<Customer> customers2 = new ArrayList<>();
		for (Customer customer : customers) {
			
			 Set<DebitCard> debitCards3 = new TreeSet<>(customer.getDebitCards()); 
			 customer.setDebitCards(debitCards3); 
			 //customers2.add(customer);
		}
		Collections.sort(customers, Customer.DebitCardComparator);

		return customers;
	}

	@Override
	public DebitCard update(long debitCardNumber) {

		return debitCardRepository.findById(debitCardNumber).get();
	}

	@Override
	public String updateDebitCard(long dCardNumber, Date expiryDate) 
	{
		DebitCard debitCard = debitCardRepository.findById(dCardNumber).get();
		debitCard.setExpiryDate(expiryDate);
		debitCardRepository.saveAndFlush(debitCard);
		return "Updated Successfully";
	}
	
	

}
