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
	<style>
		.myTableTd:hover{
			overflow: visible;
			white-space: normal;
		}
		.myTableTd{
			max-width:200px;
			word-wrap: break-word;
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
			color: #e79394;
		}
	</style>
</head>
<body>
<table id="userTable" style="width: 100%;height: 650px"></table>
<div id="queryId">
	<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" style="margin: 5px" plain="true"  onclick="deleteUsers()">删除</a>
	<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" plain="true" onclick="exportUsers()" plain="true">导出</a>
	<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" plain="true" onclick="importUsers()" plain="true">批量导入用户</a>
	<a  data-options="iconCls:'icon-print'" class="easyui-linkbutton" plain="true"  href="${pageContext.request.contextPath}/resource/excelTemplate/userTemplate.xls">导入模板下载</a><br>
	<div id="content"></div>
	      用户名字:<input  class="easyui-textbox" name="name"  id="name" />
	用户身份:<select class="easyui-combobox" name="yes" id="yes" style="width: 150px" data-options="prompt:'请选择',loader:userType,mode:'remote',valueField:'id',textField:'roleName',
        panelWidth:150"></select>
	<input class="easyui-combobox" label="注册时间:" id="registerTime" name="registerTime" data-options="valueField: 'value',textField: 'label',
								data: [{
								   label: '一年内',
								   value: '365'
								   },{
								   label: '半年内',
								   value: '180'
								   },{
								   label: '30天内',
								   value: '30'
								   },
								   {label: '10天内',
								   value: '10'
								   }]">
	<a class="easyui-linkbutton" onclick="searchParamUser()">查询</a>
	<a class="easyui-linkbutton" onclick="$('#name').textbox('clear');$('#yes').textbox('clear');$('#registerTime').textbox('clear')">重置</a>
	<%--<input type="text" id="saySend">
	<button class="easyui-linkbutton" type="button" onclick="say()"><span>发送消息</span></button>--%>
	<br>
</div>
<div id="dialog" class="easyui-dialog" title="编辑用户信息"
	 style="width: 400px;height: 400px"
	 data-options="closed:true,modal:true">
</div>
<input type="hidden" value="${path }" id="path">
<div id="contractExcel" class="easyui-dialog" data-options="closed:true"
	 style="width: 360px; height: 76px">
	<form id="wgks_form" name="wgks_form" method="post" enctype="multipart/form-data">
		<input  class="easyui-filebox" name="file"  id="import_file" required="required" data-options="accept:'application/vnd.ms-excel',buttonText: '选择文件'">
		<button type="button"  class="easyui-linkbutton  save" id="wgks_form_btn" onclick="importFile(this)">开始导入</button>
	</form>
</div>
<div id="errorExcel" class="easyui-dialog" closed="true" data-options="closable:false"  style="width: 760px" buttons="#errorOK" >
	<div id="errorData">
	</div>
	<div id="errorOK">
		<a href="javascript:void(0)" class="easyui-linkbutton  save" onclick="isCloseShow()">确定</a>
	</div>
</div>

<form method="post" target="_blank" id="exportUserForm">
	<input type="hidden" id="ex_userColums" name="userColums"/>
	<input type="hidden" id="ex_name" name="name"/>
	<input type="hidden" id="ex_yes"  name="yes"/>
	<input type="hidden" id="ex_registerTime"  name="registerTime"/>
</form>

