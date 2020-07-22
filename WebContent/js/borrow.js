var path=$("#path").val();
function borrowx(bookid,userid){
	//alert(path+"/borrow/delete.html");
	$.ajax({
		url:path+"/borrow/delete.html",
		data:{bid:bookid,uid:userid},
		dataType:"text",
		type:"post",
		success:function(result){
			if(result=="true"){
                $.messager.confirm('提示',"归还书籍成功！", function(r){
                    if (r){
                        // window.location.href=path+"/borrow/borrowlist.html";
						initborrowlistDate();
                    }
                });
			}else if(result=="false"){
                $.messager.alert('提示',"归还书籍失败/记录已放入历史中...");
				initborrowlistDate();
				// window.location.href=path+"/borrow/borrowlist.html";
			}else{
                $.messager.alert('提示',"归还书籍失败/请重试...");
				initborrowlistDate();
				// window.location.href=path+"/borrow/borrowlist.html";
			}
		},
		error:function(){
			alert("ajax失败！")
		}
	})
	
	
	
}
function lookx(bookName,borrowTime){
    $.messager.alert('提示',"书名:"+bookName+"<br/>被借日期:"+borrowTime);
}
