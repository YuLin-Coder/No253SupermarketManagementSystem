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
		// TODO 自动生成的方法存根
		return userDao.findByUserName(userName);
	}

	@Override
	public List<User> findAll(Map<String, Object> map) {
		// TODO 自动生成的方法存根
		return userDao.findAll(map);
	}

	@Override
	public Long count(Map<String, Object> map) {
		// TODO 自动生成的方法存根
		return userDao.count(map);
	}

	@Override
	public Integer add(User user) {
		// TODO 自动生成的方法存根
		return userDao.add(user);
	}

	@Override
	public Integer delete(Integer id) {
		// TODO 自动生成的方法存根
		return userDao.delete(id);
	}

	@Override
	public Integer update(User user) {
		// TODO 自动生成的方法存根
		return userDao.update(user);
	}

	@Override
	public Integer updateReset(Integer id) {
		// TODO 自动生成的方法存根
		return userDao.updateReset(id);
	}

	@Override
	public User findRoleId(String userName) {
		// TODO 自动生成的方法存根
		return userDao.findRoleId(userName);
	}

	
}
