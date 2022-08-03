package com.lzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {

	@RequestMapping("/toAdminPage")
	public String toAdminPage() {
		System.out.println("toAdminPage ran()..");
		return "adminPage";
	}
}
