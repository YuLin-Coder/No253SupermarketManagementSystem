package com.supermarket.controller;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.supermarket.entity.Menu;
import com.supermarket.entity.RoleMenu;
import com.supermarket.service.MenuService;
import com.supermarket.service.RoleMenuService;

@Controller
@RequestMapping("/menu")
public class MenuController {

	@Resource
	public MenuService menuService;
	
	@Resource
	public RoleMenuService roleMenuService;
	
	
	/**
	 * ����Ȩ�޲˵�
	 * 
	 * @param session
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/loadMenuInfo")
	public String loadMenuInfo(HttpSession session, Integer d_id,Integer roleId) throws Exception {
		List<Menu> menuList = menuService.findByRoleIdMenu(roleId);
		List<Integer> menuIdList=new LinkedList<Integer>();
		//menuIdList ��menuList ���ݽ�ɫID��ѯ�����в˵�
		for(Menu menu:menuList){
			menuIdList.add(menu.getId());
		}
		return getAllMenuByParentId(d_id,menuIdList).toString();// 1 �� ��ǰ��ɫ�˵�ID
	}

	/**
	 * ��ȡ���в˵���Ϣ
	 * 
	 * @param parentId
	 * @param roleId
	 * @return
	 */
	public JsonArray getAllMenuByParentId(Integer d_id,List<Integer> menuIdList) {//1 �͵�ǰ��ɫ�˵�ID
		JsonArray jsonArray = this.getMenuByParentId(d_id,menuIdList);
		for (int i = 0; i < jsonArray.size(); i++) {
			JsonObject jsonObject = (JsonObject) jsonArray.get(i);
			if ("open".equals(jsonObject.get("menuId").getAsString())) {
				continue;
			} else {
				jsonObject.add("children", getAllMenuByParentId(jsonObject.get("p_id").getAsInt(),menuIdList));
			}
		}
		return jsonArray;
	}

	/**
	 * ���ݸ��ڵ���û���ɫId��ѯ�˵�
	 * 
	 * @param parentId
	 * @param roleId
	 * @return
	 */
	public JsonArray getMenuByParentId(Integer d_id,List<Integer> menuIdList) {
		List<Menu> menuList = menuService.findByParentIdAndRoleId(d_id);//��һ�δ���1 
		JsonArray jsonArray = new JsonArray();
		for (Menu menu : menuList) {
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("id", menu.getId()); // �ڵ�Id
			jsonObject.addProperty("name", menu.getName()); // �ڵ�����
			jsonObject.addProperty("p_id", menu.getP_id()); // �ڵ�����
			if (menu.getMenuId() == 0) {
				jsonObject.addProperty("menuId", "closed"); // ���ڵ�
			} else {
				jsonObject.addProperty("menuId", "open"); // Ҷ�ӽڵ�
			}
			if(menuIdList.contains(menu.getId())){
				jsonObject.addProperty("checked", true); 
			}
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
	
	
	@ResponseBody
	@RequestMapping("/save")
	public Map<String,Object> save(Integer roleId,String[] nodes)throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		if(nodes!=null) {
			if(roleMenuService.isRoleIdExistence(roleId).size()>0) {
				roleMenuService.deleteRoleId(roleId);
			}
			for(int i=0;i<nodes.length;i++) {
				RoleMenu roleMenu= new RoleMenu();
				roleMenu.setMenuId(Integer.parseInt(nodes[i]));
				roleMenu.setRoleId(roleId);
				roleMenuService.add(roleMenu);
			}
		}else {
			result.put("success", true);
		}
		result.put("success", true);
		return result;
	}

}
