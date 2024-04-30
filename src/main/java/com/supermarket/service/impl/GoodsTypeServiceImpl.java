package com.supermarket.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.supermarket.dao.GoodsTypeDao;
import com.supermarket.entity.GoodsType;
import com.supermarket.service.GoodsTypeService;

@Service("goodsTypeService")
public class GoodsTypeServiceImpl implements GoodsTypeService {

	@Resource
	private GoodsTypeDao goodsTypeDao;

	public List<GoodsType> findByGoodsType(Integer parentId) {
		return goodsTypeDao.findByGoodsType(parentId);
	}

	public GoodsType findByStateId(Integer id) {
		return goodsTypeDao.findByStateId(id);
	}

	public GoodsType findByPid(Integer id) {
		return goodsTypeDao.findByPid(id);
	}

	public List<GoodsType> findAll(Map<String, Object> map) {
		return goodsTypeDao.findAll(map);
	}

	public Integer delete(Integer id) {
		return goodsTypeDao.delete(id);
	}

	public GoodsType isEchoes(String name) {
		return goodsTypeDao.isEchoes(name);
	}

	public Integer update(GoodsType goodsType) {
		return goodsTypeDao.update(goodsType);
	}

	public GoodsType findById(Integer id) {
		return goodsTypeDao.findById(id);
	}

	public Integer add(GoodsType goodsType) {
		return goodsTypeDao.add(goodsType);
	}


}
