<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<footer id="footer" class="footer">
	<div class="footer-content">
    	<div class="container">
        	<div class="row g-5">
          		<div class="col-6 col-lg-2">
            		<h3 class="footer-heading">Navigation</h3>
            			<ul class="footer-links list-unstyled">
			            	<li><a href="/board/promList"><i class="bi bi-chevron-right"></i>홍보게시판</a></li>
			              	<li><a href="/board/revList"><i class="bi bi-chevron-right"></i>후기게시판</a></li>
			           	<c:if test="${!empty nmCookie}"> 
              				<li><a><i class="bi bi-chevron-right"></i>회원 마이페이지</a></li>
              			</c:if>
              			<c:if test="${!empty coCookie}"> 
              				<li><a><i class="bi bi-chevron-right"></i>기업 마이페이지</a></li>
              			</c:if>
              
					<c:choose>
              			<c:when test="${!empty nmCookie || !empty coCookie}">
              				<li><a href="/user/logout"><i class="bi bi-chevron-right"></i>로그아웃</a></li>
              			</c:when>
            			<c:otherwise>
            				<li><a href="/user/login"><i class="bi bi-chevron-right"></i>로그인</a></li>
            			</c:otherwise>
            		</c:choose>	
            			</ul>
          		</div>
          <!--  -->
          		<div class="col-6 col-lg-2">
	          	<c:if test="${!empty nmCookie}"> 
	            	<h3 class="footer-heading">회원 마이페이지</h3>
	            	<ul class="footer-links list-unstyled">
	            		<li><a href="/user/nmMyPage"><i class="bi bi-chevron-right"></i>회원 정보</a></li>
	              		<li><a href="/user/nmJoinList"><i class="bi bi-chevron-right"></i>참여 기록</a></li>
	              		<li><a href="/user/nmRevList"><i class="bi bi-chevron-right"></i>작성한 글</a></li>
	              		<li><a href="/user/nmLikeList"><i class="bi bi-chevron-right"></i>관심 글</a></li>
	            	</ul>
	          	</c:if> 
	          	<c:if test="${!empty coCookie}"> 
	          		<h3 class="footer-heading">기업 마이페이지</h3>
	            	<ul class="footer-links list-unstyled">
	              		<li><a href="/user/coMyPage"><i class="bi bi-chevron-right"></i> 작성 글 목록</a></li>
	            	</ul>
				</c:if>
				</div>
        	</div>
    	</div>
	</div>

	<div class="footer-legal">
    	<div class="container">
        	<div class="row justify-content-between">
          		<div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
            		<div class="copyright">
              			© Copyright <strong><span>ZenBlog</span></strong>. All Rights Reserved
            		</div>

					<div class="credits">
		              	<!-- All the links in the footer should remain intact. -->
		              	<!-- You can delete the links only if you purchased the pro version. -->
		              	<!-- Licensing information: https://bootstrapmade.com/license/ -->
		              	<!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/herobiz-bootstrap-business-template/ -->
	              		Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
	            	</div>
          		</div>
          	</div>
    	</div>
 	</div>
</footer>