<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增图书</title>
</head>
<body>

    <div style="float: left"><br>
        <a class="easyui-linkbutton" data-options="iconCls:'icon-back'" href="${pageContext.request.contextPath }/user/login.html">返回首页</a>
    </div>
    <br>
    <br>
    <div style="padding:10px 60px 20px 60px">
        <form id="addBook"   method="post">
            <table cellpadding="5">
                <tr>
                    <td class="mytd">书名:</td>
                    <td><input class="easyui-validatebox easyui-textbox" data-options="required:true,missingMessage:'书名不能为空'" type="text" style="height: 30px" name="name" id="bookName"></input></td>
                </tr>
                <tr>
                    <td class="mytd">作者:</td>
                    <td><input class="easyui-validatebox easyui-textbox" type="text" style="height: 30px" name="author" id="authorName" data-options="required:true,missingMessage:'作者不能为空'"></input></td>
                </tr>
                <tr>
                    <td class="mytd">库存总数:</td>
                    <td><input class="easyui-validatebox easyui-textbox" type="text" style="height: 30px" name="count" id="countName" data-options="required:true,missingMessage:'总数不能为空'"></input></td>
                </tr>
            </table>
        </form>
        <div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="isOk()">确定</a>
        </div>
    </div>

<script type="text/javascript">
    //提交
	function isOk(){
        $('#addBook').form('submit', {
            url:"${pageContext.request.contextPath }/book/SaveaddBook",
            onSubmit: function(){
                var flag= $(this).form('validate');
                if(!flag){
                    $.messager.show({
                        title:'提示',
                        msg:'请先校验表单再提交',
                        showType:'show',
                        style: {
                            right:'',
                            top:document.body.scrollTop+document.documentElement.scrollTop,
                            bottom:''
                        }
                    })
                }
                return flag;
            },
            success:function(data){
                if(data=='"true"'){
                    $.messager.alert("提示","新增成功");
                    $('#userbookdialog').dialog('close');
                    $("#bookTable").datagrid('load');
                }else if(data=='"exits"'){
                    $.messager.alert("提示","已存在重复数据");
                }else {
                    $.messager.alert("提示","新增失败");
                }
            }
        });
	}
</script>
</body>
</html>