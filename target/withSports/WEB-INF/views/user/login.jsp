<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/assets/css/login.css"/>
<script>
$(document).ready(function()
{
	$('input[type=radio][name=mmm]').on("click", function()
	{
	    var chkValue = $('input[type=radio][name=mmm]:checked').val();
	      
	    if(chkValue == '1')
	    {
	    	$('#tab11').css('display', 'block');
	        $('#tab22').css('display', 'none');
		}
	    else if(chkValue == '2')
	    {
	    	$('#tab22').css('display', 'block');
	        $('#tab11').css('display', 'none');
	    }
   	});
	
	$("#indexBtn1").on("click", function()
	{
		location.href="/";
	});
	$("#indexBtn2").on("click", function()
	{
		location.href="/";
	});
	
	$("#signUpBtn1").on("click", function()
	{
		location.href="/user/signUp";
	});
	
	$("#signUpBtn2").on("click", function()
	{
		location.href="/user/signUp";
	});
	
	$("#findIdBtn").on("click", function()
	{
		location.href="/user/nmFind";
	});
	
	$("#nmSignInBtn").on("click", function()
	{
		nmSignInCheck();
	});
	
	$("#coSignInBtn").on("click", function()
	{
		coSignInCheck();
	});
});

function nmSignInCheck()
{
	if($.trim($("#nmId").val()).length <= 0)
	{
		alert("아이디를 입력하세요.");
		$("#nmId").val("");
		$("#nmId").focus();
		return;
	}
	
	if($.trim($("#nmPwd").val()).length <= 0)
	{
		alert("비밀번호를 입력하세요.");
		$("#nmPwd").val("");
		$("#nmPwd").focus();
		return;
	}
	
	$.ajax
	({
		type:"POST",
		url:"/user/nmLoginProc",
		data:
		{
			nmId:$("#nmId").val(),
			nmPwd:$("#nmPwd").val()
		},
		datatype:"JSON",
		befoerSend:function(xhr)
		{
			xhr.setRequestHeader("AJAX", true);	
		},
		success:function(res)
		{
			if(res.code == 200)
			{
				location.href = "/";
			}
			else if(res.code == 400)
			{
				alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				$("#nmId").focus();
			}
			else if(res.code == 401)
			{
				alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				$("#nmPwd").focus();
			}
			else if(res.code == 403)
			{
				alert("정지된 사용자 입니다.");
				$("#nmId").focus();
			}
			else if(res.code == 404)
			{
				alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				$("#nmId").focus();
			}
			else if(res.code == 410)
			{
				alert("탈퇴한 사용자 입니다.");
				$("#nmId").focus();
			}
			else
			{
				alert("로그인 중 오류가 발생했습니다.");
				$("#nmId").focus();
			}	
		},	
		error:function(xhr, status, error)
		{
			icia.common.error(error);
			alert("로그인 중 오류가 발생했습니다.");
		}
	});
}

function coSignInCheck()
{
	if($.trim($("#coId").val()).length <= 0)
	{
		alert("아이디를 입력하세요.");
		$("#coId").val("");
		$("#coId").focus();
		return;
	}
	
	if($.trim($("#coPwd").val()).length <= 0)
	{
		alert("비밀번호를 입력하세요.");
		$("#coPwd").val("");
		$("#coPwd").focus();
		return;
	}
	
	
	$.ajax
	({
		type:"POST",
		url:"/user/coLoginProc",
		data:
		{
			coId:$("#coId").val(),
			coPwd:$("#coPwd").val()
		},
		datatype:"JSON",
		befoerSend:function(xhr)
		{
			xhr.setRequestHeader("AJAX", true);	
		},
		success:function(res)
		{
			if(res.code == 200)
			{
				location.href = "/";
			}
			else if(res.code == 400)
			{
				alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				$("#nmId").focus();
			}
			else if(res.code == 401)
			{
				alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				$("#nmPwd").focus();
			}
			else if(res.code == 403)
			{
				alert("관리자의 승인이 필요한 계정입니다.");
				$("#nmId").focus();
			}
			else if(res.code == 404)
			{
				alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				$("#nmId").focus();
			}
			else
			{
				alert("로그인 중 오류가 발생했습니다.");
				$("#nmId").focus();
			}	
		},	
		error:function(xhr, status, error)
		{
			icia.common.error(error);
			alert("로그인 중 오류가 발생했습니다.");
		}
	});
}
</script>
</head>
<body>
	<div class="container">
  	<!-- Heading -->
  		<h1 class="mol" style="font-weight:bold;">로그인</h1>
  			<ul class="links">
     			<li>
        			<a><input id="tab-1" type="radio" name="mmm" class="nm" value="1" checked><label for="tab-1" class="mol tab">개인회원</label></a>
     			</li>
     			<li>
        			<a><input id="tab-2" type="radio" name="mmm" class="co" value="2" ><label for="tab-2" class="mol tab">기업회원</label></a>
     			</li>
  			</ul>

		<div id='tab11'>
	  	<!-- Form -->
	  		<form id="nmloginForm" name="nmloginForm" method="post">
	    	<!-- ID input -->
	    		<div class="first-input input__block first-input__block">
	       			<input type="text" placeholder="개인회원" class="input" id="nmId" name="nmId"/>
	    		</div>
	    		<!-- password input -->
	    		<div class="input__block">
	       			<input type="password" placeholder="개인회원" class="input" id="nmPwd" name="nmPwd"/>
	    		</div>
	    		<!-- sign in button -->
	    		<button type="button" class="signin__btn" id="nmSignInBtn" name="nmSignInBtn">로그인(개인)</button>
	    
	    		<div class="mol separator">
	    			<p>회원이 아니라면?</p>
	     		</div>
	    		<button type="button" class="signup__btn" id="signUpBtn1" name="signUpBtn1">회원가입</button>
			</form>
	  
	  		<!-- separator -->
	  		<div class="mol separator">
	    		<p>아이디가 생각이 안나시나요?</p>
	  		</div>
	  
	  		<button type="button" class="google__btn" id="findIdBtn" name="findIdBtn"><i class="fa fa-google"></i>아이디 찾기</button>
	  		
	  		<button type="button" class="google__btn" id="indexBtn1" name="indexBtn1"><i class="fa fa-google"></i>메인으로</button>
		</div>
	
	
	
		<div id='tab22' style="display:none;">
			<form id="cologinForm" name="cologinForm" method="post">
	    	<!-- ID input -->
	    		<div class="first-input input__block first-input__block signup-input__block">
	       			<input type="text" placeholder="기업회원" class="input" id="coId"/>
	    		</div>
	    	<!-- password input -->
	    		<div class="input__block">
	       			<input type="password" placeholder="기업회원" class="input" id="coPwd"/>
	    		</div>
	    	<!-- sign in button -->
		    	<button type="button" class="signin__btn" id="coSignInBtn" name="coSignInBtn">로그인(기업)</button>
		    
		    	<div class="mol separator"><p>회원이 아니라면?</p></div>
		    	<button type="button" class="signup__btn" id="signUpBtn2" name="signUpBtn2">회원가입</button>
		    	
		    	<div class="mol separator"></div>
	  			<button type="button" class="google__btn" id="indexBtn2" name="indexBtn2"><i class="fa fa-google"></i>메인으로</button>
	  		</form>
		</div>
	</div>
</body>
</html>