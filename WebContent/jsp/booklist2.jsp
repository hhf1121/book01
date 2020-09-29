<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path=request.getContextPath();
request.setAttribute("path", path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>图书信息-easyUI</title>
</head>
<body>
<input type="hidden" value="${path }" id="path">
<form id="formFindList">
	<div  class="easyui-accordion" style="width: 100%">
		<div title="查询条件" data-options="selected:true">
			<ul class="search-form" style="list-style-type:none;">
				<li><input name="name" class="easyui-textbox" label="图书名称："   data-options="prompt:'支持模糊查询'" style="width:20%">
					<input name="author" class="easyui-textbox" label="作者名字：" style="width:20%">
					 时间：<input name="startTime"  class="easyui-datetimebox"   id="q_startTime" style="width:12%">至
					<input name="endTime"  class="easyui-datetimebox"  id="q_endTime" data-options="validType:['endTimeDate[\'#q_startTime\',\'结束时间必须大于或等于发起时间\']']" style="margin-left:0px;width:12%">
				</li>
				<li style="float: right">
					<a href="#" class="easyui-linkbutton search" onclick="findFlowData()">查询</a>
					<a href="#" class="easyui-linkbutton" onclick="formReset()">重置</a>
				</li>
			</ul>
		</div>
	</div>
</form>
<%--<div id="app">
	<input type="text" v-model="info" />
	{{info}}
	<button @click="test(1)">点击</button>
</div>--%>
	<table id="dataGridInbound" title="图书列表" class="easyui-datagrid" style="width: 100%;height: 540px"></table>
</body>
<script src="../js/vue-2.3.min.js" type="text/javascript" charset="utf-8"></script>
<script src="//unpkg.com/element-ui@2.3.2/lib/index.js"></script>
<link rel="stylesheet" type="text/css" href="//unpkg.com/element-ui@2.3.2/lib/theme-chalk/index.css" />
<script>
	$(function () {
        initDate();
		var p = $('#dataGridInbound').datagrid('getPager');
		$(p).pagination({
			pageSize: 10,//每页显示的记录条数，默认为10
			pageList: [5,10,20,50],//可以设置每页记录条数的列表
			beforePageText: '第',//页数文本框前显示的汉字
			afterPageText: '页    共 {pages} 页',
			displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
		});
	})

    function initDate(){
        $("#dataGridInbound").datagrid({
            url: '/book/book/getbookList',
			method:'get',
			pagination: true,//显示分页工具栏
            loadMsg: "正在努力加载数据，请稍后...",
            onBeforeLoad : function(param) {
            },
            onLoadError : function() {
                //在载入远程数据产生错误的时候触发。
            },
            onLoadSuccess: function (data) {
                if (data.total == 0) {
                    var body = $(this).data().datagrid.dc.body2;
                    body.find('table tbody').append('<tr><td style="height: 35px;width: 150px; text-align: center;display: inline-block;float: right;color: grey"><h1>未查到数据</h1></td></tr>');
                    $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
                }
                //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
                else $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
            },
            columns: [[
                { field: 'ck', checkbox: true },
                { field: 'id', title: '图书编码', width: '80', align: 'center', sortable: true },
                { field: 'name', title: '图书名称', width: '200', align: 'left', sortable: true },
                { field: 'author', title: '作者', width: '200', align: 'left', sortable: true },
                { field: 'count', title: '库存', width: '200', align: 'left', sortable: true },
                {
                    field: 'deal',
                    title: '操作',
                    align: 'center',
                    width: '200',
                    formatter: function(value, rec, index) {
                        var result = '<div id="caozuo" ><a  title="查看"  onclick="look(\''+rec.name+'\',\''+rec.count+'\')" href="javascript:void(0)">查看</a>'
                            + '<a  style="margin-left:10px" title="借阅"  onclick="borrow(\'' + rec.id + '\',${currentUser.id},$(\'#dataGridInbound\').datagrid(\'options\').pageNumber)" href="javascript:void(0)">借阅</a>';
						if(rec){//已收藏
							result=result+'<div style="display: inline;margin-left: 5px"><a  onclick="noticeLibrary(\'' + index + '\')"  href="javascript:void(0)" >' +
									'<img width="15px" height="15px"  src="/book/resource/images/star.png" id="starId'+index+'" title="收藏">' +
									'</a></div>';
						}else {
							result=result+'<div style="display: inline;margin-left: 5px"><a  onclick="noticeLibrary(\'' + index + '\')"  href="javascript:void(0)" >' +
									'<img width="15px" height="15px"  src="/book/resource/images/star-empty.png" id="starId'+index+'" title="收藏">' +
									'</a></div>';
						}
						return result+'</div>';
                    }
                },
            ]],
        });
    }

	var path = $("#path").val();
	function borrow(bookid, userid,page) {
		// $('#dataGridInbound').datagrid('options');
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
					// window.location.href=path+"/book/booklist2.html?page="+page;
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
//					window.location.href = path
//							+ "/borrow/addBorrow.html?bookid=" + bookid
//							+ "&userid=" + userid;
						xyz();
					} else if (reslut = "false") {
						// window.location.href=path+"/book/booklist2.html?page="+page;
                        $.messager.confirm('提示', '您已经借阅了此书！', function(r){
                            if (r){
                                $.messager.progress('close');
                            }
                        });

					} else {
						// window.location.href=path+"/book/booklist2.html?page="+page;
						alert("noData！");
					}
				},
				error : function() {
					alert("ajax请求失败！")
				}
			})
		}

		function xyz(){
			$.ajax({
				url:path+ "/borrow/addBorrow.html",
				data:{bookid:bookid,userid:userid},
				dataType:"text",
				type:"get",
				success:function(d){
					if(d=="true"){
						// window.location.href=path+"/book/booklist2.html?page="+page;
                        $.messager.alert('提示','借阅成功');
                        initDate();
                    }else{
						// window.location.href=path+"/book/booklist2.html?page="+page;
						alert("借阅失败！");
					}
				}

			})
		}

	}

	function look(name, count) {
		// $('#dd').dialog('refresh', 'new_content.php');
        // $('#dd').css("display","block");
		// $('#dd').dialog({
		// 	title: '提示',
		// 	width: 400,
		// 	height: 200,
		// 	closed: false,
		// 	cache: false,
		// 	concat: name + "剩余" + count + "本",
		// 	// href: 'get_content.php',
		// 	modal: true
		// });
        $.messager.alert('提示',name + "剩余" + count + "本");
	}

	//重置
	function formReset(){
		$("#formFindList").form('reset');
	}

	//查询
	function findFlowData() {
			var paramArray = $("#formFindList").serializeArray();
			var paramObjs = {};
			for (var i = 0; i < paramArray.length; i++) {
				var paramObj = {};
				paramObj[paramArray[i].name] = paramArray[i].value;
				$.extend(paramObjs, paramObj);
			}
		//请求
		$('#dataGridInbound').datagrid('load',paramObjs);
	}
	//普通方法调用vue
	function noticeLibrary(index) {
		myVue.vue_noticeLibrary(index);
	}
	var myVue=new Vue({
		el: "#vueScope",
		data:{
			isTitle:'收藏'
		},
		methods:{
				vue_noticeLibrary: function(index) {
				debugger
				var row = $('#dataGridInbound').datagrid('getRows')[index];
				//后端请求，落库。
				// $.ajax({
				// 	type: "GET",
				// 	url: "library/noticeLibrary.do",
				// 	data: { noticeId: row.id },
				// 	success: function (data, textStatus) {
				// 		if('success'===data){
				// 			// $.messager.alert('提示','操作成功');
				// 			//改变星标
				// 			var starId="starId"+index;
				// 			console.info(starId);
				// 			if($("#"+starId+"")[0].src.indexOf('/images/star.png')!==-1){
				// 				$("#"+starId+"").attr('src','/book/resource/images/star-empty.png');
				// 			}else if($("#"+starId+"")[0].src.indexOf('/images/star-empty.png')!==-1){
				// 				$("#"+starId+"").attr('src','/book/resource/images/star.png');
				// 			}
				// 		}else {
				// 			$.messager.alert('提示','操作失败,请稍后重试');
				// 		}
				// 	}
				// });
				var starId="starId"+index;
				if($("#"+starId+"")[0].src.indexOf('/images/star.png')!==-1){
					$("#"+starId+"").attr('src','/book/resource/images/star-empty.png');
					this.$message({
						message: '取消收藏(假操作)!',
                        center: true
					});
				}else if($("#"+starId+"")[0].src.indexOf('/images/star-empty.png')!==-1){
					$("#"+starId+"").attr('src','/book/resource/images/star.png');
					this.$message({
						message: '已收藏(假操作)!',
						type: 'success',
                        center: true
					});
				}
			}
		}
	});
	var app=new Vue({
		el:'#app',
		data:{
			info:'我是app'
		},
		methods:{
			test : function(index){
				this.$message({
					message: '操作成功(假操作)!'+this.info,
					type: 'success'
				});
			}
		}
	})
</script>
</html>