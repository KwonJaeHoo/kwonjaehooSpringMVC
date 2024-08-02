<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<title>Insert title here</title>
<style>
.mol{
   font-family: 'Montserrat', sans-serif;
   background: white;
}

.container {
   display: block;
   max-width: 680px;
   width: 80%;
   margin: 80px auto;
}

h1 {
   color: #e91e63;
   font-size: 48px;
   letter-spacing: -3px;
   text-align: center;
   margin: 30px 0 80px 0;
   transition: .2s linear;
}

.links .nm,
.links .co{
  top:0;
  left:0;
  right:0;
  bottom:0;
  position:absolute;
  transform:rotateY(180deg);
  backface-visibility:hidden;
  transition:all .4s linear;
}
.links .nm,
.links .co,{
  display:none;
}

.links .nm + .tab,
.links .co + .tab{
  color:gray;
  border-color:#1161ee;
}

.links .nm:checked + .tab,
.links .co:checked + .tab{
  color:#0f132a;
  border-color:#1161ee;
}

ul{
   padding-inline-start: 0;
}

.links {
   list-style-type: none;
}


.links li {
   display: inline-block;
   margin: 0 20px 0 0;
   transition: .2s linear;
}

.links li:nth-child(2) {
   opacity: .6;
}

.links li:nth-child(2):hover {
   opacity: 1;
}

.links li:nth-child(3) {
   opacity: .6;
   float: right;
}

.links li:nth-child(3):hover {
   opacity: 1;
}

.nm,
.co{
   opacity: 0;
}

.links li a {
   text-decoration: none
   font-weight: bolder;
   text-align: center;
   cursor: pointer;
}

a{
   text-decoration:none;
   font-weight:bolder;
   text-align:center;
   cursor : pointer;
}

div {
   width: 100%;
   max-width: 680px;
   margin: 40px auto 10px;
}

div .input__block {
   margin: 20px auto;
   display: block;
   position: relative;
}

div .ws_input input {
   display: block;
   float:left;
   width: 69%;
   max-width: 680px;
   height: 50px;
   border-radius: 8px;
   border: none;
   background: rgba(15, 19, 42, 0.1);
   color: rgba(15, 19, 42, 0.3);
   padding: 0 0 0 15px;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   position: relative;
}

div .ws_input{
   margin-bottom:20px;
   margin-left: 26px;
   display:flex;
   margin : 20px 31px;
   jsutify-content:between;
}

.ws_div {
   width: 100%;
   max-width: 680px;
   margin: 40px auto 10px;
   }

   div .input_block {
   margin: 20px auto;
   display: block;
   position: relative;
   }

   div .input_block.first-input_block::before {
   content: "";
   position: absolute;
   top: -15px;
   left: 50px;
   display: block;
   width: 0;
   height: 0;
   background: transparent;
   border-left: 15px solid transparent;
   border-right: 15px solid transparent;
   border-bottom: 15px solid rgba(15, 19, 42, 0.1);
   transition: .2s linear;
   }

   div .input_block.reg-input_block::before {
   content: "";
   position: absolute;
   top: -15px;
   left: 150px;
   display: block;
   width: 0;
   height: 0;
   background: transparent;
   border-left: 15px solid transparent;
   border-right: 15px solid transparent;
   border-bottom: 15px solid rgba(15, 19, 42, 0.1);
   transition: .2s linear;
   }

.ws_nmUpdate_msg{
   display:flex;
   justify-content:center;
   margin-bottom: 30px;
}

.ws_msg{
   text-decoration:underline;
   color:#e91e63;
   float:right;
   margin-right:25px;
}

.ws_nmUpdate_t{
   margin-bottom:0px;
}

div .ws_nmUpdate_btn{
   background: white;
   color: #e91e63;
   display: block;
   width: 20%;
   height: 48px;
   border-radius: 8px;
   border: solid 1px #e91e63;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   transition: .2s linear;
   margin-left: 10px;
   box-shadow: 0 1px 5px rgba(0, 0, 0, 0.36);
}

div .ws_nmUpdate_subBtn{
   background: #e91e63;
   color: white;
   display: block;
   width: 92.5%;
   max-width: 680px;
   height: 50px;
   border-radius: 8px;
   margin: 0 0 30px 30px;
   border: none;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   box-shadow: 0 15px 30px rgba(233, 30, 99, 0.36);
   transition: .2s linear;
}

