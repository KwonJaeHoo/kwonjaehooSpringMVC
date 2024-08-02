<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/assets/css/signUp.css"/>
<script>
$(document).ready(function()
{
	//모든 공백 체크 정규식
	var emptyCheck = /\s/g;
	
	//영문 대,소문자, 숫자로만 이루어진 n자리 정규식
	var idCheck = /^[a-zA-Z0-9]{4,20}$/;
	
	//특수문자, 영문 대,소문자,숫자 포함 형태의 n자리 이내의 암호 정규식
	var pwdCheck = /^.*(?=^.{8,32}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	
	//이름 정규식
	var nameCheck = /^[가-힣]{2,6}$/;
	//닉네임정규식(한글 초성 및 모음은 허가하지 않음)
	var nicknameCheck =	/^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,10}$/;
	
	//Email 정규식
	var emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	//핸드폰번호 정규식
	var telCheck = /^\d{3}-\d{3,4}-\d{4}$/;
	
	var coNumCheck = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/;
	
	var coTelCheck = /^0\d{1,2}(-|\))\d{3,4}-\d{4}$/;
	
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
	
//---------------------------------------------------------------	

	$("#userLogin1Btn").on("click", function()
	{
		location.href = "/user/login"; 
	});
	
	$("#userLogin2Btn").on("click", function()
	{
		location.href = "/user/login"; 
	});
	
//---------------------------------------------------------------	
	
	$("#nmIdDupCheck").on("click", function()
	{
		if($.trim($("#nmId").val()).length <= 0)
		{
			alert("사용자 아이디를 입력하세요.");
			$("#nmId").val("");
			$("#nmId").focus();
			return;
		}
		
		if(emptyCheck.test($("#nmId").val()))
		{
			alert("사용자 아이디는 공백을 포함 할 수 없습니다.");
			$("#nmId").focus();
			return;
		}

		if(!idCheck.test($("#nmId").val()))
		{
			alert("사용자 아이디는 4-20자의 영문 대 소문자 및 숫자로만 입력하세요.");
			$("#nmId").focus();
			return;
		}
		
		$.ajax
		({
			type:"POST",
			url:"/user/nmIdCheck",
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
					alert("가입 가능한 아이디입니다.");
					$("#nmIdCheck").val($("#nmId").val());
				}
				else if(res.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#nmId").focus();
				}
				else if(res.code == 409)
				{
					alert("중복된 아이디가 있습니다.");
					$("#nmId").focus();
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
	
//---------------------------------------------------------------	

	$("#coIdDupCheck").on("click", function()
	{		
		if($.trim($("#coId").val()).length <= 0)
		{
			alert("사용자 아이디를 입력하세요.");
			$("#coId").val("");
			$("#coId").focus();
			return;
		}
		
		if(emptyCheck.test($("#coId").val()))
		{
			alert("사용자 아이디는 공백을 포함 할 수 없습니다.");
			$("#coId").focus();
			return;
		}

		if(!idCheck.test($("#coId").val()))
		{
			alert("사용자 아이디는 4-20자의 영문 대 소문자 및 숫자로만 입력하세요.");
			$("#coId").focus();
			return;
		}
		
		$.ajax
		({
			type:"POST",
			url:"/user/coIdCheck",
			data:
			{
				coId:$("#coId").val()
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
					alert("가입 가능한 아이디입니다.");
					$("#coIdCheck").val($("#coId").val());
				}
				else if(res.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#coId").focus();
				}
				else if(res.code == 409)
				{
					alert("중복된 아이디가 있습니다.");
					$("#coId").focus();
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


//---------------------------------------------------------------	

	$("#nmSignUp").on("click", function()
	{

		if($.trim($("#nmId").val()).length <= 0)
		{
			alert("사용자 아이디를 입력하세요.");
			$("#nmId").val("");
			$("#nmId").focus();
			return;
		}
		if(emptyCheck.test($("#nmId").val()))
		{
			alert("사용자 아이디는 공백을 포함 할 수 없습니다.");
			$("#nmId").focus();
			return;
		}

		if(!idCheck.test($("#nmId").val()))
		{
			alert("사용자 아이디는 4-20자의 영문 대 소문자 및 숫자로만 입력하세요.");
			$("#nmId").focus();
			return;
		}
		
//---------------------------------------------------------------

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

		if($.trim($("#nmName").val()).length <= 0)
		{
			alert("이름을 입력해 주세요.");
			$("#nmName").val("");
			$("#nmName").focus();
			return;
		}

		if(emptyCheck.test($("#nmName").val()))
		{
			alert("이름에 공백을 넣을 수 없습니다.");
			$("#nmName").val("");
			$("#nmName").focus();
			return;
		}

		if(!nameCheck.test($("#nmName").val()))
		{
			alert("이름 형식이 올바르지 않습니다.");
			$("#nmName").val("");
			$("#nmName").focus();
			return;
		}
		
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

		if(confirm("회원가입을 진행하시겠어요?"))
		{
			if($("#nmIdCheck").val() == $("#nmId").val())
			{
				nm_signUp();
			}
			else
			{
				alert("아이디 중복체크를 확인 해 주세요.");
				return;
			}
		}
	});
	
	//---------------------------------------------------------------	

	$("#coSignUp").on("click", function()
	{

		if($.trim($("#coId").val()).length <= 0)
		{
			alert("사용자 아이디를 입력하세요.");
			$("#coId").val("");
			$("#coId").focus();
			return;
		}
		if(emptyCheck.test($("#coId").val()))
		{
			alert("사용자 아이디는 공백을 포함 할 수 없습니다.");
			$("#coId").focus();
			return;
		}

		if(!idCheck.test($("#coId").val()))
		{
			alert("사용자 아이디는 4-20자의 영문 대 소문자 및 숫자로만 입력하세요.");
			$("#coId").focus();
			return;
		}
		
//---------------------------------------------------------------

		if($.trim($("#coPwd1").val()).length <= 0)
		{
			alert("비밀번호를 입력하세요.");
			$("#coPwd1").val("");
			$("#coPwd1").focus();
			return;
		}
		
		if(!pwdCheck.test($("#coPwd1").val()))
		{
			alert("비밀번호는 영문 대소문자 숫자로 8-32자리로 입력하세요.");
			$("#coPwd1").val("");
			$("#coPwd1").focus();
			return;
		}
		
		if($.trim($("#coPwd2").val()).length <= 0)
		{
			alert("비밀번호 확인을 입력하세요.");
			$("#coPwd2").val("");
			$("#coPwd2").focus();
			return;
		}
		
		if($("#coPwd1").val() != $("#coPwd2").val())
		{
			alert("비밀번호가 일치하지 않습니다.");
			$("#coPwd2").focus();
			return;	
		}
		
		$("#coPwd").val($("#coPwd1").val());
		
//---------------------------------------------------------------

		if($.trim($("#coName").val()).length <= 0)
		{
			alert("기업 명을 입력해 주세요.");
			$("#coName").val("");
			$("#coName").focus();
			return;
		}

		if(emptyCheck.test($("#coName").val()))
		{
			alert("기업명에 공백을 넣을 수 없습니다.");
			$("#coName").val("");
			$("#coName").focus();
			return;
		}
		
//---------------------------------------------------------------

		if($.trim($("#coCeo").val()).length <= 0)
		{
			alert("대표자명을 입력해 주세요.");
			$("#coCeo").val("");
			$("#coCeo").focus();
			return;
		}

		if(emptyCheck.test($("#coCeo").val()))
		{
			alert("대표자명에 공백을 넣을 수 없습니다.");
			$("#coCeo").val("");
			$("#coCeo").focus();
			return;
		}

		if(!nameCheck.test($("#coCeo").val()))
		{
			alert("대표자명 형식이 올바르지 않습니다.");
			$("#coCeo").val("");
			$("#coCeo").focus();
			return;
		}
		
//---------------------------------------------------------------

		if($.trim($("#coNum").val()).length <= 0)
		{
			alert("사업자번호를 입력해 주세요.");
			$("#coNum").val("");
			$("#coNum").focus();
			return;
		}

		if(emptyCheck.test($("#coNum").val()))
		{
			alert("사업자번호에 공백을 넣을 수 없습니다.");
			$("#coNum").val("");
			$("#coNum").focus();
			return;
		}

		if(!coNumCheck.test($("#coNum").val()))
		{
			alert("사업자번호 형식이 올바르지 않습니다.");
			$("#coNum").val("");
			$("#coNum").focus();
			return;
		}
		
//---------------------------------------------------------------

		if($.trim($("#coAddr").val()).length <= 0)
		{
			alert("기업 주소를 입력해 주세요.");
			$("#coAddr").val("");
			$("#coAddr").focus();
			return;
		}
		
//---------------------------------------------------------------

		if($.trim($("#coTel").val()).length <= 0)
		{
			alert("전화번호를 입력해 주세요.");
			$("#coTel").val("");
			$("#coTel").focus();
			return;
		}

		if(emptyCheck.test($("#coTel").val()))
		{
			alert("전화번호에 공백을 넣을 수 없습니다.");
			$("#coTel").val("");
			$("#coTel").focus();
			return;
		}

		if(!telCheck.test($("#coTel").val()))
		{
			alert("전화번호 형식이 올바르지 않습니다.");
			$("#coTel").val("");
			$("#coTel").focus();
			return;
		}
		
//---------------------------------------------------------------

		if(confirm("회원가입을 진행하시겠어요?"))
		{
			if($("#coIdCheck").val() == $("#coId").val())
			{
				co_signUp();
			}
			else
			{
				alert("아이디 중복체크를 확인 해 주세요.");
				return;
			}
		}
	});
});





function nm_signUp()
{
	$.ajax
	({
		type:"POST",
		url:"/user/nmSignUpProc",
		data:
		{
			nmId:$("#nmId").val(),
			nmPwd:$("#nmPwd").val(),
			nmName:$("#nmName").val(),
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
				alert("회원가입이 완료 되었습니다.");
				location.href = "/user/login";
			}
			else if(res.code == 400)
			{
				alert("파라미터 값이 올바르지 않습니다.");
				$("#nmId").focus();
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
			else if(res.code == 410)
			{
				alert("중복된 아이디가 있습니다.");
				$("#nmId").focus();
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

function co_signUp()
{
	$.ajax
	({
		type:"POST",
		url:"/user/coSignUpProc",
		data:
		{
			coId:$("#coId").val(),
			coPwd:$("#coPwd").val(),
			coName:$("#coName").val(),
			coCeo:$("#coCeo").val(),
			coNum:$("#coNum").val(),
			coAddr:$("#coAddr").val(),
			coTel:$("#coTel").val(),
			coEmail:$("#coEmail").val()
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
				alert("회원가입이 완료되었습니다. 관리자의 승인을 기다려주세요.");
				location.href = "/";
			}
			else if(res.code == 400)
			{
				alert("파라미터 값이 올바르지 않습니다.");
				$("#coId").focus();
			}
			else if(res.code == 407)
			{
				alert("사업자번호가 중복됩니다.");
				$("#coNum").focus();
			}	
			else if(res.code == 408)
			{
				alert("주소가 중복됩니다.");
				$("#coAddr").focus();
			}
			else if(res.code == 409)
			{
				alert("전화번호가 중복됩니다.");
				$("#coTel").focus();
			}
			else if(res.code == 410)
			{
				alert("중복된 이메일이 있습니다.");
				$("#coEmail").focus();
			}
			else if(res.code == 411)
			{
				alert("중복된 아이디가 있습니다.");
				$("#coId").focus();
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
	<div class="container">
  	<!-- Heading -->
  		<h1 class="mol" style="font-weight:bold;">회원가입</h1>
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
  			<div id="nmSignUpForm" name="nmSignUpForm" method="post">
    			<!-- ID input -->
    			<div class="first-input input__block1 first-input__block">
    				<div class="ws_input">
             			<input type="text" placeholder="아이디" class="input" id="nmId" name="nmId"/>
             			<button type="button" id="nmIdDupCheck" class="ws_nmUpdate_btn">중복확인</button>
           			</div>
           			<div class="ws_input">
			       		<small> 아이디는 영문 대,소문자, 숫자를 포함하여 4~20자로 입력해 주세요. </small>
			       	</div> 
    			</div>
			    <!-- password input -->
			    <div class="input__block">
			    	<input type="password" placeholder="비밀번호" class="input" id="nmPwd1"/>
			       	<div class="ws_input">
			       		<small> 비밀번호는 특수문자 및 영문 대,소문자, 숫자를 포함하여 8~32자로 입력해 주세요. </small>
			       	</div>
			    </div>
			    <div class="input__block">
			    	<input type="password" placeholder="비밀번호 확인" class="input" id="nmPwd2"/>
			    </div>
			    <div class="input__block">
			       	<input type="text" placeholder="이름" class="input" id="nmName"/>
			    </div>
			    <div class="input__block">
			    	<input type="text" placeholder="닉네임" class="input" id="nmNickname"/>
			       	<div class="ws_input">
			       		<small> 닉네임은 최대 10자까지 입력가능합니다.</small>
			       	</div>
			    </div>
			    <div class="input__block">
			       	<input type="email" placeholder="이메일" class="input" id="nmEmail"/>
			       	<div class="ws_input">
			       		<small> 이메일은 형식에 맞게 입력해주세요. ex) withSports@example.com</small>
			       	</div>
			    </div>
			    <div class="input__block">
			    	<input type="tel" placeholder="전화번호" class="input" id="nmTel"/>
			       	<div class="ws_input">
			       		<small> 전화번호는 하이픈(-)까지 입력해주세요. ex) 010-1234-5678</small>
			       	</div>
			    </div>
			    <!-- sign in button -->
			   	<input type="hidden" class="input" id="nmPwd" value=""/>
			   	<input type="hidden" class="input" id="nmIdCheck" value=""/>
			   	
			    <button type="button" class="signin__btn" id="nmSignUp" name="nmSignUp">회원가입(개인)</button>
  			</div>
  			
  			<!-- separator -->
  			<div class="mol separator">
    			<p>이미 회원가입을 하셨다면?</p>
  			</div>
  			<!-- google button -->
  			<button type="button" class="google__btn" id="userLogin1Btn" name="userLogin1Btn"><i class="fa fa-google"></i>로그인 화면으로</button>
  		</div>

		<div id='tab22' style="display:none;">
			<div id="tab2" name="tab" method="post">
    		<!-- ID input -->
			    <div class="first-input input__block first-input__block signup-input__block">
			    	<div class="ws_input">
			       		<input type="text" placeholder="기업 아이디" class="input" id="coId"/>
			       		<button class="ws_nmUpdate_btn" type="button" id="coIdDupCheck">중복확인</button>
			       	</div>
			       	<div class="ws_input">
			       		<small> 아이디는 영문 대,소문자, 숫자를 포함하여 4~20자로 입력해 주세요. </small>
			       	</div> 
			   	</div>
			    <!-- password input -->
			    <div class="input__block">
			       	<input type="password" placeholder="기업 비밀번호" class="input" id="coPwd1"/>
			       	<div class="ws_input">
			       		<small> 비밀번호는 특수문자 및 영문 대,소문자, 숫자를 포함하여 8~32자로 입력해 주세요. </small>
			    	</div>
			    </div>
			   	<div class="input__block">
			       	<input type="password" placeholder="기업 비밀번호 확인" class="input" id="coPwd2"/>
			    </div>
			    <div class="input__block">
			       	<input type="text" placeholder="기업명" class="input" id="coName"/>
			    </div>
			    <div class="input__block">
			       	<input type="text" placeholder="기업 대표자명" class="input" id="coCeo"/>
			    </div>
			   	<div class="input__block">
			       	<input type="tel" placeholder="기업 사업자번호" class="input" id="coNum"/>
			    	<div class="ws_input">
			       		<small>사업자 번호는 하이픈(-)까지 입력해주세요. ex) 001-12-34567</small>
			       	</div>
			    </div>
			    <div class="input__block">
			       	<input type="text" placeholder="기업 주소" class="input" id="coAddr"/>
			    </div>
			    <div class="input__block">
			       	<input type="tel" placeholder="기업 전화번호" class="input" id="coTel"/>
			       	<div class="ws_input">
			       		<small> 전화번호는 하이픈(-)까지 입력해주세요. ex) 031-123-4567</small>
			       	</div>
			    </div>
			    <div class="input__block">
			       	<input type="email" placeholder="기업 이메일" class="input" id="coEmail"/>
			       	<div class="ws_input">
			       		<small> 전화번호는 하이픈(-)까지 입력해주세요. ex) 010-1234-5678</small>
			       	</div>
			    </div>
			    <!-- sign in button -->
			    <input type="hidden" class="input" id="coPwd" value=""/>
			   	<input type="hidden" class="input" id="coIdCheck" value=""/>
			    <button class="signup__btn" id="coSignUp" name="coSignUp">회원가입(기업) </button>
  			</div>
  			
  			<!-- separator -->
  			<div class="mol separator">
    			<p>이미 회원가입을 하셨다면?</p>
  			</div>
  			<!-- google button -->
  			<button type="button" class="google__btn" id="userLogin2Btn" name="userLogin2Btn"><i class="fa fa-google"></i>로그인 화면으로</button>
		</div>
	</div>
	
	
	
	
	
</body>
</html>