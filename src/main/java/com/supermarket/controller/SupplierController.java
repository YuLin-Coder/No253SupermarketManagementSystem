package com.supermarket.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.supermarket.entity.Supplier;
import com.supermarket.service.SupplierService;
import com.supermarket.util.ResponseUtil;

@Controller
@RequestMapping("/supplier")
public class SupplierController {

	@Resource
	private SupplierService supplierService;

	@ResponseBody
	@RequestMapping("/supplierList")
	public Map<String, Object> userList(HttpServletRequest req, Supplier supplier,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "limit", required = false) Integer limit) throws Exception {
		Map<String, Object> result = ResponseUtil.resultFye(page, limit);

		if (supplier.getName() != null) {
			String name = new String(supplier.getName().getBytes("ISO-8859-1"), "UTF-8");
			result.put("name", name);
		}
		List<Supplier> supplierList = supplierService.findAll(result);
		Long count = supplierService.count(result);
		return ResponseUtil.result(supplierList, count);
	}

	@ResponseBody

	@RequestMapping("/add")
	public Map<String, Object> add(Supplier supplier) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Supplier name = supplierService.findRepeat(supplier.getName());
		if (name == null) {
			supplierService.add(supplier);
			result.put("success", true);
		} else {
			result.put("success", false);
			result.put("errorInfo", "供应商已存在！");
		}
		return result;
	}

	@ResponseBody
	@RequestMapping("/delete")
	public Map<String, Object> delete(@RequestParam(value = "id", required = false) Integer id) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		supplierService.delete(id);
		result.put("success", true);
		return result;
	}

	
	@ResponseBody
	@RequestMapping("/update")
	public Map<String, Object> update(Supplier supplier) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		supplierService.update(supplier);
		result.put("success", true);
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/supplierlist")
	public Map<String, Object> supplier() throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Supplier> supplierList = supplierService.findAll(null);
		result.put("success", true);
		result.put("supplierList", supplierList);
		return result;
	}


}