div .input__block input {
   display: block;
   width: 90%;
   max-width: 680px;
   height: 50px;
   margin: 0 auto;
   border-radius: 8px;
   border: none;
   background: rgba(15, 19, 42, 0.1);
   color: rgba(15, 19, 42, 0.3);
   padding: 0 0 0 15px;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
}

div .input__block input:focus, div .input__block input:active {
   outline: none;
   border: none;
   color: #0f132a;
}

div .input__block input.repeat__password {
   opacity: 0;
   display: none;
   transition: .2s linear;
}

div .signin__btn {
   background: #e91e63;
   color: white;
   display: block;
   width: 92.5%;
   max-width: 680px;
   height: 50px;
   border-radius: 8px;
   margin: 0 auto;
   border: none;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   box-shadow: 0 15px 30px rgba(233, 30, 99, 0.36);
   transition: .2s linear;
}

div .signup__btn {
   background: #e91e63;
   color: white;
   display: block;
   width: 92.5%;
   max-width: 680px;
   height: 50px;
   border-radius: 8px;
   margin: 0 auto;
   border: none;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   box-shadow: 0 15px 30px rgba(233, 30, 99, 0.36);
   transition: .2s linear;
}

div .signin__btn:hover {
   box-shadow: 0 0 0 rgba(233, 30, 99, 0);
}

div .signup__btn:hover {
   box-shadow: 0 0 0 rgba(233, 30, 99, 0);
}

.separator {
   display: block;
   margin: 30px auto 10px;
   text-align: center;
   height: 40px;
   position: relative;
   background: transparent;
   color: rgba(15, 19, 42, 0.4);
   font-size: 13px;
   width: 90%;
   max-width: 680px;
}

.separator::before {
   content: "";
   position: absolute;
   top: 8px;
   left: 0;
   background: rgba(15, 19, 42, 0.2);
   height: 1px;
   width: 30%;
}

.separator::after {
   content: "";
   position: absolute;
   top: 8px;
   right: 0;
   background: rgba(15, 19, 42, 0.2);
   height: 1px;
   width: 30%;
}

.google__btn,
.github__btn {
   display: block;
   width: 99%;
   max-width: 680px;
   margin: 20px auto;
   height: 50px;
   border-radius: 8px;
   margin: 0 auto;
   border: none;
   cursor: pointer;
   font-size: 14px;
   font-family: 'Montserrat', sans-serif;
   box-shadow: 0 15px 30px rgba(233, 30, 99, 0.36);
   transition: .2s linear;
}

.google__btn.google__btn,
.github__btn.google__btn {
   background: #5b90f0;
   color: white;
   box-shadow: 0 15px 30px rgba(91, 144, 240, 0.36);
   transition: .2s linear;
}

.google__btn.google__btn .fa,
.github__btn.google__btn .fa {
   font-size: 20px;
   padding: 0 5px 0 0;
}

.google__btn.google__btn:hover,
.github__btn.google__btn:hover {
   box-shadow: 0 0 0 rgba(91, 144, 240, 0);
}

.google__btn.github__btn,
.github__btn.github__btn {
   background: #25282d;
   color: white;
   box-shadow: 0 15px 30px rgba(37, 40, 45, 0.36);
   transition: .2s linear;
}

.google__btn.github__btn .fa,
.github__btn.github__btn .fa {
   font-size: 20px;
   padding: 0 5px 0 0;
}

