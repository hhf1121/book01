function allborrow(id){
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
				initBooksData();
			}else if(result=="xxx"){
				alert("删除书籍异常！");
				initBooksData();
			}else{
				alert("删除失败，此书籍存在外借...")
				initBooksData();
			}
		},
		error:function(){
			alert("操作失败！");
		}
	})
}