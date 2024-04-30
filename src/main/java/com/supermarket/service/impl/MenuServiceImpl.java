package com.supermarket.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.supermarket.dao.MenuDao;
import com.supermarket.entity.Menu;
import com.supermarket.service.MenuService;

@Service("menuService")
public class MenuServiceImpl implements MenuService {

	@Resource
	private MenuDao menuDao;

	public List<Menu> menuList(Integer roleId) {
		return menuDao.menuList(roleId);
	}

	public List<Menu> findByRoleIdMenu(Integer roleId) {
		return menuDao.findByRoleIdMenu(roleId);
	}

	public List<Menu> findByParentIdAndRoleId(Integer parentId) {
		return menuDao.findByParentIdAndRoleId(parentId);
	}


}
