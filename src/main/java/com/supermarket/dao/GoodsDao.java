package com.supermarket.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.supermarket.entity.Goods;

@Repository
public interface GoodsDao {

	public Goods findByTypeId(Integer id);

	public List<Goods> findAll(Map<String, Object> map);

	public Long count(Map<String, Object> map);
	
	public Goods findCode(Integer id);
	
	public Goods isEchoe(String name);
	
	public Integer add(Goods goods);
	
	public Integer update(Goods goods);
	
	public Goods finddel(Integer id);
	
	public Goods findById(Integer id);
	
}
