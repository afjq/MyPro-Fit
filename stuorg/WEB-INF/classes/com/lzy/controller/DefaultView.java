package com.lzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DefaultView {

	@RequestMapping("/")
	public String defaultView() {
		System.out.println("defaultView() ran.");
		return "index";
	}
}