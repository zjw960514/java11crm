<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${ctx}/static/common/js/util.js"></script>
<script src="${ctx}/static/lib/jquery-easyui/locale/easyui-lang-zh_CN.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctx}/static/lib/jquery-easyui/jquery.edatagrid.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	$(function() {
		$("#datagrid").datagrid({
			url : "${ctx}/saleChance/pageList.action",
			method : "get",
			fit : true,
			pagination : true,
			toolbar : "#toolbar",
			fitcolums : true,
			columns : [[
						{field:"cb",checkbox:true,align:"center"},
						{field:"id",title:"编号",width:80,align:"center"},
						{field:"customerName",title:"客户名称",width:80,align:"center"},
						{field:"chanceSource",title:"机会来源",width:80,align:"center"},
					    {field:'overview',title:'概要',width:80,align:'center'},    
					    {field:'linkMan',title:'联系人',width:80,align:'center'},    
					    {field:'linkPhone',title:'联系电话',width:100,align:'center'},    
					    {field:'createMan',title:'创建人',width:100,align:'center'},    
					    {field:'createTime',title:'创建时间',width:100,align:'center'},    
					    {field:'status',title:'状态',width:100,align:'center',formatter:function(value,row,index){
					    	 if(value==1){
					    		 return "已分配";
					    	 }else{
					    		 return "未分配";
					    	 }
					    }}    
					]],
			}),
		/* 初始化添加、修改的dialog */
		$("#dialog").dialog({
			closed : true,
		    buttons : [
		        {
		        	text : "保存",
		        	iconCls : "icon-ok",
		        	handler : function() {
		        		doAddOrUpdate();
		        	}
		        },
		        {
		        	text : "关闭",
		        	iconCls : "icon-cancel",
		        	handler : function() {
		        		$("#dialog").dialog("close");
		        	}
		        }
		    ]
		}),
		//如果分配指派人，指派时间为当前时间
		$(function(){
		    $("#d_assignMan").combobox({
		        onSelect:function(record){//record就是User对象
		            if(record.trueName!=''){
		                $("#d_assignTime").val(util.getCurrentDateTime());
		            }else{
		                $("#d_assignTime").val("");
		            }
		        }
		    });
		 });
	})
	function doSearch() {
		$('#datagrid').datagrid('load', { //通过load方法获取#datagrid的url地址从而发出请求
			customerName : $("#s_customerName").val(),
			linkMan : $("#s_linkMan").val(),
			createMan : $("#s_createMan").val(),
			status : $("#s_status").val(),
			createTime : $("#startTime").val(),
			assignTime: $("#overTime").val()
		})
	}

	function doDelete() {
		//调用easyUI的getSelections方法将会返回所有被选中的行，当没有记录被选中的时候将返回一个空数组。
		var ids = util.getSelectedIds($("#datagrid").datagrid("getSelections"));
		//[1,2,3]
		if (ids.length == 0) {
			$.messager.alert("系统提示", "请选择要删除的数据");
			return;
		}
		$.messager.confirm('确认', '您确认想要删除这'+  ids.length  + '条记录吗？', function(r) {
			if (r) {
				ids = ids.join(',');
				$.ajax({
					url : "${ctx}/saleChance/delete.action",
					data : {
						ids : ids
					},
					tyoe : "post",
					datatype : "json",
					error:function(){
						$.messager.alert("删除错误！","您选择的数据里面含有已分配的数据，请重新选择！");
					},
					success : function(jsonObj) {
						$.messager.alert("系统提示", jsonObj.msg);
						if (jsonObj.code == util.SUCCESS) {
							$("#datagrid").datagrid("reload");
						}
					}
				})
			}
		})
	}
	
	function exportExcel(){
		window.location.href = "${ctx}/saleChance/exportExcel.action";			
	}

	
	//将隐藏的dialog展示出来,并进行添加操作
	var url;
	function openAddDialog() {
		 url = "${ctx}/saleChance/add.action", 
		$("#dialog").dialog("open");
		$("#form").form("clear");
		$("#createMan").val('java');
		$("#createTime").val(util.getCurrentDateTime());
	}
	
	//将隐藏的dialog展示出来,并进行修改操作
	function openUpdateDialog(){
		url = "${ctx}/saleChance/update.action";
		var selections = $("#datagrid").datagrid("getSelections");
		if(selections.length == 0) {
			$.messager.alert("系统提示", "请选择要修改的行");
			return;
		}
		var row = selections[0];
		$("#dialog").dialog("open").dialog("setTitle", "修改信息");
		//load读取记录填充到表单中。数据参数可以是一个字符串或一个对象类型，如果是字符串则作为远程URL，否则作为本地记录
		$("#form").form("load", row);
   }
	
	/* 真正的去添加或者更新用户 */
	function doAddOrUpdate() {
		$("#form").form("submit", {
			url : url,
			onSubmit : function() {// do some check
				return $(this).form('validate');//返回false终止表单提交
			},
			success : function(data) {
				var jsonObj = eval("(" + data + ")");
				$.messager.alert("系统提示", jsonObj.msg);
				if(jsonObj.code == util.SUCCESS) {
					$("#dialog").dialog("close");
					$("#datagrid").datagrid("reload");
				}
			}
		})
	}
