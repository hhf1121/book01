<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String path=request.getContextPath(); %>
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
 ${currentUser.userName }, 欢迎你！  <br>
 <h1>当前页面：共享资源页面</h1>
 <form action="<%=path%>/upLoad/uploadFile.html" method="post" enctype="multipart/form-data">
 <input type="hidden" name="userid" value="${currentUser.id }">
 <input type="file" name="path" >
 <input type="submit" value="上传">${infoxx }
 </form>
  <table class="bookTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="25%">图书名称</th>
                <th width="25%">上传者</th>
                <th width="25%">上传时间</th>
            </tr>
            <c:forEach var="x" items="${listss }" varStatus="status">
				<tr>
					<td>
					<span>${x.upName }</span>
					</td>
					<td>
					<span>${x.userName}</span>
					</td>
					<td>
					<span>${x.createDate }</span>
					</td>
					<td>
					<span><a  href="javascript:deletefile(${x.id });">删除</a></span>
					<span><a  href="<%=path %>/upLoad/download.html?file=${x.path }">下载 </a></span>
					<span><a  href="javascript:show('${x.id }')">查看</a></span>
					</td>
				</tr>
			</c:forEach>
        </table>
        
        <div id="show"></div>
        <input type="hidden" id="path" value="<%=path%>">
       <a href="<%=path%>/user/login.html">返回个人首页</a>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.js"></script>
<script type="text/javascript">
function deletefile(idx){
	$.ajax({
		url:$("#path").val()+"/upLoad/deleteFile.html",
		data:{id:idx},
		dataType:"text",
		type:"get",
		success:function(result){
			if(result=="success"){
				alert("删除文件成功");
				window.location.href=$("#path").val()+"/upLoad/Filelist.html";
			}else{
				alert("删除文件失败");
			}
		},
		error:function(){
			alert("请求失败！");
		}
	})
}
function show(info){
	$.ajax({
		url:$("#path").val()+"/upLoad/fileshow.html",
		data:{id:info},
		dataType:"text",
		type:"get",
		success:function(result){
			if(result!=null||result!=''){
			$("#show").html(result);	
			}
		},
		error:function(){
			alert("获取数据失败");
		}
	})
}

</script>
</body>
</html>