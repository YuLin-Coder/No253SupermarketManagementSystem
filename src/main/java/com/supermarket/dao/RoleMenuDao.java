package com.supermarket.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.supermarket.entity.RoleMenu;

@Repository
public interface RoleMenuDao {

	public List<RoleMenu> isRoleIdExistence(Integer id);

	public Integer deleteRoleId(Integer id);

	public Integer add(RoleMenu roleMenu);
}
