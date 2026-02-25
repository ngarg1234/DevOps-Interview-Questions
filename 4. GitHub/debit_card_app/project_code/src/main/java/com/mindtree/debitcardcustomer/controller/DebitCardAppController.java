package com.mindtree.debitcardcustomer.controller;

import java.sql.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mindtree.debitcardcustomer.entity.Customer;
import com.mindtree.debitcardcustomer.entity.DebitCard;
import com.mindtree.debitcardcustomer.service.DebitCardService;

@Controller
public class DebitCardAppController 
{
	static long dCardNumber;
	@Autowired
	DebitCardService debitCardService;
	
	@RequestMapping(path = "/", method = RequestMethod.GET)
	public String index() 
	{
		return "index";
	}
	
	@RequestMapping(path = "/customer", method = RequestMethod.GET)
	public String customer() 
	{
		return "register-customer";
	}
	
	@RequestMapping(path = "/saveCustomer", method = RequestMethod.POST)
	public String saveCustomer(Customer  customer, Model model) 
	{
		model.addAttribute("message", debitCardService.saveCustomer(customer));
		return "register-customer";
	}
	
	@RequestMapping(path = "/addDebitCard", method = RequestMethod.GET)
	public String addDebitCard(Model model) 
	{
		model.addAttribute("customers", debitCardService.getAllCustomers());
		return "add-debitcard";
	}
	
	@RequestMapping(path = "/saveDebitCard", method = RequestMethod.POST)
	public String saveDebitCard(Customer  customer, DebitCard debitCard, Model model) 
	{
		System.out.println(customer.toString());
		System.out.println(debitCard.toString());
		model.addAttribute("message", debitCardService.saveDebitCard(customer, debitCard));
		return "add-debitcard";
	}
	
	@RequestMapping(path = "/getCustomers", method = RequestMethod.GET)
	public String getCustomerDetails(Model model) 
	{
		model.addAttribute("customers", debitCardService.getCustomerDetails());
		return "display-customer";
	}
	
	@RequestMapping(path = "/update/{debitCardNumber}", method = RequestMethod.GET)
	public String update(Model model, @PathVariable long debitCardNumber) 
	{
		dCardNumber = debitCardNumber;
		model.addAttribute("debitCard", debitCardService.update(debitCardNumber));
		return "update";
	}
	
	@RequestMapping(path = "/updateDebitCard", method = RequestMethod.POST)
	public String updateDebitCard(Model model, Date expiryDate) 
	{
		model.addAttribute("message", debitCardService.updateDebitCard(dCardNumber, expiryDate));
		return "update";
	}

}
