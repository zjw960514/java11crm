package com.situ.crm.service;

import com.situ.crm.common.DataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.entity.Customer;
import com.situ.crm.entity.Product;

public interface IProductService {

	DataGrideResult<Product> PageList(Integer page, Integer rows, Product product);

	ServerResponse delete(String ids);

	ServerResponse add(Product product);

	ServerResponse update(Product product);

}
