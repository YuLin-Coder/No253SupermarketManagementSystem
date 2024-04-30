package com.supermarket.service;

import org.springframework.stereotype.Service;

import com.supermarket.entity.UserRole;

@Service
public interface UserRoleService {
public Integer add(UserRole userRole);
	
	public UserRole findAll(String userName);
	
	public Integer delete(Integer id);
}
