<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>

function promListView(promSeq)
{
	document.indexForm.promSeq.value = promSeq;
	document.indexForm.action = "/board/promView";
	document.indexForm.submit();
}
</script>
</head>
<body>
<!-- ======= Header ======= -->
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- End Header -->
<main id="main">
    <!-- ======= Hero Slider Section ======= -->
	<section id="hero-slider" class="hero-slider">
    	<div class="container-md" data-aos="fade-in">
        	<div class="row">
          		<div class="col-12">
            		<div class="swiper sliderFeaturedPosts">
              			<div class="swiper-wrapper">
              			
              			<!--  -->
		<c:choose>
			<c:when test="${!empty spPromListNew}">
				<c:forEach var="spPromListNew" items="${spPromListNew}" varStatus="status">
                			<div class="swiper-slide">
                  			<c:if test="${!empty spPromListNew.spPromFile}">
                  				<a href="javascript:void(0)" onclick="promListView(${spPromListNew.promSeq})" class="img-bg d-flex align-items-end" style="background-image: url('/resources/upload/${spPromListNew.spPromFile.promFileName}');">
                    		</c:if>
                    		<c:if test="${empty spPromListNew.spPromFile}">
                    			<a href="javascript:void(0)" onclick="promListView(${spPromListNew.promSeq})" class="img-bg d-flex align-items-end" style="background-image: url('/resources/assets/img/imgEmpty.png');">
                    		</c:if>
                    			<div class="img-bg-inner">
                      				<h2><b>${spPromListNew.promTitle}</b></h2>
                      				<p>${spPromListNew.promCoSdate} ~ ${spPromListNew.promCoEdate} ${spPromListNew.promAddr} <br />참가비 ${spPromListNew.promPrice}원</p>
                      			</div>
                      			</a>
                      		</div>
            	</c:forEach>
			</c:when>    
			<c:otherwise>
							<div class="swiper-slide">
                  				<a href="" class="img-bg d-flex align-items-end" style="background-image: url('');">
                    			<div class="img-bg-inner">
                      				<h2><b>개최된 대회가 없습니다.</b></h2>
                      				<p><br /></p>
                      			</div>
                      			</a>
                      		</div>
			</c:otherwise>
		</c:choose>          
                      	<!--  -->
                      	
              			</div>
              			<div class="custom-swiper-button-next">
              				<span class="bi-chevron-right"></span>
              			</div>
              			<div class="custom-swiper-button-prev">
                			<span class="bi-chevron-left"></span>
              			</div>
						<div class="swiper-pagination"></div>
            		</div>
          		</div>
			</div>
    	</div>
	</section>
<!-- End Hero Slider Section -->
<!-- ======= 대회정보 Section ======= -->
	<section class="category-section">
    	<div class="container" data-aos="fade-up">
	        <div class="section-header d-flex justify-content-between align-items-center mb-5">
          		<h2>대회정보</h2>
	          	<div>
	          		<a href="/board/promList" class="more">전체보기</a>
	          	</div>
        	</div>
        	<div class="row g-5">
        	
        		<!--  for -->
        <c:choose>
			<c:when test="${!empty spPromListRead}">
				<c:forEach var="spPromListRead" items="${spPromListRead}" varStatus="status">
          		<div class="col-lg-4"> <!-- 첫번째 블럭, 사진 크게 보여주고 싶은 내용 -->
            		<div class="post-entry-1 lg" >
            		<c:if test="${!empty spPromListRead.spPromFile}">
              			<a href="javascript:void(0)" onclick="promListView(${spPromListRead.promSeq})"><img src="/resources/upload/${spPromListRead.spPromFile.promFileName}" style="width:400px; height:300px;" class="img-fluid"></a>
              		</c:if>
              		<c:if test="${empty spPromListRead.spPromFile}">
              			<a href="javascript:void(0)" onclick="promListView(${spPromListRead.promSeq})"><img src="/resources/assets/img/imgEmpty.png" style="width:400px; height:300px;" class="img-fluid"></a>
              		</c:if>
              			<div class="post-meta"><span>${spPromListRead.promCoSdate} ~ ${spPromListRead.promCoEdate}</span></div>
              				<h2><a href="javascript:void(0)" onclick="promListView(${spPromListRead.promSeq})"> ${spPromListRead.promTitle}</a></h2>
			  				<p class="mb-4 d-block">${spPromListRead.promAddr}</p>
            			</div>
          		</div>
          		</c:forEach>
			</c:when>    
			<c:otherwise>
				<div class="col-lg-4"> <!-- 첫번째 블럭, 사진 크게 보여주고 싶은 내용 -->
            		<div class="post-entry-1 lg">
              			<a href="#"><img src="" alt="" class="img-fluid"></a>
              			<div class="post-meta"><span></span></div>
              				<h2><a href="#">등록된 대회가 없어요.</a></h2>
			  				<p class="mb-4 d-block">홍보게시판에 게시물이 존재하지않습니다.</p>
            			</div>
          		</div>
			</c:otherwise>
		</c:choose> 
          		<!--  -->
        	</div> 
    	</div>
	</section>
  </main>
  <!-- End #main -->
  
   <form id="indexForm" name="indexForm" method="POST">
	   	<input type="hidden" id="promSeq" name="promSeq" value="">
	   	<input type="hidden" name="curPage" value="${curPage}">
   </form>
  
<!-- ======= Footer start ======= -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- ======= Footer e n d ======= -->

<!-- 페이지 최상단이동 -->
<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>  
	
<%@ include file="/WEB-INF/views/include/vendor.jsp" %>
</body>
</html>