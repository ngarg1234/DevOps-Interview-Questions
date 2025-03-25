package com.mindtree.debitcardcustomer.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mindtree.debitcardcustomer.entity.DebitCard;

@Repository
public interface DebitCardRepository extends JpaRepository<DebitCard, Long>{

}
