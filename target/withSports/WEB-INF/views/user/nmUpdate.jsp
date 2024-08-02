<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/assets/css/signUp.css"/>
<script>
<c:if test="${empty nmCookie}">
	location.href="/";
</c:if>

$(document).ready(function()
{
	//모든 공백 체크 정규식
	var emptyCheck = /\s/g;
	
	//특수문자, 영문 대,소문자,숫자 포함 형태의 n자리 이내의 암호 정규식
	var pwdCheck = /^.*(?=^.{8,32}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	
	//닉네임정규식(한글 초성 및 모음은 허가하지 않음)
	var nicknameCheck =	/^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,10}$/;
	
	//Email 정규식
	var emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	//핸드폰번호 정규식
	var telCheck = /^\d{3}-\d{3,4}-\d{4}$/;
	
	$("#nmUsersignOut").on("click", function()
	{
		if(confirm("정말 회원탈퇴 하시겠어요?"))
		{
			nm_signOut();
		}
	});
	
	
	$("#nmUserModify").on("click", function()
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
		
//---------------------------------------------------------------

		if($.trim($("#nmNickname").val()).length <= 0)
		{
			alert("닉네임을 입력해 주세요.");
			$("#nmNickname").val("");
			$("#nmNickname").focus();
			return;
		}

		if(emptyCheck.test($("#nmNickname").val()))
		{
			alert("닉네임에 공벡을 넣을 수 없습니다.");
			$("#nmNickname").val("");
			$("#nmNickname").focus();
			return;
		}

		if(!nicknameCheck.test($("#nmNickname").val()))
		{
			alert("닉네임 형식이 올바르지 않습니다.");
			$("#nmNickname").val("");
			$("#nmNickname").focus();
			return;
		}
		
//---------------------------------------------------------------

		if($.trim($("#nmEmail").val()).length <= 0)
		{
			alert("이메일을 입력해 주세요.");
			$("#nmEmail").val("");
			$("#nmEmail").focus();
			return;
		}

		if(emptyCheck.test($("#nmEmail").val()))
		{
			alert("이메일에 공백을 넣을 수 없습니다.");
			$("#nmEmail").val("");
			$("#nmEmail").focus();
			return;
		}

		if(!emailCheck.test($("#nmEmail").val()))
		{
			alert("이메일 형식이 올바르지 않습니다.");
			$("#nmEmail").val("");
			$("#nmEmail").focus();
			return;
		}
		
//---------------------------------------------------------------

		if($.trim($("#nmTel").val()).length <= 0)
		{
			alert("전화번호를 입력해 주세요.");
			$("#nmTel").val("");
			$("#nmTel").focus();
			return;
		}

		if(emptyCheck.test($("#nmTel").val()))
		{
			alert("전화번호에 공백을 넣을 수 없습니다.");
			$("#nmTel").val("");
			$("#nmTel").focus();
			return;
		}

		if(!telCheck.test($("#nmTel").val()))
		{
			alert("전화번호 형식이 올바르지 않습니다.");
			$("#nmTel").val("");
			$("#nmTel").focus();
			return;
		}
		
//---------------------------------------------------------------

		if(confirm("회원정보를 수정하시겠어요?"))
		{
			nm_modify();
		}
	});
});

function nm_modify()
{
	$.ajax
	({
		type:"POST",
		url:"/user/nmUpdateProc",
		data:
		{
			nmId:$("#nmId").val(),
			nmPwd:$("#nmPwd").val(),
			nmNickname:$("#nmNickname").val(),
			nmEmail:$("#nmEmail").val(),
			nmTel:$("#nmTel").val()		
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
				alert("회원정보가 수정되었습니다.");
				location.href = "/user/nmMyPage";
			}
			else if(res.code == 404)
			{
				alert("등록된 아이디가 없습니다.");
			}
			else if(res.code == 400)
			{
				alert("파라미터 값이 올바르지 않습니다.");
			}
			else if(res.code == 407)
			{
				alert("닉네임이 중복됩니다.");
				$("#nmNickname").focus();
			}	
			else if(res.code == 408)
			{
				alert("이메일이 중복됩니다.");
				$("#nmEmail").focus();
			}
			else if(res.code == 409)
			{
				alert("전화번호가 중복됩니다.");
				$("#nmTel").focus();
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
}

function nm_signOut()
{
	$.ajax
	({
		type:"POST",
		url:"/user/nmSignOutProc",
		data:
		{
			nmId:$("#nmId").val()		
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
				alert("회원탈퇴가 완료되었습니다. 추 후 재가입 시 기존 사용하던 아이디는 사용이 불가능합니다.");
				location.href = "/";
			}
			else if(res.code == 400)
			{
				alert("파라미터 값이 올바르지 않습니다.");
			}
			else if(res.code == 404)
			{
				alert("등록된 아이디가 없습니다.");
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
}
</script>
</head>
<body>
<c:if test="${!empty nmCookie}">
<div class="container">
  <!-- Heading -->
  <h1 class="ws_nmUpdate_t" style="font-weight:bold;">회원정보 수정</h1>
  <p class="ws_nmUpdate_msg">기업회원 정보 수정은 관리자에게 문의 바랍니다.</p>
  
  <!-- Form -->
  <form  action="" method="post">
    <!-- ID input -->
    <div class="first-input input__block">
       <input type="text" placeholder="아이디" class="input" id="nmId" name="nmId" value="${spNmUser.nmId}" readonly />
    </div>
    <!-- password input -->
    <div class="input__block">
       <input type="password" placeholder="비밀번호" class="input" id="nmPwd1" name="nmPwd1" />
        <div class="ws_input">
			<small> 비밀번호는 특수문자 및 영문 대,소문자, 숫자를 포함하여 8~32자로 입력해 주세요. </small>
		</div>	
    </div>

    <div class="input__block">
       <input type="password" placeholder="비밀번호 확인" class="input" id="nmPwd2" name="nmPwd2"/>
    </div>
    
    <div class="input__block">
       <input type="text" placeholder="이름" class="input" id="nmName" name="nmName" value="${spNmUser.nmName}" readonly/>
    </div>
    
    <div class="input__block">
       	<input type="text" placeholder="닉네임" class="input" id="nmNickname" name="nmNickname" />
		<div class="ws_input">
			<small> 닉네임은 최대 10자까지 입력가능합니다.</small>
		</div>
    </div>
    
    <div class="input__block">
       	<input type="text" placeholder="이메일" class="input" id="nmEmail" name="nmEmail" />
       	<div class="ws_input">
			<small> 이메일은 형식에 맞게 입력해주세요. ex) withSports@example.com</small>
		</div>
    </div>
	<div class="input__block">
       	<input type="text" placeholder="전화번호" class="input" id="nmTel" name="nmTel" />
       	<div class="ws_input">
			<small> 전화번호는 하이픈(-)까지 입력해주세요. ex) 010-1234-5678</small>
		</div>
    </div>
    <input type="hidden" class="input" id="nmPwd" value=""/>
    <button type="button" class="ws_nmUpdate_subBtn" id="nmUserModify" name="nmUserModify">수정</button>
    
    <div><a class="ws_nmUpdate_msg ws_msg" id="nmUsersignOut">회원탈퇴</a></div>
  </form>
</div>
</c:if>
</body>
</html>