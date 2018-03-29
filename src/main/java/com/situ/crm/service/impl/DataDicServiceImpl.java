package com.situ.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.DataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.entity.DataDic;
import com.situ.crm.mapper.DataDicMapper;
import com.situ.crm.service.IDataDicService;

@Service
public class DataDicServiceImpl implements IDataDicService {

	@Autowired
	private DataDicMapper dataDicMapper;

	@Override
	public DataGrideResult<DataDic> PageList(Integer page, Integer rows, DataDic dataDic) {
		// 下边注释掉的是不需要分页的，只需要将数据查出来然后返回就好了。
		/*
		 * int total =dataDicMapper.pagelist().size(); List<Customer> rows =
		 * dataDicMapper.pagelist(); return new DataGrideResult<>(total, rows);
		 */

		// 1、设置分页 通过插件pageHelper
		PageHelper.startPage(page, rows);
		// 2、执行查询(查询的是分页之后的数据)
		List<DataDic> list = dataDicMapper.pageList(dataDic);
		// 3、得到满足条件的所有的数据的数量，二上面的list是满足条件的一页
		PageInfo pageInfo = new PageInfo<>(list);
		Integer total = (int) pageInfo.getTotal();
		return new DataGrideResult<>(total, list);
	}

	@Override
	public ServerResponse delete(String ids) {
		String[] idArray = ids.split(",");
		int count = dataDicMapper.deleteAll(idArray);
		if (count > 0) {
			return ServerResponse.createSuccess("删除成功");
		}
		return ServerResponse.createError("删除失败");
	}

	@Override
	public ServerResponse add(DataDic dataDic) {
		int count = dataDicMapper.insert(dataDic);
		if (count > 0) {
			return ServerResponse.createSuccess("添加成功");
		}
		return ServerResponse.createError("添加失败");
	}

	@Override
	public ServerResponse update(DataDic dataDic) {
		int count = dataDicMapper.updateByPrimaryKey(dataDic);
		if (count > 0) {
			return ServerResponse.createSuccess("修改成功");
		}
		return ServerResponse.createError("修改失败");
	}

	@Override
	public List<DataDic> selectDicName(DataDic dataDic) {
		return dataDicMapper.selectDicName(dataDic);
	}
}
