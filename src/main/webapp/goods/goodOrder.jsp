<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/static/jquery-3.3.1.js"></script>
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(document).ready(function() {
    $("#dh").load("${pageContext.request.contextPath}/orderList/genCode.do");
});	

</script>
<body>
<script>
layui.use(['form', 'laydate','table'], function(){
	  var form = layui.form
	  ,layer = layui.layer
	  ,laydate = layui.laydate
	  ,table = layui.table;
	  
	  
	//数据表格显示
	  table.render({
	    elem: '#demo'
	    ,url: '${pageContext.request.contextPath}/orderList/order.do' //数据接口
	    ,cellMinWidth: 80
	    ,page: true //开启分页
	    ,id: 'testReload'
	    ,cols: [[ //表头
	     {field: 'code',align:'center', title: '单号'}
	     ,{field: 'name',align:'center', title: '供应商'}
	     ,{field: 'contact',align:'center', title: '供应商联系人'}
	     ,{field: 'number',align:'center', title: '联系方式'}
	     ,{field: 'paymoney',align:'center', title: '支付金额'}
	     ,{field: 'releaseStrPay',align:'center', title: '支付日期'}
	     ,{field: 'state',align:'center', title: '支付状态',templet: '#sexTpl1'}
	     ,{field: 'releaseStr',align:'center', title: '订单创建时间'}
	     ,{field: 'remark',align:'center', title: '备注'}
	    ]]
	  });
	  
	  //输入框 条件搜索
	  var $ = layui.$, active = {
		        reload: function(){
		            var code = $('#code');
		            table.reload('testReload', {
		                where: {
		                	code: code.val()
		                }
		            });
		        }
		    };
	  
	  //输入框按钮监听
	  $('.demoTable .layui-btn').on('click', function(){
		    var type = $(this).data('type');
		    active[type] ? active[type].call(this) : '';
		});
	  
	  
	  //日期
	  laydate.render({
	    elem: '#paydate'
	  });
	  $.post("${pageContext.request.contextPath}/supplier/supplierlist.do",function(result){
			if(result.success){
				
				var deptSelect=$("#supplier_id");
		   		for(var i =0 ;i<result.supplierList.length;i++){
		   			 	var opt = document.createElement ("option");
		   			    opt.value = result.supplierList[i].id;
		   			    opt.innerText = result.supplierList[i].name;
		   			    deptSelect.append(opt);   
		   		}
		   		form.render("select");
			}
		});
		
	  
	  
	//监听提交
	  form.on('submit(demo1)', function(data){
		  var dh = $("#dh").text();
	    if(data.field['supplier_id']== -1){
	    	layer.msg("供应商不能为空");
	    	 return false;
	    }
	     if(data.field['paymoney'] == "" ){
	    	layer.msg("支付金额不能为空");
	    	 return false;
	    }
	     if(data.field['paymoney'] <0 ){
		    	layer.msg("支付金额不能小于0");
		    	 return false;
		}
	     if(data.field['paydate']== ""){
	    	layer.msg("支付日期不能为空");
	    	 return false;
	    }
	     $.ajax({
             url: "${pageContext.request.contextPath}/orderList/orderSave.do",
             type: "POST",
             data:{supplier_id:data.field['supplier_id'],paymoney:data.field['paymoney'],releaseStrPay:data.field['paydate'],state:data.field['state'],remark:data.field['remark'],code:dh},
             dataType: "json",
             success: function(data){
                 if(data.success){
                     layer.msg("添加成功", {icon: 6});
                     setTimeout("refreshPage()",1000);
                 }
             }
         });
	    return false;
	  });
	 
	  
	});
	
function refreshPage()
{
window.location.reload();
}
</script>
 <script type="text/html" id="sexTpl1">
  {{#  if(d.state == 1){ }}
    	已支付
  {{#  } else { }}
    	未支付
  {{#  } }}
</script>
<fieldset class="layui-elem-field site-demo-button" style="margin-top: 30px;">
	<legend>单号:<span id="dh"></span></legend>
	<form class="layui-form" action="">

  <div class="layui-form-item">
    <div class="layui-inline">
     <label class="layui-form-label">供应商</label>
    <div class="layui-input-block">
      <select name="supplier_id" id="supplier_id">
        <option value="-1"></option>
      </select>
    </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">支付金额</label>
      <div class="layui-input-inline">
        <input type="text" name="paymoney"  autocomplete="off" class="layui-input">
      </div>
    </div>
     <div class="layui-inline">
      <label class="layui-form-label">支付日期</label>
      <div class="layui-input-inline">
        <input type="text" name="paydate" id="paydate"  placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
      </div>
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-inline">
     <label class="layui-form-label">支付状态</label>
    <div class="layui-input-block">
      <select name="state" id="state">
        <option value="1">支付</option>
        <option value="0">未支付</option>
      </select>
    </div>
    </div>
    
    <div class="layui-inline">
      <label class="layui-form-label">备注</label>
      <div class="layui-input-inline">
        <input type="text" name="remark" id="remark" class="layui-input" style="width: 400px;">
      </div>
    </div>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <div class="layui-inline">
      <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
      </div>
  </div>
</form>
</fieldset>
<fieldset class="layui-elem-field site-demo-button" style="margin-top: 30px;">
    <legend>单号查询</legend>
    <div style="padding-left: 30px;padding-bottom: 20px;padding-top: 10px;">
  <div class="demoTable">
	<div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
    	单号ID：
		<div class="layui-inline">
			<input class="layui-input" name="code" id="code" autocomplete="off">
		</div>
		<button class="layui-btn" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
	</div>
	</div>
</div>   
</fieldset>
<table id="demo" lay-filter="test" ></table>
</body>
</html>