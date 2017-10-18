
function register(){
		var userName=$("#userName").val();
		var passWord=$("#passWord").val();
		var name=$("#name").val();
		var address=$("#address").val();
		var path=$("#path").val();
		var flag=false;
		var f=false;
		var f1=false;
		var f2=false;
		if(userName==null||userName==''){
			$("#s1").html("账号不能为空").css({"color":"red","font-size":"12px"});;
			flag=false;
		}else{
		$.ajax({
			async:false,
			url:path+"/user/ifExist",
			data:{userName:userName},
			dataType:"text",
			type:"post",
			success:function(result){
				if(result=="true"){
					$("#s1").html("账号可以使用").css({"color":"green","font-size":"12px"});;
					flag=true;
				}else{
					$("#s1").html("账号被占用").css({"color":"red","font-size":"12px"});;
					flag=false;
				}
			},
			error:function(){
				$("#s1").html("验证失败").css({"color":"red","font-size":"12px"});;
				flag=false;
			}
		})
		}
		if(passWord==null||passWord==''){
			$("#s2").html("密码不能为空").css({"color":"red","font-size":"12px"});
			f=false;
		}else{
			$("#s2").html("密码合法").css({"color":"green","font-size":"12px"});
			f=true;
		}
		var erx=/[^0-9]/;//正则：不是数字
		if(name==null||name==''){
			$("#s3").html("姓名不能为空").css({"color":"red","font-size":"12px"});;
			f1=false;
		}else if(!erx.test(name)){
			$("#s3").html("必须正确填写您的姓名、一旦注册成功，不可修改").css({"color":"red","font-size":"12px"});;
			f1=false;
		}else{
			$("#s3").html("姓名合法").css({"color":"green","font-size":"12px"});;
			f1=true;
		}
		
		if(address==null||address==''){
			$("#s4").html("地址不能为空").css({"color":"red","font-size":"12px"});;
			f2=false;
		}else{
			$("#s4").html("地址合法").css({"color":"green","font-size":"12px"});;
			f2=true;
		}
		//提交表单
		if(f==true&&f1==true&&f2==true&&flag==true){
			$("#form").submit();
		}
}

