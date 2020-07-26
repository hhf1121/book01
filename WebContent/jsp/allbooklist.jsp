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
<title>图书信息</title>
</head>
<body>
<table id="bookTable"  style="width: 100%;height: 650px"></table>

<div id="querybook" style="margin: 5px;">
	<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="margin: 5px" onclick="addBook()">新增</a><br><br>
	图书名称:<input  class="easyui-textbox" name="name"  id="bookname" />
	作者名称:<input  class="easyui-textbox" name="author"  id="bookauthor" />
	<a class="easyui-linkbutton" onclick="searchBook()">查询</a>
	<a class="easyui-linkbutton" onclick="$('#bookname').textbox('clear');$('#bookauthor').textbox('clear')">重置</a>
	<br>
</div>

<div id="userbookdialog" ></div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/allbook.js"></script>
<script type="text/javascript" >
	$(function () {
		initBooksData();
		$('#userbookdialog').dialog({
			width: 500,
			height: 320,
			maximizable: true,
			closed: true,
			modal: true
		});
	})

	function initBooksData() {
		$('#bookTable').datagrid({
			title:'图书列表',
			url:'${pageContext.request.contextPath }/book/getallbooklist',
			method:'post',
			pagination: true,//显示分页工具栏
			rownumbers:true,
			singleSelect:false,
			pageSize: 10,//每页显示的记录条数，默认为10
			pageList: [5,10,20,50],//可以设置每页记录条数的列表
			toolbar:'#querybook',//绑定工具栏
			loadMsg:'正在加载,请稍后...',
			columns:[[
				/*{field:'ck',checkbox:true},*/
				{field:'id',title:'图书编码',width:'10%', sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'name',title:'图书名称',width:'20%', sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'author',title:'图书作者',width:'20%', sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'count',title:'剩余库存',width:'20%', sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'countSize',title:'总数',width:'20%', sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{
					field: 'deal',
					title: '操作',
					align: 'center',
					width: '10%',
					formatter: function(value, rec, index) {
						var result = '<a  title="删除"  onclick="allborrow(\''+rec.id+'\')" href="javascript:void(0)">删除</a>';
						return result;
					}
				},
			]],
			onLoadSuccess:function (data) {//请求成功，返回的数据
				data;
			}
		});
	}
	
	function searchBook() {
		//获取表格的查询参数
		var queryParams=$("#bookTable").datagrid('options').queryParams;
		queryParams.name=$("#bookname").val();
		queryParams.author=$("#bookauthor").val();
		//重新加载表格数据
		$("#bookTable").datagrid('load');
	}

	function addBook() {
		$('#userbookdialog').dialog({
			title:'新增图书',
			href:'${pageContext.request.contextPath }/book/addBook.html'
		});
		$('#userbookdialog').dialog('open');
	}
	
</script>
</html>