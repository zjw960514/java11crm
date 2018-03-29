package com.situ.crm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.DataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.entity.Product;
import com.situ.crm.service.IProductService;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private IProductService productService;
	
	
	@RequestMapping("/productManage")
	public String index() {
		return "product_index";
	}
	

	@RequestMapping("/pageList") 
	@ResponseBody
	public  DataGrideResult<Product>  pageList(Integer page ,Integer rows , Product product) {
		return productService.PageList(page, rows ,product);
	}
	
	
	@RequestMapping("/delete") 
	@ResponseBody
	public   ServerResponse delete(String ids){
		return productService.delete(ids);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ServerResponse add(Product product) {
		return productService.add(product);
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public ServerResponse update(Product product){
		return productService.update(product);
	}
	
}
