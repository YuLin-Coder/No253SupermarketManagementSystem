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
 <script type="text/html" id="sexTpl1">
  {{#  if(d.purchasing_price > 0 ){ }}
    {{ d.purchasing_price+'￥'}}
  {{#  } else { }}
   {{ d.purchasing_price+'￥'}}
  {{#  } }}
</script>
  <script type="text/html" id="sexTpl2">
  {{#  if(d.last_purchasing_price > 0 ){ }}
    {{ d.last_purchasing_price+'￥'}}
  {{#  } else { }}
   {{ d.last_purchasing_price+'￥'}}
  {{#  } }}
</script>
<script>
layui.use(['table','form'], function(){
  var table = layui.table;
  var form = layui.form;
  
  //数据表格显示
  table.render({
    elem: '#demo'
    ,url: '${pageContext.request.contextPath}/goods/goodsDel.do' //数据接口
    ,cellMinWidth: 80
    ,page: true //开启分页
    ,id: 'testReload'
    ,cols: [[ //表头
     {field: 'name',align:'center', title: '商品名称'}
     ,{field: 'model',align:'center', title: '型号'}
     ,{field: 'unit',align:'center', title: '单位'}
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
	    if(obj.event === 'edit'){
	    	//删除用户
	        layer.confirm('真的恢复该商品吗？', function(index){
	            $.ajax({
	                url: "${pageContext.request.contextPath}/goods/goodsUpdate.do",
	                type: "POST",
	                data:{"id":data.id},
	                dataType: "json",
	                success: function(data){
	                    if(data.success){
	                        layer.msg("恢复成功", {icon: 6});
	                        setTimeout("refreshPage()",1000);
	                    }else{
	                        layer.msg(data.errorInfo, {icon: 5});
	                    }
	                }
	            });
	        });
	    }
	});
});
function refreshPage()
{
window.location.reload();
}
  </script>
<body>
 <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>删除记录</legend>
  </fieldset>
  <div class="demoTable">
	<div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
    	商品名称：
		<div class="layui-inline">
			<input class="layui-input" name="name" id="demoReload" autocomplete="off">
		</div>
		<button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
	</div>
</div>   
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">恢复</a>
</script>
  <table id="demo" lay-filter="test" ></table>
</body>
</html>