<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String mypath=request.getContextPath(); %>
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
<form id="filemyForm" style="float: left;margin: 5px"  action="<%=mypath%>/upLoad/uploadFile"
			method="post" enctype="multipart/form-data" >
	<input class="easyui-validatebox easyui-filebox" name="myuploadfile" id="myuploadfile" data-options="iconCls:'icon-save',buttonAlign:'left',prompt:'选择文件',buttonText:'选择'" />
</form><a href="#" class="easyui-linkbutton" style="margin: 5px 0px 0px 50px" onclick="myuploadFile()">上传</a>


<table id="fileList" title="文件列表" class="easyui-datagrid" style="width: 100%;height: 600px"></table>
<div id="bookdialog" ></div>
<div id="bb">
	<a href="#" class="easyui-linkbutton" onclick="preData()">上一页</a>
	<a href="#" class="easyui-linkbutton" onclick="nextData()">下一页</a>
</div>
</div>
        <input type="hidden" id="mypath" value="<%=mypath%>">
<script type="text/javascript">

	$(function () {
		initDateFile();
		$("#filemyForm").form({
			onSubmit: function(){
				debugger
			},
			success:function(data){
				var result=JSON.parse(data);//字符串转换成json对象
				if(result.success){
					$.messager.show({
						title:'提示',
						msg:result.data,
						showType: 'show',
						timeout:1000,
						style:{
							right:'',
							height:'80px',
							top:document.body.scrollTop+document.documentElement.scrollTop,
							bottom:''
						}
					})
					$("#filemyForm").form("clear");
					initDateFile()
				}else{
					$.messager.alert("提示",result.data);
				}
			}
		});
		$('#bookdialog').dialog({
			buttons:'#bb',
			width: 600,
			height: 400,
            maximizable: true,
			closed: true,
			modal: true
		});
	})

	function initDateFile(){
		$("#fileList").datagrid({
			url: '/book/upLoad/getFilelist',
			// pagination: true,//表示在datagrid设置分页
			// rownumbers: true,
			singleSelect: false,
			striped: true,
			nowrap: true,
			rownumbers: true,
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
								+'<a  href="<%=mypath %>/upLoad/download.html?file='+rec.path+'">下载 </a>'
								+ '<a  style="margin-left:10px" title="查看"  onclick="showFile(\''+ rec.id + '\',\''+ rec.upName + '\')" href="javascript:void(0)">查看</a>';
						return result;
					}
				},
			]],
		});
	}

	function deletefile(idx){
		$.ajax({
			url:$("#mypath").val()+"/upLoad/deleteFile.html",
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
	function showFile(id,name){
		$.ajax({
			url:$("#mypath").val()+"/upLoad/fileshow.html",
			data:{id:id,currentPage:"1"},
			dataType:"text",
			type:"get",
			success:function(result){
				var fileData=JSON.parse(result);//字符串转换成json对象
				if(fileData!=null||fileData.content.length>0){// id-名字-页码
					$('#bookdialog').dialog({title:id+"&"+name+"&"+fileData.currentPage,content:'<div id="isTop" style="font-size: 10px;color: royalblue">'+fileData.content+'</div>'});
					$('#bookdialog').dialog('open');
                    $("#isTop").scrollTop(0);
				}
			},
			error:function(){
				alert("获取数据失败");
			}
		})
	}
	function myuploadFile() {
		$('#filemyForm').submit();
	}
	function preData() {//上一页 id&名字&页码
		var title=$('#bookdialog').panel('options').title;
		var page=title.split('&')[2];
		var id=title.split('&')[0];
		if(parseInt(page)-1>0){
			var currentPage=parseInt(page)-1;
			$.ajax({
				url:$("#mypath").val()+"/upLoad/fileshow.html",
				data:{id:id,currentPage:currentPage+""},
				dataType:"text",
				type:"get",
				success:function(result){
					var fileData=JSON.parse(result);//字符串转换成json对象
					if(fileData!=null||fileData.content.length>0){
						$('#bookdialog').dialog({title:id+"&"+fileData.bookname+"&"+fileData.currentPage,content:fileData.content});
						$('#bookdialog').dialog('open');
                        $('#bookdialog').dialog('scrollTo',0);
                    }
				},
				error:function(){
					alert("获取数据失败");
				}
			})
		}else {
			$.messager.show({
				title:'提示',
				msg:"没有上一页",
				showType: 'show',
				timeout:1000,
				style:{
					right:'',
					height:'80px',
					top:document.body.scrollTop+document.documentElement.scrollTop,
					bottom:''
				}
			})
		}
	}
	function nextData() {//下一页 id&名字&页码
		var title=$('#bookdialog').panel('options').title;
		var page=title.split('&')[2];
		var id=title.split('&')[0];
		if(parseInt(page)+1>0){
			var currentPage=parseInt(page)+1;
			$.ajax({
				url:$("#mypath").val()+"/upLoad/fileshow.html",
				data:{id:id,currentPage:currentPage+""},
				dataType:"text",
				type:"get",
				success:function(result){
					var fileData=JSON.parse(result);//字符串转换成json对象
					if(fileData!=null||fileData.content.length>0){
						$('#bookdialog').dialog({title:id+"&"+fileData.bookname+"&"+fileData.currentPage,content:'<div id="isTop" style="font-size: 10px;color: royalblue">'+fileData.content+'</div>'});
						$('#bookdialog').dialog('open');
                        $("#isTop").scrollTop(0);
					}
				},
				error:function(){
					alert("获取数据失败");
				}
			})
		}else {
			$.messager.show({
				title:'提示',
				msg:"没有下一页",
				showType: 'show',
				timeout:1000,
				style:{
					right:'',
					height:'80px',
					top:document.body.scrollTop+document.documentElement.scrollTop,
					bottom:''
				}
			})
		}
	}
</script>
</body>
</html>