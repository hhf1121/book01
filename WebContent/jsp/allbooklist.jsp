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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图书信息</title>
<link href="<%=path %>/css/pic.css" type="text/css" rel="stylesheet" />
</head>
<body>
<img alt="用户头像" src="<%=path %>/${currentUser.picPath }" title="头像" width="100px" height="100px"  class="pic"/>
<h1 style="color:orange"> ${currentUser.userName },欢迎你！</h1><a href="<%=path%>/user/login.html">返回个人首页</a>
<div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>图书信息页面</span>  <a href="<%=path%>/book/addBook.html">增加图书</a>
             <span style="color:red">${sessionScope.infox }</span>
        </div>
        <div class="search">
        	<form method="post" id="form" action="${pageContext.request.contextPath }/book/allbooklist.html">
				<span>图书名称：</span>
				<input name="name" type="text" value="${name }">
				
				<span>作者名称：</span>
				<input name="author" type="text" value="${author }">
				<input type="hidden" name="pageIndex" value="1"/>
				<input value="查 询" type="submit" id="searchbutton">
			</form>
        </div>
        <!--供应商操作表格-->
        <table class="bookTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="20%">图书编码</th>
                <th width="25%">图书名称</th>
                <th width="25%">图书作者</th>
                <th width="10%">剩余库存</th>
                <th width="10%">总数</th>
            </tr>
            <c:forEach var="book" items="${booklist }" varStatus="status">
				<tr>
					<td>
					<span>${book.id }</span>
					</td>
					<td>
					<span>${book.name }</span>
					</td>
					<td>
					<span>${book.author}</span>
					</td>
					<td>
					<span>${book.count}</span>
					</td>
					<td>
					<span>${book.countSize}</span>
					</td>
					<td>
					<span><a  href="javascript:allborrow(${book.id },${pageNo});">删除</a></span>
					</td>
				</tr>
			</c:forEach>
        </table>
	<input type="hidden" value="${path }" id="path">
        <input type="hidden" id="totalPageCount" value="${totalPageCount}"/>
		  	<c:import url="rollpage.jsp">
	          	<c:param name="totalCount" value="${totalCount}"/>
	          	<c:param name="pageNo" value="${pageNo}"/>
	          	<c:param name="totalPageCount" value="${totalPageCount}"/>
          	</c:import>
    	</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath }/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/allbook.js"></script>
</html>