<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path=request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>共享资源</title>
<style type="text/css">
.s{
	color: red;
	font-size: 12px;
}
</style>
</head>
<body>
<form action="<%=path%>/upLoad/uploadFile.html" enctype="multipart/form-data" method="post">
	<input class="easyui-filebox" name="path" data-options="buttonAlign:'left',prompt:'选择文件',buttonText:'选择'" />
	<input type="submit" value="上传" />
</form>

<table id="fileList" title="文件列表" class="easyui-datagrid" style="width: 100%;height: 650px"></table>

<div id="show"></div>
        <input type="hidden" id="path" value="<%=path%>">
<script type="text/javascript">

	$(function () {
		initDateFile();
	})

	function initDateFile(){
		$("#fileList").datagrid({
			url: '/book/upLoad/getFilelist',
			// pagination: true,//表示在datagrid设置分页
			// rownumbers: true,
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
				{ field: 'ck', checkbox: true },
				{ field: 'upName', title: '图书名称', width: '25%', align: 'left', sortable: true },
				{ field: 'userName', title: '上传者', width: '25%', align: 'left', sortable: true },
				{ field: 'createDate', title: '上传时间', width: '25%', align: 'left', sortable: true,formatter: function (value, row, index) {
						return formatDateBoxFull(value);
					}
				},
				{
					field: 'deal',
					title: '操作',
					align: 'center',
					width: '200',
					formatter: function(value, rec, index) {
						var result = '<a  title="删除" class="easyui-linkbutton"  onclick="deletefile(\''+rec.id+'\')" href="javascript:void(0)">删除</a> '
								+'<a  href="<%=path %>/upLoad/download.html?file=${x.path }">下载 </a>'
								+ '<a  style="margin-left:10px" title="查看"  onclick="showFile(\'' + rec.id + '\')" href="javascript:void(0)">查看</a>';
						return result;
					}
				},
			]],
		});
	}

	function deletefile(idx){
		$.ajax({
			url:$("#path").val()+"/upLoad/deleteFile.html",
			data:{id:idx},
			dataType:"text",
			type:"get",
			success:function(result){
				if(result=="success"){
					alert("删除文件成功");
					// window.location.href=$("#path").val()+"/upLoad/Filelist.html";
					initDateFile();
				}else{
					alert("删除文件失败");
				}
			},
			error:function(){
				alert("请求失败！");
			}
		})
	}
	function showFile(info){
	$.ajax({
		url:$("#path").val()+"/upLoad/fileshow.html",
		data:{id:info},
		dataType:"text",
		type:"get",
		success:function(result){
			if(result!=null||result!=''){
			$("#show").html(result);	
			}
		},
		error:function(){
			alert("获取数据失败");
		}
	})
}

</script>
</body>
</html>