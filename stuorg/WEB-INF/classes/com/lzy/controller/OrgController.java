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
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lzy.domain.Admin;
import com.lzy.domain.Org;
import com.lzy.service.OrgService;

@Controller
@RequestMapping(value = "/org")
public class OrgController {

	@Autowired
	private OrgService orgService;

//	去三级联动管理页面
//	提供orgList
	@RequestMapping(value = "/toManageOrg")
	public String toManageOrg(Model model, @RequestParam(required = true, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "5") Integer pageSize, HttpServletRequest request) {
		System.out.println("OrgController.toManageOrg() ran...");
//		分页:每页展示的条数
		PageHelper.startPage(page, 20);
		List<Org> orgList = this.orgService.findAll();

		PageInfo<Org> pageInfo = new PageInfo<Org>(orgList);
		long total = pageInfo.getTotal(); // 总记录数
		int pages = pageInfo.getPages(); // 总页数
		pageSize = pageInfo.getPageSize(); // 每页的展示条数
		System.out.println("总记录数 :" + total);
		System.out.println("总页数 :" + pages);
		System.out.println("每页的展示条数 :" + pageSize);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("orgList", orgList);

		// 取用户,页面跳转判断
		HttpSession session = request.getSession();
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			return "manageOrg";
		} else {
			return "user/showOrg";
		}

	}

//	/org/delOrg?orgId=${org.orgId}
//	删除组织
	@RequestMapping("delOrg")
	public String delOrg(@Param("orgId") String orgId) {
		System.out.println("OrgController.delOrg() ran");
		System.out.println("从ManageOrg页面传来的值orgId是" + orgId);
		this.orgService.delOrgById(Integer.parseInt(orgId));
		return "redirect:/org/toManageOrg";
	}

//	/org/toInsertOrg
//	去新增一个组织页面
//	@RequestMapping("toInsertOrg")
//	public String toInsertOrg() {
//		return "insertOrg";
//	}

//	insertOrg
//	新增组织
	@RequestMapping("insertOrg")
	public String insertOrg(@Param("orgName") String orgName) {
		System.out.println("OrgController.insertOrg() ran");
		System.out.println("从insertOrg页面传来的值orgName是" + orgName);
		Org org = new Org();
		org.setOrgName(orgName);
		this.orgService.insertOrg(org);
		return "redirect:/org/toManageOrg";
	}

//	/org/toUpdateOrg?orgId=${org.orgId}&orgName=${org.orgName}
//	去修改组织编辑页面
	@RequestMapping("toUpdateOrg")
	public ModelAndView toUpdateOrg(@Param("orgId") String orgId) {
		System.out.println("OrgController.toUpdateOrg() ran");
		System.out.println("orgId=" + orgId);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("orgId", orgId);
		modelAndView.setViewName("updateOrg");
		return modelAndView;
	}

//	/org/updateOrg?orgId=${orgId }
//	修改组织
	@RequestMapping("updateOrg")
	public String updateOrg(Org org) {
		System.out.println("OrgController.updateOrg() ran");
		System.out.println("从UpdateOrg页面传来的值是" + org.getOrgId() + org.getOrgName());
//		更新组织
		int i = this.orgService.updateOrg(org);
		System.out.println(i);
		return "redirect:/org/toManageOrg";
	}
}
