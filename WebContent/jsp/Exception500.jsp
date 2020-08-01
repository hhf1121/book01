<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path=request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>系统异常</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/easyui/themes/icon.css" type="text/css"></link>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/easyui/themes/default/easyui.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath }/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
<div class="easyui-layout" style="width:1200px;height:800px;margin: 0 auto;border: 1px silver solid">
    <div data-options="region:'north',title:' 用户信息 '" style="height:150px;">
        <div style="margin: 0 auto;font-size: 20px">
            <img  src="<%=path %>/${currentUser.picPath }"  width="100px" height="100px"  class="pic"/>
            <div style="float: right;margin-right: 300px;margin-top: 10px"><span style="color: #b447ff">${currentUser.userName }</span>, 欢迎你！您的身份是：<span style="color:red;">${role }</span></div>
            <c:if test="${currentUser.yes==1 }"><span style="color:red; font-size: 12px">升级为vip会员将开启图书借阅功能！请联系管理员..</span></c:if>
            ${infoup }
        </div>
        <div class="easyui-draggable" data-options="handle:'#title1'"
             style="height: 80px;width: 150px;margin-top: -70px;margin-left:1020px;border: 1px solid #95B8E7;border-radius: 5px">
            <div id="title1" style="background:#E6F0FF;border-radius: 5px">用户操作</div>
            <div class="easyui-tree"data-options="animate:'true',lines:'true'">
                <li><a  href="${pageContext.request.contextPath }/user/userlist.html?id=${currentUser.id }">个人信息管理</a></li>
                <li><a  href="<%=path %>/user/out.html">退出系统</a></li>
            </div>
        </div>
    </div>
    <div style="margin-top: 300px">
        <H1 STYLE="width: 300px;margin: 0 auto">系统异常,请重试</H1>
    </div>
</div>
</body>
</html>
