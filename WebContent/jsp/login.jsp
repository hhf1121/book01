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
						<td><input class="easyui-textbox" type="text" name="userName" data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>密码:</td>
						<td><input class="easyui-textbox" type="password" name="passWord" data-options="required:true"></input></td>
					</tr>
				</table>
			</form>
			<div>
				<span style="color: green">使用</span><a href="http://192.168.50.164:8080/common/oauth2/authorize?redirect_uri=http://192.168.50.164:8081/book/sso.html" style="color: red">壹米滴答</a><span style="color:green;">账户登录</span>
			</div>
			<div style="text-align:center;padding:5px">
					<a href="<%=path%>/login/doindex.html" class="easyui-linkbutton">注册</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="loginUser()">登录</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="xxx()">忘记密码</a>
			</div>
		</div>
	</div>
</div>
<div id="dlg" class="easyui-dialog" title="找回密码" data-options="iconCls:'icon-save'" style="width:600px;height:300px;padding:10px">
	<form  method="post" style="width: 400px;text-align: center" id="retrunPass">
		<tr>
			<td>账号:</td>
			<td><input class="easyui-textbox" type="text" name="userName" value="${userName1 }" data-options="required:true"></input></td>
		</tr>
		<br>
		<tr>
			<td>姓名:</td>
			<td><input class="easyui-textbox" type="text" name="name" value="${name1 }" data-options="required:true"></input></td>
		</tr>
		<br>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="returnPass()">确定</a>
		<%--<input class="easyui-linkbutton" type="submit" value="确定"/>--%>
	</form>
	<p id="px"><c:if test="${password1!=null }">您的密码为：${password1 }</c:if>${info1}</p>
</div>
<script type="text/javascript">
	$(function () {
		$('#dlg').dialog('close');//默认对话框是关闭的
		// $.fn.userName.defaults.missingMessage="请输入账号";
		// $.fn.passWord.defaults.missingMessage="请输入密码";
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
		var isRight=$('#retrunPass').form('validate');
		$('#retrunPass').form({
			url:'${pageContext.request.contextPath}/user/backPass.do',
			onSubmit: function(){
				debugger

			},
			success:function(data){
				debugger
				alert(data)
			}
		});
		if(isRight){
			$('#retrunPass').submit();
		}

	}

</script>
</body>
</html>