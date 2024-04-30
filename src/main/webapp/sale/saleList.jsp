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
      ,{field: 'salenumber',align:'center', title: '销售数量'}
      ,{field: 'purchasing_price',align:'center', title: '采购价',templet: '#sexTpl1'}
      ,{field: 'last_purchasing_price',align:'center', title: '出售价',templet: '#sexTpl2'}
      ,{field: 'min_num',align:'center', title: '库存下限'}
      ,{field: 'producer',align:'center', title: '生产厂商'}
      ,{field: 'remarks',align:'center', title: '备注'}
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
});
function refreshPage()
{
window.location.reload();
}
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
</body>
</html>