<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.s{
	color: red;
	font-size: 12px;
}
</style>
</head>
<body>
 ${currentUser.userName }, 欢迎你！<br>
<form action="${pageContext.request.contextPath }/user/upateUser.html" method="post">
用户id：<input type="text" readonly="readonly"  value="${user.id }" name="id"><span class="s">*不可更改</span><br/>
用户账号：<input type="text" readonly="readonly" value="${user.userName }"  name="userName"><span class="s">*不可更改</span><br/>
用户密码：<input type="text" value="${user.passWord }" name="passWord"><br/>
用户姓名：<input type="text" readonly="readonly" value="${user.name }" name="name"><span class="s">*不可更改</span><br/>
用户地址：<input type="text" value="${user.address }" name="address"><br/>
用户身份：
		<select name="yes">
				<c:if test="${rolelist != null }">
				   <option value="0">--请选择--</option>
				   <c:forEach var="role" items="${rolelist}">
					  		<option <c:if test="${role.id == user.yes }">selected="selected"</c:if>
					  		value="${role.id}">${role.roleName}</option>
				   </c:forEach>
				</c:if>
	      </select>
<span class="s"></span><br/>
用户注册时间：<input type="text" readonly="readonly" value="${user.createDate }" name="createDate"><span class="s">*不可更改</span><br/>
<input type="button" value="更新读者信息" onclick="submitForm();"/><a href="${pageContext.request.contextPath }/user/login.html">返回</a>
</form>
<h3 style="color:red">${info }</h3>
<h3 style="color:red">${userInfo }</h3>
<script type="text/javascript">
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