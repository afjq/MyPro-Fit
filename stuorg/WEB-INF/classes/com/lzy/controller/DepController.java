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
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lzy.domain.Admin;
import com.lzy.domain.Dep;
import com.lzy.domain.Org;
import com.lzy.service.DepService;
import com.lzy.service.OrgService;

@Controller
@RequestMapping(value = "/dep")
public class DepController {

	@Autowired
	private DepService depService;
	@Autowired
	private OrgService orgService;

//	regist页面的二级联动下拉列表，
	// 根据组织Id查询部门，页面js+ajax异步请求
//	此时不用Model封装，而是方法返回类型直接返回，使用	@ResponseBody   注解
	@ResponseBody
	@RequestMapping(value = "/findAllDepByOrgId", produces = "application/json; charset=utf-8")
	public List<Dep> findAllDepByOrgId(@RequestParam("orgId") Integer orgId) {
		System.out.println("DepController.findAllDepByOrgId() ran.");
		System.out.println("页面的orgId=" + orgId);
		List<Dep> depList = this.depService.findAll(orgId);
//		System.out.println("查找的该组织下的所有部门：");
//		for (Dep dep : depList) {
//			System.out.println(dep);
//		}
		return depList;
	}

//	去部门管理页面
//	/dep/toManageDep?orgId=${org.orgId}
	@RequestMapping("/toManageDep")
	public String toManageDep(@RequestParam("orgId") Integer orgId, Model model,
			@RequestParam(required = true, defaultValue = "1") Integer page,
			@RequestParam(required = false, defaultValue = "5") Integer pageSize, HttpServletRequest request) {
		System.out.println("toManageDep() ran....orgId=" + orgId);
//		分页:每页展示的条数
		PageHelper.startPage(page, 10);
//		准备部门数据
		List<Dep> depList = this.depService.findAll(orgId);
		Org org = this.orgService.findById(orgId);
//		分页
		PageInfo<Dep> pageInfo = new PageInfo<Dep>(depList);
		long total = pageInfo.getTotal(); // 总记录数
		int pages = pageInfo.getPages(); // 总页数
		pageSize = pageInfo.getPageSize(); // 每页的展示条数
		System.out.println("总记录数 :" + total);
		System.out.println("总页数 :" + pages);
		System.out.println("每页的展示条数 :" + pageSize);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("depList", depList);
		model.addAttribute("org", org);
		// 取用户,页面跳转判断
		HttpSession session = request.getSession();
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			return "manageDep";
		} else {
			return "user/showDep";
		}

	}

	// 删除部门
	@RequestMapping("delDep")
	public String delDep(@Param("depId") Integer depId, @Param("orgId") Integer orgId) {
		System.out.println("DepController.delDep() ran");
		System.out.println("从ManageDep页面收到的depId是：" + depId);
		this.depService.delDepById(depId);
		// 需要给组织Id，用来查询显示所有部门
		return "redirect:/dep/toManageDep?orgId=" + orgId;
	}

//	去新增部门页面
//	@RequestMapping("toInsertDep")
//	public String toInsertDep(@Param("orgId") Integer orgId, Model model) {
//		System.out.println("toInsertDep() ran ....,orgId==========" + orgId);
//		Org org = this.orgService.findById(orgId);
//		model.addAttribute("org", org);
//		return "insertDep";
//	}

//	insertDep插入部门
	@RequestMapping("insertDep")
	public String insertDep(@Param("depName") String depName, @Param("orgId") Integer orgId) {
		System.out.println("insertDep() ran ...." + depName + orgId);
		this.depService.insertDep(depName, orgId);
		return "redirect:/dep/toManageDep?orgId=" + orgId;
	}

//	去修改部门页面
//	/dep/toUpdateDep?depId=${dep.depId}&orgId=${orgId}
	@RequestMapping("toUpdateDep")
	public String toUpdateDep(@Param("depId") Integer depId, @Param("orgId") Integer orgId, Model model) {
		System.out.println("toUpdateDep() ran ....");
//		通过Service层封装的，通过部门Id查找部门名称
		Dep dep = this.depService.findById(depId);
		Org org = this.orgService.findById(orgId);
		model.addAttribute("dep", dep);
		model.addAttribute("org", org);
		return "updateDep";
	}

	// 修改部门
	@RequestMapping("updateDep")
	public String updateDep(@Param("depId") Integer depId, @Param("depName") String depName,
			@Param("orgId") Integer orgId) {
		System.out.println("DepController.updateDep() ran");
		System.out.println("从UpdateDep页面收到的depId,depName,orgId是：" + depId + depName + orgId);
//		从数据库查询，
		Dep depFromDB = this.depService.findById(depId);
		String depNameFromDB = depFromDB.getDepName();

//		判断是否一样，如果不一样，就修改部门表
		if (!depName.equals(depNameFromDB)) { // 修改了
			this.depService.updateDepById(depId, depName);
			// 需要给组织Id，用来查询显示所有部门
		}
		return "redirect:/dep/toManageDep?orgId=" + orgId;

	}

}
