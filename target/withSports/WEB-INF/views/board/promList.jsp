<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>

$(document).ready(function()
{
	<c:if test="${!empty coCookie}">
		$("#promWriteBtn").on("click", function()
		{
			location.href = "/board/promWrite"; 
		});	
	</c:if>
	
	$("#promSearchType").change(function()
	{
		$("#promSearchValue").val("");
	});
	
   	$("#promSearchBtn").on("click", function() 
   	{
   		if($("#promSearchType").val() != "")
    	{
    		if($.trim($("#promSearchValue").val()) == "")
    	    {
    	    	alert("조회 값을 입력하세요.");
    	    	$("#promSearchValue").val("");
    	    	$("#promSearchValue").focus();
    	    	return;
    	    }
    	}
   		
		document.promListForm.promSeq.value = "";
		
		document.promListForm.searchType.value = $("#promSearchType").val();
		document.promListForm.searchValue.value = $("#promSearchValue").val();
		document.promListForm.curPage.value = "1";
		
		document.promListForm.action = "/board/promList";
		document.promListForm.submit();
   	});
});


function promListPaging(curPage)
{
	document.promListForm.promSeq.value = "";
	document.promListForm.curPage.value = curPage;
	document.promListForm.action = "/board/promList";
	document.promListForm.submit();
}

