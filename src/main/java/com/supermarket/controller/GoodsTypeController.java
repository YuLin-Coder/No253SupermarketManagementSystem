package com.supermarket.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.supermarket.entity.GoodsType;
import com.supermarket.service.GoodsService;
import com.supermarket.service.GoodsTypeService;
import com.supermarket.util.ResponseUtil;

@Controller
@RequestMapping("/goodsType")
public class GoodsTypeController {

	@Resource
	private GoodsTypeService goodsTypeService;

	@Resource
	private GoodsService goodsService;

	/**
	 * ������Ʒ���
	 * 
	 * @param session
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/loadGoodstypeInfo", produces="application/json;charset=UTF-8")
	public String loadGoodstypeInfo() throws Exception {
		System.out.println("---------------------------------------------"+getAllMenuByParentId(-1).toString());
		return getAllMenuByParentId(-1).toString();
	}

	/**
	 * ��ȡ������Ʒ���
	 * 
	 * @param parentId
	 * @param roleId
	 * @return
	 */
	public JsonArray getAllMenuByParentId(Integer parentId) {
		JsonArray jsonArray = this.getMenuByParentId(parentId);
		for (int i = 0; i < jsonArray.size(); i++) {
			JsonObject jsonObject = (JsonObject) jsonArray.get(i);
			if ("open".equals(jsonObject.get("state").getAsString())) {
				continue;
			} else {
				jsonObject.add("children", getAllMenuByParentId(jsonObject.get("id").getAsInt()));
			}
		}
		System.out.println("---------------------------------------------"+jsonArray.toString());
		return jsonArray;
	}

	/**
	 * ���ݸ��ڵ��ѯ��Ʒ���
	 * 
	 * @param parentId
	 * @param roleId
	 * @return
	 */
	public JsonArray getMenuByParentId(Integer parentId) {
		List<GoodsType> goodsTypeList = goodsTypeService.findByGoodsType(parentId);
		JsonArray jsonArray = new JsonArray();
		for (GoodsType goodsType : goodsTypeList) {
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("id", goodsType.getId()); // �ڵ�Id
			jsonObject.addProperty("name", goodsType.getName()); // �ڵ�����
			jsonObject.addProperty("p_id", goodsType.getP_id()); // �ڵ�����
			jsonObject.addProperty("states", goodsType.getState()); // �ڵ�����
			jsonObject.addProperty("spread", true);
			if (goodsType.getState() == 1) {
				jsonObject.addProperty("state", "closed"); // ���ڵ�
			} else {
				jsonObject.addProperty("state", "open"); // Ҷ�ӽڵ�
			}
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}

	@ResponseBody
	@RequestMapping("/typelist")
	public String typeList(HttpServletResponse response) throws Exception {
		JsonArray jsonArray = new JsonArray();
		List<GoodsType> typeList = goodsTypeService.findAll(null);
		for (GoodsType goodsType : typeList) {
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("id", goodsType.getId());
			jsonObject.addProperty("name", goodsType.getName());
			jsonArray.add(jsonObject);
		}
		ResponseUtil.write(response, jsonArray);
		return null;
	}

	@ResponseBody
	@RequestMapping("/delete")
	public Map<String, Object> delete(@RequestParam(value = "id", required = false) Integer id) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		if (goodsTypeService.findByPid(id) != null) {
			result.put("success", false);
			result.put("errorInfo", "����ɾ���ӽڵ�");
		} else if (goodsService.findByTypeId(id) == null) {
			goodsTypeService.delete(id);
			result.put("success", true);
		} else {
			result.put("success", false);
			result.put("errorInfo", "����Ʒ����Ѿ���ʹ��");
		}
		return result;
	}

	@ResponseBody
	@RequestMapping("/update")
	public Map<String, Object> update(GoodsType goodsType) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		GoodsType goodsTypes = goodsTypeService.isEchoes(goodsType.getName());
		if (goodsTypes == null) {
			goodsTypeService.update(goodsType);
			result.put("success", true);
		} else {
			if (goodsTypes.getId() != goodsType.getId()) {
				result.put("success", false);
				result.put("errorInfo", "��Ʒ�����ڣ����飡");
			} else {
				goodsTypeService.update(goodsType);
				result.put("success", true);
			}
		}
		return result;
	}

	@ResponseBody
	@RequestMapping("/save")
	public Map<String, Object> save(GoodsType goodsType) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		GoodsType goodsTypes = goodsTypeService.findById(goodsType.getId());
		if (goodsTypeService.isEchoes(goodsType.getName()) != null) {
			result.put("success", false);
			result.put("errorInfo", "����Ʒ����Ѿ�����");
		} else {
			if (goodsTypes.getState() == 0) {
				goodsTypes.setState(1);
				goodsTypeService.update(goodsTypes);
			}
			goodsType.setP_id(goodsType.getId());
			if (goodsType.getId() == 1) {
				goodsType.setState(1);
			} else {
				goodsType.setState(0);
			}
			goodsTypeService.add(goodsType);
			result.put("id", goodsType.getId());
			result.put("success", true);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping("/typelistSel")
	public Map<String, Object> typelistSel() throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<GoodsType> typeList = goodsTypeService.findAll(null);
		result.put("typeList", typeList);
		result.put("success", true);
		return result;
	}

	
}
