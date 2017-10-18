var path=$("#path").val();
function lookuser(userid){
	if(userid!=null||userid!=''){
		$.ajax({
			url:path+"/user/usershowAjax.html",
			data:{id:userid},
			dataType:"json",
			type:"get",
			success:function(result){
				if(result!=null){
					alert(result.name+result.address);
				}
			},
			error:function(){
				alert("AJAX失败！");
			}
		})
	}else{
		alert("获取用户信息失败！")
	}
	
	
	
	
}