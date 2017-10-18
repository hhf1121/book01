var path = $("#path").val();
function borrow(bookid, userid) {
	$.ajax({
		url : path + "/book/ajax",
		data : {
			bid : bookid
		},
		dataType : "text",
		type : "post",
		success : function(result) {
			if (result == "true") {
				abc();
			}else{
				window.location.href=path+"/book/booklist.html";
				alert("书籍库存不足！");
			}
		}
	})
	function abc() {
		// alert(bookid+"-"+bookcount+"-"+userid);
		$.ajax({
			url : path + "/book/borrow.html",
			data : {
				bid : bookid,
				uid : userid
			},
			type : "post",
			dataType : "text",
			success : function(result) {
				if (result == "true") {
					// 刷新window.history.go(0);
					window.location.href = path
							+ "/borrow/addBorrow.html?bookid=" + bookid
							+ "&userid=" + userid;
				} else if (reslut = "false") {
					alert("您已经借阅了此书！");
				} else {
					alert("noData！");
				}
			},
			error : function() {
				alert("ajax请求失败！")
			}
		})
	}
}

function look(name, count) {
	alert(name + "剩余" + count + "本");
}
