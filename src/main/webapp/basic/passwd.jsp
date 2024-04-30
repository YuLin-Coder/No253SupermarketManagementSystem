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
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>密码修改</legend>
  </fieldset>
<form class="layui-form" action="">
  <div class="layui-form-item">
    <label class="layui-form-label">新密码</label>
    <div class="layui-input-block">
      <input style="width:500px;" type="password" name="password" id="password"  placeholder="请输入新密码"  class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">新密码</label>
    <div class="layui-input-block">
      <input style="width:500px;" type="password" name="qrpassword"  id="qrpassword" placeholder="请输入确认新密码"  class="layui-input">
    </div>
  </div>
      <input style="width:500px;" type="hidden" value="${sessionScope.currentUser.id}" name="id"  id="id" placeholder="请输入确认新密码"  class="layui-input">
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
  </div>
</form>
<script>
//Demo
layui.use('form', function(){
  var form = layui.form;
  
  //监听提交
  form.on('submit(demo1)', function(data){  
    if(data.field['password']!= data.field['qrpassword']){
    	layer.msg("两次密码不相同");
    	 return false;
    }
    alert(data.field['id']);
    if(data.field['id']=="" || data.field['id']==null){
    	layer.msg("系统出错，请重新登陆");
    	 return false;
    }
    if(data.field['password']=="" || data.field['password']== null){
    	layer.msg("新密码不能为空");
    	 return false;
    }
    if(data.field['qrpassword']=="" || data.field['qrpassword']==null){
    	layer.msg("确认密码不能为空");
    	 return false;
    }
    $.ajax({
        url: "${pageContext.request.contextPath}/user/updatepswd.do",
        type: "POST",
        data:{password:data.field['password'],id:data.field['id']},
        dataType: "json",
        success: function(data){
            if(data.success){
                layer.msg("修改成功,请重新登陆", {icon: 6});
            }
        }
    });
    return false;
  });
});
</script>
</body>
</html>