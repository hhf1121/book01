<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.sql.Timestamp" %>
<%
String path=request.getContextPath();
request.setAttribute("path", path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body style="background-color:gray">
 ${currentUser.userName },欢迎你！
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>历史借阅页面</span>  <%-- <span style="color:red">${sessionScope.info }</span> --%>
           <%--   <span style="color:red">${sessionScope.infox }</span> --%>
        </div>
        <!--供应商操作表格-->
        <table class="bookTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="15%">图书名称</th>
                <th width="10%">借阅者</th>
                <th width="20%">借阅时间</th>
                <th width="20%">归还时间</th>
                <th width="5%">阅读时间(天)</th>
            </tr>
            <c:forEach var="Library" items="${Librarylist }" varStatus="status">
				<tr>
					<td>
					<span style="color:orange">${Library.bookName }</span>
					</td>
					<td>
					<span>${Library.userName }</span>
					</td>
					<td>
					<span style="color:pink"><fmt:formatDate value="${Library.borrowTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
					</td>
					<td>
					<span><fmt:formatDate value="${Library.bakeTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
					</td>
					<td>
					<span style="color:red"><fmt:formatNumber value="{(Library.bakeTime.getTime()-Library.borrowTime.getTime())/3600000/24 }" maxFractionDigits="2" ></fmt:formatNumber></span>
					</td>
				</tr>
			</c:forEach>
        </table>
      <a href="<%=path%>/user/login.html">返回个人首页</a>
</body>
</html>