<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	request.setAttribute("path", path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户信息</title>
<link href="css/pic.css" type="text/css" rel="stylesheet" />
</head>
<body>
	<img alt="用户头像" src="<%=path %>/${currentUser.picPath }" title="头像"
		width="100px" height="100px" class="pic" />
	<h1 style="color: orange">${currentUser.userName },欢迎你！</h1>
	<a href="<%=path%>/user/login.html">返回个人首页</a>
	<div class="right">
		<div class="location">
			<strong>你现在所在的位置是:</strong> <span>读者信息页面</span>
		</div>
		<div class="search">
			<form method="post" id="form"
				action="${pageContext.request.contextPath }/user/alluserlist.html">
				<span>读者名字：</span> <input name="name" type="text" value="${name }">
				<span>读者身份：</span> <select name="yes">
					<option value="0">--请选择--</option>
					<c:if test="${rolelist!=null }">
						<c:forEach items="${rolelist }" var="rl">
							<option <c:if test="${yes==rl.id }">selected="selected"</c:if>
								value="${rl.id }">${rl.roleName }</option>
						</c:forEach>
					</c:if>
				</select> <input type="hidden" name="pageIndex" value="1" /> <input
					value="查 询" type="submit" id="searchbutton">
			</form>
		</div>
		<!--供应商操作表格-->
		<table class="bookTable" cellpadding="0" cellspacing="0">
			<tr class="firstTr">
				<th width="5%">读者id</th>
				<th width="15%">读者账号</th>
				<th width="15%">读者密码</th>
				<th width="10%">读者名字</th>
				<th width="10%">读者住址</th>
				<th width="10%">读者角色</th>
				<th width="25%">注册时间</th>
				<th width="25%">全选<input type="checkbox" name="all" id="all"><input
					type="button" value="删除" name="delete" class="delete" /></th>
			</tr>
			<c:forEach var="user" items="${userlist }" varStatus="status">
				<tr>
					<td><span>${user.id }</span></td>
					<td><span>${user.userName }</span></td>
					<td><span>${user.passWord}</span></td>
					<td><span>${user.name}</span></td>
					<td><span>${user.address}</span></td>
					<td><span> <c:if test="${user.yes==1 }">普通会员</c:if> <c:if
								test="${user.yes==2 }">vip会员</c:if> <c:if test="${user.yes==3 }">系统管理员</c:if>
					</span></td>
					<td><span><fmt:formatDate value="${user.createDate}"
								pattern="yyyy-MM-dd HH:mm:ss" /></span></td>
					<td><span><a
							href="<%=path %>/user/usershow/${user.id }">查看</a></span> 
							<span>
							<c:if test="${user.yes!=3 }"><input
							type="checkbox" name="userlist" value="${user.id }" /></c:if>
							</span></td>
				</tr>
			</c:forEach>
		</table>
		<input type="hidden" value="${path }" id="path"> <input
			type="hidden" id="totalPageCount" value="${totalPageCount}" />
		<c:import url="rollpage.jsp">
			<c:param name="totalCount" value="${totalCount}" />
			<c:param name="pageNo" value="${pageNo}" />
			<c:param name="totalPageCount" value="${totalPageCount}" />
		</c:import>
	</div>
</body>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript">
	$(".delete").click(function() {
		var list="";
		$("[name='userlist']:checked").each(function(){
			list +=$(this).val()+","; 
		})
		if(list==null||list==''){
			alert("请选择要删除的对象");
		}else{
			if(confirm("是否删除？")){
				$.ajax({
					url:$("#path").val()+"/user/deleteByIdList",
					data:{"idList":list},
					dataType:"text",
					type:"post",
					success:function(result){
						if(result=="success"){
							alert("删除成功！");
							window.location.href=$("#path").val()+"/user/alluserlist.html";
						}else{
							alert("删除失败！")
						}
					},
					error:function(){
						alert("请求失败.");
						window.location.href=$("#path").val()+"/user/alluserlist.html";
					}
					
				})
			}
			
		}
		
	})

	
	//全选、反选
	$("#all").click(function() {
	if($(this).attr("checked")){
		$("[name='userlist']").attr("checked","true");
	}else{
		$("[name='userlist']").removeAttr("checked");
	}
	})
</script>
</html>