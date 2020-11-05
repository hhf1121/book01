<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path=request.getContextPath();
request.setAttribute("path", path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员借阅历史</title>
</head>
<body>
<table id="librarylistTable" style="width: 100%;height: 650px"></table>
<div id="querylibraryId" style="margin: 10px">
	图书名称:<input  class="easyui-textbox" name="bookName"  id="bookName" />
	读者名称:<input  class="easyui-textbox" name="userName"  id="userName" />
	<a class="easyui-linkbutton" onclick="searchParamLibrary()">查询</a>
	<a class="easyui-linkbutton" onclick="$('#userName').textbox('clear');$('#bookName').textbox('clear')">重置</a>
	<br>
</div>
</body>
<script type="text/javascript">
	$(function () {
		$('#librarylistTable').datagrid({
			title:'历史借阅列表',
			url:'${pageContext.request.contextPath }/libraryborrow/getalllibrarylist',
			method:'get',
			pagination: true,//显示分页工具栏
			rownumbers:true,
			singleSelect:false,
			toolbar:'#querylibraryId',//绑定工具栏
			loadMsg:'正在加载,请稍后...',
			columns:[[
				{field:'bookName',title:'图书名称',width:'20%', sortable:true,editor:'textbox'},
				{field:'userName',title:'借阅者',width:'20%', sortable:true,editor:'textbox'},
				{field:'borrowTime',title:'借阅时间',width:'23%', sortable:true,formatter: function (value, row, index) {
						return formatDateBoxFull(value);
					}},
				{field:'bakeTime',title:'归还时间',width:'23%', sortable:true,formatter: function (value, row, index) {
						return formatDateBoxFull(value);
					}},
				{
					field: 'deal',
					title: '操作',
					align: 'center',
					width: '12%',
					formatter: function(value, rec, index) {
						var result = '<a  title="查看借阅者信息" class="easyui-linkbutton"  onclick="lookuser(\''+rec.userId+'\')" href="javascript:void(0)">查看借阅者信息</a>';
						return result;
					}
				},
			]],
			onLoadSuccess:function (data) {//请求成功，返回的数据

			}
		});
	})

	function searchParamLibrary() {
		//获取表格的查询参数
		var queryParams=$("#librarylistTable").datagrid('options').queryParams;
		queryParams.bookName=$("#bookName").val();
		queryParams.userName=$("#userName").val();
		//重新加载表格数据
		$("#librarylistTable").datagrid('load');
	}
</script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/lookuser.js"></script>
</html>