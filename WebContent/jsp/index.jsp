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
<title>注册</title>
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
		<input type="button" value="注册" onclick="register();" />
</form>
<h3>${error }</h3>
<a href="<%=path%>/login/dologin.html">我有账号</a>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript">
	function register() {
		var userName=$("#userName").val();
		var passWord=$("#passWord").val();
		var name=$("#name").val();
		var address=$("#address").val();
		var path=$("#path").val();
		var flag=false;
		var f=false;
		var f1=false;
		var f2=false;
		if(userName==null||userName==''){
			$("#s1").html("账号不能为空").css({"color":"red","font-size":"12px"});;
			flag=false;
		}else{
			$.ajax({
				async:false,
				url:path+"/user/ifExist",
				data:{userName:userName},
				dataType:"text",
				type:"post",
				success:function(result){
					if(result=="true"){
						$("#s1").html("账号可以使用").css({"color":"green","font-size":"12px"});;
						flag=true;
					}else{
						$("#s1").html("账号被占用").css({"color":"red","font-size":"12px"});;
						flag=false;
					}
				},
				error:function(){
					$("#s1").html("验证失败").css({"color":"red","font-size":"12px"});;
					flag=false;
				}
			})
		}
		if(passWord==null||passWord==''){
			$("#s2").html("密码不能为空").css({"color":"red","font-size":"12px"});
			f=false;
		}else{
			$("#s2").html("密码合法").css({"color":"green","font-size":"12px"});
			f=true;
		}
		var erx=/[^0-9]/;//正则：不是数字
		if(name==null||name==''){
			$("#s3").html("姓名不能为空").css({"color":"red","font-size":"12px"});;
			f1=false;
		}else if(!erx.test(name)){
			$("#s3").html("必须正确填写您的姓名、一旦注册成功，不可修改").css({"color":"red","font-size":"12px"});;
			f1=false;
		}else{
			$("#s3").html("姓名合法").css({"color":"green","font-size":"12px"});;
			f1=true;
		}

		if(address==null||address==''){
			$("#s4").html("地址不能为空").css({"color":"red","font-size":"12px"});;
			f2=false;
		}else{
			$("#s4").html("地址合法").css({"color":"green","font-size":"12px"});;
			f2=true;
		}
		//提交表单
		if(f==true&&f1==true&&f2==true&&flag==true){
			$("#form").submit();
		}
	}
</script>
</body>
</html>