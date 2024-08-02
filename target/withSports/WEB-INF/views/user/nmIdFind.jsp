<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/assets/css/nmFind.css"/>
<script>
<c:if test="${empty nmId}">
	alert("잘못된 접근입니다.")
	location.href="/user/login";
</c:if>
$(document).ready(function()
{
	$("#userLogin1Btn").on("click", function()
	{
		location.href = "/user/login"; 
	});	
});
</script>
</head>
<body>
<div class="container">
	<h1 class="mol" style="font-weight:bold;">아이디 찾기</h1>
 		<ul class="links">
 		</ul>
	<div id='tab11'>
  		<!-- Form -->
  		<form id="tab1" name="tab" action="" method="post">
  			<div class="mol separator">
  				<p>회원님의 아이디는 <b>${nmId}</b> 입니다.</p>
  			</div>
  			<button type="button" class="google__btn" id="userLogin1Btn" name="userLogin1Btn"><i class="fa fa-google"></i>로그인 화면으로</button>
    	</form>
	</div>
</div>
</body>
</html>