</body>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/socket.io.js"></script>
<script type="text/javascript">
	const userTypeArray=new Array();//过滤器
	const userColums=[[
				{field:'ck',checkbox:true},
				{field:'id',title:'用户id',width:'5%',isExport:true, sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'userName',title:'用户账号',width:'15%',isExport:true, sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'passWord',title:'用户密码',width:'10%',isExport:false, sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'name',title:'用户名字',width:'15%',isExport:true, sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'address',title:'用户住址',width:'15%',isExport:true, sortable:true,editor:'textbox'},/*动态列表，每次点击排序的时候，会发起请求。需要服务端处理*/
				{field:'yes',title:'用户角色',width:'10%', isText:true,isExport:true, sortable:true,editor:{
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
				{field:'createDate',title:'注册时间',isExport:true,width:'26%',formatter: function (value, row, index) {
						return formatDateBoxFull(value);
					}},
			]]
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
			columns:userColums,
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
		queryParams.registerTime=$("#registerTime").combobox("getValue");
		//重新加载表格数据
		$("#userTable").datagrid('load');
	}

	function importFile(btn) {
		$(btn).linkbutton('disable');
		$('#wgks_form').form('submit',{
			url : 'dealImportUser',
			onSubmit : function() {
				var filebox = $("#import_file").filebox("getValue");
				if (filebox) {
					return true;
				}else {
					$(btn).linkbutton('enable');
					return false;
				}
			},
			success : function(result) {
				debugger
				var json=JSON.parse(result);
				if(json.success==false){
					if(typeof(json.error)=='string'){
						$.messager.alert("提示",json.error);
						$(btn).linkbutton('enable');
					}else {
						var array= json.error;
						if(array.length > 0) {
							var Str= "<div style='height:600px;width:100%;display:block;overflow-y:auto;'>"
							Str+="<table class='datagrid-btable' cellspacing='0' cellpadding='0' border='0' style='border: 1px solid gray' '><tr>" +
									"<td style='width: 100px;background-color: #ccc;'><b>账号</b></td>" +
									"<td style='width: 100px;background-color: #ccc;'><b>密码</b></td>" +
									"<td style='width: 100px;background-color: #ccc;'><b>名字</b></td>" +
									"<td style='width: 100px;background-color: #ccc;'><b>住址</b></td>" +
									"<td style='width: 100px;background-color: #ccc;'><b>角色</b></td>" +
									"<td style='width: 200px;background-color: #ccc;'><b>错误信息</b></td>" +
									"</tr>";
							$.each(
									array,
									function(i, value) {
										Str= Str+
												"<tr >" +
												"<td style='width: 100px;border: 1px gray dashed '>"+value.userName+"</td>" +
												"<td style='width: 100px;border: 1px gray dashed '>"+value.passWord+"</td>" +
												"<td style='width: 100px;border: 1px gray dashed '>"+value.name+"</td>" +
												"<td style='width: 100px;border: 1px gray dashed '>"+value.address+"</td>" +
												"<td style='width: 100px;border: 1px gray dashed '>"+value.yesText+"</td>" +
												"<td class='myTableTd' style='width: 100px;border: 1px gray dashed '>"+value.errInfo+"</td>"
												+ "</tr>"
									});
						}
						Str= Str+"</table></div>"
						$("#errorData").append(Str);
						$("#errorExcel").dialog({
							title : '导入成功！以下数据不符合规则:',
							iconCls:'icon-title'
						});
						$("#errorExcel").dialog('open');
						$("#contractExcel").dialog('close');
					}
				}else{
                    $.messager.show({
                        title:'提示',
                        msg:'导入完成',
                        timeout:1000,
                        showType:'slide'
                    });
					$("#contractExcel").dialog('close');
					$('#userTable').datagrid('reload'); // reload the role data
					$("#import_file").filebox("setValue",null);
				}
			},
			error:function(result){
				$(btn).linkbutton('enable');
			}
		});
	}

	function isCloseShow() {
		$("#errorExcel").dialog('close')
		$("#errorData").html("");
		$('#userTable').datagrid('reload');
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
	/*var socket = io.connect('http://learn.hhf.com:9092');
	socket.on('messageevent', function (data) {
		let html = document.createElement('p')
		html.innerHTML = `系统消息：<span>${data.hello}</span>`
		document.getElementById('content').appendChild(html)
		console.log(data);
	});
	function say() {
		let t = document.getElementById('saySend').value
		if (!t) return
		let html = document.createElement('p')
		html.innerHTML = `你细声说：<span>${t}</span>`
		document.getElementById('content').appendChild(html)
		socket.emit('messageevent', { my: t});
	}*/

	/**
	 * 前端js的 socket.emit("事件名","参数数据")方法，是触发后端自定义消息事件的时候使用的,
	 * 前端js的 socket.on("事件名",匿名函数(服务器向客户端发送的数据))为监听服务器端的事件
	 **/
	var socket = io.connect('http://127.0.0.1:9092?empCode=050069');
	var firstconnect = true;

	function connect() {
		if(firstconnect) {
			socket.on('reconnect', function(){ status_update("Reconnected to Server"); });
			socket.on('reconnecting', function( nextRetry ){ status_update("Reconnecting in "
			+ nextRetry + " seconds"); });
			socket.on('reconnect_failed', function(){ message("Reconnect Failed"); });
			firstconnect = false;
		} else {
			socket.reconnect();
		}
	}

	//监听服务器连接事件
	// socket.on('connect', function(){ console.info("Connected to Server"); });
	// socket.on('message', function(data){ console.info(data); });
	// //监听服务器关闭服务事件
	// socket.on('disconnect', function(){ console.info("Disconnected from Server"); });
	// //监听服务器端发送消息事件
	// socket.on('messageevent', function(data) {
	// 	message(data)
	// 	//console.log("服务器发送的消息是："+data);
	// });

	function message(data) {
		console.info("Server says: " + data);
	}

	//点击发送消息触发
	function say() {
		console.log("点击了发送消息，开始向服务器发送消息")
		var msg = "我很好的,是的．";
		socket.emit('connect', {empCode: msg});
		socket.emit('message', {empCode: msg});
		socket.emit('messageevent', {empCode: msg});
		socket.emit('disconnect');
	};

	function importUsers() {
		$("#wgks_form").form("clear");
		$("#wgks_form_btn").linkbutton('enable');
		$("#contractExcel").dialog({
			title : '用户导入',
			iconCls:'icon-title'
		});
		$('#contractExcel').dialog('open');
	}
	function exportUsers() {
		//获取表格的查询参数
		var queryParams=$("#userTable").datagrid('options').queryParams;
		queryParams.name=$("#name").val();
		queryParams.yes=$("#yes").combobox("getValue");
		queryParams.registerTime=$("#registerTime").combobox("getValue");
		if (queryParams != undefined && queryParams != null) {
			$("#ex_userColums").val(JSON.stringify(userColums[0]));
			$("#ex_name").val(queryParams.name?queryParams.name:undefined);
			$("#ex_yes").val(queryParams.yes?queryParams.yes:undefined);
			$("#ex_registerTime").val(queryParams.registerTime?queryParams.registerTime:undefined);
			var from = document.getElementById("exportUserForm");
			from.action =  "/book/user/exportAlluserlist.do";
			from.submit();
		}
	}
</script>
</html>