</script>
</head>
<body>
	<table id="datagrid"></table>

	<!-- toolbar开始 -->
	<div id="toolbar">
		<a href="javascript:openAddDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a> 
		<a href="javascript:openUpdateDialog()"class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a> 
		<a href="javascript:doDelete()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
		<a href="javascript:exportExcel()"class="easyui-linkbutton" data-options="iconCls:'icon-remove'">导出表格</a> 
		<div>
			客户名称：<input type="text" id="s_customerName" style="width:80"/> 
			联系人：<input type="text" id="s_linkMan" style="width:80" /> 
			创建人：<input type="text" id="s_createMan"  style="width:80"/> 
			分配状态：<select class="easyui-combobox" id="s_status" editable="false"  panelHeight="auto">
				<option value="">请选择...</option>
				<option value="0">未分配</option>
				<option value="1">已分配</option>
			    </select><br><br>
			开始时间：<input class="easyui-datebox" name="开始时间"     
       		   style="width:150px" id="startTime">
       	         结束时间：<input class="easyui-datebox" name="結束时间"     
       		  style="width:150px" id="overTime">  
			<a href="javascript:doSearch()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
		</div>
	</div>
	<!-- toolbar 结束 -->


	<!-- 添加和修改的dialog 开始 -->
    <div id="dialog" style="width:650;height:280,padding: 10px 20px">
       <form action="" id="form" method="post">
           <input type="hidden" id="id" name="id"/>
           <table cellspacing="8px">
              <tr>
		   			<td>客户名称：</td>
		   			<td><input type="text" id="customerName" name="customerName" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>机会来源</td>
		   			<td><input type="text" id="chanceSource" name="chanceSource" /></td>
		   		</tr>
		   		<tr>
		   			<td>联系人：</td>
		   			<td><input type="text" id="linkMan" name="linkMan" /></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>联系电话：</td>
		   			<td><input type="text" id="linkPhone" name="linkPhone" /></td>
		   		</tr>
		   		<tr>
		   			<td>成功几率(%)：</td>
		   			<td><input type="text" id="successRate" name="successRate" class="easyui-numberbox" data-options="min:0,max:100" required="true"/>&nbsp;<font color="red">*</font></td>
		   			<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   		</tr>
		   		<tr>
		   			<td>概要：</td>
		   			<td colspan="4"><input type="text" id="overview" name="overview" style="width: 420px"/></td>
		   		</tr>
		   		<tr>
		   			<td>机会描述：</td>
		   			<td colspan="4">
		   				<textarea rows="5" cols="50" id="description" name="description"></textarea>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>创建人：</td>
		   			<td><input type="text" editable="false" id="createMan" name="createMan" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>创建时间：</td>
		   			<td><input class="easyui-datebox" name="createTime" style="width:150px" id="createTime">
       		   			&nbsp;<font color="red">*</font></td>
		   		</tr>
		   		<tr>
		   			<td>指派给：</td>
		   			<td><input class="easyui-combobox" id="d_assignMan" name="d_assignMan" data-options="panelHeight:'auto',editable:false,valueField:'trueName',textField:'trueName',url:'${ctx}/user/selectCustomerManagerList.action'"/></td>
		   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		   			<td>指派时间：</td>
		   			<td><input type="text" id="d_assignTime" name="d_assignTime" readonly="readonly"/></td>
		   		</tr>
           </table>
       </form>
    </div>
    <!-- 添加和修改的dialog 结束 -->
</body>
</html>