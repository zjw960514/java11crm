package com.situ.crm.common;

import java.io.Serializable;
import java.util.List;


/*
 * 
 * easyUi数据表格返回所需要的数据结构
 * @param<T>
 */

public class DataGrideResult <T> implements Serializable{

	private Integer total;
	private List<T> rows;
	@Override
	public String toString() {
		return "DataGrideResult [total=" + total + ", rows=" + rows + "]";
	}
	public DataGrideResult() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DataGrideResult(Integer total, List<T> rows) {
		super();
		this.total = total;
		this.rows = rows;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public List<T> getRows() {
		return rows;
	}
	public void setRows(List<T> rows) {
		this.rows = rows;
	}
	
	
}
