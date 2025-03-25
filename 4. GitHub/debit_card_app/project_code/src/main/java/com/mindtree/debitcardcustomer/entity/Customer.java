package com.mindtree.debitcardcustomer.entity;

import java.util.Comparator;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Customer 
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int customerId;
	private String customerName;
	private int age;
	@OneToMany(cascade = CascadeType.PERSIST, mappedBy = "customer")
	private Set<DebitCard> debitCards;
	public Customer() {
		super();
	}
	public Customer(int customerId, String customerName, int age, Set<DebitCard> debitCards) {
		super();
		this.customerId = customerId;
		this.customerName = customerName;
		this.age = age;
		this.debitCards = debitCards;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public Set<DebitCard> getDebitCards() {
		return debitCards;
	}
	public void setDebitCards(Set<DebitCard> debitCards) {
		this.debitCards = debitCards;
	}
	@Override
	public String toString() {
		return "Customer [customerId=" + customerId + ", customerName=" + customerName + ", age=" + age
				+ ", debitCards=" + debitCards + "]";
	}
	
	public static Comparator<Customer> DebitCardComparator = new Comparator<Customer>() {
		
		@Override
		public int compare(Customer c1, Customer c2) 
		{
			
			return c2.getDebitCards().size() - c1.getDebitCards().size();
		}
	};
}
