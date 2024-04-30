<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css" />
<style>
body{height:100%;background:#16a085;overflow:hidden;}
canvas{z-index:-1;position:absolute;}
.black_overlay{  display: none;  position: absolute;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.8;  opacity:.80;  filter: alpha(opacity=80);  }  
.white_content {  display: none;  position: absolute;  top: 25%;  left: 35%;  width: 25%;  height: 15%;  padding: 16px;  border: 2 solid black;  background-color: white;  z-index:1002;  overflow: auto;  } 
</style>
<script src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/static/js/verifyCode.js"></script>
<script src="${pageContext.request.contextPath}/static/js/Particleground.js"></script>
<title>后台登录-超市管理系统</title>
</head>
<script>
	$(document).ready(function() {
	  $('body').particleground({
	    dotColor: '#5cbdaa',
	    lineColor: '#5cbdaa'
	  });
	  
	  $("#loginBtn").click(function(){
		 var userName = $("#userName").val();
		 var password = $("#password").val();
		 var imageCode = $("#imageCode").val();
		 if(userName == null || userName ==""){
			 alert("用户名不能为空！");
			 return false;
		}
		 if(password == null || password ==""){
			 alert("密码不能为空！");
			 return false;
		}
		 if(imageCode == null || imageCode ==""){
			 alert("验证码不能为空！");
			 return false;
		}
		  $.post("${pageContext.request.contextPath}/user/login.do",{userName:userName,password:password,imageCode:imageCode},function(result){
			  if(result.success){
				  window.location.href="/SupermarketManager/main.jsp";
			  }else{
				  alert(result.errorInfo);
			  }
		  });
	  });
	});
</script>
<body>
<dl class="admin_login">
 <dt>
  <strong>超市管理系统</strong>
  <em>Supermarket Management System</em>
 </dt>
 <dd class="user_icon">
  <input type="text" id="userName" placeholder="账号" class="login_txtbx"/>
 </dd>
 <dd class="pwd_icon">
  <input type="password" id="password" placeholder="密码" class="login_txtbx"/>
 </dd>
  <dd class="val_icon">
  <div class="checkcode">
    <input type="text" id="imageCode" name="imageCode" placeholder="验证码" maxlength="4" class="login_txtbx">
    <img id="imgObj" title="看不清，换一张" src="${pageContext.request.contextPath}/drawImage.do" onclick="changeImg()" />
  </div>
 </dd>
 <dd>
  <input type="button" id="loginBtn" value="立即登陆" class="submit_btn"/>
 </dd>
 <dd>
  <p>© 2020-2021 版权所有</p>
 </dd>
</dl>
</body>
</html>