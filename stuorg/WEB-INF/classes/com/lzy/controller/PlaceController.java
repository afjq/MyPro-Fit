package com.lzy.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lzy.domain.Admin;
import com.lzy.domain.Place;
import com.lzy.domain.Ptype;
import com.lzy.service.PlaceService;
import com.lzy.service.PtypeService;

@Controller
@RequestMapping(value = "/place")
public class PlaceController {

	@Autowired
	private PtypeService ptypeService;
	@Autowired
	private PlaceService placeService;

//	toManagePlace
	@RequestMapping("/toManagePlace")
	public String toManagePlace(Model model, HttpServletRequest request) {
		System.out.println("toManagePlace ran()..");
		List<Ptype> ptypeList = this.ptypeService.findAll();
		model.addAttribute("ptypeList", ptypeList);

		// 取用户,页面跳转判断
		HttpSession session = request.getSession();
		Admin admin = (Admin) session.getAttribute("admin");
		if (admin != null) {
			return "managePlace";
		} else {
			return "user/showPlace";
		}
	}

//	删除场地
//	/plce/delPlace?placeId=${place.placeId }
	@RequestMapping("/delPlace")
	public String delPlace(@RequestParam("placeId") Integer placeId) {
		System.out.println("delPlace ran()..");
		this.placeService.delById(placeId);
		System.out.println("删除场地成功！");
		return "redirect:/place/toManagePlace";
	}

//	新增场地
//	/place/insertPlace
	@RequestMapping("/insertPlace")
	public String insertPlace(@RequestParam("placeName") String placeName,
			@RequestParam("placeCapacity") Integer placeCapacity, @RequestParam("placeType") Integer placeType) {
//		根据类型ID找到类型
		Ptype ptype = this.ptypeService.findById(placeType);
		Place place = new Place();
		place.setPlaceName(placeName);
		place.setPlaceCapacity(placeCapacity);
		place.setPlaceType(ptype);
		System.out.println("新增的place===" + place);
		this.placeService.insertPlace(place);
		System.out.println("新增place成功。");
		return "redirect:/place/toManagePlace";
	}

//	修改场地
//	/plce/updatePlace?placeId=${place.placeId }
	@RequestMapping("/updatePlace")
	public String updatePlace(@RequestParam("placeId") Integer placeId) {
//		findByID
		Place place = this.placeService.findById(placeId);
//		this.placeService.
		return "managePlace";
	}

//	Ajax 通过场地类型ID请求 获取 场地list	
	@ResponseBody
	@RequestMapping(value = "/findAllPlaceByPtypeId", produces = "application/json; charset=utf-8")
	public List<Place> findAllPlaceByPtypeId(@RequestParam("ptypeId") Integer ptypeId) {
		System.out.println("DepController.findAllDepByOrgId() ran.");
		System.out.println("页面的ptypeId=" + ptypeId);
		List<Place> placeList = this.placeService.findByPtypeId(ptypeId);
//		System.out.println("查找的该组织下的所有部门：");
//		for (Place place : placeList) {
//			System.out.println(place);
//		}
		return placeList;
	}
}
