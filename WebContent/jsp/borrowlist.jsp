<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path=request.getContextPath();
request.setAttribute("path", path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图书借阅</title>
</head>
<body>
<h1 style="color:orange"> ${currentUser.userName },欢迎你！</h1><a href="<%=path%>/user/login.html">返回个人首页</a><span id="ss">${infob }</span>
<div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>您的图书借阅页面</span>  <%-- <span style="color:red">${sessionScope.info }</span> --%>
           <%--   <span style="color:red">${sessionScope.infox }</span> --%>
        </div>
        <div class="search">
        	<form method="post" id="form" action="${pageContext.request.contextPath }/borrow/borrowlist.html">
			<input type="hidden"  value="1" name="pageIndex" />
			</form>
        </div>
        <!--供应商操作表格-->
        <table class="bookTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="20%">图书名称</th>
                <th width="25%">借阅者</th>
                <th width="25%">借阅时间</th>
            </tr>
            <c:forEach var="borrow" items="${borrowlist }" varStatus="status">
				<tr>
					<td>
					<span>${borrow.bookName }</span>
					</td>
					<td>
					<span>${borrow.userName }</span>
					</td>
					<td>
					<span><fmt:formatDate value="${borrow.borrowTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
					</td>
					<td>
					<span><a  href="javascript:lookx('${borrow.bookName }','<fmt:formatDate value="${borrow.borrowTime}" pattern="yyyy-MM-dd HH:mm:ss"/>');">查看</a></span>
					<span><a  href="javascript:borrowx(${borrow.bookId },${borrow.userId });">归还</a></span>
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
<script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/borrow.js"></script>
</html>