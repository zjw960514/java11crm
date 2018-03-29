package com.situ.crm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.situ.crm.common.DataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.entity.DataDic;
import com.situ.crm.service.IDataDicService;

@Controller
@RequestMapping("/dataDic")
public class DataDicController {

	@Autowired
	private IDataDicService dataDicService;
	
	
	@RequestMapping("/dataDicManage")
	public String index() {
		return "data_dic_index";
	}
	

	@RequestMapping("/pageList") 
	@ResponseBody
	public  DataGrideResult<DataDic>  pageList(Integer page ,Integer rows , DataDic dataDic) {
		return dataDicService.PageList(page, rows ,dataDic);
	}
	
	
	@RequestMapping("/delete") 
	@ResponseBody
	public   ServerResponse delete(String ids){
		return dataDicService.delete(ids);
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public ServerResponse add(DataDic dataDic) {
		return dataDicService.add(dataDic);
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public ServerResponse update(DataDic dataDic){
		return dataDicService.update(dataDic);
	}
	
	@RequestMapping("/selectDicName")
	@ResponseBody
	public List<DataDic> selectDicName(DataDic dataDic){
		return dataDicService.selectDicName(dataDic);
	}
}
