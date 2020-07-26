var path=$("#path").val();
function lookuser(userid){
	debugger
	if(userid!=null||userid!=''){
		$.ajax({
			url:path+"/user/usershowAjax.html",
			data:{id:userid},
			dataType:"json",
			type:"get",
			success:function(result){
				if(result!=null){
					$.messager.show({
						title:'用户信息',
						msg:result.name+"-"+result.address,
						showType:'show',
						style: {
							right:'',
							top:document.body.scrollTop+document.documentElement.scrollTop,
							bottom:''
						}
					})
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