<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<title>用户信息</title>
</head>
<script>
//Demo

</script>
<script>
layui.use(['table','form'], function(){
  var table = layui.table;
  var form = layui.form;
  
  //数据表格显示
  table.render({
    elem: '#demo'
    ,url: '${pageContext.request.contextPath}/user/userList.do' //数据接口
    ,cellMinWidth: 80
    ,page: true //开启分页
    ,id: 'testReload'
    ,cols: [[ //表头
      {field: 'id', title: 'ID',align:'center',sort: true, fixed: 'left'}
      ,{field: 'userName',align:'center', title: '用户名'}
      ,{field: 'trueName',align:'center', title: '真实姓名'}
      ,{field: 'number',align:'center', title: '联系电话'}
      ,{field: 'address',align:'center', title: '联系地址'}
      ,{field: 'roleName',align:'center', title: '角色'}
      ,{fixed: 'right',title: '操作', align:'center', toolbar: '#barDemo'}
    ]]
  });
  
  //输入框 条件搜索
  var $ = layui.$, active = {
	        reload: function(){
	            var demoReload = $('#demoReload');
	            table.reload('testReload', {
	                where: {
	                	userName: demoReload.val()
	                }
	            });
	        }
	    };
  
  //输入框按钮监听
  $('.demoTable .layui-btn').on('click', function(){
	    var type = $(this).data('type');
	    active[type] ? active[type].call(this) : '';
	});
  
  //form表格监听
  form.on('submit(formDemo)', function(data){
	    layer.msg(JSON.stringify(data.field));
	    return false;
	  });
  
  //操作按钮监听
  table.on('tool(test)', function(obj){
	    var data = obj.data;
	    if(obj.event === 'del'){
	    	//删除用户
	        layer.confirm('真的删除该用户吗？', function(index){
	            $.ajax({
	                url: "${pageContext.request.contextPath}/user/delete.do",
	                type: "POST",
	                data:{"id":data.id},
	                dataType: "json",
	                success: function(data){
	                    if(data.success){
	                       //删除这一行
	                        obj.del();
	                       //关闭弹框
	                        layer.close(index);
	                        layer.msg("删除成功", {icon: 6});
	                        setTimeout("refreshPage()",1000);
	                    }else{
	                        layer.msg(data.errorInfo, {icon: 5});
	                    }
	                }
	            });
	        });
	    } else if(obj.event === 'edit'){
	    	//修改用户
	    	 layer.open({
	    	        type: 1
	    	        ,anim:5
	    	        ,title:"修改用户"
	    	        ,area: ['700px', '520px']
	    	        ,resize:false
	    	        ,offset: '100px'
	    	        ,shade:0
	    	        ,content:$("#add",function(){
	    	        	  $.post("${pageContext.request.contextPath}/role/rolefind.do",function(result){
		    	        		 var deptSelect=$("#roleId");
		    	        		 var arr = eval('(' + result + ')');
		    	        		 for(var i =0 ;i<arr.length;i++){
		    	        			 	var opt = document.createElement ("option");
		    	        			    opt.value = arr[i].id;
		    	        			    opt.innerText = arr[i].name;
		    	        			    deptSelect.append(opt);   
		    	        			}
		    	        		 $("#roleId").val(data.roleId);
		    	        		 form.render("select");
		    	          }); 
	    	        	$("#id").val(data.id);
	    	        	$("#userName").val(data.userName);
	    	        	$("#password").val(data.password);
	    	        	$("#confirmPassword").val(data.password) 
	    	        	$("#number").val(data.number);
	    	        	$("#address").val(data.address);
	    	        	$("#trueName").val(data.trueName);
	    	        	$("#userName").attr("disabled", true);  
	    	        	form.render("radio");
	    	        })
	    	        ,btn: '保存'
	    	        ,btnAlign: 'r'
	    	        ,closeBtn:1
	    	        ,yes: function(){
	    	        	var id =$("#id").val();
	    	        	var userName =$("#userName").val();
	    	         	var password =$("#password").val();
	    	         	var confirmPassword =$("#confirmPassword").val();
	    	         	var number =$("#number").val();
	    	         	var address =$("#address").val();
	    	         	var trueName =$("#trueName").val();
	    	        	var roleId =$('#roleId option:selected').val();
	    	         	var r=/^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
	    	         	
	    	         	if(userName==null || userName==''){
	    	         		layer.msg('用户名不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(password==null || password==''){
	    	         		layer.msg('密码不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(confirmPassword==null || confirmPassword==''){
	    	         		layer.msg('确认密码不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(confirmPassword!= password){
	    	         		layer.msg('确认密码有误！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(trueName==null || trueName==''){
	    	         		layer.msg('真实姓名不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(roleId==null || roleId==''){
	    	         		layer.msg('角色不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	$.post("${pageContext.request.contextPath}/user/update.do",{id:id,userName:userName,password:password,trueName:trueName,address:address,number:number,roleId:roleId},function(result){
	    	         		if(result.success){
	    	         			layer.closeAll();
	    	         			layer.msg('用户修改成功！', {icon: 1});
	    	         			setTimeout("refreshPage()",1000);
	    	  			  }else{
	    	  					layer.msg(result.errorInfo, {icon: 5});
	    	  			  }
	    	         	});
	    	        	
	    	        }
			    	 ,cancel: function(index, layero){ 
			    		 setTimeout("refreshPage()",100);
			    		  return false; 
			    		}  
	    	      });
	    }else if(obj.event === 'cz'){
	    	//修改用户
	    	 layer.open({
	    	        type: 1
	    	        ,anim:5
	    	        ,title:"重置密码"
	    	        ,area: ['500px', '180px']
	    	        ,resize:false
	    	        ,offset: '100px'
	    	        ,shade:0
	    	        ,content:'<div style="padding: 30px;">是否要重置密码？重置后为"123"</div>'
	    	        ,btn: '确认'
	    	        ,btnAlign: 'r'
	    	        ,closeBtn:2
	    	        ,yes: function(){
	    	         	$.post("${pageContext.request.contextPath}/user/reset.do",{id:data.id},function(result){
	    	         		if(result.success){
	    	         			layer.closeAll();
	    	         			layer.msg('密码重置成功！', {icon: 1});
	    	         			setTimeout("refreshPage()",1000);
	    	  			  }
	    	         	});
	    	        	
	    	        }
			    	 ,cancel: function(index, layero){ 
			    		 setTimeout("refreshPage()",100);
			    		  return false; 
			    		}  
	    	      });
	    }
	});
});
  </script>
<body>
 <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>用户管理</legend>
  </fieldset>
  <div class="demoTable">
	<div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
    	用户名称：
		<div class="layui-inline">
			<input class="layui-input" name="userName" id="demoReload" autocomplete="off">
		</div>
		<button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
		<button data-method="offset" data-type="auto" class="layui-btn"><i class="layui-icon">&#xe654;</i>添加用户</button>
	</div>
</div>   
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="cz">重置密码</a>
</script>
<script>
layui.use(['layer','form'], function(){ 
  var $ = layui.jquery, layer = layui.layer,form = layui.form;
  var active = {
    offset: function(othis){
      var type = othis.data('type')
      ,text = othis.text();
    	  $.post("${pageContext.request.contextPath}/role/rolefind.do",function(result){
     		 var deptSelect=$("#roleId");   
     		 var arr = eval('(' + result + ')');
     		 for(var i =0 ;i<arr.length;i++){
     			 	var opt = document.createElement ("option");
     			    opt.value = arr[i].id;
     			    opt.innerText = arr[i].name;
     			    deptSelect.append(opt); 
     			    console.log(opt);
     			}
     		 form.render("select");
       }); 
      layer.open({
        type: 1
        ,anim:5
        ,title:"添加商品"
        ,area: ['700px', '600px']
        ,resize:false
        ,shade:0
        ,offset: '30px' 
        ,content:$("#add")
        ,btn: '保存'
        ,btnAlign: 'r' //按钮居中
        ,yes: function(){
        	var userName =$("#userName").val();
         	var password =$("#password").val();
         	var confirmPassword =$("#confirmPassword").val();
         	var trueName =$("#trueName").val();
         	var number =$("#number").val();
         	var address =$("#address").val();
         	var roleId =$('#roleId option:selected').val(); 
         	var r=/^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
         	if(userName==null || userName==''){
         		layer.msg('用户名不能为空！', {icon: 5});
         		return false;
         	}
         	if(password==null || password==''){
         		layer.msg('密码不能为空！', {icon: 5});
         		return false;
         	}
         	if(confirmPassword==null || confirmPassword==''){
         		layer.msg('确认密码不能为空！', {icon: 5});
         		return false;
         	}
         	if(confirmPassword!= password){
         		layer.msg('确认密码有误！', {icon: 5});
         		return false;
         	}
         	if(trueName==null || trueName==''){
         		layer.msg('真实姓名不能为空！', {icon: 5});
         		return false;
         	}
         	if(roleId==null || roleId==''){
         		layer.msg('角色不能为空！', {icon: 5});
         		return false;
         	}
         	$.post("${pageContext.request.contextPath}/user/add.do",{userName:userName,password:password,trueName:trueName,address:address,number:number,roleId:roleId},function(result){
         		if(result.success){
         			layer.closeAll();
         			layer.msg('用户添加成功！', {icon: 1});
         			setTimeout("refreshPage()",1000);
  			  }else{
  					layer.msg(result.errorInfo, {icon: 5});
  			  }
         	});
        }
      ,cancel: function(index, layero){ 
 		 setTimeout("refreshPage()",100);
 		  return false; 
 		} 
      });
      
    }
  };
  $('#layerDemo .layui-btn').on('click', function(){
    var othis = $(this), method = othis.data('method');
    active[method] ? active[method].call(this, othis) : '';
  });
});

function refreshPage()
{
window.location.reload();
}
</script>
  <table id="demo" lay-filter="test" ></table>
  <form class="layui-form" id="add" action="" style="display:none;padding-left: 10%">
  <div class="layui-form-item" style="padding: 15px;">
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label" style="color: red;">用户名</label>
    <div class="layui-input-block">
      <input type="hidden" name="id" id="id"  style="width: 15px;" lay-verify="title" autocomplete="off" class="layui-input">
      <input type="text" name="userName" id="userName"  style="width: 350px;" lay-verify="title" autocomplete="off" placeholder="请输入用户名" class="layui-input" >
    </div>
  </div>
   <div class="layui-form-item" >
    <label class="layui-form-label" style="color: red;">密码</label>
    <div class="layui-input-block">
      <input type="password" name="password" id="password"  style="width: 350px;" lay-verify="title" autocomplete="off" placeholder="请输入密码" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item" >
    <label class="layui-form-label" style="color: red;">确认密码</label>
    <div class="layui-input-block">
      <input type="password" name="confirmPassword" id="confirmPassword"  style="width: 350px;" lay-verify="title" autocomplete="off" placeholder="请输入确认密码" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label" style="color: red;">真实姓名</label>
    <div class="layui-input-block">
      <input type="text" name="trueName" id="trueName" style="width: 350px;" lay-verify="title" autocomplete="off" placeholder="请输入真实姓名" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">联系地址</label>
    <div class="layui-input-block">
      <input type="text" name="address" id="address" style="width: 350px;" lay-verify="title" autocomplete="off" placeholder="请输入联系地址" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">联系方式</label>
    <div class="layui-input-block">
      <input type="text" name="number" id="number" style="width: 350px;" lay-verify="title" autocomplete="off" placeholder="请输入联系方式" class="layui-input">
    </div>
  </div>
   <div class="layui-form-item">
    <label class="layui-form-label" style="color: red;">角色</label>
    <div class="layui-input-block" style="width: 250px;">
      <select class="layui-input" name="roleId" id="roleId" lay-verify="required" >
      	<option value="">请选择角色</option>
      </select>
    </div>
  </div>
  </form>
</body>
</html>