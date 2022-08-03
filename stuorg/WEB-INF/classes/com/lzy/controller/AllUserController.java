package com.lzy.controller;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lzy.domain.Admin;
import com.lzy.domain.User;
import com.lzy.service.AdminService;
import com.lzy.service.UserService;

@Controller
@RequestMapping(value = "/allUser")
public class AllUserController {

	@Autowired
	private AdminService adminService;
	@Autowired
	private UserService userService;

//	登陆，分为管理员和用户
	/**
	 * @param num
	 * @param psw
	 * @param identity
	 * @param model
	 * @param httpSession
	 * @return
	 */
	@RequestMapping("/login")
	public String login(@RequestParam("num") String num, @RequestParam("psw") String psw,
			@RequestParam("identity") String identity, Model model, HttpSession httpSession) {

		System.out.println("AdminController.aLogin() ran...");
		System.out.println("页面的num=" + num);
		System.out.println("页面的psw=" + psw);
		System.out.println("页面的identity=" + identity);

//		判断identity的值是user还是admin
		if (identity.equals("user")) {// 是用户
//			根据用户的学号在数据库中找到用户
			User user = userService.findByNum(num);
			System.out.println("根据登录账号找到的admin：" + user);
			if (user == null) {// 如果找到的User是null，就封装提示信息到Model。
				model.addAttribute("mes", "该用户不存在，请注册。");
				return "index";
			} else {// 否则user存在，判断用户账户密码是否正确
				if (user.getUserPsw().equals(psw)) {// 密码正确
					httpSession.setAttribute("user", user);
					return "user/userPage";// 跳转用户页面
				} else {// 密码错误
					model.addAttribute("mes", "账号或密码有误，请重新输入。");
					return "index";
				}
			}

		} else {// 管理员身份登录
//			根据管理员账号在数据库找到的管理员
			Admin admin = adminService.findByAdminNum(num);
			System.out.println("根据登录账号找到的admin：" + admin);
			if (admin == null) {// 如果找到的User是null，就封装提示信息到Model。
				model.addAttribute("mes", "该管理员不存在，请注册。");
				return "index";
			} else {// 否则，判断用户账户密码是否正确
				if (admin.getAdminPsw().equals(psw)) {// 密码正确，跳转页面
//					session保存管理员
					httpSession.setAttribute("admin", admin);
					return "adminPage";// 跳转到管理员选择管理中心
				} else {// 密码错误
					model.addAttribute("mes", "账号或密码有误，请重新输入。");
					return "index";
				}
			}
		}

	}

	@RequestMapping("/logOut")
	public String logOut(HttpServletRequest request) {
		System.out.println("AllUserController.logOut() ran...");
		Enumeration em = request.getSession().getAttributeNames();
		System.out.println(em);
		while (em.hasMoreElements()) {
			request.getSession().removeAttribute(em.nextElement().toString());
		}
		return "index";
	}

}
