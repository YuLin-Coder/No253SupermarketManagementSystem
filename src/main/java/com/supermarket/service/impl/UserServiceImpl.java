package com.supermarket.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.supermarket.dao.OrderDao;
import com.supermarket.dao.UserDao;
import com.supermarket.entity.Order;
import com.supermarket.entity.User;
import com.supermarket.service.OrderService;
import com.supermarket.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Resource
	private UserDao userDao;
	
	@Override
	public User findByUserName(String userName) {
		// TODO �Զ����ɵķ������
		return userDao.findByUserName(userName);
	}

	@Override
	public List<User> findAll(Map<String, Object> map) {
		// TODO �Զ����ɵķ������
		return userDao.findAll(map);
	}

	@Override
	public Long count(Map<String, Object> map) {
		// TODO �Զ����ɵķ������
		return userDao.count(map);
	}

	@Override
	public Integer add(User user) {
		// TODO �Զ����ɵķ������
		return userDao.add(user);
	}

	@Override
	public Integer delete(Integer id) {
		// TODO �Զ����ɵķ������
		return userDao.delete(id);
	}

	@Override
	public Integer update(User user) {
		// TODO �Զ����ɵķ������
		return userDao.update(user);
	}

	@Override
	public Integer updateReset(Integer id) {
		// TODO �Զ����ɵķ������
		return userDao.updateReset(id);
	}

	@Override
	public User findRoleId(String userName) {
		// TODO �Զ����ɵķ������
		return userDao.findRoleId(userName);
	}

	
}