.google__btn.github__btn:hover,
.github__btn.github__btn:hover {
   box-shadow: 0 0 0 rgba(37, 40, 45, 0);
}
</style>
<script type="text/javascript">
$(document).ready(function(){
   var id = 0;
   var nic = 0;
   var email = 0;
   var tel = 0;
   
   $("#nmId").change(function(){
      id = 0;
   });
   
   $("#nmNickname").change(function(){
      nic = 0;
   });
   
   $("#nmEmail").change(function(){
      email = 0;
   });
   
   $("#nmTel").change(function(){
      tel = 0;
   });
   
   $("input[type=radio][name=mmm]").on("click", function(){
      
      var chkValue = $("input[type=radio][name=mmm]:checked").val();
      
      if(chkValue == "1"){
         $("#nmSingUp").css("display", "block");
         $("#coSingUp").css("display", "none");
      }
      else if(chkValue == "2"){
         $("#coSingUp").css("display", "block");
         $("#nmSingUp").css("display", "none");
      }
   });
   
   $("#btnNmIdChk").on("click", function(){
      if($.trim($("#nmId").val()).length <= 0)
      {
         alert("아이디를 입력하세요.");
         $("#nmId").val("");
         $("#nmId").focus();
         return;
      }
      
      if(fn_emptCheck($("#nmId").val()))
      {
         alert("아이디에 공백을 포함할 수 없습니다.");
         $("#nmId").val("");
         $("#nmId").focus();
         return;
      }
      
      if(!fn_idpwCheck($("#nmId").val()))
      {
         alert("아이디는 4~12자의 영문 대소문자와 숫자로만 입력하세요.");
         $("#nmId").val("");
         $("#nmId").focus();
         return;
      }
      
      var a = $("#nmId").val();
      var b = "q";
      id = 1;
      
      fn_nmSame(a, b)
   });
   
  $("#btnNmNicknameChk").on("click", function(){
     if($.trim($("#nmNickname").val()).length <= 0)
      {
         alert("닉네임를 입력하세요.");
         $("#nmNickname").val("");
         $("#nmNickname").focus();
         return;
      }
     
     var a = $("#nmNickname").val();
     var b = "w";
     nic = 1;
     
     fn_nmSame(a, b)
   });
   
  $("#btnNmEmailChk").on("click", function(){
     if($.trim($("#nmEmail").val()).length <= 0)
      {
         alert("이메일를 입력하세요.");
         $("#nmEmail").val("");
         $("#nmEmail").focus();
         return;
      }
      
      if(!fn_validateEmail($("#nmEmail").val()))
      {
         alert("이메일 형식으로 입력하세요.");
         $("#nmEmail").val("");
         $("#nmEmail").focus();
         return;
      }
     
     var a = $("#nmEmail").val();
     var b = "e";
     email = 1;
     
     fn_nmSame(a, b)
  });

  $("#btnNmTelChk").on("click", function(){
      if($.trim($("#nmTel").val()).length <= 0)
      {
         alert("전화번호를 입력하세요.");
         $("#nmTel").val("");
         $("#nmTel").focus();
         return;
      }
      
      if(!fn_checktel($("#nmTel").val()))
      {
         alert("전화번호 형식으로 입력하세요.(010-1111-1111)");
         $("#nmTel").val("");
         $("#nmTel").focus();
         return;
      }
     
     var a = $("#nmTel").val();
     var b = "r";
     tel = 1;
     
     fn_nmSame(a, b)
  });
   
   $("#nmSignUp").on("click", function(){
      if($.trim($("#nmPwd").val()).length <= 0)
      {
         alert("비밀번호를 입력하세요.");
         $("#nmPwd").val("");
         $("#nmPwd").focus();
         return;
      }
      
      if(fn_emptCheck($("#nmPwd").val()))
      {
         alert("비밀번호에 공백을 포함할 수 없습니다.");
         $("#nmPwd").val("");
         $("#nmPwd").focus();
         return;
      }
      
      if(!fn_idpwCheck($("#nmPwd").val()))
      {
         alert("비밀번호는 4~12자의 영문 대소문자와 숫자로만 입력하세요.");
         $("#nmPwd").val("");
         $("#nmPwd").focus();
         return;
      }
      
      if($("#nmPwd").val() != $("#nmPwd2").val())
      {
         alert("비밀번호가 다릅니다.");
         $("#nmPwd2").val("");
         $("#nmPwd2").focus();
         return;
      }
      
      if($.trim($("#nmName").val()).length <= 0)
      {
         alert("이름를 입력하세요.");
         $("#nmName").val("");
         $("#nmName").focus();
         return;
      }
      
      if(id != 1)
      {
         alert("아이디 중복 확인을 진행해 주세요.");
         return;
      }
      
      if(nic != 1)
      {
         alert("닉네임 중복 확인을 진행해 주세요.");
         return;
      }
      
      if(email != 1)
      {
         alert("이메일 중복 확인을 진행해 주세요.");
         return;
      }
      
      if(tel != 1)
      {
         alert("전화번호 중복 확인을 진행해 주세요.");
         return;
      }
      
      var musa = "musa";
      
    //일반회원 회원가입
      $.ajax({
         type:"POST",
         url:"/user/nmSignUp",
         data:{
            nmId:$("#nmId").val(),
            nmPwd:$("#nmPwd").val(),
            nmName:$("#nmName").val(),
            nmNickname:$("#nmNickname").val(),
            nmEmail:$("#nmEmail").val(),
            nmTel:$("#nmTel").val(),
            musa:musa
         },
         datatype:"JSON",
         beforeSend:function(xhr){
            xhr.setRequestHeader("AJAX", "true");
         },
         success:function(response){
            if(response.code == 0)
            {
               alert("환영합니다.");
               location.href = "/";
            }
            else if(response.code == 100)
            {
               alert("제대로 된 경로로 가입을 하지 않으셨습니다.");
               $("#nmId").focus();
            }
            else if(response.code == 400)
            {
               alert("파라미터 값이 잘못 되었습니다.");
               $("#nmNickName").focus();
            }
            else
            {
               alert("오류가 발생했습니다.");
               $("#nmId").focus();
            }
         },
         error:function(xhr, status, error){
            icia.common.error(error);
         }
      });
   });
   
    $("#coId").change(function(){
      id = 0;
   });
   
   $("#coEmail").change(function(){
      email = 0;
   });
   
   
   $("#btnCoIdChk").on("click", function(){
      if($.trim($("#coId").val()).length <= 0)
      {
         alert("아이디를 입력하세요.");
         $("#coId").val("");
         $("#coId").focus();
         return;
      }
      
      if(fn_emptCheck($("#coId").val()))
      {
         alert("아이디에 공백을 포함할 수 없습니다.");
         $("#coId").val("");
         $("#coId").focus();
         return;
      }
      
      if(!fn_idpwCheck($("#coId").val()))
      {
         alert("아이디는 4~12자의 영문 대소문자와 숫자로만 입력하세요.");
         $("#coId").val("");
         $("#coId").focus();
         return;
      }
      
      var a = $("#coId").val();
      var b = "1";
      id = 2;
      
      fn_coSame(a, b)
   });
  
  $("#btnCoEmailChk").on("click", function(){
     if($.trim($("#coEmail").val()).length <= 0)
      {
         alert("이메일를 입력하세요.");
         $("#coEmail").val("");
         $("#coEmail").focus();
         return;
      }
      
      if(!fn_validateEmail($("#coEmail").val()))
      {
         alert("이메일 형식으로 입력하세요.");
         $("#coEmail").val("");
         $("#coEmail").focus();
         return;
      }
     
     var a = $("#coEmail").val();
     var b = "2";
     email = 2;
     
     fn_coSame(a, b)
 });
   
   $("#coSignUp").on("click", function(){
      if($.trim($("#coPwd").val()).length <= 0)
      {
         alert("비밀번호를 입력하세요.");
         $("#coPwd").val("");
         $("#coPwd").focus();
         return;
      }
      
      if(fn_emptCheck($("#coPwd").val()))
      {
         alert("비밀번호에 공백을 포함할 수 없습니다.");
         $("#coPwd").val("");
         $("#coPwd").focus();
         return;
      }
      
      if(!fn_idpwCheck($("#coPwd").val()))
      {
         alert("비밀번호는 4~12자의 영문 대소문자와 숫자로만 입력하세요.");
         $("#coPwd").val("");
         $("#coPwd").focus();
         return;
      }
      
      if($("#coPwd").val() != $("#coPwd2").val())
      {
         alert("비밀번호가 다릅니다.");
         $("#coPwd2").val("");
         $("#coPwd2").focus();
         return;
      }
      
      if($.trim($("#coName").val()).length <= 0)
      {
         alert("기업명을 입력하세요.");
         $("#coName").val("");
         $("#coName").focus();
         return;
      }
      
      if($.trim($("#coCeo").val()).length <= 0)
      {
         alert("대표자명을 입력하세요.");
         $("#coCeo").val("");
         $("#coCeo").focus();
         return;
      }
      
      if($.trim($("#coNum").val()).length <= 0)
      {
         alert("사업자등록번호를 입력하세요.");
         $("#coNum").val("");
         $("#coNum").focus();
         return;
      }
      
      if(!fn_checkBrn($("#coNum").val()))
      {
         alert("사업자등록번호 형식으로 입력하세요.(000-00-00000)");
         $("#coNum").val("");
         $("#coNum").focus();
         return;
      }
      
      if($.trim($("#coAddr").val()).length <= 0)
      {
         alert("주소를 입력하세요.");
         $("#coAddr").val("");
         $("#coAddr").focus();
         return;
      }
      
      if($.trim($("#coTel").val()).length <= 0)
      {
         alert("전화번호를 입력하세요.");
         $("#coTel").val("");
         $("#coTel").focus();
         return;
      }
      
      if(!fn_checktel($("#coTel").val()))
      {
         alert("전화번호 형식으로 입력하세요.(010-1111-1111)");
         $("#coTel").val("");
         $("#coTel").focus();
         return;
      }
      
      if(id != 2)
      {
         alert("아이디 중복 확인을 진행해 주세요.");
         return;
      }
      
      if(email != 2)
      {
         alert("이메일 중복 확인을 진행해 주세요.");
         return;
      }
      
      var musa = "musa";
      
       //일반회원 회원가입
      $.ajax({
         type:"POST",
         url:"/user/nmSignUp",
         data:{
            nmId:$("#nmId").val(),
            nmPwd:$("#nmPwd").val(),
            nmName:$("#nmName").val(),
            nmNickname:$("#nmNickname").val(),
            nmEmail:$("#nmEmail").val(),
            nmTel:$("#nmTel").val(),
            musa:musa
         },
         datatype:"JSON",
         beforeSend:function(xhr){
            xhr.setRequestHeader("AJAX", "true");
         },
         success:function(response){
            if(response.code == 0)
            {
               alert("환영합니다.");
               location.href = "/";
            }
            else if(response.code == 100)
            {
               alert("제대로 된 경로로 가입을 하지 않으셨습니다.");
               $("#nmId").focus();
            }
            else if(response.code == 400)
            {
               alert("파라미터 값이 잘못 되었습니다.");
               $("#nmNickName").focus();
            }
            else
            {
               alert("오류가 발생했습니다.");
               $("#nmId").focus();
            }
         },
         error:function(xhr, status, error){
            icia.common.error(error);
         }
      });
   });
   
});

