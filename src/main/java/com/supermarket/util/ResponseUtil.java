package com.supermarket.util;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

public class ResponseUtil {
	
	public static void write(HttpServletResponse response, Object o) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(o.toString());
		out.flush();
		out.close();
	}

	public static Map<String, Object> resultFye(Integer page, Integer limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page * 10 - 10);
		map.put("limit", limit);
		return map;
	}
	
	public static Map<String, Object> result(Object data,Object count) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", 0);
		result.put("msg", "");
		result.put("data", data);
		result.put("count", count);
		return result;
	}
}
