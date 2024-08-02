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
	//특수문자, 영문 대,소문자,숫자 포함 형태의 n자리 이내의 암호 정규식
	var pwdCheck = /^.*(?=^.{8,32}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	
	$("#nmChangePwdBtn").on("click", function()
	{
		if($.trim($("#nmPwd1").val()).length <= 0)
		{
			alert("비밀번호를 입력하세요.");
			$("#nmPwd1").val("");
			$("#nmPwd1").focus();
			return;
		}
		
		if(!pwdCheck.test($("#nmPwd1").val()))
		{
			alert("비밀번호는 영문 대소문자 숫자로 8-32자리로 입력하세요.");
			$("#nmPwd1").val("");
			$("#nmPwd1").focus();
			return;
		}
		
		if($.trim($("#nmPwd2").val()).length <= 0)
		{
			alert("비밀번호 확인을 입력하세요.");
			$("#nmPwd2").val("");
			$("#nmPwd2").focus();
			return;
		}
		
		if($("#nmPwd1").val() != $("#nmPwd2").val())
		{
			alert("비밀번호가 일치하지 않습니다.");
			$("#nmPwd2").focus();
			return;	
		}
		
		$("#nmPwd").val($("#nmPwd1").val());
		
		$.ajax
		({
			type:"POST",
			url:"/user/nmPwdFindChange",
			data:
			{
				nmId:$("#nmId").val(),
				nmPwd:$("#nmPwd").val()
			},
			datatype:"JSON",
			beforeSend:function(xhr)
			{
				xhr.setRequestHeader("AJAX", true);
			},
			success:function(res)
			{
				if(res.code == 200)
				{
					alert("비밀번호가 변경되었습니다. 다시 로그인 해주세요.");
					location.href = "/user/login";
				}
				else if(res.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
				}
				else if(res.code == 404)
				{
					alert("아이디가 없습니다.");
				}	
				else
				{
					alert("오류가 발생했습니다. 다시 시도해주세요.");
				}
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}
	   	});
	});
});
</script>
</head>
<body>

<div class="container">
	<h1 class="mol" style="font-weight:bold;">비밀번호 변경</h1>
 		<ul class="links">
 		</ul>
	<div id='tab11'>
  		<!-- Form -->
  		<form id="nmPwdChangeForm" name="nmPwdChangeForm" method="post">
    	<!-- ID input -->
    		<div class="input__block">
       			<input type="password" placeholder="비밀번호" class="input" id="nmPwd1"/>
    		</div>
    	<!-- password input -->
    		<div class="input__block">
       			<input type="password" placeholder="비밀번호 확인" class="input" id="nmPwd2" />
    		</div>
    	<!-- sign in button -->
    		<button type="button" class="signin__btn" id="nmChangePwdBtn" name="nmChangePwdBtn">비밀번호 변경</button>
    		<input type="hidden" placeholder="비밀번호 확인" class="input" id="nmId" value="${nmId}" />
    		<input type="hidden" placeholder="비밀번호 확인" class="input" id="nmPwd" value=""/>
    		<div class="mol separator"></div>
  			<!-- google button -->
    	</form>
	</div>
</div>
</body>
</html>