function fn_emptCheck(value)
{
   //공백체크
   var emptCheck = /\s/g;
   
   return emptCheck.test(value);
}

function fn_idpwCheck(value)
{
   //영어 대소문자, 숫자로만 이루어진 4~12자리 정규식
   var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
   
   return idPwCheck.test(value);
}

function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}

function fn_checkBrn(value) 
{
   var brn = /^[0-9]{3}-[0-9]{2}-[0-9]{5}$/;
   
   return brn.test(value)
}

function fn_checktel(value) 
{
   var tnn = /^0\d{1,2}(-|\))\d{3,4}-\d{4}$/;
   
   return tnn.test(value)
}

function fn_nmSame(a, b)
{
   //중복 체크
   $.ajax({
      type:"POST",
      url:"/user/nmSCheck",
      data:{
         nmValue:a,
         sameChkNum:b
      },
      datatype:"JSON",
      beforeSend:function(xhr){
         xhr.setRequestHeader("AJAX", "true");
      },
      success:function(response){
         if(response.code == 0)
         {
            alert("회원가입 가능.");
         }
         else if(response.code == 11)
         {
            alert("중복된 아이디가 있습니다.");
            $("#nmId").focus();
         }
         else if(response.code == 12)
         {
            alert("중복된 닉네임이 있습니다.");
            $("#nmNickName").focus();
         }
         else if(response.code == 13)
         {
            alert("중복된 이메일이 있습니다.");
            $("#nmEmail").focus();
         }
         else if(response.code == 14)
         {
            alert("중복된 전화번호가 있습니다.");
            $("#nmTel").focus();
         }
         else
         {
            alert("오류가 발생했습니다.");
            $("#nmId").focus();
         }
      },
      error:function(xhr, status, error){
         icia.common.error(error);
      }
   });
}

