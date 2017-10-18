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
				alert("归还书籍成功！");
				window.location.href=path+"/borrow/borrowlist.html";
			}else if(result=="false"){
				alert("归还书籍失败/记录已放入历史中...");
				window.location.href=path+"/borrow/borrowlist.html";
			}else{
				alert("归还书籍失败/请重试...");
				window.location.href=path+"/borrow/borrowlist.html";
			}
		},
		error:function(){
			alert("ajax失败！")
		}
	})
	
	
	
}
function lookx(bookName,borrowTime){
	alert(bookName+",被借日期"+borrowTime);
}
