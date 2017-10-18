function allborrow(id,pageNo){
	var bid=id;
	var path=$("#path").val();
	$.ajax({
		url:path+"/book/deleteBook.html",
		data:{bid:bid},
		dataType:"text",
		type:"post",
		success:function(result){
			if(result=="true"){
				alert("删除成功！");
				window.location.href=path+"/book/allbooklist.html?pageIndex="+pageNo;
			}else if(result=="xxx"){
				alert("删除书籍发生意外！");
				window.location.href=path+"/book/allbooklist.html?pageIndex="+pageNo;
			}else{
				alert("删除失败，此书籍存在外借...")
				window.location.href=path+"/book/allbooklist.html?pageIndex="+pageNo;
			}
		},
		error:function(){
			alert("操作失败！");
		}
	})
}