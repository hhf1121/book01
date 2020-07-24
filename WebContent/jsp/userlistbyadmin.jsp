<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String	userId= request.getParameter("id");

String path = request.getContextPath();
	request.setAttribute("path", path);
	request.setAttribute("userId", userId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息编辑</title>
<style type="text/css">
.s{
	color: red;
	font-size: 12px;
}
</style>
</head>
<body>
<input type="hidden" value="${path }" id="path">
<input type="hidden" value="${userId }" id="userId">
<div style="width: 300px;height: auto;text-align:center">
	<form id="myform" method="post">
		用户id：<input class="easyui-textbox" name="id" data-options="required:true" /><br>
		用户账号：<input class="easyui-textbox" name="userName" data-options="required:true" /><br>
		用户密码：<input class="easyui-textbox" name="passWord" data-options="required:true" /><br>
		用户姓名：<input class="easyui-textbox" name="name" data-options="required:true" /><br>
		用户地址：<input class="easyui-textbox" name="address" data-options="required:true" /><br>
		用户身份：<select class="easyui-combobox" style="width: 150px;" name="yes" data-options="loader:myUserloader,mode:'remote',valueField:'id',textField:'roleName',
        panelWidth:150,panelHeight:'auto'">
	</select>
	</form>
	<a href="#" class="easyui-linkbutton" onclick="submitForm()">提交</a>
</div>



<script type="text/javascript">
	// const  isuserTypeArray=new Array();
	$(function () {
		//根据id获取用户
		initUser($("#userId").val());
		$("#myform").form({
			width:'300px',
			height:'auto',
			textAlign:'center',
			url:'${pageContext.request.contextPath }/user/upateUser',
			onSubmit: function(){

			},
			success:function(data){
				let result=JSON.parse(data);//字符串转换成json对象
				if(result.success){
					$.messager.confirm('提示',result.data,function (r) {
						if(r){
							$('#dialog').dialog('close');
							$("#userTable").datagrid('load');
						}
					})
				}else{
					$.messager.alert("提示",result.data);
				}
			}
		})
	})

	function myUserloader(param, success, error) {
		$.ajax({
			url:$("#path").val()+'/base/getUserLevel',
			method:'post',
			dataType:'json',
			success:function (data) {
				success(data);
			},
			error:function () {
				error.apply(this,arguments)
			}
		})
	}

	function submitForm(){
		$.messager.confirm('提示',"确定修改？",function (r) {
			if(r){
				if($("#myform").form('validate')){
					$("#myform").submit();
				}
			}else{
				initUser($("#userId").val());
			}
		})

	}

	function initUser(id) {
		$.ajax({
			url:$("#path").val()+'/user/getUserById?id='+id,
			dataType:'json',
			method:'get',
			success:function (data) {
				if(data.success){
					var user=data.data;
					$("#myform").form('load',{
						id:user.id,
						name:user.name,
						userName:user.userName,
						passWord:user.passWord,
						address:user.address,
						yes:user.yes
					});
				}
				// success(data);
			},
			error:function () {
				error.apply(this,arguments)
			}
		})
	}

	// function formatItem(data) {
	// 	for (var j=0;j<isuserTypeArray.length;j++){
	// 		if(data.id==isuserTypeArray[j].id){
	// 			return isuserTypeArray[j].roleName;
	// 		}
	// 	}
	// 	return "未获取"
	// }


</script>
</body>
</html>