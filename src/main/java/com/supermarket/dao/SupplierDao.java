package com.supermarket.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.supermarket.entity.Supplier;

@Repository
public interface SupplierDao {
	
	
	public List<Supplier> findAll(Map<String,Object> map);
	
	public Long count(Map<String, Object> map);
	
	public Integer add(Supplier supplier);
	
	public Supplier findRepeat(String name);
	
	public Integer delete(Integer id);
	
	public Integer update(Supplier supplier);
}
