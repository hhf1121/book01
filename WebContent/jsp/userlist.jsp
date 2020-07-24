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
	<title>个人信息</title>
</head>
<style>
	.mytd{
		width: 50px;
		float: left;
	}
</style>
<body  style="width:500px; margin: 0 auto">
<input type="hidden" value="${path }" id="path">
<input type="hidden" value="${userID }" id="userId">

<div class="easyui-panel" title="个人信息" style="width:400px">
	<div style="padding:10px 60px 20px 60px">
		<form id="updateUser" action="${pageContext.request.contextPath }/user/upateUserByUser" enctype="multipart/form-data" method="post">
			<table cellpadding="5">
				<tr>
					<td class="mytd">id:</td>
					<td><input class="easyui-validatebox easyui-textbox" data-options="readonly:true" type="text" style="height: 30px" name="id" id="id"></input></td>
				</tr>
				<tr>
					<td class="mytd">账号:</td>
					<td><input class="easyui-validatebox easyui-textbox" type="text" style="height: 30px" name="userName" id="userName" data-options="required:true,missingMessage:'账号不能为空',readonly:true"></input></td>
				</tr>
				<tr>
					<td class="mytd">密码:</td>
					<td><input class="easyui-validatebox easyui-passwordbox" type="text" style="height: 30px"  name="passWord"  id="passWord" data-options="required:true,validType:'ispassWord',missingMessage:'密码长度:3-10位'"></input></td>
				</tr>
				<tr>
					<td class="mytd">名字:</td>
					<td><input class="easyui-validatebox easyui-textbox" type="text" name="name" id="name" data-options="required:true,missingMessage:'名字不能为空',readonly:true" style="height: 30px"></input></td>
				</tr>
				<tr>
					<td class="mytd">住址:</td>
					<td><input  class="easyui-validatebox easyui-combobox" name="address" id="address" data-options="required:true,loader:updateloader,mode:'remote',valueField:'text',textField:'text',
        			formatter:updateformatItem,missingMessage:'住址不能为空'" style="height: 30px" ></input></td>
				</tr>
				<tr>
					<td class="mytd">用户身份:</td>
					<td>
						<select class="easyui-combobox" id="yes" style="width: 150px;" name="yes" data-options="loader:myupdateUserloader,mode:'remote',valueField:'id',textField:'roleName',
       					 panelWidth:150,panelHeight:'auto'">
						</select>
					</td>
				</tr>
				<tr>
					<td class="mytd">上传头像:</td>
					<td>
						<input class="easyui-filebox" style="height: 30px"  data-options="buttonText:'选择',prompt:'请选择图片...'" name="pic" id="pic" />
					</td>
				</tr>
			</table>
		</form>
		<div style="text-align:center;padding:5px">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateregister()">更改信息</a>
			<a class="easyui-linkbutton" href="${pageContext.request.contextPath }/user/login.html">返回</a>
		</div>
	</div>
</div>

<script type="text/javascript">

	$(function () {
		//自定义校验
		$.extend($.fn.validatebox.defaults.rules, {
			ispassWord:{
				validator: function(value, param){
					let ispasslength=value.length>=3&&value.length<=10;
					if(ispasslength==false){
						$.fn.validatebox.defaults.rules.ispassWord.message="密码长度:3-10位";
						return false;
					}
					return true;
				}
			}
		});
		$("#updateUser").form({
			onSubmit: function(){

			},
			success:function(data){
				let result=JSON.parse(data);//字符串转换成json对象
				if(result.success){
					$.messager.show({
						title:'提示',
						msg:'更新成功！',
						showType: 'show',
						timeout:1000,
						style:{
							right:'',
							height:'80px',
							top:document.body.scrollTop+document.documentElement.scrollTop,
							bottom:''
						}
					})
					getUser($('#userId').val())
				}else{
					$.messager.alert("提示",result.data);
				}
			}
		})
		getUser($('#userId').val());
	})


	function updateregister() {
		let isFlag=$('#updateUser').form('validate');
		if(isFlag){
			$('#updateUser').submit();
		}else {
			$.messager.show({
				title:'提示',
				msg:'请合法填写表单信息',
				timeout:2000,
				showType:'show',
				style:{
					left:400,
					top:100
				}
			});
		}
	}

	function updateloader(param, success, error) {
		$.ajax({
			url:'http://localhost:8083/book/base/getComboboxData.json?level=1&name='+$("#address").val(),
			dataType:'json',
			success:function (data) {
				success(data);
			},
			error:function () {
				error.apply(this,arguments)
			}
		})
	}

	function myupdateUserloader(param, success, error) {
		$.ajax({
			url:$("#path").val()+'/base/getUserLevel',
			method:'post',
			dataType:'json',
			success:function (data) {
				success(data);
			},
			error:function () {
				error.apply(this,arguments)
			}
		})
	}

	function updateformatItem(row) {
		var inputValue= $("#address").val();
		var showText='<span>'+row.text+'</span>';
		//替换文本
		const newText=showText.replace(inputValue, "<span style='color: red'>"+inputValue+"</span>");
		return newText;
	}

	function getUser(id) {
		$.ajax({
			url:$("#path").val()+'/user/getUserById?id='+id,
			dataType:'json',
			method:'get',
			success:function (data) {
				if(data.success){
					var user=data.data;
					$("#updateUser").form('load',{
						id:user.id,
						name:user.name,
						userName:user.userName,
						passWord:user.passWord,
						address:user.address,
						yes:user.yes,
						pic:user.pic
					});
				}
				// success(data);
			},
			error:function () {
				error.apply(this,arguments)
			}
		})
	}

</script>
</body>
</html>