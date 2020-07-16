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
	<link rel="stylesheet" href="${pageContext.request.contextPath }/easyui/themes/icon.css" type="text/css"></link>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/easyui/themes/default/easyui.css" type="text/css"></link>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="${pageContext.request.contextPath }/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/easyui/jquery.easyui.min.js"></script>
<title>图书信息-easyUI</title>
</head>
<body>
<h1 style="color:orange"> ${currentUser.userName },欢迎你！</h1><a href="<%=path%>/user/login.html">返回个人首页</a>
<input type="hidden" value="${path }" id="path">
<div data-options="region:'center'">
	<div id="toolbarList">
		<form action="#" id="formFindList">
			<div  class="easyui-accordion">
				<div title="" data-options="selected:true">
					<ul class="search-form" style="list-style-type:none">
						<li><input name="name" class="easyui-textbox" label="图书名称：" labelWidth="100px;"  data-options="prompt:'请输入'" style="width:20%"> </li>
						<li ><input name="author" class="easyui-textbox" label="作者名字：" labelWidth="100px;"  style="width:20%"> </li>
					<%--	<li style="width: 252px;text-align: right;">
							流程类型：<input id="q_flowGroup" name="flowGroupId" class="easyui-combobox" style="height: 30px;width:100px;vertical-align: middle;" data-options="
			       		editable:false,
			       		loadFilter:function(data){
			       			var row = {id:'',name:'-- 请选择 --'};
				            data.splice(0,0,row);
				            return data;
				     	}">
						</li>--%>
						<li ><input name="startTime"  class="easyui-datetimebox"  label="发起时间：" labelWidth="100px;" id="q_startTime" style="width:20%"></li>
						<li ><input name="endTime"  class="easyui-datetimebox"  label="至：" labelWidth="100px;" id="q_endTime" data-options="validType:['endTimeDate[\'#q_startTime\',\'结束时间必须大于或等于发起时间\']']" style="width:20%"></li>
						<li >
							<a href="#" class="easyui-linkbutton search" onclick="findFlowData()">查询</a>
							<a href="#" class="easyui-linkbutton" onclick="formReset()">重置</a>
						</li>
					</ul>
				</div>
			</div>
		</form>
	</div>
</div>
<table id="dataGridInbound" title="数据列表" class="easyui-datagrid" style="height:600px "></table>
</body>
<script>
	$(function () {

        initDate();

	})

    function initDate(){
        $("#dataGridInbound").datagrid({
            title: '数据详情',
            url: '/book/book/getbookList.do',
            pagination: true,//表示在datagrid设置分页
            rownumbers: true,
            toolbar : '#toolbarList',
            singleSelect: false,
            striped: true,
            nowrap: true,
            collapsible: true,
            fitColumns: true,
            remoteSort: false,
            method:'get',
            loadMsg: "正在努力加载数据，请稍后...",
            // queryParams: { name: "", author: "" ,page:$('#dataGridInbound').datagrid('options').pageNumber==null?"1":$('#dataGridInbound').datagrid('options').pageNumber},
            onBeforeLoad : function(param) {
            },
            onLoadError : function() {
                //在载入远程数据产生错误的时候触发。
            },
            onLoadSuccess: function (data) {
                if (data.total == 0) {
                    var body = $(this).data().datagrid.dc.body2;
                    body.find('table tbody').append('<tr><td width="' + body.width() + '" style="height: 35px; text-align: center;"><h1>未查到数据</h1></td></tr>');
                    $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
                }
                //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
                else $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
            },
            columns: [[
                { field: 'ck', checkbox: true },
                { field: 'id', title: '图书编码', width: '200', align: 'left', sortable: true },
                { field: 'name', title: '图书名称', width: '200', align: 'left', sortable: true },
                { field: 'author', title: '作者', width: '200', align: 'left', sortable: true },
                { field: 'count', title: '库存', width: '200', align: 'left', sortable: true },
                {
                    field: 'deal',
                    title: '操作',
                    align: 'center',
                    width: '200',
                    formatter: function(value, rec, index) {
                        var result = '<a  title="查看"  onclick="look(\''+rec.name+'\',\''+rec.count+'\')" href="javascript:void(0)">查看</a>'
                            + '<a  style="margin-left:10px" title="借阅"  onclick="borrow(\'' + rec.id + '\',${currentUser.id},$(\'#dataGridInbound\').datagrid(\'options\').pageNumber)" href="javascript:void(0)">借阅</a>';
                        return result;
                    }
                },
            ]],
        });
    }

	var path = $("#path").val();
	function borrow(bookid, userid,page) {
		// $('#dataGridInbound').datagrid('options');
		$.ajax({
			url : path + "/book/ajax",
			data : {
				bid : bookid
			},
			dataType : "text",
			type : "post",
			success : function(result) {
				if (result == "true") {
					abc();
				}else{
					window.location.href=path+"/book/booklist2.html?page="+page;
					alert("书籍库存不足！");
				}
			}
		})
		function abc() {
			// alert(bookid+"-"+bookcount+"-"+userid);
			$.ajax({
				url : path + "/book/borrow.html",
				data : {
					bid : bookid,
					uid : userid
				},
				type : "post",
				dataType : "text",
				success : function(result) {
					if (result == "true") {
						// 刷新window.history.go(0);
//					window.location.href = path
//							+ "/borrow/addBorrow.html?bookid=" + bookid
//							+ "&userid=" + userid;
						xyz();
					} else if (reslut = "false") {
						// window.location.href=path+"/book/booklist2.html?page="+page;
                        $.messager.confirm('提示', '您已经借阅了此书！', function(r){
                            if (r){
                                $.messager.progress('close');
                            }
                        });

					} else {
						window.location.href=path+"/book/booklist2.html?page="+page;
						alert("noData！");
					}
				},
				error : function() {
					alert("ajax请求失败！")
				}
			})
		}

		function xyz(){
			$.ajax({
				url:path+ "/borrow/addBorrow.html",
				data:{bookid:bookid,userid:userid},
				dataType:"text",
				type:"get",
				success:function(d){
					if(d=="true"){
						// window.location.href=path+"/book/booklist2.html?page="+page;
                        $.messager.alert('提示','借阅成功');
                        initDate();

                    }else{
						// window.location.href=path+"/book/booklist2.html?page="+page;
						alert("借阅失败！");
					}
				}

			})
		}

	}

	function look(name, count) {
		debugger
		// $('#dd').dialog('refresh', 'new_content.php');
        // $('#dd').css("display","block");
		// $('#dd').dialog({
		// 	title: '提示',
		// 	width: 400,
		// 	height: 200,
		// 	closed: false,
		// 	cache: false,
		// 	concat: name + "剩余" + count + "本",
		// 	// href: 'get_content.php',
		// 	modal: true
		// });
        $.messager.alert('提示',name + "剩余" + count + "本");
	}

	//重置
	function formReset(){
		$("#formFindList").form('reset');
	}

	//查询
	function findFlowData() {
			var paramArray = $("#formFindList").serializeArray();
			var paramObjs = {};
			for (var i = 0; i < paramArray.length; i++) {
				var paramObj = {};
				paramObj[paramArray[i].name] = paramArray[i].value;
				$.extend(paramObjs, paramObj);
			}
		//请求
		$('#dataGridInbound').datagrid('load',paramObjs);
	}

</script>
</html>