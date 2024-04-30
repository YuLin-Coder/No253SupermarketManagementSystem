package com.supermarket.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.supermarket.entity.Menu;

@Service
public interface MenuService {

	public List<Menu> menuList(Integer roleId);
	
	/**
	 * 根据角色ID查询当前所拥有的菜单
	 * @param id
	 * @return
	 */
	public List<Menu> findByRoleIdMenu(Integer roleId);
	
	/**
	 * 根据p_id查询所有菜单
	 * @param parentId
	 * @return
	 */
	public List<Menu> findByParentIdAndRoleId(Integer parentId);
	
}
