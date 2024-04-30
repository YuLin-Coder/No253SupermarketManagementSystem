package com.supermarket.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.supermarket.dao.GoodsDao;
import com.supermarket.entity.Goods;
import com.supermarket.service.GoodsService;

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService {

	@Resource
	private GoodsDao goodsDao;
	
	public Goods findByTypeId(Integer id) {
		return goodsDao.findByTypeId(id);
	}

	public List<Goods> findAll(Map<String, Object> map) {
		return goodsDao.findAll(map);
	}

	public Long count(Map<String, Object> map) {
		return goodsDao.count(map);
	}

	public Goods findCode(Integer id) {
		return goodsDao.findCode(id);
	}

	public Goods isEchoe(String name) {
		return goodsDao.isEchoe(name);
	}

	public Integer add(Goods goods) {
		return goodsDao.add(goods);
	}

	public Integer update(Goods goods) {
		return goodsDao.update(goods);
	}

	public Goods finddel(Integer id) {
		return goodsDao.finddel(id);
	}

	public Goods findById(Integer id) {
		return goodsDao.findById(id);
	}


}
