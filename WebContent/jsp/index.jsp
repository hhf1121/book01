<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body  style="width:500px; margin: 0 auto">
<h1>注册页面</h1>
<input type="hidden" value="<%=path%>" id="path">
<form action="<%=path%>/user/adduser.html" method="post" id="form" enctype="multipart/form-data">
用户名：<input type="text" name="userName" id="userName"/><span id="s1"></span><br/>
密码：<input type="password" name="passWord" id="passWord"/><span id="s2"></span><br/>
名字：<input type="text" name="name" id="name"/><span id="s3"></span><br/>
住址：<input type="text" name="address" id="address"/><span id="s4"></span><br/>
上传头像：<input type="file" name="pic" id="pic"><br/>
		<input type="button" value="注册" onclick="register()" />
</form>
<h3>${error }</h3>
<a href="<%=path%>/login/dologin.html">我有账号</a>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/register.js"></script>
</body>
</html>