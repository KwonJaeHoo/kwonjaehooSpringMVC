<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
<c:if test="${empty nmCookie}">
	location.href="/";
</c:if>

$(document).ready(function()
{
	$("#updateBtn").on("click", function()
	{
		location.href = "/user/nmUpdate"; 
	});	
});
</script>
</head>
<body>
<c:if test="${!empty nmCookie}">
<!-- ======= Header ======= -->
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- End Header -->
  <main id="main">
    <section>
      <div class="container" data-aos="fade-up">
        <div class="row">
          <div class="col-lg-12 text-center mb-5">
            <h1 class="page-title">My Page</h1>
          </div>
        </div>

        <!--sub 네비게이션 시작-->
        <nav class="navbar navbar-expand-lg justify-content-center mb-3">
          <div class="align-items-center">
            <div class="collapse navbar-collapse align-items-center" id="navbarNavDropdown">
              <ul class="navbar-nav">
                <li class="nav-item">
                  <a class="nav-link active" aria-current="page" disabled>회원정보</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/user/nmJoinList">참여기록</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/user/nmRevList">작성글</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="/user/nmLikeList">관심글</a>
                </li>
              </ul>
            </div>
          </div>
        </nav>
        <!-- sub 네비게이션 끝 -->
    </section>    
        <div class=" post-entry-2 row justify-content-md-center">
          <div class="col-6 px-5 mx-5 py-4 bg-light">
            <span class="text-center"><h2 class="mt-3 mb-5 strong display-6 .post-meta"><b>회 원 정 보</b></h2></span>
            <div class="post-entry-2 row mb-4 ms-2">
              <div class="col-8">
                <span class="d-block mt-2 mb-4 text-uppercase" id="nmId" name="nmId"><b>- 회원 아이디 :</b> ${spNmUser.nmId}</span>
                <span class="d-block mb-4 text-uppercase" id="nmName" name="nmName"><b>- 회원 이 &nbsp; 름 :</b> ${spNmUser.nmName}</span>
                <span class="d-block mb-4 text-uppercase" id="nmNickname" name="nmNickname"><b>- 회원 닉네임 :</b> ${spNmUser.nmNickname}</span>
                <span class="d-block mb-4 text-uppercase" id="nmEmail" name="nmEmail"><b>- 회원 이메일 :</b> ${spNmUser.nmEmail}</span>
                <span class="d-block mb-4 text-uppercase" id="nmTel" name="nmTel"><b>- 회원 연락처 :</b> ${spNmUser.nmTel}</span>
              </div>
              <div class="col-4" >
                <img src="/resources/assets/img/revImage.png" class="ws-myImg" style="width: 150px; height:200px">
              </div>
            </div>
            <div class="mt-3 align-items-center">
              <button type="button" class="btn ws-myBtn mx-auto" id="updateBtn" name="updateBtn">회원정보 수정</button>
            </div>
          </div>
        </div>

        <div class="row mb-5 ">
        </div>
        
        
  </main><!-- End #main -->

<!-- ======= Footer start ======= -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- ======= Footer e n d ======= -->

<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<%@ include file="/WEB-INF/views/include/vendor.jsp" %>
</c:if>
</body>
</html>