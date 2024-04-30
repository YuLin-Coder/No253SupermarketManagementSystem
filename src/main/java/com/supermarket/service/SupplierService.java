package com.supermarket.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.supermarket.entity.Supplier;

@Service
public interface SupplierService {
public List<Supplier> findAll(Map<String,Object> map);
	
	public Long count(Map<String, Object> map);
	
	public Integer add(Supplier supplier);
	
	public Supplier findRepeat(String name);
	
	public Integer delete(Integer id);
	
	public Integer update(Supplier supplier);
}
