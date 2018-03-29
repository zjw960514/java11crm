package com.situ.crm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.DataGrideResult;
import com.situ.crm.entity.Customer;
import com.situ.crm.service.ICustomerService;

@Controller
@RequestMapping("/customer")
public class CustomerController {

	@Autowired
	private ICustomerService customerService;
	
	
	@RequestMapping("/index")
	public String index() {
		return "customer_list";
	}
	
	@RequestMapping("/pageList") 
	@ResponseBody
	public  DataGrideResult<Customer>  pageList() {
		return customerService.PageList();
	}
}
