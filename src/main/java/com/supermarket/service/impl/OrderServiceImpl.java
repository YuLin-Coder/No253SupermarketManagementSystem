package com.supermarket.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.supermarket.dao.OrderDao;
import com.supermarket.entity.Order;
import com.supermarket.service.OrderService;

@Service("orderService")
public class OrderServiceImpl implements OrderService {

	@Resource
	private OrderDao orderDao;

	public Order getTodayMaxNumber() {
		return orderDao.getTodayMaxNumber();
	}

	public List<Order> findAll(Map<String, Object> map) {
		return orderDao.findAll(map);
	}

	public Long count(Map<String, Object> map) {
		return orderDao.count(map);
	}

	public Integer add(Order order) {
		return orderDao.add(order);
	}
}
