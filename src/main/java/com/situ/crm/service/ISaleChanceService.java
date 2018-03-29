package com.situ.crm.service;

import javax.servlet.http.HttpServletResponse;

import com.situ.crm.common.DataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.entity.SaleChance;

public interface ISaleChanceService {

	DataGrideResult<SaleChance> PageList(Integer page, Integer rows, SaleChance saleChance);

	ServerResponse delete(String ids);

	ServerResponse add(SaleChance saleChance);

	ServerResponse update(SaleChance saleChance);

	void exportExcel(HttpServletResponse response);


}
