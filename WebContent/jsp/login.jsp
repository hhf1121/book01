<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fm" uri="http://www.springframework.org/tags/form" %>
<%
	String path=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>登录页面</title>
	<style type="text/css">
		#px{
			color:red;
			text-align: center;
		}
		.mycss{
			padding-top: 150px;
			width: 800px;
			display: block;
			margin: 0 auto;
		}
	</style>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/easyui/themes/icon.css" type="text/css"></link>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/easyui/themes/default/easyui.css" type="text/css"></link>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="${pageContext.request.contextPath }/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/easyui/jquery.easyui.min.js"></script>
</head>
<body style="width: 800px;margin: 0 auto">
<div class="mycss">
	<div class="easyui-panel" title="用户登录" style="width:400px;text-align: center">
		<div style="padding:10px 60px 20px 60px">
			<form id="ff" action="<%=path %>/user/login.html" method="post">
				<table cellpadding="5">
					<tr>
						<td>账号:</td>
						<td><input class="easyui-textbox" id="userName" type="text" name="userName" data-options="required:true,missingMessage:'账号不能为空'"></input></td>
					</tr>
					<tr>
						<td>密码:</td>
						<td><input class="easyui-passwordbox" id="passWord" type="text" name="passWord" data-options="required:true,missingMessage:'密码不能为空'"></input></td>
					</tr>
				</table>
			</form>
			<div id="isSSO">
				<span style="color: green">使用</span><a href="http://192.168.50.164:8080/common/oauth2/authorize?redirect_uri=http://192.168.50.164:8081/book/sso.html" style="color: red">壹米滴答</a><span style="color:green;">账户登录</span>
			</div>
			<div style="text-align:center;padding:5px">
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="loginUser()">登录</a>
				<a href="<%=path%>/login/doindex.html" class="easyui-linkbutton">注册</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="xxx()">忘记密码</a>
			</div>
			<span style="color: red">${info }</span>
		</div>
	</div>
</div>
<div id="dlg" class="easyui-dialog" title="找回密码" data-options="iconCls:'icon-save'"
	 closable="false"
	 style="width:600px;height:300px;padding:10px;margin: 0 auto">
	<form  method="post" action="<%=path %>/user/backPass.do" style="width: 400px;text-align: center" id="retrunPass">
		<br>
		<br>
		<tr>
			<td>账号:</td>
			<td><input class="easyui-textbox" type="text" name="userName" data-options="required:true,missingMessage:'请输入账号'"></input></td>
		</tr>
		<br>
		<tr>
			<td>姓名:</td>
			<td><input class="easyui-textbox" type="text" name="name" data-options="required:true,missingMessage:'请输入名字'"></input></td>
		</tr>
		<br>
		<br>
		<br>
		<a href="javascript:void(0)" class="easyui-linkbutton" id="zhaohui" onclick="returnPass()">找回</a>
		<a href="#" class="easyui-linkbutton" onclick="$('#retrunPass').form('clear'),$('#dlg').dialog('close'),isClosed()">关闭</a>
		<%--<input class="easyui-linkbutton" type="submit" value="确定"/>--%>
	</form>
	<p id="px" style="display:none"></p>
</div>
<script type="text/javascript">
	$(function () {
		$('#dlg').dialog('close');//默认对话框是关闭的
		//绑定回车键
		$('#ff').find('input').on('keyup',function(event){
			if(event.keyCode == '13'){
				loginUser();
			}
		});
	})
	function xxx(){
		$('#dlg').dialog('open');
	}
	function loginUser(){
		var form = $('#ff').form('validate');
		if(form){
			$('#ff').submit();
		}
	}
	function returnPass() {
		$('#retrunPass').form('submit',{
			url:'${pageContext.request.contextPath}/user/backPass',
			dataType : 'json',
			onSubmit: function(param){
				return $('#retrunPass').form('validate');
			},
			success:function(data){
				let result=JSON.parse(data);//字符串转换成json对象
				if(result.success){
					$('#px').css("display",'block');
					$('#px').html("您的密码是："+result.data.password1)
				}else{
					$('#px').css("display",'block');
					$('#px').html(result.error.info1)
				}
				$('#zhaohui').linkbutton('disable');
				setTimeout(function () {
					$('#zhaohui').linkbutton('enable');
				},2000)
			}
		});
	}

	function isClosed() {
		$('#px').html("");
		$('#px').css("display","none");
	}
</script>
</body>
</html>