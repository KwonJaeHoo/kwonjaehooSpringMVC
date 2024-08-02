<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<header id="header" class="header d-flex align-items-center fixed-top">
	<div class="container-fluid container-xl d-flex align-items-center justify-content-between">
		<a href="/" class="logo d-flex align-items-center"> <h1>withSports</h1> </a>

		<nav id="navbar" class="navbar">
	    	<ul>
	        	<li><a href="/board/promList">홍보게시판</a></li>
	          	<li><a href="/board/revList">후기게시판</a></li>
	          
			<c:if test="${!empty nmCookie}"> 
	          	<li class="dropdown"><a><span>회원 마이페이지</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
		        	<ul>
		        		<li><a href="/user/nmMyPage">회원 정보</a></li>
				  		<li><a href="/user/nmJoinList">참여 기록</a></li>
		            	<li><a href="/user/nmRevList">작성 글</a></li>
		              	<li><a href="/user/nmLikeList">관심 글</a></li>
		        	</ul>
	        	</li>
			</c:if>
			
			<c:if test="${!empty coCookie}"> 
	        	<li class="dropdown"><a><span>기업 마이페이지</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
		        	<ul>
		            	<li><a href="/user/coMyPage">작성 글 목록</a></li>
		        	</ul>
	          	</li>
			</c:if>
			
			<c:choose>
				<c:when test="${!empty nmCookie || !empty coCookie}">
						<li><a href="/user/logout">로그아웃</a></li>
				</c:when>
				
				<c:otherwise>
					<li><a href="/user/login">로그인</a></li>
				</c:otherwise>
	          
	        </c:choose>
	        
	        </ul>
		</nav>
	<!-- 창 줄어들었을 때 메뉴 나오는거 --> 
		<div class="position-relative">
	        <i class="bi bi-list mobile-nav-toggle"></i>
	    </div>
	</div>
</header>