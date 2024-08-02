<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/assets/css/nmFind.css"/>
<script>
$(document).ready(function()
{
	//모든 공백 체크 정규식
	var emptyCheck = /\s/g;
	
	//이름 정규식
	var nameCheck = /^[가-힣]{2,6}$/;

	//Email 정규식
	var emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
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
	
	$("#loginBtnIdFind").on("click", function()
	{
		location.href = "/user/login"; 
	});
			
	$("#loginBtnPwdFind").on("click", function()
	{
		location.href = "/user/login"; 
	});
	
	
	$("#nmIdFindBtn").on("click", function()
	{
		if($.trim($("#nmNameIdFind").val()).length <= 0)
		{
			alert("이름을 입력해 주세요.");
			$("#nmNameIdFind").val("");
			$("#nmNameIdFind").focus();
			return;
		}

		if(emptyCheck.test($("#nmNameIdFind").val()))
		{
			alert("이름에 공백을 넣을 수 없습니다.");
			$("#nmNameIdFind").val("");
			$("#nmNameIdFind").focus();
			return;
		}

		if(!nameCheck.test($("#nmNameIdFind").val()))
		{
			alert("이름 형식이 올바르지 않습니다.");
			$("#nmNameIdFind").val("");
			$("#nmNameIdFind").focus();
			return;
		}
		
		if($.trim($("#nmEmailIdFind").val()).length <= 0)
		{
			alert("이메일을 입력해 주세요.");
			$("#nmEmailIdFind").val("");
			$("#nmEmailIdFind").focus();
			return;
		}

		if(emptyCheck.test($("#nmEmailIdFind").val()))
		{
			alert("이메일에 공백을 넣을 수 없습니다.");
			$("#nmEmailIdFind").val("");
			$("#nmEmailIdFind").focus();
			return;
		}

		if(!emailCheck.test($("#nmEmailIdFind").val()))
		{
			alert("이메일 형식이 올바르지 않습니다.");
			$("#nmEmailIdFind").val("");
			$("#nmEmailIdFind").focus();
			return;
		}
		
		$.ajax
		({
			type:"POST",
			url:"/user/nmIdFindProc",
			data:
			{
				nmNameIdFind:$("#nmNameIdFind").val(),
				nmEmailIdFind:$("#nmEmailIdFind").val()
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
					document.nmIdFindForm.action = "/user/nmIdFind";
					document.nmIdFindForm.submit();
				}
				else if(res.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
				}
				else if(res.code == 409)
				{
					alert("입력하는 값과 일치하는 정보가 없습니다.");
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
	
	
	
	
	
	
	
	$("#nmPwdFindBtn").on("click", function()
	{
		if($.trim($("#nmIdPwdFind").val()).length <= 0)
		{
			alert("사용자 아이디를 입력하세요.");
			$("#nmIdPwdFind").val("");
			$("#nmIdPwdFind").focus();
			return;
		}
		
		if(emptyCheck.test($("#nmIdPwdFind").val()))
		{
			alert("사용자 아이디는 공백을 포함 할 수 없습니다.");
			$("#nmIdPwdFind").focus();
			return;
		}
		
		if($.trim($("#nmNamePwdFind").val()).length <= 0)
		{
			alert("이름을 입력해 주세요.");
			$("#nmNamePwdFind").val("");
			$("#nmNamePwdFind").focus();
			return;
		}

		if(emptyCheck.test($("#nmNamePwdFind").val()))
		{
			alert("이름에 공백을 넣을 수 없습니다.");
			$("#nmNamePwdFind").val("");
			$("#nmNamePwdFind").focus();
			return;
		}

		if(!nameCheck.test($("#nmNamePwdFind").val()))
		{
			alert("이름 형식이 올바르지 않습니다.");
			$("#nmNamePwdFind").val("");
			$("#nmNamePwdFind").focus();
			return;
		}
		
		if($.trim($("#nmEmailPwdFind").val()).length <= 0)
		{
			alert("이메일을 입력해 주세요.");
			$("#nmEmailPwdFind").val("");
			$("#nmEmailPwdFind").focus();
			return;
		}

		if(emptyCheck.test($("#nmEmailPwdFind").val()))
		{
			alert("이메일에 공백을 넣을 수 없습니다.");
			$("#nmEmailPwdFind").val("");
			$("#nmEmailPwdFind").focus();
			return;
		}

		if(!emailCheck.test($("#nmEmailPwdFind").val()))
		{
			alert("이메일 형식이 올바르지 않습니다.");
			$("#nmEmailPwdFind").val("");
			$("#nmEmailPwdFind").focus();
			return;
		}

		
		$.ajax
		({
			type:"POST",
			url:"/user/nmPwdFindProc",
			data:
			{
				nmIdPwdFind:$("#nmIdPwdFind").val(),
				nmNamePwdFind:$("#nmNamePwdFind").val(),
				nmEmailPwdFind:$("#nmEmailPwdFind").val()
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
					document.nmPwdFindForm.action = "/user/nmPwdFindEmail";
					document.nmPwdFindForm.submit();
				}
				else if(res.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
				}
				else if(res.code == 409)
				{
					alert("입력하는 값과 일치하는 정보가 없습니다.");
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
	<h1 class="mol" style="font-weight:bold;">아이디/비밀번호 찾기</h1>
 		<ul class="links">
    		<li>
       			<a><input id="tab-1" type="radio" name="mmm" class="nm" value="1" checked><label for="tab-1" class="mol tab">아이디</label></a>
    		</li>
    		<li>
       			<a><input id="tab-2" type="radio" name="mmm" class="co" value="2" ><label for="tab-2" class="mol tab">비밀번호</label></a>
    		</li>
 		</ul>
	<div id='tab11'>
  		<!-- Form -->
  		<form id="nmIdFindForm" name="nmIdFindForm" method="post">
    	<!-- ID input -->
    		<div class="first-input input__block first-input__block">
       			<input type="text" placeholder="개인회원 이름" class="input" id="nmNameIdFind" name="nmNameIdFind"/>
    		</div>
    	<!-- password input -->
    		<div class="input__block">
       			<input type="email" placeholder="개인회원 이메일" class="input" id="nmEmailIdFind" name="nmEmailIdFind"/>
    		</div>
    	<!-- sign in button -->
    		<button type="button" class="signin__btn" id="nmIdFindBtn" name="nmIdFindBtn">아이디 찾기</button>
    
    		<div class="mol separator"></div>
  			<!-- google button -->
  			<button type="button" class="google__btn" id="loginBtnIdFind" name="loginBtnIdFind"><i class="fa fa-google"></i>로그인 화면으로</button>
    	</form>
	</div>

	<div id='tab22' style="display:none;">
		<form id="nmPwdFindForm" name="nmPwdFindForm" method="post">
    <!-- ID input -->
	    	<div class="first-input input__block first-input__block signup-input__block">
	       		<input type="text" placeholder="개인회원 아이디" class="input" id="nmIdPwdFind" name="nmIdPwdFind"/>
	    	</div>
	    	<!-- password input -->
	    	<div class="input__block">
	       		<input type="text" placeholder="개인회원 이름" class="input" id="nmNamePwdFind" name="nmNamePwdFind"/>
	    	</div>
	    	<div class="input__block">
	       		<input type="email" placeholder="개인회원 이메일" class="input" id="nmEmailPwdFind" name="nmEmailPwdFind"/>
	    	</div>
	    	<!-- sign in button -->
	    	<button type="button" class="signin__btn" id="nmPwdFindBtn" name="nmPwdFindBtn">비밀번호 찾기</button>
	    	<div class="mol separator"></div>
  			<!-- google button -->
  			<button type="button" class="google__btn" id="loginBtnPwdFind" name="loginBtnPwdFind"><i class="fa fa-google"></i>로그인 화면으로</button>
		</form>
	</div>
</div>

</body>
</html>