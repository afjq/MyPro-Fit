package com.lzy.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lzy.domain.Admin;
import com.lzy.domain.Clas;
import com.lzy.domain.Dep;
import com.lzy.domain.Org;
import com.lzy.domain.User;
import com.lzy.service.ClasService;
import com.lzy.service.DepService;
import com.lzy.service.OrgService;
import com.lzy.service.UserService;

@Controller
@RequestMapping(value = "/user")
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	private OrgService orgService;
	@Autowired
	private ClasService clasService;
	@Autowired
	private DepService depService;

//	去管理成员页面，根据部门Id查询所有用户给前端
	@RequestMapping("/toManageUser")
//user/toManageUser?depId=${dep.depId}&orgId=${orgId}	
	public String toManageUser(@Param("depId") Integer depId, @Param("orgId") Integer orgId, Model model,
			@RequestParam(required = true, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "5") Integer pageSize, HttpServletRequest request) {
		System.out.println("UserController.toManageUser() ran.");
		System.out.println("depId:" + depId + "---orgId:" + orgId);
//		分页:每页展示的条数
		PageHelper.startPage(page, 10);
//		准备用户集,org信息，dep信息
		List<User> userList = this.userService.findByDepId(depId);
		Org org = this.orgService.findById(orgId);
		Dep dep = this.depService.findById(depId);
//		分页
		PageInfo<User> pageInfo = new PageInfo<User>(userList);
		long total = pageInfo.getTotal(); // 总记录数
		int pages = pageInfo.getPages(); // 总页数
		pageSize = pageInfo.getPageSize(); // 每页的展示条数
		System.out.println("总记录数 :" + total);
		System.out.println("总页数 :" + pages);
		System.out.println("每页的展示条数 :" + pageSize);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("userList", userList);
		model.addAttribute("org", org);
		model.addAttribute("dep", dep);

		// 取用户,页面跳转判断
		HttpSession session = request.getSession();
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			return "manageUser";
		} else {
			return "user/showUser";
		}
	}

//	根据用户Id删除用户
	@RequestMapping("/delUser")
//	/user/delUser?userId=${user.userId }&depId=${dep.depId}&orgId=${orgId}	
	public String delUser(@Param("userId") Integer userId, @Param("depId") Integer depId,
			@Param("orgId") Integer orgId) {
		System.out.println("UserController.delUser() ran....userId=" + userId + ",depId+" + depId + ",orgId=" + orgId);
		this.userService.delUser(userId);
		return "redirect:/user/toManageUser?depId=" + depId + "&orgId=" + orgId;
	}

//	去修改成员信息页面
	@RequestMapping("/toUpdateUser")
//	/user/toUpdateUser?userId=${user.userId }&depId=${dep.depId}&orgId=${orgId}
	public String toUpdateUser(@Param("userId") Integer userId, @Param("depId") Integer depId,
			@Param("orgId") Integer orgId, Model model) {
		System.out.println("UserController.toUpdateUser() ran.");
		System.out.println("depId:" + depId + "---orgId:" + orgId + "---userId:" + userId);
//		根据用户Id查询用户给页面
		User user = this.userService.findById(userId);
		System.out.println(user);
//		查找组织名
//		查找部门名
		Org org = this.orgService.findById(orgId);
		Dep dep = this.depService.findById(depId);
//		查找组织列表，给修改成员页面的组织下拉列表
		List<Org> orgList = this.orgService.findAll();
//		根据组织Id查找部门成员
		List<Dep> depList = this.depService.findAll(orgId);
		List<Clas> clasList = this.clasService.findAll();
		model.addAttribute("org", org);
		model.addAttribute("dep", dep);
		model.addAttribute("user", user);
		model.addAttribute("orgList", orgList);
		model.addAttribute("depList", depList);
		model.addAttribute("clasList", clasList);
		return "updateUser";
	}

//	修改成员信息
	@RequestMapping("/updateUser")
	public String updateUser(@RequestParam("userId") Integer userId, @RequestParam("userName") String userName,
			@RequestParam("userNum") String userNum, @RequestParam("userPsw") String userPsw,
			@RequestParam("userPhone") String userPhone, @RequestParam("userQQ") String userQQ,
			@RequestParam("userClass") Integer userClass, @RequestParam("userOrg") Integer userOrg,
			@RequestParam("userDep") Integer userDep) {
		System.out.println("==============================================UserController.updateUser() ran.");
		System.out.println("userId===" + userId);
		System.out.println("userClass===" + userClass);
		System.out.println("userOrg===" + userOrg);
		System.out.println("userDep===" + userDep);
		Clas clas = this.clasService.findById(userClass);
		Org org = this.orgService.findById(userOrg);
		Dep dep = this.depService.findById(userDep);
//		准备user
		User user = new User();
		user.setUserId(userId);
		user.setUserName(userName);
		user.setUserNum(userNum);
		user.setUserPsw(userPsw);
		user.setUserPhone(userPhone);
		user.setUserQq(userQQ);
		user.setUserClass(clas);
		user.setUserOrg(org);
		user.setUserDep(dep);
		System.out.println("user为：" + user);
//		更新用户
		this.userService.updateById(user);
		System.out.println("更新用户成功");
		return "redirect:/user/toManageUser?depId=" + dep.getDepId() + "&orgId=" + org.getOrgId();
	}

//	去注册页面
	@RequestMapping("/toRegist")
	public String toRegist(Model model) {
		System.out.println("===============================================UserController.toRegist() ran.");
//		准备组织、班级;
//		部门信息采用异步请求的二级联动
		List<Clas> clasList = this.clasService.findAll();
//		for (Clas clas : clasList) {
//			System.out.println(clas);
//		}
		List<Org> orgList = this.orgService.findAll();
		model.addAttribute("clasList", clasList);
		model.addAttribute("orgList", orgList);
		return "regist";
	}

//	注册
	@RequestMapping("/regist")
	public String regist(@RequestParam("num") String num, @RequestParam("name") String name,
			@RequestParam("psw") String psw, @RequestParam("phone") String phone, @RequestParam("QQ") String QQ,
			@RequestParam("clas") Integer clas, @RequestParam("org") Integer org, @RequestParam("dep") Integer dep,
			Model model) {
		System.out.println("UserController.regist() ran.");
//		判断该账户是否已经存在？
		User userCheck = this.userService.findByNum(num);
		if (userCheck == null) {// 用户不存在
//			不存在该用户，可以继续注册：找到班级，组织，部门
			Clas clas1 = this.clasService.findById(clas);
			Org org2 = this.orgService.findById(org);
			Dep dep2 = this.depService.findById(dep);
//			封装User
//			null, num, name, psw, org2, dep2, clas1, phone, QQ, null
			User user = new User();
			user.setUserNum(num);
			user.setUserName(name);
			user.setUserPsw(psw);
			user.setUserOrg(org2);
			user.setUserDep(dep2);
			user.setUserClass(clas1);
			user.setUserPhone(phone);
			user.setUserQq(QQ);
			System.out.println("准备好的：：：" + user);
//			注册
			this.userService.insertUser(user);
			System.out.println("插入用户成功");
//			直接去登陆页面
			model.addAttribute("mes", "注册成功，请登录。");
			return "index";
		} else {// 用户已存在，跳转登录页面
			model.addAttribute("mes", "该用户已存在，请登录。");
			return "index";
		}
	}
}
