package com.situ.crm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexCrotroller {

	
	@RequestMapping("/index")
	public String index() {
		return "index";
	}
}
