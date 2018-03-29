package com.situ.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.situ.crm.common.DataGrideResult;
import com.situ.crm.entity.Customer;
import com.situ.crm.mapper.CustomerMapper;
import com.situ.crm.service.ICustomerService;

@Service
public class CustomerServiceImpl implements ICustomerService {

	@Autowired
	private CustomerMapper CustomerMapper;
	
	
	@Override
	public DataGrideResult<Customer> PageList() {
		int total =CustomerMapper.pagelist().size();
		 List<Customer> rows = CustomerMapper.pagelist();
		 return new DataGrideResult<>(total, rows);
	}

}
