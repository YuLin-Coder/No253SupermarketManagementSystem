<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>超市管理系统</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/aliimage/iconfont.css">
</head>
<script type="text/javascript">
window.onload=function()//用window的onload事件，窗体加载完毕的时候
{
	var o=document.getElementById("body_wh");
	var h = o.offsetHeight; //高度
	var he=h-35;
	var demo = document.getElementById('iframe_aa');
	demo.style.height = he+'px';
}

 function qiue(){
	 layer.confirm('确定要安全退出吗?', {
         title:'提示',
         btn: ['确定','取消']
     }, function(){
         layer.closeAll();
         window.location.href="${pageContext.request.contextPath}/user/logout.do";

     });
} 
 
</script>
<script type="text/javascript">
layui.use('layer', function(){
	  var layer = layui.layer;
	  
	  layer.msg('hello');
	});       
</script>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">
				<i class="icon iconfont">&#xe600;</i>
			</div>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item">
					<a href="javascript:;"> 
						<img src="http://t.cn/RCzsdCq" class="layui-nav-img"> ${currentUser.trueName}
					</a>
					<dl class="layui-nav-child">
						<dd><a href="${pageContext.request.contextPath}/basic/passwd.jsp" target="iframe_a"><i class="layui-icon">&#xe673;</i>&nbsp;密码修改</a></dd>
						<dd><a href="javascript:qiue()" ><i class="layui-icon">&#xe65c;</i>&nbsp;安全退出</a></dd>
					</dl>
				</li>
			</ul>
		</div>

		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<ul class="layui-nav layui-nav-tree" lay-filter="test">
					<li class="layui-nav-item layui-nav-itemed">
						<c:forEach var="menu" items="${menuList}">
							<c:if test="${menu.p_id==10}">
								<a class="" href="javascript:;"><i class="icon iconfont">${menu.icon}</i>&nbsp;${menu.name}</a>
							</c:if>
							<dl class="layui-nav-child">
								<c:if test="${menu.p_id==1010}">
									<dd><a target="iframe_a" href="${pageContext.request.contextPath}${menu.url }"><i class="icon iconfont">${menu.icon}</i>&nbsp;${menu.name}</a></dd>
								</c:if>
							</dl>
						</c:forEach>
					</li>
					<li class="layui-nav-item">
						<c:forEach var="menu" items="${menuList}">
							<c:if test="${menu.p_id==20}">
								<a href="javascript:;"><i class="icon iconfont">${menu.icon}</i>&nbsp;${menu.name}</a>
							</c:if>
							<dl class="layui-nav-child">
								<c:if test="${menu.p_id==2020}">
									<dd><a target="iframe_a" href="${pageContext.request.contextPath}${menu.url }"><i class="icon iconfont">${menu.icon}</i>&nbsp;${menu.name}</a></dd>
								</c:if>
							</dl>
						</c:forEach>
					</li>

					<li class="layui-nav-item">
						<c:forEach var="menu" items="${menuList}">
							<c:if test="${menu.p_id==30}">
								<a href="javascript:;"><i class="icon iconfont">${menu.icon}</i>&nbsp;${menu.name}</a>
							</c:if>
							<dl class="layui-nav-child">
								<c:if test="${menu.p_id==3030 }">
									<dd><a target="iframe_a" href="${pageContext.request.contextPath}${menu.url }"><i class="icon iconfont">${menu.icon}</i>&nbsp;${menu.name}</a></dd>
								</c:if>
							</dl>
						</c:forEach>
					</li>

					<li class="layui-nav-item">
						<c:forEach var="menu" items="${menuList}">
							<c:if test="${menu.p_id==40}">
								<a href="javascript:;"><i class="icon iconfont">${menu.icon}</i>&nbsp;${menu.name}</a>
							</c:if>
							<dl class="layui-nav-child">
								<c:if test="${menu.p_id==4040 }">
									<dd><a target="iframe_a" href="${pageContext.request.contextPath}${menu.url }"><i class="icon iconfont">${menu.icon}</i>&nbsp;${menu.name}</a></dd>
								</c:if>
							</dl>
						</c:forEach></li>

				</ul>
			</div>
		</div>

		<div class="layui-body" id="body_wh">
			<!-- 内容主体区域 -->
			 <div style="padding: 15px;">
         		<iframe id="iframe_aa" name="iframe_a" scrolling="auto"  frameborder="0" width="100%"></iframe>
			</div>
 		</div>
 		
	</div> 
	<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
	<script>
		//JavaScript代码区域
		layui.use('element', function() {
			var element = layui.element;

		});
	</script>
	 <div class="layui-form-item" style="display:none;padding-left: 20%">
  <label class="layui-form-label" style="color: red;">退货数量</label>
    <div class="layui-input-inline" style="width: 100px;">
    	<input type="hidden" name="ids" id="ids"  style="width: 15px;" lay-verify="title" autocomplete="off" class="layui-input">
      <input type="text"  onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" onblur="if(!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/))this.value=this.o_value;else{if(this.value.match(/^\.\d+$/))this.value=0+this.value;if(this.value.match(/^\.$/))this.value=0;this.o_value=this.value}" name="returnnumber" id="returnnumber"  placeholder="请输入退货数量" style="width: 250px;" autocomplete="off" class="layui-input">
    </div>
    </div>
</body>
</html>