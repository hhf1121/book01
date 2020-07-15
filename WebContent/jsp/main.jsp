<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path=request.getContextPath(); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<link href="<%=path %>/css/pic.css" type="text/css" rel="stylesheet" />
</head>
<body  style="width:500px; margin: 0 auto">

<img alt="用户头像" src="<%=path %>/${currentUser.picPath }" title="头像" width="100px" height="100px"  class="pic"/>
${currentUser.userName }, 欢迎你！您的身份是：${role }<br/>
 <c:if test="${currentUser.yes==1 }"><span style="color:red; font-size: 12px">升级为vip会员将开启图书借阅功能！请联系管理员..</span></c:if>
	<ul>
		<c:forEach items="${list }" var="li">
		<li><a href="<%=path %>${li.path }">${li.listName }</a></li>
		</c:forEach>
		<li><a href="${pageContext.request.contextPath }/user/userlist.html">个人信息管理</a></li>
		<li><a href="<%=path %>/user/out.html">退出系统</a></li>
	</ul>
	${infoup }
</body>
</html>