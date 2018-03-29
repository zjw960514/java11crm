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
			url : "${ctx}/dataDic/pageList.action",
			method : "get",
			fit : true,
			pagination : true,
			toolbar : "#toolbar",
			fitcolums : true,
			columns : [[
				{field:"cb",checkbox:true,align:"center"}, 
				{field:"id",title:"编号",width:80,align:"center"},
				{field:"dataDicName",title:"数据字典名",width:380,align:"center"},
				{field:"dataDicValue",title:"数据字典值",width:380,align:"center"},
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
		//绑定数据字典的下拉框
		$('#dic_name').combobox({    
	    url:'${ctx}/dataDic/selectDicName.action',    
	    valueField:'dataDicName',    
	    textField:'dataDicName'   
		}); 
	})
	//搜索
	function doSearch() {
		$('#datagrid').datagrid('load', { //通过load方法获取#datagrid的url地址从而发出请求
			dataDicName : $("#dic_name").val(),
			dataDicValue : $("#dic_value").val()
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
					url : "${ctx}/dataDic/delete.action",
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
		 url = "${ctx}/dataDic/add.action", 
		$("#dialog").dialog("open");
		$("#form").form("clear");
	}
	
	//将隐藏的dialog展示出来,并进行修改操作
	function openUpdateDialog(){
		url = "${ctx}/dataDic/update.action";
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
			数据字典名：<input id="dic_name" name="dic_name" 
								data-options="
    							url:'${ctx}/dataDic/selectDataDicName.action',
    							valueField:'dataDicName',
    							textField:'dataDicName',
    							panelHeight:'auto' ">  
			数据字典值：<input type="text" id="dic_value"/>
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
                  <td>数据字典名：</td>
                  <td><input type="text" id="dataDicName" name="dataDicName" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
                   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td>数据字典名值：</td>
                  <td><input type="text" id="dataDicValue" name="dataDicValue" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
               </tr>
           </table>
       </form>
    </div>
    <!-- 添加和修改的dialog 结束 -->
</body>
</html>