function promListView(promSeq)
{
	document.promListForm.promSeq.value = promSeq;
	document.promListForm.action = "/board/promView";
	document.promListForm.submit();
}
</script>
</head>
<body>
<!-- ======= Header ======= -->
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- End Header -->

  <main id="main">
    <section>
      <div class="container">
        <div class="row">
          <div class="col-md-9"  data-aos="fade-up">
            <div class="logo mb-5 align-items-center">
                <h1 class="text-center">대회 정보</h1>
            </div>

            <div class="col-12 float-sm-end">
				<c:if test="${!empty coCookie}">	
              		<button id="promWriteBtn" class="btn btn-primary float-start">글쓰기</button>
             	</c:if>
              <form class="search-form d-md-flex float-end">
                <select name="promSearchType" id="promSearchType" class="form-select me-1" style="width:110px; height:40px;"aria-label="Default select example">
                    <option>조회항목</option>
                    <option value="1" <c:if test='${searchType eq "1"}'> selected </c:if>>작성자</option>
                    <option value="2" <c:if test='${searchType eq "2"}'> selected </c:if>>행사명</option>
                    <option value="3" <c:if test='${searchType eq "3"}'> selected </c:if>>행사내용</option>
                </select>
                <input value="${searchValue}" name="promSearchValue" id="promSearchValue" type="text" class="form-control w-50 me-1" placeholder="Search" aria-label="Recipient's username" aria-describedby="basic-addon2">
                <button type="button" id="promSearchBtn"class="btn btn-primary">Search</button>
              </form>
            </div><br/><br/>



            <!--대회 리스트 시작(게시물 5개씩 추천)-->
		<c:choose>
			<c:when test="${!empty spPromList}">
				<c:forEach var="spPromList" items="${spPromList}" varStatus="status">
					<div class="d-md-flex post-entry-2 half my-5">
		                <div class="me-4 ratio ratio-16x9 p-3" style="width:400px; height:250px;">
		                <c:if test="${!empty spPromList.spPromFile}">
		                    <img class="" src="/resources/upload/${spPromList.spPromFile.promFileName}" alt="대회포스터">
		                </c:if>
		                <c:if test="${empty spPromList.spPromFile}">
		                    <img ${spPromList.spPromFile.promFileName}class="" src="/resources/assets/img/imgEmpty.png" alt="대회포스터">
		                </c:if>
		                </div>
		                <div>
		                    <div class="post-meta w-200" style="width: 500px;">
		                        <span class="mx-1"></span><span class="date">${spPromList.promCate}</span><span class="mx-1">&bullet;</span>
		                        <span class="date">게시일 : ${spPromList.promRegDate}</span>
		                        <span class="mx-1 float-end">
		                            <img src="/resources/assets/img/pm-like.png" class="me-1" style="width:15px;height:15px;">${spPromList.promLikeCnt} &nbsp;
		                            <img src="/resources/assets/img/pm-view.png" class="me-1" style="width:22px;height:20px;">${spPromList.promReadCnt}
		                        </span>
		                    </div>
		                    <h3><a href="javascript:void(0)" onclick="promListView(${spPromList.promSeq})">${spPromList.promTitle}</a></h3>
		                    <ul class="list-unstyled">
		                        <li>- 모집기간 : ${spPromList.promMoSdate} ~ ${spPromList.promMoEdate}</li>
		                        <li>- 행사일자 : ${spPromList.promCoSdate} ~ ${spPromList.promCoEdate}</li>
		                        <li>- 행사장소 : ${spPromList.promAddr}</li>
		                        <li>- 모집인원 : ${spPromList.promJoinCnt}/${spPromList.promLimitCnt}(명)</li>
		                        <li>- 주최자 : ${spPromList.coName}</li>
		                    </ul>
		
		                    <div style="width:500px">
		                        <!-- <button class="btn btn-primary float-end">참여</button> -->
		                    <c:if test='${spPromList.promJoinCnt == spPromList.promLimitCnt}'> 
		                        <button class="btn btn-outline-secondary float-end" disabled>모집마감</button>
		                    </c:if>
		                    <c:if test='${spPromList.promJoinCnt != spPromList.promLimitCnt}'> 
		                        <button class="btn btn-outline-secondary float-end">모집중</button>
		                    </c:if>
		                    </div>    
		                </div>
		            </div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="d-md-flex post-entry-2 half my-5">
			    	<div class="me-4 ratio ratio-16x9 p-3">
			        	<h3>현재 개최중인 대회가 없거나 검색결과값이 존재하지 않습니다. </h3>
			        </div>
	
			    </div>
			</c:otherwise>
		</c:choose>
			

            
            <!--대회 리스트 끝-->

            <!-- 페이징 -->
            <div class="text-center py-4">
                <div class="custom-pagination">
			<c:if test="${!empty paging}">
				<c:if test="${paging.prevBlockPage gt 0}">     
					<a class="prev" href="javascript:void(0)" onclick="promListPaging(${paging.prevBlockPage})">Previous</a>  
				</c:if>   
					<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
			<c:choose>
				<c:when test="${i ne curPage}">
					<a  href="javascript:void(0)" onclick="promListPaging(${i})">${i}</a>
	        	</c:when>
	        	<c:otherwise>
	        		<a class="active"href="javascript:void(0)">${i}</a>
	        	</c:otherwise>
   			</c:choose>
   		</c:forEach>
				<c:if test="${paging.nextBlockPage gt 0}">
                    <a class="next" href="javascript:void(0)" onclick="promListPaging(${paging.nextBlockPage})">Next</a>
                </c:if>
           </c:if>     
                </div>
           </div>
            <!-- 페이징 -->
        </div>

	
        <div class="col-md-3">    
            <!-- ======= Sidebar ======= -->
                <div class="aside-block">
    
                <ul class="nav nav-pills custom-tab-nav mb-4" id="pills-tab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="pills-popular-tab" data-bs-toggle="pill" data-bs-target="#pills-popular" type="button" role="tab" aria-controls="pills-popular" aria-selected="true">Popular</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="pills-trending-tab" data-bs-toggle="pill" data-bs-target="#pills-trending" type="button" role="tab" aria-controls="pills-trending" aria-selected="false">Trending</button>
                    </li>
                </ul>
    
                <div class="tab-content" id="pills-tabContent">
    
                    <!-- 좋아요순-->
           	
                    <div class="tab-pane fade show active" id="pills-popular" role="tabpanel" aria-labelledby="pills-popular-tab">
                        <!--리스트 시작(8개추천)-->
			<c:choose>
				<c:when test="${!empty spPromListLike}">
					<c:forEach  var="spPromListLike" items="${spPromListLike}" varStatus="status">
                        <div class="post-entry-1 border-bottom">
                          <div class="post-meta" style="width:300px">
                            <span class="date">${spPromListLike.promCate}</span> <span>&bullet;</span>
                            <span class="float-end">
                              <img src="/resources/assets/img/pm-like.png" class="me-1" style="width:22px;height:20px;margin-bottom:0px;">
                              <span>추천수 : ${spPromListLike.promLikeCnt}</span>
                            </span>
                          </div>
                          <div class="post-meta">
                            <h2 class="my-3 d-flex" style="width:300px"><a href="javascript:void(0)" onclick="promListView(${spPromListLike.promSeq})">${spPromListLike.promTitle}</a></h2>
                            <span class="d-block mb-1 me-2">행사일자 : ${spPromListLike.promCoSdate}</span>
                            <span class="d-block mb-1 me-2">행사일자 : ${spPromListLike.promCoEdate}</span>
                            <span class="mb-3 me-2 d-block">주최자 : ${spPromListLike.coName}</span>
                          </div>
                        </div>
                        <!--리스트 끝-->
                	</c:forEach>
				</c:when>
			</c:choose>
                    </div>

                    <!-- 좋아요순 끝 -->
    
                    <!-- 조회수 시작 -->

                    <div class="tab-pane fade" id="pills-trending" role="tabpanel" aria-labelledby="pills-trending-tab">
                        <!--리스트 시작-->
			<c:choose>
				<c:when test="${!empty spPromListRead}">
					<c:forEach  var="spPromListRead" items="${spPromListRead}" varStatus="status">
                        <div class="post-entry-1 border-bottom">
                          <div class="post-meta" style="width:300px">
                            <span class="date">${spPromListRead.promCate}</span> <span>&bullet;</span>
                            <span class="float-end">
                              <img src="/resources/assets/img/pm-view.png" class="me-1" style="width:22px;height:20px;margin-bottom:0px;">
                              <span>조회수 : ${spPromListRead.promReadCnt}</span>
                            </span>
                          </div>
                          <div class="post-meta">
							<h2 class="my-3 d-flex" style="width:300px"><a href="javascript:void(0)" onclick="promListView(${spPromListRead.promSeq})">${spPromListRead.promTitle}</a></h2>
                            <span class=" d-block mb-1 me-2">행사일자 : ${spPromListRead.promCoSdate}</span>
                            <span class="d-block mb-1 me-2">행사일자 : ${spPromListRead.promCoEdate}</span>
                            <span class="mb-3 me-2 d-block">주최자 : ${spPromListRead.coName}</span>
                          </div>
                        </div>
                        <!--리스트 끝-->
					</c:forEach>
				</c:when>
			</c:choose>   
                    </div>
   
                    <!-- 조회수 끝 -->
                </div>
            </div>
    
            </div>
        </div>
    </section>
</main><!-- End #main -->

    <form id="promListForm" name="promListForm" method="POST">
	   	<input type="hidden" id="promSeq" name="promSeq" value="">
	   	<input type="hidden" name="searchType" value="${searchType}">
	   	<input type="hidden" name="searchValue" value="${searchValue}">
	   	<input type="hidden" name="curPage" value="${curPage}">
   	</form>
<!-- ======= Footer start ======= -->
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<!-- ======= Footer e n d ======= -->

<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<%@ include file="/WEB-INF/views/include/vendor.jsp" %>
</body>
</html>