function fn_coSame(a, b)
{
   //중복 체크
   $.ajax({
      type:"POST",
      url:"/user/coSCheck",
      data:{
         coValue:a,
         ildan:b
      },
      datatype:"JSON",
      beforeSend:function(xhr){
         xhr.setRequestHeader("AJAX", "true");
      },
      success:function(response){
         if(response.code == 10)
         {
            alert("회원가입 가능(중복아이디 없음).");
         }
         else if(response.code == 11)
         {
            alert("중복된 아이디가 있습니다.");
            $("#coId").focus();
         }
         else if(response.code == 20)
         {
            alert("회원가입 가능(중복 이메일 없음).");
         }
         else if(response.code == 13)
         {
            alert("중복된 이메일이 있습니다.");
         }
         else
         {
            alert("오류가 발생했습니다.");
            $("#coId").focus();
         }
      },
      error:function(xhr, status, error){
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
        <a><input id="tab-1" type="radio" name="mmm" class="nm" value="1" checked><label for="tab-1" class="mol tab">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;개인회원</label></a>
     </li>
     <li>
        <a><input id="tab-2" type="radio" name="mmm" class="co" value="2" ><label for="tab-2" class="mol tab">기업회원</label></a>
     </li>
  </ul>

  <div id="nmSingUp">
  <div>
       <div id="tab1" name="tab" class="ws_div">
          <!-- ID input -->
          <div class="first-input input_block first-input_block">
             <div class="ws_input">
             <input type="text" placeholder="아이디" class="input" id="nmId" />
             <button type="button" id="btnNmIdChk" class="ws_nmUpdate_btn" value="">중복확인</button>
            </div> 
          </div>
    <div class="input__block">
       <input type="password" placeholder="비밀번호" class="input" id="nmPwd" maxlength="20" />
    </div>
    <div class="input__block">
       <input type="password" placeholder="비밀번호 확인" class="input" id="nmPwd2" maxlength="20" />
    </div>
    
    <div class="input__block">
       <input type="text" placeholder="이름" class="input" id="nmName" maxlength="6" />
    </div>
    
    <div class="ws_input">
       <input type="text" placeholder="닉네임" class="input" id="nmNickname" maxlength="30" />
       <button type="button" id="btnNmNicknameChk" class="ws_nmUpdate_btn" value="">중복확인</button>
    </div>
    
    <div class="ws_input">
       <input type="text" placeholder="이메일" class="input" id="nmEmail" maxlength="50" />
       <button type="button" id="btnNmEmailChk" class="ws_nmUpdate_btn" value="">중복확인</button>
    </div>
   <div class="ws_input">
       <input type="text" placeholder="연락처" class="input" id="nmTel" maxlength="15" />
       <button type="button" id="btnNmTelChk" class="ws_nmUpdate_btn" value="">중복확인</button>
    </div>
    <input type="hidden" id="nmPwd" name="nmPwd" value=""/>
    <button id="nmSignUp" name="nmSignUp" class="ws_nmUpdate_subBtn">회원가입</button>
    </div>
  </div>
</div>
<div id="coSingUp" style="display:none;">
<div>
      <div id="tab2" name="tab" class="ws_div">
       <!-- ID input -->
       <div class="first-input input_block reg-input_block">
          <div class="ws_input">
           <input type="text" placeholder="기업 아이디" class="input" id="coId" />
           <button type="button" id="btnCoIdChk" class="ws_nmUpdate_btn" value="">중복확인</button>
        </div>
       </div>
    <div class="input__block">
       <input type="password" placeholder="비밀번호" class="input" id="coPwd" maxlength="20"/>
    </div>
    <div class="input__block">
       <input type="password" placeholder="비밀번호 확인" class="input" id="coPwd2" maxlength="20" />
    </div>
    <div class="input__block">
       <input type="text" placeholder="기업명" class="input" id="coName" maxlength="50" />
    </div>
    <div class="input__block">
       <input type="text" placeholder="대표명" class="input" id="coCeo" maxlength="6" />
    </div>
    <div class="input__block">
       <input type="text" placeholder="사업자번호" class="input" id="coNum"/>
    </div>
    <div class="input__block">
       <input type="text" placeholder="주소" class="input" id="coAddr" maxlength="100" />
    </div>
    <div class="input__block">
       <input type="tel" placeholder="기업전화번호" class="input" id="coTel" maxlength="15" />
    </div>
    <div class="ws_input">
       <input type="text" placeholder="이메일" class="input" id="coEmail"    />
       <button type="button" id="btnCoEmailChk" class="ws_nmUpdate_btn">중복확인</button>
    </div>
    <!-- sign in button -->
    <button class="signup__btn" id="coSignUp" name="coSignUp">
      회원가입
    </button>
  </div>
  </div>
    
    
  </div>

</div>


</body>
</html>