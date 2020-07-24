<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/easyui/themes/icon.css" type="text/css"></link>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/easyui/themes/default/easyui.css" type="text/css"></link>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="${pageContext.request.contextPath }/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/easyui/jquery.easyui.min.js"></script>
<title>注册</title>
</head>
<style>
	.mytd{
		width: 50px;
		float: left;
	}
</style>
<body  style="width:500px; margin: 0 auto">
<h1></h1>
<input type="hidden" value="<%=path%>" id="path">

<div class="easyui-panel" title="用户注册" style="width:400px">
	<div style="padding:10px 60px 20px 60px">
		<form id="ff" action="<%=path%>/user/adduser.html" enctype="multipart/form-data" method="post">
			<table cellpadding="5">
				<tr>
					<td class="mytd">账号:</td>
					<td><input class="easyui-validatebox easyui-textbox" type="text" style="height: 30px" name="userName" id="userName" data-options="required:true,missingMessage:'账号不能为空',validType:'isuserName'"></input></td>
				</tr>
				<tr>
					<td class="mytd">密码:</td>
					<td><input class="easyui-validatebox easyui-passwordbox" type="text" style="height: 30px"  name="passWord"  id="passWord" data-options="required:true,validType:'ispassWord',missingMessage:'密码长度:3-10位'"></input></td>
				</tr>
				<tr>
					<td class="mytd">名字:</td>
					<td><input class="easyui-validatebox easyui-textbox" type="text" name="name" id="name" data-options="required:true,missingMessage:'名字不能为空',validType:'isname'" style="height: 30px"></input></td>
				</tr>
				<tr>
					<td class="mytd">住址:</td>
					<td><input  class="easyui-validatebox easyui-combobox" name="address" id="address" data-options="required:true,loader:registerloader,mode:'remote',valueField:'text',textField:'text',
        			formatter:registerformatItem,missingMessage:'住址不能为空'" style="height: 30px" ></input></td>
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
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="register()">确定注册</a>
			<a href="<%=path%>/login/dologin.html" class="easyui-linkbutton">已有账号</a>
		</div>
		<span style="color: red">${error }</span>
	</div>
</div>
<script type="text/javascript">

	$(function () {
		//自定义校验
		$.extend($.fn.validatebox.defaults.rules, {
			isuserName: {
				validator: function(value, param){
					let result123=$.ajax({
						async:false,
						url:"${pageContext.request.contextPath}/user/ifExist",
						data:{userName:value},
						dataType:"text",
						type:"post",
						success:function(result){
							debugger
							if(result=="true"){
								$.fn.validatebox.defaults.rules.isuserName.message="账号可以使用";
								return "true";
							}else{
								$.fn.validatebox.defaults.rules.isuserName.message="账号被占用";
								return "false";
							}
						},
						error:function(){
							$.fn.validatebox.defaults.rules.isuserName.message="验证失败";
							return "false";
						}
					}).responseText;
					if(result123=="true"){
						return true;
					}
				}
			},
			ispassWord:{
				validator: function(value, param){
					let ispasslength=value.length>=3&&value.length<=10;
					if(ispasslength==false){
						$.fn.validatebox.defaults.rules.ispassWord.message="密码长度:3-10位";
						return false;
					}
					return true;
				}
			},
			isname : {
				validator: function(value, param){
					var erx=/[^0-9]/;//正则：不是数字
					let isnamelength=!erx.test(value);
					if(isnamelength==true){
						$.fn.validatebox.defaults.rules.isname.message="姓名不能含数字，一旦注册成功、不可修改";
						return false;
					}
					return true;
				}
			}
		});
	})
	function register() {
		let isFlag=$('#ff').form('validate');
		if(isFlag){
			$('#ff').submit();
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


	function registerloader(param, success, error) {
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

	function registerformatItem(row) {
		var inputValue= $("#address").val();
		var showText='<span>'+row.text+'</span>';
		//替换文本
		const newText=showText.replace(inputValue, "<span style='color: red'>"+inputValue+"</span>");
		return newText;
	}
</script>
</body>
</html>