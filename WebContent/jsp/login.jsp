<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
#dpass{
display: none;
}
#px{
color:red;
}
</style>
</head>
<body style="width:500px; margin: 0 auto">
<h1>登录页面</h1>
<form action="<%=path %>/user/login.html" method="post" >
<fm:errors path="userName" />
账号：<input type="text" name="userName" id="userName"/><span id="s1"></span><br/>
<fm:errors path="passWord"  />
密码：<input type="password" name="passWord" id="passWord"/><span id="s2"></span><br/>
	<input type="submit" value="登录" />
</form>
<span style="color: green">使用</span><a href="http://192.168.50.164:8080/common/oauth2/authorize?redirect_uri=http://192.168.50.164:8081/book/sso.html" style="color: red">壹米滴答</a><span style="color:green;">账户登录</span>
<h3>${info }</h3>
<a href="<%=path%>/login/doindex.html">注册</a>
<a href="#" onclick="xxx();">忘记密码</a>
<p id="px"><c:if test="${password1!=null }">您的密码为：${password1 }</c:if>${info1}</p>
<div id="dpass">
<form action="<%=path%>/user/backPass.html" method="post">
	账号<input type="text" name="userName" value="${userName1 }"><br/>
	姓名<input type="text" name="name" value="${name1 }" /><br/>
	<input type="submit" value="找回密码"/>
</form>
</div>
${loginInfo }
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript">
	function xxx(){
		var div=document.getElementById("dpass");
		$(div).show();
	}
</script>
</body>
</html>