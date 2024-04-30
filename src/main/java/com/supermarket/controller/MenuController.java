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
	 * 加载权限菜单
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
		//menuIdList 是menuList 根据角色ID查询的所有菜单
		for(Menu menu:menuList){
			menuIdList.add(menu.getId());
		}
		return getAllMenuByParentId(d_id,menuIdList).toString();// 1 和 当前角色菜单ID
	}

	/**
	 * 获取所有菜单信息
	 * 
	 * @param parentId
	 * @param roleId
	 * @return
	 */
	public JsonArray getAllMenuByParentId(Integer d_id,List<Integer> menuIdList) {//1 和当前角色菜单ID
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
	 * 根据父节点和用户角色Id查询菜单
	 * 
	 * @param parentId
	 * @param roleId
	 * @return
	 */
	public JsonArray getMenuByParentId(Integer d_id,List<Integer> menuIdList) {
		List<Menu> menuList = menuService.findByParentIdAndRoleId(d_id);//第一次传入1 
		JsonArray jsonArray = new JsonArray();
		for (Menu menu : menuList) {
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("id", menu.getId()); // 节点Id
			jsonObject.addProperty("name", menu.getName()); // 节点名称
			jsonObject.addProperty("p_id", menu.getP_id()); // 节点名称
			if (menu.getMenuId() == 0) {
				jsonObject.addProperty("menuId", "closed"); // 根节点
			} else {
				jsonObject.addProperty("menuId", "open"); // 叶子节点
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
