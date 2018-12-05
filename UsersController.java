package com.ldxy.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ldxy.entity.Users;
import com.ldxy.service.UsersService;

@Controller
public class UsersController {
	
	@Autowired
	private UsersService usersService;
	
	@RequestMapping("show/{toPage}")
	public String show(@PathVariable String toPage) {
		return toPage;
	}
	
	//处理员工登录请求的方法
	@RequestMapping("login")
	public String login(String userName,String userPassword,HttpServletRequest request) {
		String address = null;
		Users users = usersService.login(userName, userPassword);
		HttpSession session = request.getSession();
		if(users != null) {
			session.setAttribute("users", users);
			address = "index";
		}else {
			session.setAttribute("nouser", "用户名或密码错误");
			address = "login";
		}
		return address;
	}
	
	//处理页面加载的方法
	@RequestMapping("choose/{pageName}/{pageNum}")
	public ModelAndView choose(@PathVariable String pageName,@PathVariable int pageNum) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(pageName);
		if(!"top".equals(pageName) && !"left".equals(pageName)) {
			Map map = getPage(pageName,pageNum);
			modelAndView.addObject("pageNum", map.get("pageNum"));
			modelAndView.addObject("pageSize", map.get("pageSize"));
			modelAndView.addObject("list", map.get("list"));
			modelAndView.addObject("rowNum", map.get("rowNum"));
			modelAndView.addObject("num", map.get("num"));
		}
		return modelAndView;
	}
	
	@RequestMapping("getPage")
	@ResponseBody
	public Map getPage(String pageName,int pageNum) {
		int pageSize = 1;
		List<Users> list = null;
		int rowNum = 0;
		int num;
		switch(pageName) {
		case "user" :
			list = usersService.thisPage(pageSize, pageNum);
			rowNum = usersService.count();
			break;
		}
		num = (rowNum % pageSize == 0) ? (rowNum / pageSize) : (rowNum / pageSize) + 1;
		Map map = new HashMap();
		map.put("pageNum", pageNum); //当前页页码
		map.put("pageSize", pageSize);//每页显示记录数
		map.put("list", list);//当前页面所有记录
		map.put("rowNum", rowNum);//数据库所有记录条数
		map.put("num", num);//总页数
		return map;
	}
	
	@RequestMapping("user1")
	@ResponseBody
	public List<Users> getUser(Model model) {
		int pageSize = 1;
		int pageNum = 1;
		List<Users> list = usersService.selectAll();
		int rowNum = usersService.count();
		int num = (rowNum % pageSize == 0) ? (rowNum / pageSize) : (rowNum / pageSize) + 1;
		model.addAttribute("pageSize", pageSize);
		return list;
	}
	
	
	
}
