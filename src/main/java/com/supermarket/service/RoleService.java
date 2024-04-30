package com.supermarket.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.supermarket.entity.Role;

@Service
public interface RoleService {
public Role findByRoleName(Integer id);
	
	public List<Role> findAll(Map<String,Object> map);
	
	public Long count(Map<String, Object> map);
	
	public Role findRepeat(String roleName);
	
	public Integer add(Role role);
	
	public Integer delete(Integer id);
	
	public Integer update(Role role);
}
