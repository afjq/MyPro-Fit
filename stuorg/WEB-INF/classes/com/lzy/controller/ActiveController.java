package com.lzy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lzy.domain.Active;
import com.lzy.service.ActiveService;

@Controller
@RequestMapping(value = "/active")
public class ActiveController {

	@Autowired
	private ActiveService activeMapper;

//	/active/toManageActive
	@RequestMapping("/toManageActive")
	public String toManageActive(Model model) {
//		所有活动，用户
		List<Active> activeList = this.activeMapper.findAll();
		model.addAttribute("activeList", activeList);
		return "manageActive";
	}
}
