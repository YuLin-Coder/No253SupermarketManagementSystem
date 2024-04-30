<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/static/jquery-3.3.1.js"></script>
<script src="${pageContext.request.contextPath}/static/zTree_v3/js/jquery.ztree.all.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<style>
.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
</style>
<script type="text/javascript">  
var zTreeObj;  
var setting = {  
    view : {  
        enable : true,  
        showLine : true,  
        showIcon : showIconForTreeRight,  
        addHoverDom: addHoverDom,  
        removeHoverDom: removeHoverDom
    },  
    data : {  
        simpleData : {  
            enable : true  
        }  
    },  
    callback : {  
        onClick : zTreeOnClickRight,  
        beforeRemove: beforeRemove,  
        onRename: zTreeOnRename,  
        onRemove: zTreeOnRemove,  
    },  
    edit:{  
        enable: true,  
        showRemoveBtn :true,  
        showRenameBtn :true,  
        removeTitle :"删除",  
        renameTitle :"修改"  
    }  
};  
  
function showIconForTreeRight(treeId, treeNode) {  
    return !treeNode.isParent;  
}; 
//树的单击事件  
function zTreeOnClickRight(event, treeId, treeNode) {  
    var treeid = zTreeObj.getSelectedNodes()[0].id;  
    var treepid = zTreeObj.getSelectedNodes()[0].pId;  
    var treename = zTreeObj.getSelectedNodes()[0].name;
    console.log(treeNode.id);
    document.getElementById("type_id").value=treeNode.id;
    document.getElementById("ss").click();
}  
  
function zTreeOnRename(event, treeId, treeNode, isCancel) {  
    $.post('${pageContext.request.contextPath}/goodsType/update.do', {  
        id:treeNode.id,  
        name: treeNode.name  
    }, function(result) {  
        if (result.success) {  
        	layer.msg("修改成功", {icon: 6});
        	setTimeout("refreshPage()",1000);
        } else {  
        	layer.msg(result.errorInfo, {icon: 5});
        	setTimeout("refreshPage()",1000);
        }  
    });  
}  
function zTreeOnRemove(event, treeId, treeNode) {  
     $.post('${pageContext.request.contextPath}/goodsType/delete.do', {  
        id: treeNode.id,  
     }, function(result) {  
        if (result.success) {  
        	layer.msg("删除成功", {icon: 6});
        } else {  
        	layer.msg(result.errorInfo, {icon: 5});
        	setTimeout("refreshPage()",1000);
        }  
     });  
}  
  
var newCount = 1;  
function addHoverDom(treeId, treeNode) {  
    var sObj = $("#" + treeNode.tId + "_span");  
    var addBtn = $("#addBtn_" + treeNode.tId)  
    if (treeNode.editNameFlag || addBtn.length > 0) return;  
    var addStr = "<span class='button add' id='addBtn_" + treeNode.tId + "' title='新增' onfocus='this.blur();'></span>";  
  
    sObj.after(addStr);  
    var btn = $("#addBtn_" + treeNode.tId);  
  
    if (btn) btn.bind("click", function() {  
        var name = "新增节点" + (newCount++);  
        $.post('${pageContext.request.contextPath}/goodsType/save.do', {  
            id: treeNode.id,  
            name: name  
        }, function(data, textStatus, xhr) {  
            /*optional stuff to do after success */  
            if (textStatus == "success") {  
                var newID = data.id;
                zTreeObj.addNodes(treeNode, {  
                    id: newID,  
                    p_id: treeNode.id,  
                    name: name  
                });  
                var node = zTreeObj.getNodeByParam("id", newID, null); //根据新的id找到新添加的节点  
                zTreeObj.selectNode(node); //让新添加的节点处于选中状态+  
            } else {  
                toastr.error("加载错误");  
            }  
        });  
  
        return false;  
    });  
}  
function removeHoverDom(treeId, treeNode) {  
    $("#addBtn_"+treeNode.tId).unbind().remove();  
}  
  
