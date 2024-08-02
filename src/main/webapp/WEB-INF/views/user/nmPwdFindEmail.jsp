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
	var code = "";  /*인증번호 저장할 곳*/
	var nmEmail = $('#nmEmail').val();
	$.ajax
	({
		type: 'GET',
		url: '/user/nmPwdFindEmailProc?nmEmail=' + nmEmail
		, /*url을 통해 데이터를 보낼 수 있도록 GET방식, url명을 "mailCheck"로 지정 */
		success: function(data) 
		{
			code = data;
		}
	});
	
	$("#userPwdEmailBtn").on("click", function()
	{
		if($.trim($("#nmPwdEmail").val()).length <= 0)
		{
			alert("인증번호를 입력하세요.");
			return;
		}
		
		if($("#nmPwdEmail").val() != code)
		{
			alert("인증번호가 일치하지 않습니다.");
			return;
		}
		
		if($("#nmPwdEmail").val() == code)
		{
			document.nmPwdFindForm.action = "/user/nmPwdFind";
			document.nmPwdFindForm.submit();
		}
	});

	$("#loginBtn").on("click", function()
	{
		location.href = "/user/login";
	});
});
</script>
</head>
<body>
<div class="container">
	<h1 class="mol" style="font-weight:bold;">비밀번호 찾기</h1>
 		<ul class="links">
 		</ul>
	<div id='tab11'>
  		<!-- Form -->
  		<form id="nmPwdFindForm" name="nmPwdFindForm" method="post">
  			<div class="input__block">
       			<input type="text" placeholder="인증번호 입력" class="input" id="nmPwdEmail" name="nmPwdEmail"/>
       			
       			<input type="hidden" id="nmId" name="nmId" value="${nmId}">
       			<input type="hidden" id="nmName" name="nmName" value="${nmName}">
       			<input type="hidden" id="nmEmail" name="nmEmail" value="${nmEmail}">
       			
    		</div>
  			<div class="mol separator">
  				<p>${nmEmail}로 인증번호를 발송했습니다.</p>
  			</div>

  			
  			<button type="button" class="signin__btn" id="userPwdEmailBtn" name="userPwdEmailBtn"><i class="fa fa-google"></i>인증번호 확인</button>
  			<button type="button" class="google__btn" id="loginBtn" name="loginBtn"><i class="fa fa-google"></i>로그인 화면으로</button>
    	</form>
	</div>
</div>
</body>
</html>