package com.situ.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.situ.crm.common.DataGrideResult;
import com.situ.crm.common.ServerResponse;
import com.situ.crm.entity.Customer;
import com.situ.crm.entity.User;
import com.situ.crm.mapper.CustomerMapper;
import com.situ.crm.mapper.UserMapper;
import com.situ.crm.service.ICustomerService;
import com.situ.crm.service.IUserService;

@Service
public class UserServiceImpl implements IUserService {

	@Autowired
	private UserMapper userMapper;

	@Override
	public DataGrideResult<User> PageList(Integer page, Integer rows, User user) {
		// 下边注释掉的是不需要分页的，只需要将数据查出来然后返回就好了。
		/*
		 * int total =userMapper.pagelist().size(); List<Customer> rows =
		 * userMapper.pagelist(); return new DataGrideResult<>(total, rows);
		 */

		// 1、设置分页 通过插件pageHelper
		PageHelper.startPage(page, rows);
		// 2、执行查询(查询的是分页之后的数据)
		List<User> list = userMapper.pageList(user);
		// 3、得到满足条件的所有的数据的数量，二上面的list是满足条件的一页
		PageInfo pageInfo = new PageInfo<>(list);
		Integer total = (int) pageInfo.getTotal();
		return new DataGrideResult<>(total, list);
	}

	@Override
	public ServerResponse delete(String ids) {
		String[] idArray = ids.split(",");
		int count = userMapper.deleteAll(idArray);
		if (count > 0) {
			return ServerResponse.createSuccess("删除成功");
		}
		return ServerResponse.createError("删除失败");
	}

	@Override
	public ServerResponse add(User user) {
		int count = userMapper.insert(user);
		if (count > 0) {
			return ServerResponse.createSuccess("添加成功");
		}
		return ServerResponse.createError("添加失败");
	}

	@Override
	public ServerResponse update(User user) {
		int count = userMapper.updateByPrimaryKey(user);
		if (count > 0) {
			return ServerResponse.createSuccess("修改成功");
		}
		return ServerResponse.createError("修改失败");
	}

	@Override
	public List<User> selectCustomerManagerList() {
		return userMapper.selectCustomerManagerList();
	}
}
