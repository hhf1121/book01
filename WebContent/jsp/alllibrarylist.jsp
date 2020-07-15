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
<title>Insert title here</title>
<link href="css/pic.css" type="text/css" rel="stylesheet" />
</head>
<body>
<img alt="用户头像" src="<%=path %>/${currentUser.picPath }" title="头像" width="100px" height="100px"  class="pic"/>
<h1 style="color:orange"> ${currentUser.userName },欢迎你！</h1><a href="<%=path%>/user/login.html">返回个人首页</a>
<div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>会员借阅历史页面</span> 
        </div>
        <div class="search">
        	<form method="post" id="form" action="${pageContext.request.contextPath }/libraryborrow/alllibrarylist.html">
				<span>图书名称：</span>
				<input name="bookName" type="text" value="${bookName }">
				<span>读者名称：</span>
				<input name="userName" type="text" value="${userName }">
				<input type="hidden" name="pageIndex" value="1"/>
				<input value="查 询" type="submit" id="searchbutton">
			</form>
        </div>
        <!--供应商操作表格-->
        <table class="bookTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">图书名称</th>
                <th width="10%">借阅者</th>
                <th width="10%">借阅时间</th>
                <th width="10%">归还时间</th>
            </tr>
            <c:forEach var="Library" items="${Librarylist }" varStatus="status">
				<tr>
					<td>
					<span>${Library.bookName }</span>
					</td>
					<td>
					<span>${Library.userName }</span>
					</td>
					<td>
					<span>${Library.borrowTime }</span>
					</td>
					<td>
					<span>${Library.bakeTime }</span>
					</td>
					<td>
					<span><a  href="javascript:lookuser('${Library.userId }');">查看读者信息</a></span>
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
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/lookuser.js"></script>
</html>