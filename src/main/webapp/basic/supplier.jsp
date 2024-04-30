<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<title>供应商信息</title>
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
    ,url: '${pageContext.request.contextPath}/supplier/supplierList.do' //数据接口
    ,cellMinWidth: 80
    ,page: true //开启分页
    ,id: 'testReload'
    ,cols: [[ //表头
      {field: 'id', title: 'ID',align:'center',sort: true, fixed: 'left'}
      ,{field: 'address',align:'center', title: '地址'}
      ,{field: 'contact',align:'center', title: '联系人'}
      ,{field: 'name',align:'center', title: '厂商'}
      ,{field: 'number',align:'center', title: '联系方式'}
      ,{field: 'remarks',align:'center', title: '备注'}
      ,{fixed: 'right',title: '操作', align:'center', toolbar: '#barDemo'}
    ]]
  });
  
  //输入框 条件搜索
  var $ = layui.$, active = {
	        reload: function(){
	            var demoReload = $('#demoReload');
	            table.reload('testReload', {
	                where: {
	                	name: demoReload.val()
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
	        layer.confirm('真的删除该供应商吗？', function(index){
	            $.ajax({
	                url: "${pageContext.request.contextPath}/supplier/delete.do",
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
	    	        ,title:"修改供应商"
	    	        ,area: ['700px', '520px']
	    	        ,resize:false
	    	        ,offset: '100px'
	    	        ,shade:0
	    	        ,content:$("#add",function(){
	    	        	$("#id").val(data.id);
	    	        	$("#name").val(data.name);
	    	        	$("#contact").val(data.contact);
	    	        	$("#address").val(data.address) 
	    	        	$("#number").val(data.number);
	    	        	$("#remarks").val(data.remarks);
	    	        })
	    	        ,btn: '保存'
	    	        ,btnAlign: 'r'
	    	        ,closeBtn:1
	    	        ,yes: function(){
	    	        	var id =$("#id").val();
	    	        	var address =$("#address").val();
	    	         	var contact =$("#contact").val();
	    	         	var name =$("#name").val();
	    	         	var number =$("#number").val();
	    	         	var remarks =$("#remarks").val();
	    	         	if(address==null || address==''){
	    	         		layer.msg('地址不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(contact==null || contact==''){
	    	         		layer.msg('联系人不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(name==null || name==''){
	    	         		layer.msg('供应商不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(number==null || number==''){
	    	         		layer.msg('联系方式不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	$.post("${pageContext.request.contextPath}/supplier/update.do",{id:id,address:address,contact:contact,name:name,number:number,remarks:remarks},function(result){
	    	         		if(result.success){
	    	         			layer.closeAll();
	    	         			layer.msg('供应商修改成功！', {icon: 1});
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
	});
});
  </script>
<body>
 <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>用户管理</legend>
  </fieldset>
  <div class="demoTable">
	<div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
    	供应商名称：
		<div class="layui-inline">
			<input class="layui-input" name="name" id="demoReload" autocomplete="off">
		</div>
		<button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
		<button data-method="offset" data-type="auto" class="layui-btn"><i class="layui-icon">&#xe654;</i>添加供应商</button>
	</div>
</div>   
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
layui.use('layer', function(){ 
  var $ = layui.jquery, layer = layui.layer; 
  var active = {
    offset: function(othis){
      var type = othis.data('type')
      ,text = othis.text();
      layer.open({
        type: 1
        ,anim:5
        ,title:"添加供应商"
        ,area: ['600px', '500px']
        ,resize:false
        ,shade:0
        ,offset: '60px'
        ,content:$("#add")
        ,btn: '保存'
        ,btnAlign: 'r' //按钮居中
        ,yes: function(){
         	var address =$("#address").val();
         	var contact =$("#contact").val();
         	var name =$("#name").val();
         	var number =$("#number").val();
         	var remarks =$("#remarks").val();
         	if(address==null || address==''){
         		layer.msg('地址不能为空！', {icon: 5});
         		return false;
         	}
         	if(contact==null || contact==''){
         		layer.msg('联系人不能为空！', {icon: 5});
         		return false;
         	}
         	if(name==null || name==''){
         		layer.msg('供应商不能为空！', {icon: 5});
         		return false;
         	}
         	if(number==null || number==''){
         		layer.msg('联系方式不能为空！', {icon: 5});
         		return false;
         	}
         	$.post("${pageContext.request.contextPath}/supplier/add.do",{address:address,contact:contact,name:name,number:number,remarks:remarks},function(result){
         		if(result.success){
         			layer.closeAll();
         			layer.msg('供应商添加成功！', {icon: 1});
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
    <label class="layui-form-label" style="color: red;">地址</label>
    <div class="layui-input-block">
      <input type="hidden" name="id" id="id"  style="width: 15px;" lay-verify="title" autocomplete="off" class="layui-input">
      <input type="text" name="address" id="address"  style="width: 350px;" lay-verify="title" autocomplete="off" placeholder="请输入地址" class="layui-input" >
    </div>
  </div>
   <div class="layui-form-item" >
    <label class="layui-form-label" style="color: red;">联系人</label>
    <div class="layui-input-block">
      <input type="text" name="contact" id="contact"  style="width: 350px;" lay-verify="title" autocomplete="off" placeholder="请输入联系人" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item" >
    <label class="layui-form-label" style="color: red;">供应商</label>
    <div class="layui-input-block">
      <input type="text" name="name" id="name"  style="width: 350px;" lay-verify="title" autocomplete="off" placeholder="请输入供应商" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label" style="color: red;">联系方式</label>
    <div class="layui-input-block">
      <input type="text" name="number" id="number" style="width: 350px;" lay-verify="title" autocomplete="off" placeholder="请输入联系方式" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">备注</label>
    <div class="layui-input-block">
      <input type="text" name="remarks" id="remarks" style="width: 350px;" lay-verify="title" autocomplete="off" class="layui-input">
    </div>
  </div>
  </form>
</body>
</html>