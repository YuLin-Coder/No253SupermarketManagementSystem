package com.supermarket.dao;


import org.springframework.stereotype.Repository;

import com.supermarket.entity.UserRole;

@Repository
public interface UserRoleDao {
	
	public Integer add(UserRole userRole);
	
	public UserRole findAll(String userName);
	
	public Integer delete(Integer id);
}
