<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<title>Insert title here</title>
</head>
<body>
<script>
layui.use(['table','form'], function(){
  var table = layui.table,form = layui.form;
  
  table.render({
    elem: '#demo2'
    ,url: '${pageContext.request.contextPath}/goods/goodsList.do' //数据接口
    ,page: true //开启分页
    ,id: 'testReload'
    ,cols: [[ //表头
      {field: 'name',align:'center', title: '商品名称'}
      ,{field: 'model',align:'center', title: '型号'}
      ,{field: 'unit',align:'center', title: '单位'}
      ,{field: 'returnnumber',align:'center', title: '退货数量'}
      ,{field: 'purchasing_price',align:'center', title: '采购价',templet: '#sexTpl1'}
      ,{field: 'last_purchasing_price',align:'center', title: '出售价',templet: '#sexTpl2'}
      ,{field: 'min_num',align:'center', title: '库存下限'}
      ,{field: 'producer',align:'center', title: '生产厂商'}
      ,{field: 'remarks',align:'center', title: '备注'}
      ,{fixed: 'right',title: '操作', align:'center', toolbar: '#barDemo'}
    ]]
  });
  
  //输入框 条件搜索
  var $ = layui.$, active = {
	        reload: function(){
	            var demoReload = $('#name');
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


table.on('tool(test)', function(obj){
    var data = obj.data;
    if(obj.event === 'edit'){
    	  layer.open({
    	        type: 1
    	        ,anim:5
    	        ,title:"退货"
    	        ,area: ['700px', '200px']
    	        ,resize:false
    	        ,shade:0
    	        ,offset: '30px' 
    	        ,content:$("#add",function(){
    	        	$("#ids").val(data.id);
    	        })
    	        ,btn: '保存'
    	        ,btnAlign: 'r' //按钮居中
    	        ,yes: function(){
    	        	var id =$("#ids").val();
    	         	var returnnumber =$("#returnnumber").val(); 
    	         	if(returnnumber==null || returnnumber==''){
    	         		layer.msg('退货数量不能为空！', {icon: 5});
    	         		return false;
    	         	}
    	         	$.post("${pageContext.request.contextPath}/goods/updateReturn.do",{id:id,returnnumber:returnnumber},function(result){
    	         		if(result.success){
    	         			layer.closeAll();
    	         			layer.msg('退货成功！', {icon: 1});
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
function refreshPage()
{
window.location.reload();
}
</script> 
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">退货</a>
</script>
<div class="layui-fluid">
      	 <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;margin-left: 10px;">
    		<legend>销售管理</legend>
  		  </fieldset>
  		  <div style="padding-left: 15px;">
  		  	<div class="demoTable" >
					<div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
				    	商品名称：
						<div class="layui-inline">
							<input type="text" class="layui-input" name="name" id="name" autocomplete="off">
						</div>
						<button class="layui-btn layui-btn-normal" data-type="reload" id="ss"><i class="layui-icon">&#xe615;</i>搜索</button>
					</div>
				</div>  
  		  <table id="demo2" lay-filter="test"></table>
  		  </div>  
      </div>
       <form class="layui-form" id="add" action="" style="display:none;padding-left: 20%">
	<div class="layui-form-item" style="padding-top: 20px;padding-left: 10%">
  </div>
  <div class="layui-form-item">
  <label class="layui-form-label" style="color: red;">退货数量</label>
    <div class="layui-input-inline" style="width: 100px;">
    	<input type="hidden" name="ids" id="ids"  style="width: 15px;" lay-verify="title" autocomplete="off" class="layui-input">
      <input type="text"  onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onblur="if(!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/))this.value=this.o_value;else{if(this.value.match(/^\.\d+$/))this.value=0+this.value;if(this.value.match(/^\.$/))this.value=0;this.o_value=this.value}" name="returnnumber" id="returnnumber"  placeholder="请输入退货数量" style="width: 250px;" autocomplete="off" class="layui-input">
    </div>
    </div>
  </form>
</body>
</html>