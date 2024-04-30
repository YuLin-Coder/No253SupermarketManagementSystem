package com.supermarket.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.supermarket.entity.Order;

@Repository
public interface OrderDao {
	
	public Order getTodayMaxNumber();
	
	public List<Order> findAll(Map<String,Object> map);
	
	public Long count(Map<String,Object> map);
	
	public Integer add(Order order);
}
