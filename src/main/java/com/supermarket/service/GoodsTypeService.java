package com.supermarket.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.supermarket.entity.GoodsType;

@Service
public interface GoodsTypeService {

	public List<GoodsType> findByGoodsType(Integer parentId);

	public GoodsType findByStateId(Integer id);

	public GoodsType findByPid(Integer id);
	
	public List<GoodsType> findAll(Map<String,Object> map);
	
	public Integer delete(Integer id);
	
	public GoodsType isEchoes(String name);
	
	public Integer update(GoodsType goodsType);
	
	public GoodsType findById(Integer id);
	
	public Integer add(GoodsType goodsType);
	
}
