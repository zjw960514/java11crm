<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${ctx}/static/common/js/util.js"></script>
<script type="text/javascript">
	$(function() {
		$("#datagrid").datagrid({
			url : "${ctx}/user/pageList.action",
			method : "get",
			fit : true,
			pagination : true,
			toolbar : "#toolbar",
			fitcolums : true,
			columns : [[
				{field:"cb",checkbox:true,align:"center"},
				{field:"id",title:"编号",width:80,align:"center"},
				{field:"name",title:"用户名",width:80,align:"center"},
				{field:"trueName",title:"真实姓名",width:80,align:"center"},
				{field:"email",title:"邮箱",width:80,align:"center"},
				{field:"phone",title:"联系电话",width:80,align:"center"},
				{field:"roleName",title:"角色",width:80,align:"center"},
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
		}); 
	})
	function doSearch() {
		$('#datagrid').datagrid('load', { //通过load方法获取#datagrid的url地址从而发出请求
			name : $("#s_name").val(),
			email : $("#s_email").val(),
			roleName : $("#s_roleName").val(),
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
					url : "${ctx}/user/delete.action",
					data : {
						ids : ids
					},
					tyoe : "post",
					datatype : "json",
					success : function(jsonObj) {
						$.messager.alert("系统提示", jsonObj.msg);
						if (jsonObj.code == util.SUCCESS) {
							$("#datagrid").datagrid("reload");
						}
					}
				})
			}
		});
	}

	
	//将隐藏的dialog展示出来,并进行添加操作
	var url;
	function openAddDialog() {
		 url = "${ctx}/user/add.action", 
		$("#dialog").dialog("open");
		$("#form").form("clear");
	}
	
	//将隐藏的dialog展示出来,并进行修改操作
	function openUpdateDialog(){
		url = "${ctx}/user/update.action";
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
				if($("#roleName").combobox("getValue") == "") {
					$.messager.alert("系统提示", "请选择用户角色");
					return false;
				}
				return $(this).form('validate');//返回false终止表单提交
			},
			success : function(data) {
				// change the JSON string to javascript object
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
		<div>
			用户名：<input type="text" id="s_name" /> 
			邮箱：<input type="text" id="s_email" /> 
			角色：<select class="easyui-combobox" id="s_roleName" editable="false"  panelHeight="auto">
				<option value="">请选择...</option>
				<option value="系统管理员">系统管理员</option>
				<option value="销售主管">销售主管</option>
				<option value="客户经理">客户经理</option>
				<option value="高管">高管</option>
			    </select> 
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
                  <td>用户名：</td>
                  <td><input type="text" id="name" name="name" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
                   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td>密码：</td>
                  <td><input type="text" id="password" name="password" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
               </tr>
               <tr>
                  <td>真实姓名：</td> 
                  <td><input type="text" id="trueName" name="trueName" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
                   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td>邮箱：</td>
                  <td><input type="text" id="email" name="email" class="easyui-validatebox" required="true" validType="email"/><font color="red">*</font></td>
               </tr>
               <tr>
                  <td>联系电话：</td>
                  <td><input type="text" id="phone" name="phone" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
                   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td>用户角色：</td>
                  <td>
                      <select class="easyui-combobox" id="roleName" panelHeight="auto" editable="false" name="roleName" style="width:160">
                          <option value="">请选择...</option>
                          <option value="系统管理员">系统管理员</option>
                          <option value="销售主管">销售主管</option>
                          <option value="客户经理">客户经理</option>
                          <option value="高管">高管</option>
                      </select>
                      <font color="red">*</font></td>
               </tr>
           </table>
       </form>
    </div>
    <!-- 添加和修改的dialog 结束 -->
</body>
</html>