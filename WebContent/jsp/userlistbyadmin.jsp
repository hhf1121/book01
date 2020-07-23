<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	request.setAttribute("path", path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息编辑</title>
<style type="text/css">
.s{
	color: red;
	font-size: 12px;
}
</style>
</head>
<body>
<input type="hidden" value="${path }" id="path">
<div>
	<form id="myform" action="${pageContext.request.contextPath }/user/upateUser.html" method="post">
		用户id：<input class="easyui-textbox" name="id" data-options="required:true" /><br>
		用户账号：<input class="easyui-textbox" name="userName" data-options="required:true" /><br>
		用户密码：<input class="easyui-textbox" name="passWord" data-options="required:true" /><br>
		用户姓名：<input class="easyui-textbox" name="name" data-options="required:true" /><br>
		用户地址：<input class="easyui-textbox" name="address" data-options="required:true" /><br>
		用户身份：<select class="easyui-combobox" name="yes" data-options="loader:myloader,mode:'remote',valueField:'id',textField:'roleName',
        formatter:formatItem,panelWidth:150,panelHeight:'auto'">
	</select>
	</form>
	<a href="#" class="easyui-linkbutton" onclick="submitForm()">提交</a>
	<a href="#" class="easyui-linkbutton" onclick="$('#myform').form('clear')">清空</a>
	<a href="#" class="easyui-linkbutton" onclick="$('#myform').form('reset')">重置</a>
</div>



<script type="text/javascript">


	function myloader(param, success, error) {
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

function submitForm(){
	var flag=confirm("确定更新？");
	if(flag){
		document.getElementsByTagName("form")[0].submit();
	}else{
		var h3=document.getElementsByTagName("h3")[0];
		h3.innerHTML="您已经取消更新信息...";
	}
}
</script>
</body>
</html>