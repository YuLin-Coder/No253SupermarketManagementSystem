package com.supermarket.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.supermarket.entity.Menu;

@Repository
public interface MenuDao {
	
	public List<Menu> menuList(Integer roleId);
	
	public List<Menu> findByRoleIdMenu(Integer roleId);
	
	public List<Menu> findByParentIdAndRoleId(Integer parentId);
	
	
}