function beforeRemove(treeId, treeNode) {  
    return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");  
}
	$(document).ready(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/goodsType/loadGoodstypeInfo.do",
			dataType : 'json',
			type : 'post',
			success : function(result) {
				 zTreeObj = $.fn.zTree.init($("#ztree1"), setting, result);
				 zTreeObj.expandAll(true);
			}
	});
});
</script> 
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
  var table = layui.table,form = layui.form;
  
  table.render({
    elem: '#demo2'
    ,url: '${pageContext.request.contextPath}/goods/goodsList.do' //数据接口
    ,page: true //开启分页
    ,id: 'testReload'
    ,cols: [[ //表头
      {field: 'name',align:'center',width:'250px;', title: '商品名称'}
      ,{field: 'model',align:'center',width:'100px;', title: '型号'}
      ,{field: 'unit',align:'center',width:'100px;', title: '单位'}
      ,{field: 'number',align:'center',width:'100px;', title: '数量'}
      ,{field: 'purchasing_price',align:'center',width:'100px;', title: '采购价',templet: '#sexTpl1'}
      ,{field: 'last_purchasing_price',align:'center',width:'100px;', title: '出售价',templet: '#sexTpl2'}
      ,{field: 'min_num',align:'center',width:'100px;', title: '库存下限'}
      ,{field: 'producer',align:'center',width:'250px;', title: '生产厂商'}
      ,{field: 'remarks',align:'center',width:'250px;', title: '备注'}
      ,{fixed: 'right',title: '操作', align:'center', width:'180px;', toolbar: '#barDemo'}
    ]]
  });
  
  //输入框 条件搜索
  var $ = layui.$, active = {
	        reload: function(){
	            var demoReload = $('#demoReload');
	            var type_id = $('#type_id');
	            table.reload('testReload', {
	                where: {
	                	name: demoReload.val(),
	                	type_id:type_id.val()
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
	    if(obj.event === 'del'){
	        layer.confirm('真的删除该商品吗？', function(index){
	            $.ajax({
	                url: "${pageContext.request.contextPath}/goods/delete.do",
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
	    	 layer.open({
	    	        type: 1
	    	        ,anim:5
	    	        ,title:"修改商品"
	    	        ,area: ['700px', '600px']
	    	        ,resize:false
	    	        ,shade:0
	    	        ,offset: '30px' 
	    	        ,shade:0
	    	        ,content:$("#add",function(){
	    	        	  $.post("${pageContext.request.contextPath}/goodsType/typelist.do",function(result){
		    	         	  	
		    	        		 var deptSelect=$("#type_ids");
		    	        		 var arr = eval('(' + result + ')');
		    	        		 for(var i =0 ;i<arr.length;i++){
		    	        			 	var opt = document.createElement ("option");
		    	        			    opt.value = arr[i].id;
		    	        			    opt.innerText = arr[i].name;
		    	        			    deptSelect.append(opt);   
		    	        			}
		    	        		 $("#type_ids").val(data.type_id);
		    	        		 form.render("select");
		    	          }); 
	    	        	$("#id").val(data.id);
	    	        	$("#name").val(data.name);
	    	        	$("#remarks").val(data.remarks);
	    	        	$("#code").val(data.code);
	    	         	$("#model").val(data.model);
	    	         	$("#purchasing_price").val(data.purchasing_price);
	    	         	$("#last_purchasing_price").val(data.last_purchasing_price);
	    	         	$("#min_num").val(data.min_num);
	    	         	$("#producer").val(data.producer);
	    	         	$("#unit").val(data.unit);
	    	         	$("#type_id").val(data.typename);
	    	         	$("#number").val(data.number);
	    	        })
	    	        ,btn: '保存'
	    	        ,btnAlign: 'r'
	    	        ,closeBtn:1
	    	        ,yes: function(){
	    	        	var id =$("#id").val();
	    	        	var name =$("#name").val();
	    	         	var model =$("#model").val(); 
	    	         	var type_id =$('#type_ids option:selected').val(); 
	    	         	var purchasing_price =$("#purchasing_price").val();
	    	         	var last_purchasing_price =$("#last_purchasing_price").val();
	    	         	var min_num =$("#min_num").val();
	    	         	var producer =$("#producer").val();
	    	        	var numbers =$("#number").val();
	    	         	var remarks =$("#remarks").val();   
	    	         	var unit =$("#unit").val();
	    	         	if(name==null || name==''){
	    	         		layer.msg('商品名称不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(model==null || model==''){
	    	         		layer.msg('商品型号不能为空！', {icon: 5});
	    	         		return false;
	    	         	} 
	    	         	if(purchasing_price==null || purchasing_price==''){
	    	         		layer.msg('采购价不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(last_purchasing_price==null || last_purchasing_price==''){
	    	         		layer.msg('出售价不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(min_num==null || min_num==''){
	    	         		layer.msg('库存下限不能为空！', {icon: 5});
	    	         		return false;
	    	         	}
	    	         	if(producer==null || producer==''){
	    	         		layer.msg('生产厂商不能为空！', {icon: 5});
	    	         		return false;
	    	         	} 
	    	        	if(unit==null || unit==''){
	    	         		layer.msg('单位不能为空！', {icon: 5});
	    	         		return false;
	    	         	} 
	    	        	 if(type_id==null || type_id==''){
	    	          		layer.msg('商品类别不能为空！', {icon: 5});
	    	          		return false;
	    	          	}
	    	        	 if(numbers==null || numbers==''){
	    	          		layer.msg('商品数量不能为空！', {icon: 5});
	    	          		return false;
	    	          	}
	    	         	$.post("${pageContext.request.contextPath}/goods/update.do",{type_id:type_id,id:id,name:name,model:model,purchasing_price:purchasing_price,last_purchasing_price:last_purchasing_price,min_num:min_num,producer:producer,remarks:remarks,unit:unit,numbers:numbers},function(result){
	    	         		if(result.success){
	    	         			layer.closeAll();
	    	         			layer.msg('商品修改成功！', {icon: 1});
	    	         			setTimeout("refreshPage()",1000);
	    	  			  }else{
	    	  					layer.msg('商品修改失败', {icon: 5});
	    	  			  }
	    	         	});
	    	        	
	    	        }
			    	 ,cancel: function(index, layero){ 
			    		 setTimeout("refreshPage()",100);
			    		  return false; 
			    		}  
	    	      });
	    }else if(obj.event === 'jian'){
	    	 layer.open({
	    	        type: 1
	    	        ,anim:5
	    	        ,title:"卖出商品"
	    	        ,area: ['700px', '200px']
	    	        ,resize:false
	    	        ,shade:0
	    	        ,offset: '30px' 
	    	        ,shade:0
	    	        ,content:$("#jian",function(){
	    	        	$("#ids").val(data.id);
	    	        })
	    	        ,btn: '保存'
	    	        ,btnAlign: 'r'
	    	        ,closeBtn:1
	    	        ,yes: function(){
	    	        	var id =$("#ids").val();
	    	        	var number =$("#numbers").val();
	    	         	$.post("${pageContext.request.contextPath}/goods/updatenumber.do",{id:id,number:number},function(result){
	    	         		if(result.success){
	    	         			layer.closeAll();
	    	         			layer.msg('销售成功！', {icon: 1});
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
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="jian">卖出</a>
</script>
<script>
layui.use(['layer','form'], function(){ 
  var $ = layui.jquery, layer = layui.layer,form = layui.form;
  var active = {
    offset: function(othis){
      var type = othis.data('type')
      ,text = othis.text();
    	  $.post("${pageContext.request.contextPath}/goodsType/typelist.do",function(result){
     		 var deptSelect=$("#type_ids");
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
        	var name =$("#name").val();
         	var model =$("#model").val(); 
         	var number =$("#number").val();
         	var purchasing_price =$("#purchasing_price").val();
         	var last_purchasing_price =$("#last_purchasing_price").val();
         	var min_num =$("#min_num").val();
         	var producer =$("#producer").val();
         	var type_id =$('#type_ids option:selected').val(); 
         	var remarks =$("#remarks").val();   
         	var unit =$("#unit").val();
         	if(name==null || name==''){
         		layer.msg('商品名称不能为空！', {icon: 5});
         		return false;
         	}
         	if(number==null || number==''){
         		layer.msg('商品数量不能为空！', {icon: 5});
         		return false;
         	}
         	if(model==null || model==''){
         		layer.msg('商品型号不能为空！', {icon: 5});
         		return false;
         	} 
         	if(purchasing_price==null || purchasing_price==''){
         		layer.msg('采购价不能为空！', {icon: 5});
         		return false;
         	}
         	if(last_purchasing_price==null || last_purchasing_price==''){
         		layer.msg('出售价不能为空！', {icon: 5});
         		return false;
         	}
         	if(min_num==null || min_num==''){
         		layer.msg('库存下限不能为空！', {icon: 5});
         		return false;
         	}
         	if(producer==null || producer==''){
         		layer.msg('生产厂商不能为空！', {icon: 5});
         		return false;
         	} 
        	if(unit==null || unit==''){
         		layer.msg('单位不能为空！', {icon: 5});
         		return false;
         	} 
        	 if(type_id==null || type_id==''){
          		layer.msg('商品类别不能为空！', {icon: 5});
          		return false;
          	}
         	$.post("${pageContext.request.contextPath}/goods/save.do",{number:number,type_id:type_id,name:name,model:model,purchasing_price:purchasing_price,last_purchasing_price:last_purchasing_price,min_num:min_num,producer:producer,remarks:remarks,unit:unit},function(result){
         		if(result.success){
         			layer.closeAll();
         			layer.msg('商品添加成功！', {icon: 1});
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
<div class="layui-fluid">
  <div class="layui-row">
    <div class="layui-col-md2">
  		  <div style="overflow:scroll;width:100%;height:85%;">
  		  <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;margin-right: 10px;">
    		<legend>商品类别</legend>
  		  </fieldset>
  		  <ul class="ztree" id="ztree1"></ul> 
  		  </div>
    </div>
      <div class="layui-col-md10">
      	 <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;margin-left: 10px;">
    		<legend>商品管理</legend>
  		  </fieldset>
  		  <div style="padding-left: 15px;">
  		  	<div class="demoTable" >
					<div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
				    	商品名称：
						<div class="layui-inline">
							<input class="layui-input" name="name" id="demoReload" autocomplete="off">
							<input type="hidden" class="layui-input" name="type_id" id="type_id" autocomplete="off">
						</div>
						<button class="layui-btn layui-btn-normal" data-type="reload" id="ss"><i class="layui-icon">&#xe615;</i>搜索</button>
						<button data-method="offset" data-type="auto" class="layui-btn layui-btn-normal"><i class="layui-icon">&#xe654;</i>添加商品</button>
					</div>
				</div>  
  		  <table id="demo2" lay-filter="test"></table>
  		  </div>  
      </div>
    </div>
</div>

<form class="layui-form" id="add" action="" style="display:none;padding-left: 20%">
	<div class="layui-form-item" style="padding-top: 20px;padding-left: 10%">
  	<div class="layui-form-mid layui-word-aux">-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;红色为必选项-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;</div>
  </div>
   <div class="layui-form-item">
    <label class="layui-form-label" style="color: red;">商品名称</label>
    <div class="layui-input-block">
    <input type="hidden" name="id" id="id"  style="width: 15px;" lay-verify="title" autocomplete="off" class="layui-input">
      <input type="text" name="name" id="name" style="width: 250px;" lay-verify="title" autocomplete="off" placeholder="请输入商品名称" class="layui-input">
    </div>
  </div>
    <div class="layui-form-item">
    <label class="layui-form-label" style="color: red;">商品型号</label>
    <div class="layui-input-block">
      <input type="text" name="model" id="model" style="width: 250px;" lay-verify="title" autocomplete="off" placeholder="请输入商品型号" class="layui-input">
    </div>
  </div> 
  <div class="layui-form-item">
  <label class="layui-form-label" style="color: red;">购买数量</label>
    <div class="layui-input-inline" style="width: 100px;">
      <input type="text"  onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onblur="if(!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/))this.value=this.o_value;else{if(this.value.match(/^\.\d+$/))this.value=0+this.value;if(this.value.match(/^\.$/))this.value=0;this.o_value=this.value}" name="number" id="number"  placeholder="请输入采购数量" style="width: 250px;" autocomplete="off" class="layui-input">
    </div>
    </div>
    <div class="layui-form-item">
    <label class="layui-form-label" style="color: red;">单位</label>
    <div class="layui-input-block">
      <input type="text" name="unit" id="unit" style="width: 250px;" lay-verify="title" autocomplete="off" placeholder="请输入商品单位" class="layui-input">
    </div>
  </div> 
 <div class="layui-form-item">
  <label class="layui-form-label" style="color: red;">采购价</label>
    <div class="layui-input-inline" style="width: 100px;">
      <input type="text"  onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onblur="if(!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/))this.value=this.o_value;else{if(this.value.match(/^\.\d+$/))this.value=0+this.value;if(this.value.match(/^\.$/))this.value=0;this.o_value=this.value}" name="price_min" id="purchasing_price" placeholder="￥" placeholder="请输入采购价" style="width: 250px;" autocomplete="off" class="layui-input">
    </div>
    </div>
    <div class="layui-form-item">
  <label class="layui-form-label" style="color: red;">出售价</label>
    <div class="layui-input-block" style="width: 100px;">
      <input type="text" onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onblur="if(!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/))this.value=this.o_value;else{if(this.value.match(/^\.\d+$/))this.value=0+this.value;if(this.value.match(/^\.$/))this.value=0;this.o_value=this.value}" name="price_min" id="last_purchasing_price" placeholder="￥" placeholder="请输入出售价" style="width: 250px;" autocomplete="off" class="layui-input">
    </div>
    </div>
	<div class="layui-form-item">
    <label class="layui-form-label" style="color: red;">库存下限</label>
    <div class="layui-input-block">
      <input type="text" onkeyup="this.value=this.value.replace(/[^\d]/g,'') " onafterpaste="this.value=this.value.replace(/[^\d]/g,'') " name="min_num" id="min_num" style="width: 250px;" lay-verify="title" autocomplete="off" placeholder="请输入库存下限" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label" style="color: red;">生产厂商</label>
    <div class="layui-input-block">
      <input type="text" name="producer" id="producer" style="width: 250px;" lay-verify="title" autocomplete="off" placeholder="请输入生产厂商" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label" style="color: red;">商品类别</label>
    <div class="layui-input-block" style="width: 250px;">
      <select class="layui-input" name="type_ids" id="type_ids" lay-verify="required" >
      	<option value="">请选择商品类别</option>
      </select>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">备注</label>
    <div class="layui-input-block">
      <input type="text" name="remarks" id="remarks" style="width: 250px;" lay-verify="title" autocomplete="off" placeholder="请输入备注" class="layui-input">
    </div>
  </div> 
  </form>
  
  <form class="layui-form" id="jian" action="" style="display:none;padding-left: 20%">
	<div class="layui-form-item" style="padding-top: 20px;padding-left: 10%">
  </div>
  <div class="layui-form-item">
  <label class="layui-form-label" style="color: red;">卖出数量</label>
    <div class="layui-input-inline" style="width: 100px;">
    	<input type="hidden" name="ids" id="ids"  style="width: 15px;" lay-verify="title" autocomplete="off" class="layui-input">
      <input type="text"  onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onblur="if(!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/))this.value=this.o_value;else{if(this.value.match(/^\.\d+$/))this.value=0+this.value;if(this.value.match(/^\.$/))this.value=0;this.o_value=this.value}" name="numbers" id="numbers"  placeholder="请输入卖出数量" style="width: 250px;" autocomplete="off" class="layui-input">
    </div>
    </div>
  </form>
