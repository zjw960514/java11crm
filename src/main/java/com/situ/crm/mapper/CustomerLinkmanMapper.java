package com.situ.crm.mapper;

import com.situ.crm.entity.CustomerLinkman;
import com.situ.crm.entity.CustomerLinkmanExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CustomerLinkmanMapper {
    int countByExample(CustomerLinkmanExample example);

    int deleteByExample(CustomerLinkmanExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(CustomerLinkman record);

    int insertSelective(CustomerLinkman record);

    List<CustomerLinkman> selectByExample(CustomerLinkmanExample example);

    CustomerLinkman selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") CustomerLinkman record, @Param("example") CustomerLinkmanExample example);

    int updateByExample(@Param("record") CustomerLinkman record, @Param("example") CustomerLinkmanExample example);

    int updateByPrimaryKeySelective(CustomerLinkman record);

    int updateByPrimaryKey(CustomerLinkman record);
}