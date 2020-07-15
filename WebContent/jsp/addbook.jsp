<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<span style="color:red">${addbookInfo }</span>
<form action="${pageContext.request.contextPath}/book/SaveaddBook.html" method="post" id="form">
书名：<input type="text" name="name" id="name"/><span id="s1"></span><br/>
作者：<input type="text" name="author" id="author"/><span id="s2"></span><br/>
库存：<input type="text" name="count" id="count"/><span id="s3"></span><br/>
<input type="button" value="添加" onclick="add();"/>
</form>
<a href="${pageContext.request.contextPath}/book/allbooklist.html">返回书籍列表页面</a>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript">
	function add(){
		var name=document.getElementById("name").value;
		var author=document.getElementById("author").value;
		var count=document.getElementById("count").value;
		var f=false;
		var f1=false;
		var f2=false;
		if(name==null||name==''){
			$("#s1").html("请填入合法的书名").css("color","red");
			f=false;
		}else{
			f=true;
		}
		if(author==null||author==''){
			$("#s2").html("请填入合法的名字").css("color","red");
			f1=false;
		}else{
			f1=true;
		}
		var co=parseInt(count);
		if(isNaN(co)){
			$("#s3").html("请填入合法的库存").css("color","red");
			f2=false;
		}else{
			f2=true;
		}
		if(f==true&&f1==true&&f2==true){
			$("#form").submit();
		}
	}
</script>
</body>
</html>