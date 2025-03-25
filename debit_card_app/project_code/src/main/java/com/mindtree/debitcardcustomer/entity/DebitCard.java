package com.mindtree.debitcardcustomer.entity;

import java.sql.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class DebitCard implements Comparable<DebitCard>
{
	@Id
	private long debitCardNumber;
	private Date expiryDate;
	private String accountType;
	private double amount;
	@ManyToOne(cascade = CascadeType.PERSIST)
	private Customer customer;
	public DebitCard() {
		super();
	}
	public DebitCard(long debitCardNumber, Date expiryDate, String accountType, double amount, Customer customer) {
		super();
		this.debitCardNumber = debitCardNumber;
		this.expiryDate = expiryDate;
		this.accountType = accountType;
		this.amount = amount;
		this.customer = customer;
	}
	public long getDebitCardNumber() {
		return debitCardNumber;
	}
	public void setDebitCardNumber(long debitCardNumber) {
		this.debitCardNumber = debitCardNumber;
	}
	public Date getExpiryDate() {
		return expiryDate;
	}
	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}
	public String getAccountType() {
		return accountType;
	}
	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (debitCardNumber ^ (debitCardNumber >>> 32));
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DebitCard other = (DebitCard) obj;
		if (debitCardNumber != other.debitCardNumber)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "DebitCard [debitCardNumber=" + debitCardNumber + ", expiryDate=" + expiryDate + ", accountType="
				+ accountType + ", amount=" + amount + "]";
	}
	
	@Override
	public int compareTo(DebitCard d) 
	{
		return (int) (d.getAmount() - this.getAmount());
	}
	
	
}
