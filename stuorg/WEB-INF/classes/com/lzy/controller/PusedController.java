package com.lzy.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lzy.domain.Admin;
import com.lzy.domain.Dep;
import com.lzy.domain.Place;
import com.lzy.domain.Pused;
import com.lzy.domain.User;
import com.lzy.service.PlaceService;
import com.lzy.service.PusedService;

@Controller
@RequestMapping(value = "/pused")
public class PusedController {
	@Autowired
	private PusedService pusedService;
	@Autowired
	private PlaceService placeService;

//	查看某个场地的使用情况
//	/pused/toShowPused?${place.placeId }
	@RequestMapping("/toShowPused")
	public String toShowPused(@RequestParam("placeId") Integer placeId, Model model,
			@RequestParam(required = true, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "5") Integer pageSize, HttpServletRequest request) {
//		分页:每页展示的条数
		PageHelper.startPage(page, 10);
//		使用记录集合
		List<Pused> pusedList = this.pusedService.findByPlaceId(placeId);
//		场地基本信息
		Place place = this.placeService.findById(placeId);
//		创建分页信息
		PageInfo<Pused> pageInfo = new PageInfo<Pused>(pusedList);
		long total = pageInfo.getTotal(); // 总记录数
		int pages = pageInfo.getPages(); // 总页数
		pageSize = pageInfo.getPageSize(); // 每页的展示条数
		System.out.println("总记录数 :" + total);
		System.out.println("总页数 :" + pages);
		System.out.println("每页的展示条数 :" + pageSize);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("pusedList", pusedList);
		model.addAttribute("place", place);

		// 取用户,页面跳转判断
		HttpSession session = request.getSession();
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			return "managePused";
		} else {
			return "user/showPused";
		}
	}

//	申请使用场地	
//	/pused/applyPlace
	@ResponseBody
	@RequestMapping(value = "/applyPlace", produces = "application/json; charset=utf-8")
	public String applyPlace(@RequestParam("placeId") Integer placeId, @RequestParam("pusedFor") String pusedFor,
			@RequestParam("pusedStartTime") Date pusedStartTime, @RequestParam("pusedEndTime") Date pusedEndTime,
			HttpServletRequest request) {
		System.out.println("PusedController.applyPlace() ran ....");
		// 取用户,页面跳转判断
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
//		用户的部门
		Dep userDep = user.getUserDep();
		Place place = this.placeService.findById(placeId);
//		创建对象
		Pused pused = new Pused();
//		申请时间，现在新建一个
		pused.setPusedApplyTime(new Date());
		pused.setPusedStartTime(pusedStartTime);
		pused.setPusedEndTime(pusedEndTime);
		pused.setPusedPlace(place);
		pused.setPusedFor(pusedFor);
		pused.setPusedDep(userDep);
		System.out.println("准备好的pused===" + pused);
		int i = this.pusedService.insertPused(pused);
		if (i == 1) {
			System.out.println("插入成功！");
			String msg = "提交申请成功！请等待教师审核！";
			return msg;
		} else {
			System.out.println("插入失败！");
			String msg = "失败！";
			return msg;
		}

	}

	@InitBinder
	public void initBinder(WebDataBinder binder, WebRequest request) {
		System.out.println("日期转换");
		// 转换日期
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));// CustomDateEditor为自定义日期编辑器
	}
}
