<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.sql.Timestamp" %>
<%
String path=request.getContextPath();
request.setAttribute("path", path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body >
<table id="librarylistId" title="历史借阅列表" class="easyui-datagrid" style="height:650px;width: 100%"></table>
<script>
	$(function () {
        initDateLibrary();
		var p = $('#librarylistId').datagrid('getPager');
		$(p).pagination({
			pageSize: 10,//每页显示的记录条数，默认为10
			pageList: [5,10,20,50],//可以设置每页记录条数的列表
			beforePageText: '第',//页数文本框前显示的汉字
			afterPageText: '页    共 {pages} 页',
			displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
		});

	})

	function initDateLibrary(){
		$("#librarylistId").datagrid({
			url: '/book/libraryborrow/getlibrarylist',
            pagination: true,//表示在datagrid设置分页
            rownumbers: true,
            singleSelect: false,
            striped: true,
            nowrap: true,
            collapsible: true,
            fitColumns: true,
            remoteSort: false,
			method:'get',
			loadMsg: "正在努力加载数据，请稍后...",
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
			},
			columns: [[
				/*{ field: 'ck', checkbox: true },*/
				{ field: 'bookName', title: '图书名称', width: '15%', align: 'center', sortable: true },
				{ field: 'userName', title: '借阅者', width: '20%', align: 'left', sortable: true },
				{ field: 'borrowTime', title: '借阅时间', width: '25%', align: 'left', sortable: true,formatter: function (value, row, index) {
                        return formatDateBoxFull(value);
                    }
                },
				{ field: 'bakeTime', title: '归还时间', width: '25%', align: 'left', sortable: true ,formatter: function (value, row, index) {
                        return formatDateBoxFull(value);
                    }
                },
				{ field: 'readDays', title: '阅读时间(天)', width: '15%', align: 'left', sortable: true }
			]],
		});
	}

</script>
</body>
</html>