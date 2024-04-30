package com.supermarket.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.supermarket.entity.Menu;
import com.supermarket.entity.User;
import com.supermarket.entity.UserRole;
import com.supermarket.service.MenuService;
import com.supermarket.service.UserRoleService;
import com.supermarket.service.UserService;
import com.supermarket.util.ResponseUtil;

@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private UserService userService;

	@Resource
	private MenuService menuService;

	@Resource
	private UserRoleService userRoleService;

	/**
	 * 用户登陆
	 * @param imageCode
	 * @param session
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/login")
	public Map<String, Object> login(String imageCode, HttpSession session, User user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		if (!session.getAttribute("checkcode").equals(imageCode)) {
			map.put("success", false);
			map.put("errorInfo", "验证码输入错误!");
			return map;
		}
		Subject subect = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(user.getUserName(), user.getPassword());
		try {
			subect.login(token);
			String userName = (String) SecurityUtils.getSubject().getPrincipal();
			User currentUser = userService.findByUserName(userName);
			UserRole userRole = userRoleService.findAll(currentUser.getUserName());
			List<Menu> menuList = menuService.menuList(userRole.getRoleId());
			session.setAttribute("menuList", menuList);
			session.setAttribute("currentUser", currentUser);
			map.put("success", true);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("errorInfo", "用户名或者密码错误!");
			return map;
		}
	}

	/**
	 * 查询所有用户 按条件搜索
	 * @param user
	 * @param page
	 * @param limit
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/userList")
	public Map<String, Object> userList(User user, @RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit) throws Exception {
		Map<String, Object> result = ResponseUtil.resultFye(page, limit);
		if(user.getUserName()!=null){
			String userName = new String(user.getUserName().getBytes("ISO-8859-1"), "UTF-8");
			result.put("userName", userName);
		}
		List<User> userList = userService.findAll(result);
		Long count = userService.count(result);
		return ResponseUtil.result(userList, count);
	}

	/**
	 * 添加用户
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/add")
	public Map<String, Object> add(User user) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		User userName = userService.findByUserName(user.getUserName());
		if (userName == null) {
			userService.add(user);
			Integer s = user.getRoleId();
			UserRole userRole = new UserRole();
			userRole.setRoleId(s);
			userRole.setUserId(user.getId());
			userRoleService.add(userRole);
			result.put("success", true);
		} else {
			result.put("success", false);
			result.put("errorInfo", "用户名已存在！");
		}

		return result;
	}

	/**
	 * 删除用户 如有角色对应  删除角色对应关系
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/delete")
	public Map<String, Object> delete(@RequestParam(value = "id", required = false) Integer id) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		userService.delete(id);
		userRoleService.delete(id);
		result.put("success", true);
		return result;
	}

	/**
	 * 更新用户信息
	 * 更新角色 删除之前的对应关系 添加新的对应关系
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/update")
	public Map<String, Object> update(User user) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		UserRole userRole = userRoleService.findAll(user.getUserName());
		if(userRole.getRoleId()==user.getRoleId()){
			userService.update(user);
		}else{
			userService.update(user);
			userRoleService.delete(user.getId());
			userRole.setRoleId(user.getRoleId());
			userRole.setUserId(user.getId());
			userRoleService.add(userRole);
		}
		result.put("success", true);
		return result;
	}
	
	/**
	 * 重置密码
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/reset")
	public Map<String, Object> reset(@RequestParam(value = "id", required = false) Integer id) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		userService.updateReset(id);
		result.put("success", true);
		return result;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session)throws Exception{
		SecurityUtils.getSubject().logout();
		return "redirect:/login.jsp";
	}
	
	@ResponseBody
	@RequestMapping("/updatepswd")
	public Map<String, Object> updatepswd(User user) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		userService.update(user);
		result.put("success", true);
		return result;
	}
	
}
