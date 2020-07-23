<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path=request.getContextPath();
request.setAttribute("path", path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<input type="hidden" value="${path }" id="path">
	<div class="right">
		<table id="borrowlistDetail" title="图书历史借阅详情" class="easyui-datagrid" style="height:600px;width: 1200px;margin: 0 auto "></table>
	</div>
</body>
<script type="text/javascript" >
	$(function () {
		initborrowlistDate();
		var p = $('#borrowlistDetail').datagrid('getPager');
		$(p).pagination({
			pageSize: 10,//每页显示的记录条数，默认为10
			pageList: [5,10,20,50],//可以设置每页记录条数的列表
			beforePageText: '第',//页数文本框前显示的汉字
			afterPageText: '页    共 {pages} 页',
			displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
		});
	})
	function initborrowlistDate() {
		$('#borrowlistDetail').datagrid({
			url:'${pageContext.request.contextPath }/borrow/getBorrowlist',
			pagination: true,//表示在datagrid设置分页
			method:'get',
			columns:[[
				{field:'bookName',title:'图书名称',width:'10%', align: 'left'},
				{field:'userId',title:'借阅者id',width:100,hidden: true, align: 'left'},
				{field:'name',title:'借阅者姓名',width:'15%', align: 'left'},
				{field:'userName',title:'借阅者账号',width:'15%',sortable: true, align: 'left'},
				{field:'borrowTime',title:'借阅时间',width:'20%',align:'right',sortable: true, align: 'left',
					formatter: function (value, row, index) {
						return formatDateBoxFull(value);
					}},
				{
					field: 'deal',
					title: '操作',
					align: 'center',
					width: '40%',
					formatter: function(value, rec, index) {
						var result = '<a  title="查看" class="easyui-linkbutton"  onclick="lookx(\''+rec.bookName+'\',\''+formatDateBoxFull(rec.borrowTime)+'\')" href="javascript:void(0)">查看</a>'
								+ '<a   class="easyui-linkbutton"  style="margin-left:10px" title="归还"  onclick="borrowx(\''+rec.bookId+'\',\''+rec.userId+'\')" href="javascript:void(0)">归还</a>';
						return result;
					}
				},
			]],
			onBeforeLoad : function(param) {
			},
			onLoadError : function() {
				//在载入远程数据产生错误的时候触发。
			},
			onLoadSuccess: function (data) {
				if (data.total == 0) {
					var body = $(this).data().datagrid.dc.body2;
					body.find('table tbody').append('<tr><td style="height: 35px;width: 150px; text-align: center;display: inline-block;float: right;color: grey"><h1>未查到数据</h1></td></tr>');
					$(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
				}
				//如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
				else $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
			}
		});
	}

</script>
<script type="text/javascript"  src="${pageContext.request.contextPath }/js/borrow.js"></script>
</html>