package com.supermarket.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.supermarket.entity.Role;

@Repository
public interface RoleDao {
	
	public Role findByRoleName(Integer id);
	
	public List<Role> findAll(Map<String,Object> map);
	
	public Long count(Map<String, Object> map);
	
	public Role findRepeat(String roleName);
	
	public Integer add(Role role);
	
	public Integer delete(Integer id);
	
	public Integer update(Role role);
}
