<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	request.setAttribute("path", path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户信息</title>
</head>
<body>
<table id="userTable" style="width: 100%;height: 650px"></table>
<div id="queryId">
	<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteUsers()">删除</a><br><br>
	      读者名字:<input  class="easyui-textbox" name="name"  id="name" />
	读者身份:<select class="easyui-combobox" name="yes" id="yes" style="width: 150px" data-options="prompt:'请选择',loader:userType,mode:'remote',valueField:'id',textField:'roleName',
        panelWidth:150"></select>
	<a class="easyui-linkbutton" onclick="searchParamUser()">查询</a>
	<a class="easyui-linkbutton" onclick="$('#name').textbox('clear');$('#yes').textbox('clear')">重置</a>
	<br>
</div>
<div id="dialog" class="easyui-dialog" title="编辑用户信息"
	 style="width: 400px;height: 400px"
	 data-options="closed:true,modal:true">
</div>
<input type="hidden" value="${path }" id="path">
</body>
<script type="text/javascript">
	const userTypeArray=new Array();//过滤器
	$(function () {
		$('#userTable').datagrid({
			title:'用户列表',
			url:'/book/user/getAlluserlist',
			method:'get',
			pagination: true,//显示分页工具栏
			rownumbers:true,
			singleSelect:false,
			toolbar:'#queryId',//绑定工具栏
			// fitColumns: true,
			// frozenColumns:[[{field:'id',title:'主键',width:'100'}]],//冻结
			loadMsg:'正在加载,请稍后...',
			columns:[[
				{field:'ck',checkbox:true},
				{field:'id',title:'读者id',width:'5%', sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'userName',title:'读者账号',width:'15%', sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'passWord',title:'读者密码',width:'10%', sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'name',title:'读者名字',width:'15%', sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'address',title:'读者住址',width:'15%', sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'yes',title:'读者角色',width:'10%', sortable:true,editor:{
						type:'combobox',
						options:{
							url:$("#path").val()+'/base/getUserLevel',
							method:'post',
							valueField:'id',
							textField:'roleName'
						}
					},
					formatter: function (value, row, index) {
					for (var j=0;j<userTypeArray.length;j++){
						if(row.yes==userTypeArray[j].id){
							return userTypeArray[j].roleName;
						}
					}
						return "未获取";
					}},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'createDate',title:'注册时间',width:'26%',formatter: function (value, row, index) {
						return formatDateBoxFull(value);
					}},
			]],
			onLoadSuccess:function (data) {//请求成功，返回的数据

			},
			onClickRow:function (index) {
				// $("#myTable").datagrid("beginEdit",index);
			},
			onDblClickRow: function (rowIndex, rowData) {//双击
				$("#dialog").dialog({
					href:'/book/jsp/userlistbyadmin.jsp?id='+rowData.id,
				})
				$('#dialog').dialog('open');
			}
		});
	})

	function searchParamUser() {
		//获取表格的查询参数
		var queryParams=$("#userTable").datagrid('options').queryParams;
		queryParams.name=$("#name").val();
		queryParams.yes=$("#yes").combobox("getValue");
		//重新加载表格数据
		$("#userTable").datagrid('load');
	}

	//删除
	function deleteUsers() {
		var ids = [];
		var rows=$("#userTable").datagrid('getSelections');//获取选中的项
		ids=rows.map(o=>{
			return o.id;
		})
		if(ids.length==0){
			$.messager.alert("请至少选择一条数据");
		}else{
			var list="";
			for (let i = 0; i < ids.length; i++) {
				list +=ids[i]+",";
			}
			$.messager.confirm('提示', '确定删除吗?', function(r){
				if (r){
					$.ajax({
						url:$("#path").val()+"/user/deleteByIdList",
						data:{"idList":list},
						dataType:"json",
						success:function(result){
							if(result=="success"){
								$.messager.alert("提示","删除成功！");
								$("#userTable").datagrid('load');
							}else{
								$.messager.alert("提示","删除失败！")
							}
						},
						error:function(){
							$.messager.alert("提示","后端请求失败.");
							$("#userTable").datagrid('load');
						}

					})
				}
			});
		}

	}


	//请求用户类型
	function userType(param, success, error) {
		$.ajax({
			url:$("#path").val()+'/base/getUserLevel',
			dataType:'json',
			method:'post',
			success:function (data) {
				for (var i=0;i<data.length;i++){
					userTypeArray.push(data[i]);
				}
				success(data);
			},
			error:function () {
				error.apply(this,arguments)
			}
		})
	}

</script>
</html>