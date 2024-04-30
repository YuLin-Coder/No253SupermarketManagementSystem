package com.supermarket.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.supermarket.dao.RoleDao;
import com.supermarket.dao.RoleMenuDao;
import com.supermarket.entity.Role;
import com.supermarket.service.RoleService;

@Service("roleService")
public class RoleServiceImpl implements RoleService {

	@Resource
	private RoleDao roleDao;
	
	@Override
	public Role findByRoleName(Integer id) {
		// TODO �Զ����ɵķ������
		return roleDao.findByRoleName(id);
	}

	@Override
	public List<Role> findAll(Map<String, Object> map) {
		// TODO �Զ����ɵķ������
		return roleDao.findAll(map);
	}

	@Override
	public Long count(Map<String, Object> map) {
		// TODO �Զ����ɵķ������
		return roleDao.count(map);
	}

	@Override
	public Role findRepeat(String roleName) {
		// TODO �Զ����ɵķ������
		return roleDao.findRepeat(roleName);
	}

	@Override
	public Integer add(Role role) {
		// TODO �Զ����ɵķ������
		return roleDao.add(role);
	}

	@Override
	public Integer delete(Integer id) {
		// TODO �Զ����ɵķ������
		return roleDao.delete(id);
	}

	@Override
	public Integer update(Role role) {
		// TODO �Զ����ɵķ������
		return null;
	}

}
